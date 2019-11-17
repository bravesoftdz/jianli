package bpinterface;

import java.util.List;

import models.Result;
import models.TmpTable;

public interface TmpTableBPInterface {
	
	Result save(TmpTable tmpTable) throws Exception;
	
	Result deleteBySessionId(String sessionId);
	
	/**
	 * 删除一天前的所有报表产生的临时表
	 * 今天00:00之前的数据
	 * @return
	 */
	Result deleteByDay();

	List getList();
	
	
}
