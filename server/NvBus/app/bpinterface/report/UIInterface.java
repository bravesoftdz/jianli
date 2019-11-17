package bpinterface.report;

import models.MetaColumn;
import models.MetaForm;
import models.MetaReference;
import models.MetaSubcolumn;

public interface UIInterface {
	
	/**
	 * 生成表头
	 * @param formkey
	 * @return
	 * @throws Exception TODO
	 */
	public String tableColumns(String formkey) throws Exception;
	
	/**
	 * 生成条件查询HTML
	 * @param columnid
	 * @return
	 */
	public String conditionHtml(Long columnid);
	
	/**
	 * 生成表单HTML
	 * @param formkey
	 * @return
	 */
	public String formHtml(String formkey);

	/**
	 * 列表页面获取时间和自动补全字段的配置信息
	 * @param formkey
	 * @return
	 */
	public String listModuleSettings(String formkey);

	/**
	 * 编辑页面获取时间和自动补全字段的配置信息
	 * @param formkey
	 * @return
	 */
	public String editModuleSettings(String formkey);

	
	/**
	 * 生成扩展按钮HTML
	 * @param formkey
	 * @return
	 */
	public String operateHtml(String formkey);
	

	/**
	 * 生成可编辑表格的表头
	 * @param formkey
	 * @return
	 */
	public String editortableColumns(String formkey);
	
	/**
	 * 获得排序字段
	 * 
	 * @param formkey
	 * @return
	 */
	public String orderHtml(String formkey);

	/**
	 * 含有默认值的一行数据
	 * @param formkey
	 * @return
	 */
	public String defrowdata(String formkey);

}
