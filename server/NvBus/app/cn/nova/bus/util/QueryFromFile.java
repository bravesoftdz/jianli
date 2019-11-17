package cn.nova.bus.util;

import java.util.List;
import java.util.Map;

import cn.nova.bus.query.vo.SaleLocalTicketQryVo;
import cn.nova.bus.query.vo.TicketsellQryVo;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.jpa.ListUtil;
/**
 * 
 * <b>类描述：分页查询类，从文件中读取数据</b><br/>
 * <b>类名称：</b>QueryFromFile<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@bus365.com">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
public class QueryFromFile {

	public List<Map<String, Object>> query(Global global,String reportname,int pagesize,int pages){
		//售票情况查询
		if(reportname.equals(PaginationReportName.TICKETSELLQRY)){		
			List<Map<String, Object>> list=ReportUtil.readFromFile(TicketsellQryVo.class,global,PaginationReportName.TICKETSELLQRY,pagesize,pages);
			return list;
		}
		//异售本明细表
		if(reportname.equals(PaginationReportName.SALELOCALTICKETQRY)){		
			List<Map<String, Object>> list=ReportUtil.readFromFile(SaleLocalTicketQryVo.class,global,PaginationReportName.SALELOCALTICKETQRY,pagesize,pages);
			return list;
		}
		return null;

	}
}
