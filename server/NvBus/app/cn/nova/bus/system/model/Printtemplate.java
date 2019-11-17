package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the PRINTTEMPLATE database table.
 * 
 */
@Entity
@Table(name="PRINTTEMPLATE")
public class Printtemplate implements Serializable, Cloneable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="PRINTTEMPLATE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PRINTTEMPLATE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(length=1000)
	private String backgroundimage;

	@Column(nullable=false, precision=2)
	private byte columnsperpage;

	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=6)
	private int height;

	@Column(nullable=false, precision=6)
	private int heightcorrection;

	@Column(nullable=false, precision=6,name="LEFTMARGIN")
	private int left;

	@Column(nullable=false, length=20)
	private String name;

	@Column(length=100)
	private String printername;

	@Column(nullable=false, precision=10)
	private long printtemplatetypeid;

	@Column(nullable=false, precision=4)
	private short rowperpage;

	@Column(nullable=false, precision=6)
	private int rowspace;

	@Column(nullable=false, precision=6)
	private int top;

	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

	@Column(nullable=false, precision=6)
	private int width;

	private boolean autopages;
	
	private int printheighttype;
	
	//bi-directional many-to-one association to Printtemplateitem
	@OneToMany(cascade=CascadeType.ALL,mappedBy="printtemplate")
	private List<Printtemplateitem> printtemplateitems;

    public Printtemplate() {
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

	public String getBackgroundimage() {
		return this.backgroundimage;
	}

	public void setBackgroundimage(String backgroundimage) {
		this.backgroundimage = backgroundimage;
	}

	public byte getColumnsperpage() {
		return this.columnsperpage;
	}

	public void setColumnsperpage(byte columnsperpage) {
		this.columnsperpage = columnsperpage;
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

	public int getHeight() {
		return this.height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getHeightcorrection() {
		return this.heightcorrection;
	}

	public void setHeightcorrection(int heightcorrection) {
		this.heightcorrection = heightcorrection;
	}

	public int getLeft() {
		return this.left;
	}

	public void setLeft(int left) {
		this.left = left;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPrintername() {
		return this.printername;
	}

	public void setPrintername(String printername) {
		this.printername = printername;
	}

	public long getPrinttemplatetypeid() {
		return this.printtemplatetypeid;
	}

	public void setPrinttemplatetypeid(long printtemplatetypeid) {
		this.printtemplatetypeid = printtemplatetypeid;
	}

	public short getRowperpage() {
		return this.rowperpage;
	}

	public void setRowperpage(short rowperpage) {
		this.rowperpage = rowperpage;
	}

	public int getRowspace() {
		return this.rowspace;
	}

	public void setRowspace(int rowspace) {
		this.rowspace = rowspace;
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

	public int getWidth() {
		return this.width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public List<Printtemplateitem> getPrinttemplateitems() {
		return this.printtemplateitems;
	}

	public void setPrinttemplateitems(List<Printtemplateitem> printtemplateitems) {
		this.printtemplateitems = printtemplateitems;
	}

	public void setAutopages(boolean autopages) {
		this.autopages = autopages;
	}

	public boolean isAutopages() {
		return autopages;
	}

	public int getPrintheighttype() {
		return printheighttype;
	}

	public void setPrintheighttype(int printheighttype) {
		this.printheighttype = printheighttype;
	}
	
}