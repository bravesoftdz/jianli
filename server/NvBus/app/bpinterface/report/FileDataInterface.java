package bpinterface.report;

import java.util.Map;

import models.Result;

public interface FileDataInterface {
	/**
	 * 分页查询
	 * @param formkey
	 * @param params
	 * @param page
	 * @param rows
	 * @param orderCondition 
	 * @param isPagination 是否分页触发
	 * @return
	 * @throws Exception 
	 */
	public Map<String,Object> getPage(String formkey, String params, int page, int rows, String orderCondition, boolean isPagination) throws Exception;
	
	/**
	 * 查询所有
	 * @param formkey
	 * @return
	 */
	public Map<String,Object> getList(String formkey);
	
	
	/**
	 * 自动完成，数据查询
	 * @param fieldid
	 * @param params
	 * @return
	 */
	public Map<String, Object> autoComplete(Long fieldid, String params);
}
