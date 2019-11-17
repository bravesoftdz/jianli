package job;

import java.util.List;

import models.TmpTable;
import play.db.jpa.JPA;
import play.jobs.Every;
import play.jobs.Job;
import util.RedisUtil.RedisDBApp;
import bp.TmpTableBP;

//@Every("3h")
public class DropTmpTableJob extends Job {
	/**
	 * 每天清除一次离线用户创建的临时表
	 */
	@Override
	public void doJob() throws Exception {
		super.doJob();
		
		TmpTableBP ttBP = new TmpTableBP();
//		List<TmpTable> ttList = ttBP.getList();
 		try{
 			if (!JPA.em().getTransaction().isActive()) {
				JPA.em().getTransaction().begin();
			}
 			ttBP.deleteByDay();
// 			for (TmpTable tt: ttList) {
// 				if(util.RedisUtil.get(RedisDBApp.Session, tt.getSessionid().getBytes()) == null){
// 					ttBP.deleteBySessionId(tt.getSessionid());
// 				}
// 			}
 			JPA.em().getTransaction().commit();
 		} catch (Exception e){
 			e.printStackTrace();
 		}
	}	
}
