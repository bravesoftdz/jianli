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
 * <b>创建人：</b><a href="mailto:lanchengkun@bus365.com">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
@Entity
@DelphiDS
public class TicketsellQryVo implements Serializable{
	@Id
	public long id;

	public String sellip;//
	public Timestamp selltime;
	public String buspark;
	public String ticketentrance;
	public BigDecimal price;
	public BigDecimal fueladditionfee;
	public BigDecimal stationservicefee;
	public BigDecimal discountrate;
	public BigDecimal fullprice;
	public Long distance;
	public byte carrychildnum;
	public Date departdate;
	public String departtime;
	//表示不求和字段
	@UnSum
	public int seatno;
	public String ticketno;
	public String sellway;
	public String ticketstatus;
	public String paymethod;
	public String orgname;
	public String schedulecode;
	public String dpartname;
	public String reachname;
	public String sellname;
	public boolean ischecked;
	public boolean isdepartinvoices;
	public boolean iseticketsell;//新添加电子票字段
	public boolean islocal;
	public String vehicletypename;
	public String tickettypename;
	public boolean islinework;
	public String ticketoutletname;
	public String customername;
	//public String sex;
	//public String familyaddress;
	public String certificateno;
	public String certificatetypename;
	public String hticketoutlesname;
	public String houtletsaddress;
	public String checkedname;
	public String checkstationname;
	public String departinvoicesbyname;
	public String departinvoicesno;
	public Timestamp departinvoicestime;
	public BigDecimal servicefee;
	public String vehiclebrandmodelname;
	public Timestamp checktime;
	public BigDecimal computefee;
	public BigDecimal coolairfee;
	public BigDecimal additionfee;
	public boolean isovertime;
	public String routename;
	public BigDecimal ticketprice;
	public BigDecimal returnamount;
	public String returnbyname;
	public Timestamp returntime;
	public String returnway;
	public BigDecimal moreprice;
	public BigDecimal otherfee;
	public BigDecimal insurefee;
	public BigDecimal waterfee;
	public BigDecimal serviceprice;
	public BigDecimal subtotal;
	public String printname;
	public String printorgname;
	public String vehicleno;
	public Date olddepartdate;
	//public String mobilephone;
	public String batchno;
	public boolean returnmethod;
	//public String orderno;
	
}
