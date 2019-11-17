package job;

import java.util.Date;

import javax.persistence.Query;

import play.db.jpa.JPA;

/**
 * 
 * @author lck
 * 
 * 创建序列:在系统启动时执行或者由python调用执行,而实际由存储过程执行
 */
public class CreateSequence {

	// 创建序列方法
	public void createSeq(String connConfigName) {
		try {
			if(null==connConfigName||connConfigName.equals("")){
				return;
			}
			JPA.setCurrentConfigName(connConfigName);
			play.Logger.info("创建序列:" + new Date()+",connConfigName="+connConfigName);
			Query query = JPA.em().createNativeQuery(
					"{call sp_updateseq()}");
			query.executeUpdate();
			play.Logger.info("创建序列结束:" + new Date());

		} catch (Exception e) {
			play.Logger.error("创建序列异常：" + e.getMessage());
		}

	}
}
