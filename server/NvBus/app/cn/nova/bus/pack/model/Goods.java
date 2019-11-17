package cn.nova.bus.pack.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
public class Goods implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "GOODS_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "GOODS_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 6)
	private long id	;//number(10)	n
	
	private String goodsno	;//varchar2(20)	y			寄存单号
	private String num	;//varchar2(10)	y			保管牌号
	private String customer	;//varchar2(20)	y			旅客姓名
	private String phone	;//varchar2(20)	y			旅客电话
	private String idcardno	;//varchar2(20)	y			身份证
	private String goodstype	;//varchar2(10)	y			小件类别:（0：纸箱、1：提包、2：背包、3：行李箱）取数据字典
	private int pieces	;//number(5)	y			件数
	private String location	;//varchar2(20)	y			存放位置
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date pickupenddate;//	date	y			提取截止日期
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date deposittiime;//	date	y			寄存时间
	
	@Column(nullable = false, precision = 6, scale = 2)
	private BigDecimal custodial	;//number(6,2)	y			保管费
	
	@Column(nullable = false, precision = 6, scale = 2)
	private BigDecimal penalty	;//number(6,2)	y			滞纳金
	
	@Column(nullable = false, precision = 6, scale = 2)
	private BigDecimal totalfee	;//number(6,2)	y			合计金额
	private Long consignee	;//number(10)	y			收货人
	private String status	;//varchar2(10)	y			状态（0：库存、1：已提领，2：作废）
	private String pickuper	;//varchar2(30)	y			提领人
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date pickupdate;//	date	y			提领日期
	private Long operator	;//number(10)	y			办理员
	private String remak	;//varchar2(50)	y			备注
	private long orgid	;//number(10)	y			
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;//	date	n	sysdate		
	private long createby	;//number(10)	n			
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;//	date	n	sysdate		
	private long updateby	;//number(10)	n	
	
	private String picture;  //图片
	@Transient
	private String pictureName;  //图片名，不存数据库，只用于修改的时候是否下载图片
	public Goods() {
		// TODO Auto-generated constructor stub
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getGoodsno() {
		return goodsno;
	}
	public void setGoodsno(String goodsno) {
		this.goodsno = goodsno;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getIdcardno() {
		return idcardno;
	}
	public void setIdcardno(String idcardno) {
		this.idcardno = idcardno;
	}
	public String getGoodstype() {
		return goodstype;
	}
	public void setGoodstype(String goodstype) {
		this.goodstype = goodstype;
	}
	public int getPieces() {
		return pieces;
	}
	public void setPieces(int pieces) {
		this.pieces = pieces;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public Date getPickupenddate() {
		return pickupenddate;
	}
	public void setPickupenddate(Date pickupenddate) {
		this.pickupenddate = pickupenddate;
	}
	public Date getDeposittiime() {
		return deposittiime;
	}
	public void setDeposittiime(Date deposittiime) {
		this.deposittiime = deposittiime;
	}
	public BigDecimal getCustodial() {
		return custodial;
	}
	public void setCustodial(BigDecimal custodial) {
		this.custodial = custodial;
	}
	public BigDecimal getPenalty() {
		return penalty;
	}
	public void setPenalty(BigDecimal penalty) {
		this.penalty = penalty;
	}
	public BigDecimal getTotalfee() {
		return totalfee;
	}
	public void setTotalfee(BigDecimal totalfee) {
		this.totalfee = totalfee;
	}
	public Long getConsignee() {
		return consignee;
	}
	public void setConsignee(Long consignee) {
		this.consignee = consignee;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPickuper() {
		return pickuper;
	}
	public void setPickuper(String pickuper) {
		this.pickuper = pickuper;
	}
	public Date getPickupdate() {
		return pickupdate;
	}
	public void setPickupdate(Date pickupdate) {
		this.pickupdate = pickupdate;
	}
	public Long getOperator() {
		return operator;
	}
	public void setOperator(Long operator) {
		this.operator = operator;
	}
	public String getRemak() {
		return remak;
	}
	public void setRemak(String remak) {
		this.remak = remak;
	}
	public long getOrgid() {
		return orgid;
	}
	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public long getCreateby() {
		return createby;
	}
	public void setCreateby(long createby) {
		this.createby = createby;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public long getUpdateby() {
		return updateby;
	}
	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getPictureName() {
		return pictureName;
	}

	public void setPictureName(String pictureName) {
		this.pictureName = pictureName;
	}
	
	
}
