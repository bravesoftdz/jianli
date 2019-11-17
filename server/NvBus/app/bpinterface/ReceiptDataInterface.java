package bpinterface;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityTransaction;
import javax.persistence.Query;

import play.db.jpa.JPA;
import bp.FileDataBP;
import bp.UIBP;

import com.alibaba.fastjson.JSON;

import models.BaseModel;
import models.MetaColumn;
import models.Result;

public interface ReceiptDataInterface {
	/**
	 * 根据主表记录ID查询关联的所有子表记录
	 * @param formkey
	 * @param id
	 * @return
	 */
	public Map<String,Object> getlist(String formkey, Long id);

	/**
	 * 主子表保存
	 * @param formkey
	 * @param params
	 * @param items
	 * @param delids
	 * @return
	 * @throws Exception 
	 */
	public Result save(String formkey,String params,String items, String delids) throws Exception;
	
	/**
	 * 根据ID查询（子表）
	 * @param formkey
	 * @param id
	 * @return
	 */
	public Object findById(String formkey,Long id);
	
	/**
	 * 主子表删除
	 * @param formkey
	 * @param ids
	 * @return
	 */
	public Result bulkDelete(String formkey, String ids);
}
