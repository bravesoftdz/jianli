package cn.nova.bus.system.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.orm.jpa.ReceiveOnly;


/**
 * The persistent class for the PRINTTEMPLATEITEM database table.
 * 
 */
@Entity
@Table(name="PRINTTEMPLATEITEM")
public class Printtemplateitem implements Serializable, Cloneable {
	private static final long serialVersionUID = 1L;
	//该字段作为记录的操作类型字段
	@Transient
    private String opertype;  //2删除  4插入 8修改

	@Id
	@SequenceGenerator(name="PRINTTEMPLATEITEM_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PRINTTEMPLATEITEM_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, length=50)
	private String fontname;

	@Column(nullable=false, precision=10, scale=4)
	private BigDecimal fontsize;

	@Column(nullable=false, precision=6)
	private int height;

	@Column(nullable=false, precision=1)
	private boolean isprint;

	@Column(nullable=false, precision=6,name="LEFTMARGIN")
	private int left;

	@Column(length=100)
	private String parameter;

	@Column(nullable=false, length=100)
	private String title;

	@Column(nullable=false, precision=6)
	private int top;

	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

	@Column(nullable=false, length=10)
	private String valuetype;

	@Column(nullable=false, precision=6)
	private int width;

	//bi-directional many-to-one association to Printtemplate
    @ManyToOne
	@JoinColumn(name="PRINTTEMPLATEID", nullable=false)
	private Printtemplate printtemplate;
    
    @Transient
    @ReceiveOnly
    private long printtemplateid;

	//bi-directional many-to-one association to Printtemplatetypeitem
    @ManyToOne
	@JoinColumn(name="PRINTTEMPLATETYPEITEMID", nullable=false)
	private Printtemplatetypeitem printtemplatetypeitem;
    
	@Transient
	@ReceiveOnly
	private long printtemplatetypeitemid;

	@Transient
	private boolean islist;

	@Transient
	private String itemcode;

	@Transient
	private String itemname;
	@Transient
	private String itemtype;

	@Transient
	private String updatebyname;
	@Transient
	private String createbyname;

	public Printtemplateitem() {
	}
	@Lob()
	private byte[] printpicture;
	
	
	@Transient
	private String picture;
	
	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}
	
    public Printtemplateitem(Printtemplateitem printtemplateitem) {
		this.setCreateby(printtemplateitem.getCreateby());
		this.setCreatetime(printtemplateitem.getCreatetime());
		this.setFontname(printtemplateitem.getFontname());
		this.setFontsize(printtemplateitem.getFontsize());
		this.setHeight(printtemplateitem.getHeight());
		this.setIsprint(printtemplateitem.getIsprint());
		this.setLeft(printtemplateitem.getLeft());
		this.setTop(printtemplateitem.getTop());
		this.setParameter(printtemplateitem.getParameter());
		this.setPrinttemplate(printtemplateitem.getPrinttemplate());
		this.setPrinttemplatetypeitem(printtemplateitem.getPrinttemplatetypeitem());
		this.setTitle(printtemplateitem.getTitle());
		this.setUpdateby(printtemplateitem.getUpdateby());
		this.setUpdatetime(printtemplateitem.getUpdatetime());
		this.setValuetype(printtemplateitem.getValuetype());
		this.setWidth(printtemplateitem.getWidth());
		//this.setpicture(printtemplateitem.getPrintpicture());
		//this.setPrintpicture(printtemplateitem.getPrintpicture());
    }
    
    @Override
	public Object clone() {
		Object o = null;
		try {
			o = super.clone();
		} catch (CloneNotSupportedException e) {
			play.Logger.error(e.getMessage(), e);
		}
		return o;
	}
    
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getFontname() {
		return this.fontname;
	}

	public void setFontname(String fontname) {
		this.fontname = fontname;
	}

	public BigDecimal getFontsize() {
		return this.fontsize;
	}

	public void setFontsize(BigDecimal fontsize) {
		this.fontsize = fontsize;
	}

	public int getHeight() {
		return this.height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public boolean getIsprint() {
		return this.isprint;
	}

	public void setIsprint(boolean isprint) {
		this.isprint = isprint;
	}

	public int getLeft() {
		return this.left;
	}

	public void setLeft(int left) {
		this.left = left;
	}

	public String getParameter() {
		return this.parameter;
	}

	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getTop() {
		return this.top;
	}

	public void setTop(int top) {
		this.top = top;
	}

	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getValuetype() {
		return this.valuetype;
	}

	public void setValuetype(String valuetype) {
		this.valuetype = valuetype;
	}

	public int getWidth() {
		return this.width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public Printtemplate getPrinttemplate() {
		return this.printtemplate;
	}

	public void setPrinttemplate(Printtemplate printtemplate) {
		this.printtemplate = printtemplate;
	}
	
	public Printtemplatetypeitem getPrinttemplatetypeitem() {
		return this.printtemplatetypeitem;
	}

	public void setPrinttemplatetypeitem(Printtemplatetypeitem printtemplatetypeitem) {
		this.printtemplatetypeitem = printtemplatetypeitem;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setPrinttemplateid(long printtemplateid) {
		this.printtemplateid = printtemplateid;
	}

	public long getPrinttemplateid() {
		return printtemplateid;
	}

	public void setPrinttemplatetypeitemid(long printtemplatetypeitemid) {
		this.printtemplatetypeitemid = printtemplatetypeitemid;
	}

	public long getPrinttemplatetypeitemid() {
		return printtemplatetypeitemid;
	}

	public boolean isIslist() {
		return islist;
	}

	public void setIslist(boolean islist) {
		this.islist = islist;
	}

	public String getItemcode() {
		return itemcode;
	}

	public void setItemcode(String itemcode) {
		this.itemcode = itemcode;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getItemtype() {
		return itemtype;
	}

	public void setItemtype(String itemtype) {
		this.itemtype = itemtype;
	}

	public String getUpdatebyname() {
		return updatebyname;
	}

	public void setUpdatebyname(String updatebyname) {
		this.updatebyname = updatebyname;
	}

	public String getCreatebyname() {
		return createbyname;
	}

	public void setCreatebyname(String createbyname) {
		this.createbyname = createbyname;
	}

	public byte[] getPrintpicture() {
		return printpicture;
	}
	
	public void setPrintpicture(byte[] printpicture) {
		this.printpicture = printpicture;
	}
	/*
	public void setPrintpicture(String printpicture) {
		System.out.println("printpicture==="+printpicture);
		this.printpicture = ConversionUtil.toByteArr(printpicture);
	}
	public void setPrintpicture(byte[] printpicture) {
		this.printpicture = printpicture;
	}

	public void setpicture(byte[] printpicture2) {
		this.printpicture = printpicture2;
	}*/

}