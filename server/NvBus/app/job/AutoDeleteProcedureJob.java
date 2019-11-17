package job;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import play.db.jpa.JPA;
import play.jobs.Job;
import play.jobs.OnApplicationStart;
//@OnApplicationStart(async=true)
public class AutoDeleteProcedureJob extends Job {
	@SuppressWarnings("unchecked")
	@Override
	public void doJob() {
		try {	
			EntityManager em = JPA.em();
				 Query query = null;
				 query = em.createNativeQuery("SELECT OBJECT_NAME FROM USER_PROCEDURES WHERE OBJECT_TYPE = 'PROCEDURE' AND OBJECT_NAME IN('CLEARBUSINESSDATA','INITSTATIONDB')");
				 List<String> list = query.getResultList();
				 for(String object_name : list){
					 query = em.createNativeQuery("DROP  PROCEDURE "+object_name);	
					 query.executeUpdate();	 
				 }		
		} catch (Exception e) {
			play.Logger.info("AutoDeleteProcedureJob 删除初始化库报错 ："+e.getMessage());
			System.out.println(e.getMessage());
		}
	}
}
