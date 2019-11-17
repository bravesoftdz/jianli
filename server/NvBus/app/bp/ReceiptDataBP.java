package bp;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.persistence.EntityTransaction;
import javax.persistence.Query;

import models.BaseModel;
import models.MetaColumn;
import models.MetaForm;
import models.MetaSubcolumn;
import models.Result;
import play.data.validation.Validation;
import play.db.jpa.JPA;
import plugin.PluginInterface;
import util.CommonUtil;
import util.DateUtils;
import util.PropertyUtil;
import bpinterface.ReceiptDataInterface;
import bpinterface.UIInterface;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class ReceiptDataBP implements ReceiptDataInterface {
	public Map<String,Object> getlist(String formkey, Long id) {
		UIInterface uibp = new UIBP();
		MetaColumn secColumn = uibp.findSecColumnByFormkey(formkey);
		StringBuilder sb = new StringBuilder();
		sb.append(secColumn.datasource);
		String alias = null;
		String fieldname = null;
		try {
			alias = secColumn.subforeignkey.split("!")[0];
			fieldname = secColumn.subforeignkey.split("!")[1];
		} catch (Exception e) {
			throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名!");
		}
		
		sb.append(" and ").append(alias).append(".").append(fieldname).append(" = ?");
		Query query = JPA.em().createNativeQuery(sb.toString());
		query.setParameter(1, id);
		List list = query.getResultList();
		String[] fields = secColumn.returncolumn.split("\\s*,\\s*");
		List<Map<String,Object>> innerMap = CommonUtil.list2Map(list,fields);
		int count = list.size();
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("total", count);
		map.put("rows", innerMap);
		return map;
	}

	public Result save(String formkey,String params,String items, String delids) throws Exception{
		UIInterface uibp = new UIBP();
		Result result = new Result();
		EntityTransaction transaction = JPA.em().getTransaction();
		if(transaction.isActive() == false) {
			transaction.begin();
		}
		try {
			//保存主表
			params = params.replaceAll("\\d+#.*?!", "");
			MetaColumn column = uibp.findColumnByFormkey(formkey);
			Class clazz = getClass(column.entityname);
			BaseModel model = (BaseModel) JSON.parseObject(params, clazz);
			Field idfield = clazz.getDeclaredField("id");
			Field isactivefield = null;
			Long id = (Long) idfield.get(model);
			if(id == null || id == 0){
				try {
					isactivefield = clazz.getDeclaredField("isactive");
					isactivefield.set(model, true);
				} catch (Exception e) {
				}
				model.createStamp(false);
			}
			if(id !=null && id != 0){
				model.updateStamp(false);
			}
			
			MetaForm form = uibp.findFormByKey(formkey);
			PluginInterface plugin = null;
			if(CommonUtil.isNotEmptyString(form.pluginname)){
				plugin = (PluginInterface) PropertyUtil.getObject(form.pluginname);
			}
			
			if(plugin != null) {
				model = (BaseModel) plugin.mainBefore(form,model);
			}
			Validation validation = Validation.current();
			if(validation.hasErrors()){
				transaction.rollback();
				return new Result(false,"操作失败!");
			}
			model = model.merge();
			model.validateAndSave();
			if(plugin != null){
				plugin.mainAfter(form,model);
			}
			id  = (Long) idfield.get(model);
			
			//删除子表
			List<Long> idlist = JSON.parseArray(delids,Long.class);
			if(!idlist.isEmpty()){
				bulkDelete(formkey,idlist);
			}
			
			//保存修改子表
			MetaColumn secColumn = uibp.findSecColumnByFormkey(formkey);
			clazz = getClass(secColumn.entityname);
			
			idfield = clazz.getDeclaredField("id");
			String fkfield = (secColumn.subforeignkey).split("!")[1];
			Field connfield = clazz.getDeclaredField(fkfield);

			JSONArray parseArray = JSON.parseArray(items);
			for(int i = 0; i < parseArray.size(); i++){
				BaseModel item  = new MetaSubcolumn();
				//把JSONObject数据封装到对象中
				JSONObject obj = (JSONObject) parseArray.get(i);
				Set<Entry<String, Object>> entrySet = obj.entrySet();
				for(Entry<String, Object> entry : entrySet){
					String key = entry.getKey();
					Object sv = entry.getValue();
					String value = entry.getValue().toString();
					Field df = clazz.getField(key);
					Class<?> ftype = df.getType();
					if(ftype.equals(Boolean.class) || ftype.equals(boolean.class)){
						value = "1".equals(value) ? "true" : "false";
						df.set(item, Boolean.valueOf(value));
					}else if(ftype.equals(Long.class)){
						if("".equals(value)){
							df.set(item, null);
						}else{
							df.set(item, Long.valueOf(value));
						}
					}else if(ftype.equals(long.class)){
						if("".equals(value)){
							df.set(item, 0);
						}else{
							df.set(item, Long.valueOf(value));
						}
					}else if(ftype.equals(Integer.class)){
						if("".equals(value)){
							df.set(item, null);
						}else{
							df.set(item, Integer.valueOf(value));
						}
					}else if(ftype.equals(int.class)){
						if("".equals(value)){
							df.set(item, 0);
						}else{
							df.set(item, Integer.valueOf(value));
						}
					}else if(ftype.equals(Date.class)){
						if("".equals(sv)){
							df.set(item, null);
						}else{
							if (sv instanceof Long) {
								df.set(item, new Date((Long)sv));
							}else{
								df.set(item, DateUtils.strToDateTime(value));
							}
						}
					}else if(ftype.equals(BigDecimal.class)){
						if("".equals(value)){
							df.set(item, null);
						}else{
							df.set(item, BigDecimal.valueOf(Double.valueOf(value)));
						}
					}else{
						df.set(item, value);
					}
				}
				
				Long itemid = (Long) idfield.get(item);
				if(itemid == null || itemid == 0) {
					try {
						isactivefield = clazz.getDeclaredField("isactive");
						isactivefield.set(item, true);//逻辑删除状态字段默认值
					} catch (Exception e) {
					}
					connfield.set(item, id);//主子表关联
					item.createStamp(false);
				}
				if(itemid != null && itemid != 0) {
					item.updateStamp(false);
				}
				if(plugin != null) {
					item = (BaseModel) plugin.subBefore(form,model,item);
				}
				if(validation.hasErrors()){
					transaction.rollback();
					return new Result(false,"操作失败!");
				}
				item = item.merge();
				item.validateAndSave();
				if(plugin != null) {
					plugin.subAfter(form,model,item);
				}
			}
			
			transaction.commit();
			result.setSuccess(true);
			result.setMessage("保存成功!");
			return result;
		} catch (Exception e) {
			transaction.rollback();
			throw e;
		}
		
	}
	
	public Object findById(String formkey,Long id){
		UIInterface uibp = new UIBP();
		MetaColumn column = uibp.findSecColumnByFormkey(formkey);
		StringBuilder sb = new StringBuilder(column.datasource);
		sb.append(" and t.id = ?");
		Query query = JPA.em().createNativeQuery(sb.toString());
		query.setParameter(1, id);
		List list = query.getResultList();
		String[] fields = column.returncolumn.split("\\s*,\\s*");
		List<Map<String,Object>> innerMap = CommonUtil.list2Map(list,fields);
		return innerMap.get(0);
	}
	
	public Result bulkDelete(String formkey, String ids) {
		UIInterface uibp = new UIBP();
		EntityTransaction transaction = JPA.em().getTransaction();
		if(transaction.isActive() == false){
			transaction.begin();
		}
		
		try {
			//删除主表记录
			MetaColumn column = uibp.findColumnByFormkey(formkey);
			Class clazz = getClass(column.entityname);
			String sql = "";
			try {
				//逻辑删除
				clazz.getDeclaredField("isactive");
				sql = "update " + column.entityname + " set isactive = 0 where id in ("+ids+")";
			} catch (Exception e) {
				//物理删除
				sql = "delete from " + column.entityname + " where id in ("+ids+")";
			}
			Query query = JPA.em().createQuery(sql);
			query.executeUpdate();
			
			//删除子表记录
			MetaColumn secColumn = uibp.findSecColumnByFormkey(formkey);
			clazz = getClass(secColumn.entityname);
			try {
				//逻辑删除
				clazz.getDeclaredField("isactive");
				sql = "update " + secColumn.entityname + " set isactive = 0 where " + secColumn.subforeignkey.split("!")[1] + " in ("+ids+")";
			} catch (Exception e) {
				//物理删除
				sql = "delete from " + secColumn.entityname + " where " + secColumn.subforeignkey.split("!")[1] + " in ("+ids+")";
			}
			query = JPA.em().createQuery(sql);
			query.executeUpdate();
			
			transaction.commit();
			Result result = new Result(true,"删除成功!");
			return result;
		} catch (Exception e) {
			transaction.rollback();
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 批量删除（子表）
	 * @param formkey
	 * @param idlist
	 */
	private void bulkDelete(String formkey,List<Long> idlist){
		UIInterface uibp = new UIBP();
		MetaColumn secColumn = uibp.findSecColumnByFormkey(formkey);
		
		StringBuilder sb = new StringBuilder();
		for(Long id : idlist) {
			sb.append(id).append(",");
		}
		sb.deleteCharAt(sb.length()-1);
		String idstr = sb.toString();
		
		Class clazz = getClass(secColumn.entityname);
		String sql = "";
		try {
			clazz.getDeclaredField("isactive");
			sql = "update " + secColumn.entityname + " set isactive = 0 where id in (" + idstr + ")";
		} catch (Exception e) {
			sql = "delete from " + secColumn.entityname + " where id in (" + idstr + ")";
		} 
		Query query = JPA.em().createQuery(sql);
		query.executeUpdate();
	}
	
	/**
	 * 根据类名获取Class
	 * @param classname
	 * @return
	 */
	private Class getClass(String classname) {
		Class clazz = null;
		try {
			clazz = Class.forName(classname);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("ERROR.ENTITY.IS.NOT.EXIST", e);
		}
		return clazz;
	}

}
