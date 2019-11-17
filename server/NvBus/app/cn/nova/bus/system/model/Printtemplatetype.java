package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * The persistent class for the PRINTTEMPLATETYPE database table.
 * 
 */
@Entity
@Table(name="PRINTTEMPLATETYPE")
public class Printtemplatetype implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="PRINTTEMPLATETYPE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PRINTTEMPLATETYPE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, length=20)
	private String name;

	//bi-directional many-to-one association to Printtemplatetypeitem
	@OneToMany(mappedBy="printtemplatetype")
	private List<Printtemplatetypeitem> printtemplatetypeitems;

    public Printtemplatetype() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Printtemplatetypeitem> getPrinttemplatetypeitems() {
		return this.printtemplatetypeitems;
	}

	public void setPrinttemplatetypeitems(List<Printtemplatetypeitem> printtemplatetypeitems) {
		this.printtemplatetypeitems = printtemplatetypeitems;
	}
	
}