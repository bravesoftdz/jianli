package util.report;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import models.MetaSubcolumn;
import play.db.jpa.JPA;
import play.mvc.Http.Cookie;
import play.mvc.Http.Request;
import util.CommonUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

/**
 * 复杂报表的一些逻辑处理
 * 1、动态扩展表头处理
 * 
 * @author mengjian
 *
 */
public class ComplexReportProcessUtils {

	/**
	 * 增加动态扩展列
	 * 
	 * @param columnlist
	 * @return
	 * @throws CloneNotSupportedException 
	 * @throws UnsupportedEncodingException 
	 */
	public List<MetaSubcolumn> dynamicadd(List<MetaSubcolumn> columnlist) throws CloneNotSupportedException, UnsupportedEncodingException {
		//TODO 需要优化
		String params = null;
		Cookie ck = Request.current().cookies.get("params");
		if(null != ck){
			String se = ck.value;
			params = java.net.URLDecoder.decode(se, "UTF-8");
		}
		List<MetaSubcolumn> listc = this.dynamicAddChild(columnlist,params);
		List<MetaSubcolumn> listp = this.dynamicAddParent(listc,params);
		//去掉用来动态扩展且不显示的问题
		List<MetaSubcolumn> listres = new ArrayList<MetaSubcolumn>();
		for (MetaSubcolumn metaSubcolumn : listp) {
			if(metaSubcolumn.isdynamicadd && 0 == metaSubcolumn.listisdisplay){
				continue;
			}
			listres.add(metaSubcolumn);
		}
		return listres;
	}

	/**
	 * 父节点动态扩展列
	 * 
	 * @param listc
	 * @param params 
	 * @return
	 */
	private List<MetaSubcolumn> dynamicAddParent(List<MetaSubcolumn> listc, String params) {
		List<MetaSubcolumn> listp = new ArrayList<MetaSubcolumn>();
		listp.addAll(listc);
		for(MetaSubcolumn obj : listc){
			if(!obj.isdynamicadd  || obj.dynamicaddsql == null || CommonUtil.isNotEmptyString(obj.ptitle)){
				continue;
			}
			//如果当前标题没有子标题，则动态扩展该列
			String dynamicaddsql = obj.dynamicaddsql;
			String regex = "\\^.*?(@(.*?)@).*?\\^";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(dynamicaddsql);
			//替换关键字生成sql
			if (matcher.find()) {
				Map<String, String> paramMap = new HashMap<String, String>();
				if(CommonUtil.isNotEmptyString(params)){
					paramMap = JSON.parseObject(params, new TypeReference<Map<String,String>>(){});
				}
				ComplexSqlUtils utils = new ComplexSqlUtils();
				dynamicaddsql = utils.getComplexSql(paramMap, dynamicaddsql, matcher);
			} 
			List resultList = JPA.em().createNativeQuery(dynamicaddsql).getResultList();
			String ptitle = obj.title;
			Map<String,List<MetaSubcolumn>> map = new HashMap<String, List<MetaSubcolumn>>();
			if(this.existSub(obj)){
				//如果当前标题有子标题，则动态扩展同时增加子标题
				for (MetaSubcolumn metaSubcolumn : listp) {
					if(ptitle.equals(metaSubcolumn.ptitle)){
						if(map.containsKey(ptitle)){
							map.get(ptitle).add(metaSubcolumn);
						}else{
							List list = new ArrayList<MetaSubcolumn>();
							list.add(metaSubcolumn);
							map.put(ptitle, list);
						}
					}
				}
			}
			List<MetaSubcolumn> list = map.get(ptitle);
			int i = 0;
			for (Object resObj : resultList) {
				MetaSubcolumn newSubObj = obj.copy();
				newSubObj.name =resObj.toString();
				newSubObj.title =resObj.toString();
				newSubObj.field = obj.field + i;
				if(null!=list && list.size() >0){
					for (MetaSubcolumn metaSubcolumn : list) {
						MetaSubcolumn subcopyvo = metaSubcolumn.copy();
						subcopyvo.ptitle = newSubObj.title;
						subcopyvo.field = metaSubcolumn.field + i;
						subcopyvo.listlocation = newSubObj.listlocation + i;
						listp = this.insertList(listp, listp.indexOf(obj), subcopyvo);
					}
				}
				i++;
				listp = this.insertList(listp, listp.indexOf(obj), newSubObj);
			}
			if(null!=list && list.size() >0){
				for (MetaSubcolumn metaSubcolumn : list) {
					listp.remove(metaSubcolumn);
				}
			}
			listp.remove(obj);
		}
		return listp;
	}

