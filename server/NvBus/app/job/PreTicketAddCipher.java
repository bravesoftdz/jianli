package job;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.encrypt.AuthcodeEncode;
import cn.nova.bus.sale.model.Ticketsell;

import play.db.jpa.JPA;
import play.jobs.Job;
import play.jobs.OnApplicationStart;

//@OnApplicationStart(async = true)
public class PreTicketAddCipher extends Job {

	
	
	public void doJob(){
		String paramValue = AuthcodeEncode.getParamValue(ParamterConst.Param_1098);
		if("1".equals(paramValue)){
			secondAuth();
		}else{
			firstAuth();
		}
	}

	public void firstAuth() {
		try {
			// 把当天和所有的预售票全部加密，消除修改加密方法之前的售票记录加密不对问题。
			// 升级的站务 如果有售票加密逻辑 去掉 t.tiksno is null 条件
			StringBuilder sql = new StringBuilder(
					"select  t from Ticketsell t where t.departdate>sysdate-1 and t.tiksno  is null and t.ticketstatus='0' ");
			Query query = JPA.em().createQuery(sql.toString());
			List<Ticketsell> ticketsells = query.getResultList();
			// 校验售票记录的密文是否正确
			for (Ticketsell ticketsell : ticketsells) {
				DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
				String datestr = df.format(ticketsell.getSelltime());
				String cipherStr = ticketsell.getOrgid() + datestr + ticketsell.getSellby();
				String tiksno = AuthcodeEncode.authcodeEncode(cipherStr);
				ticketsell.setTiksno(tiksno);
				JPA.em().merge(ticketsell);
			}
			// 批次处理前15天的数据按天循环
			for (int i = 1; i <= 15; i++) {
				sql = new StringBuilder("select  t from Ticketsell t where t.departdate > sysdate-" + (i + 1)
						+ " and t.departdate <= sysdate-" + i); //
				sql.append(" and t.tiksno  is null and t.ticketstatus='0' ");
				query = JPA.em().createQuery(sql.toString());
				ticketsells = query.getResultList();
				// 校验售票记录的密文是否正确
				for (Ticketsell ticketsell : ticketsells) {
					DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
					String datestr = df.format(ticketsell.getSelltime());
					String cipherStr = ticketsell.getOrgid() + datestr + ticketsell.getSellby();
					String tiksno = AuthcodeEncode.authcodeEncode(cipherStr);
					ticketsell.setTiksno(tiksno);
					JPA.em().merge(ticketsell);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void secondAuth() {
		try {
			// 把当天和所有的预售票全部加密，消除修改加密方法之前的售票记录加密不对问题。
			// 升级的站务 如果有售票加密逻辑 去掉 t.tiksno is null 条件
			StringBuilder sql = new StringBuilder(
					"select  t from Ticketsell t where t.departdate>sysdate-1 and t.ticketstatus='0' ");
			Query query = JPA.em().createQuery(sql.toString());
			List<Ticketsell> ticketsells = query.getResultList();
			// 校验售票记录的密文是否正确
			for (Ticketsell ticketsell : ticketsells) {
				DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
				String datestr = df.format(ticketsell.getSelltime());
				String cipherStr = ticketsell.getOrgid() + datestr + ticketsell.getSellby();
				String tiksno = AuthcodeEncode.authcodeEncode(cipherStr);
				ticketsell.setTiksno(tiksno);
				JPA.em().merge(ticketsell);
			}
			// 批次处理前15天的数据按天循环
			for (int i = 1; i <= 15; i++) {
				sql = new StringBuilder("select  t from Ticketsell t where t.departdate > sysdate-" + (i + 1)
						+ " and t.departdate <= sysdate-" + i); //
				sql.append(" and t.ticketstatus='0' ");
				query = JPA.em().createQuery(sql.toString());
				ticketsells = query.getResultList();
				// 校验售票记录的密文是否正确
				for (Ticketsell ticketsell : ticketsells) {
					DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
					String datestr = df.format(ticketsell.getSelltime());
					String cipherStr = ticketsell.getOrgid() + datestr + ticketsell.getSellby();
					String tiksno = AuthcodeEncode.authcodeEncode(cipherStr);
					ticketsell.setTiksno(tiksno);
					JPA.em().merge(ticketsell);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
