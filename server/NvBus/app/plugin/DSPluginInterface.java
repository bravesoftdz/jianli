package plugin;

import javax.persistence.Query;

public interface DSPluginInterface {
	String getSql(String params, boolean isPagination);
	String getCountSql(String params);
	String getSummarysql(String params); 
}