	/**
	 * 末级节点动态扩展
	 * 
	 * @param columnlist
	 * @param params 
	 * @return
	 */
	private List<MetaSubcolumn> dynamicAddChild(List<MetaSubcolumn> columnlist, String params) {
		List<MetaSubcolumn> listc = new ArrayList<MetaSubcolumn>();
		listc.addAll(columnlist);
		for(MetaSubcolumn obj : columnlist){
			if(!obj.isdynamicadd || obj.dynamicaddsql == null || this.existSub(obj)){
				continue;
			}
			//如果当前标题没有子标题，则动态扩展该列
			String dynamicaddsql = obj.dynamicaddsql;
			String regex = "\\^.*?(@(.*?)@).*?\\^";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(dynamicaddsql);
			//替换关键字生成sql
			if (matcher.find()) {
				Map<String, String> paramMap = new HashMap<String, String>();
				if(CommonUtil.isNotEmptyString(params)){
					paramMap = JSON.parseObject(params, new TypeReference<Map<String,String>>(){});
				}
				ComplexSqlUtils utils = new ComplexSqlUtils();
				dynamicaddsql = utils.getComplexSql(paramMap, dynamicaddsql, matcher);
			} 
			List resultList = JPA.em().createNativeQuery(dynamicaddsql).getResultList();
			int i = 0;
			for (Object resObj : resultList) {
				MetaSubcolumn newSubObj = obj.copy();
				newSubObj.name =resObj.toString();
				newSubObj.title =resObj.toString();
				newSubObj.field = newSubObj.field + i++;
				//向list中插入一个对象
				listc = this.insertList(listc,listc.indexOf(obj),newSubObj);
//				listc.add(newSubObj);
			}
			listc.remove(obj);
		}
		return listc;
	}

	/**
	 * 向list指定位置添加对象
	 * 
	 * @param list
	 * @param indexOf
	 * @param metaSubcolumn
	 */
	private List<MetaSubcolumn> insertList(List<MetaSubcolumn> list, int indexOf,
			MetaSubcolumn metaSubcolumn) {
		List<MetaSubcolumn> listrs = new ArrayList<MetaSubcolumn>();
		List<MetaSubcolumn> listbefore = new ArrayList<MetaSubcolumn>();
		listbefore = list.subList(0, indexOf+1);
		List<MetaSubcolumn> listafter = new ArrayList<MetaSubcolumn>();
		listafter = list.subList(indexOf+1, list.size());
		listrs.addAll(listbefore);
		listrs.add(metaSubcolumn);
		listrs.addAll(listafter);
		return listrs;
		
	}

	/**
	 * 判断当前标题是否存在子标题
	 * @param obj
	 * @return
	 */
	private boolean existSub(MetaSubcolumn obj) {
		
		//TODO 循环调用需处理
		int len = ((BigDecimal) (JPA
				.em()
				.createNativeQuery(
						"select count(t.id) from meta_subcolumn t where t.ptitle = ? and t.columnid = ?")
				.setParameter(1, obj.title)
				.setParameter(2, obj.columnid).getSingleResult()))
				.intValue();
		return len > 0 ? true :false;
	}

}
