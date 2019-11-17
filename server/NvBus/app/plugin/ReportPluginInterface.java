package plugin;

/**
 * 
 * @author mengjian
 *
 */
public interface ReportPluginInterface {
	
	/**
	 * 后台sql非数据库DATASOURCE字段注册sql
	 * 获得数据的最终sql
	 * 
	 * @param params
	 * @param isPagination
	 * @return
	 */
	String getSql(String params, boolean isPagination);
	
	/**
	 * 最终sql语句添加排序条件
	 * 
	 * @param params
	 * @return
	 */
	String addOrderSql(String params);

	String getCountSql(String params);

	String getSummarysql(String params);

	/**
	 * 生成临时表后的sql在做复杂处理 动态扩展 交叉处理
	 * 存在此方法时必须处理展现字段方法getResFields（）
	 * 
	 * @param sql
	 * @param formkey
	 * @param params
	 * @return
	 */
	String getDynamicaddSql(String sql, String params);
	
	/**
	 * 获得展现字段
	 * 
	 * @return
	 */
	String[] getResFields();


}
