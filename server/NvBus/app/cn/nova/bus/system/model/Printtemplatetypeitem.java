package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * The persistent class for the PRINTTEMPLATETYPEITEM database table.
 * 
 */
@Entity
@Table(name="PRINTTEMPLATETYPEITEM")
public class Printtemplatetypeitem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="PRINTTEMPLATETYPEITEM_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PRINTTEMPLATETYPEITEM_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=1)
	private boolean islist;

	@Column(nullable=false, length=20)
	private String itemcode;

	@Column(nullable=false, length=20)
	private String itemname;

	@Column(nullable=false, length=10)
	private String itemtype;

	//bi-directional many-to-one association to Printtemplateitem
	@OneToMany(mappedBy="printtemplatetypeitem")
	private List<Printtemplateitem> printtemplateitems;

	//bi-directional many-to-one association to Printtemplatetype
    @ManyToOne
	@JoinColumn(name="PRINTTEMPLATETYPEID", nullable=false)
	private Printtemplatetype printtemplatetype;

    public Printtemplatetypeitem() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public boolean getIslist() {
		return this.islist;
	}

	public void setIslist(boolean islist) {
		this.islist = islist;
	}

	public String getItemcode() {
		return this.itemcode;
	}

	public void setItemcode(String itemcode) {
		this.itemcode = itemcode;
	}

	public String getItemname() {
		return this.itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getItemtype() {
		return this.itemtype;
	}

	public void setItemtype(String itemtype) {
		this.itemtype = itemtype;
	}

	public List<Printtemplateitem> getPrinttemplateitems() {
		return this.printtemplateitems;
	}

	public void setPrinttemplateitems(List<Printtemplateitem> printtemplateitems) {
		this.printtemplateitems = printtemplateitems;
	}
	
	public Printtemplatetype getPrinttemplatetype() {
		return this.printtemplatetype;
	}

	public void setPrinttemplatetype(Printtemplatetype printtemplatetype) {
		this.printtemplatetype = printtemplatetype;
	}
	
}