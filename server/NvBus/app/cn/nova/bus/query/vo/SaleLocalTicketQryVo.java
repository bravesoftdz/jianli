package cn.nova.bus.query.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

import cn.nova.bus.util.UnSum;
import cn.nova.utils.orm.jpa.DelphiDS;

/**
 * 
 * <b>类描述：分页查询VO类的定义必须加@DelphiDS注解</b><br/>
 * <b>类名称：</b>TicketsellQryVo<br/>
 * <b>创建人：</b><a href=mailto:lanchengkun@bus365.com>jiangyr</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
@Entity
@DelphiDS
public class SaleLocalTicketQryVo implements Serializable {

	@Id
	public long id;
	public String currorgname;
	public String orderno;
	public String returnway;
	public String istaked;
	public String taketime;
	public String sellway;
	public String paymethod;
	public String sellip;
	public Timestamp selltime;
	public String buspark;
	public BigDecimal price;
	public BigDecimal discountrate;
	public BigDecimal fullprice;
	public Long distance;
	public boolean islinework;
	public String ticketentrance;
	public Date departdate;
	public String departtime;
	@UnSum
	public short seatno;
	public String ticketno;
	public String ticketstatus;
	public String tickettype;
	public BigDecimal stationservicefee;
	public boolean ischecked;
	public Timestamp checktime;
	public String checkedname;
	public String checkstationname;
	public String sellname;
	public String reachstationname;
	public String departstationname;
	public String schedulecode;
	public String tickettypename;
	public String agentname;
	public String remarks;
	public BigDecimal charges;
	public String returnip;
	public String ticketoutletname;
	public String returnsationname;
	public String returnbyname;
	public Timestamp returntime;
	public String vehicletypename;
	public String orgname;
	public boolean isdepartinvoices;
	public BigDecimal computefee;
	public BigDecimal coolairfee;
	public BigDecimal additionfee;
	public BigDecimal waterfee;
	public BigDecimal insurefee;
	public BigDecimal otherfee;
	public BigDecimal moreprice;
	public BigDecimal subtotal;
	public String routename;
	public Date olddepartdate;
	public BigDecimal manualreturnnum;
	public BigDecimal manualreturnmoney;
}
