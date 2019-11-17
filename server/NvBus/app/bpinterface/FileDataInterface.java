package bpinterface;

import java.util.Map;

import models.Result;

public interface FileDataInterface {
	/**
	 * 分页查询
	 * @param formkey
	 * @param params
	 * @param page
	 * @param rows
	 * @param isPagination 是否分页触发
	 * @return
	 * @throws Exception 
	 */
	public Map<String,Object> getPage(String formkey, String params, int page, int rows, boolean isPagination) throws Exception;
	
	/**
	 * 查询所有
	 * @param formkey
	 * @return
	 */
	public Map<String,Object> getList(String formkey);
	
	/**
	 * 根据ID查询(主表)
	 * @param formkey
	 * @param id
	 * @return
	 */
	public Object findById(String formkey,Long id);
	
	/**
	 * 单表保存
	 * @param formkey
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Result save(String formkey, String params) throws Exception;
	
	/**
	 * 逻辑删除
	 * @param formkey
	 * @param ids
	 * @return
	 */
	public Result bulkDelete(String formkey, String ids);
	
	/**
	 * 自动完成，数据查询
	 * @param fieldid
	 * @param params
	 * @return
	 */
	public Map<String, Object> autoComplete(Long fieldid, String params);
}
