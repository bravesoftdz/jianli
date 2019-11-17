/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.action<br/>
 * <b>文件名：</b>CardissueJob.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-21 上午09:31:46 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.job;

import java.util.Date;
import java.util.List;

import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.base.service.CardissueService;
import cn.nova.bus.base.service.impl.CardissueServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.job.model.Jobconfig;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>CardissueJob.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-21 上午09:31:46 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

//@Every("1min")
public class CardissueJob extends Job {
	
	//private CardissueService cardService = new CardissueServiceImpl();

  @Override
  public void doJob() {
	Jobconfig job = BusJobUtil.getJobConfig("CardissueJob");
	if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){  
		 CardissueService cardService = new CardissueServiceImpl();
		List<Cardissue> list = cardService.query(new Date());
		if(null == list) return;
		for (int i = 0; i < list.size(); i++) {
		  // 查询智能卡的有效期是否过期
		  if (list.get(i).getValiddate().getTime() < new Date().getTime()) {
		    Cardissue card = cardService.getById(list.get(i).getId());
		    card.setStatus("4");
		    try {
		      cardService.save(card, "127.0.0.1",null);
		    } catch (ServiceException e) {
		      play.Logger.error(e.getMessage(), e);
		    }
		  }
		}
		job.setLastruntime(new Date());
		job = job.merge();
		job.save();
	}
  }

}
