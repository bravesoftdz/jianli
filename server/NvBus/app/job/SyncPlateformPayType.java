package job;

import play.jobs.Job;
import play.jobs.OnApplicationStart;
import cn.nova.bus.sale.service.EPayService;
import cn.nova.bus.sale.service.TicketSellService;
import cn.nova.bus.sale.service.impl.EPayServiceImpl;
import cn.nova.bus.sale.service.impl.TicketSellServiceImpl;
//@OnApplicationStart(async=true)
public class SyncPlateformPayType extends Job{

	//EPayService ePayService = new EPayServiceImpl();
	@Override
	public void doJob() throws Exception {
		EPayService ePayService = new EPayServiceImpl();
		ePayService.syncPayGate();
	}
}
