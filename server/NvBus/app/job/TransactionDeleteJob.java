package job;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.persistence.Query;

import models.UndoTransaction;

import org.apache.commons.lang.StringUtils;

import play.Logger;
import play.Play;
import play.db.jpa.JPA;
import play.jobs.Every;
import play.jobs.Job;
import play.jobs.On;
import play.jobs.OnApplicationStart;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;
import util.RpcUtil;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import controllers.Application;

//@On("0 0 2 * * ?")
public class TransactionDeleteJob extends Job {
	@Override
	public void doJob(){
		Logger.info("begin to delete RemoteTransaction");
		Query query = JPA.em().createNativeQuery("select max(createdate) from remotetransaction ");
		Date result = (Date) query.getSingleResult();
		result = DateUtils.add(result, -10);
		query = JPA.em().createQuery("delete from RemoteTransaction where createdate < :createdate ");
		query.setParameter("createdate", result);
		query.executeUpdate();
		Logger.info("end to delete RemoteTransaction");
	}
}
