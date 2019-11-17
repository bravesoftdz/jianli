package cn.nova.bus.pay.param;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class ReachInfo implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	public long id;
	public String provincename;
	public String cityname;
	public String stationname;

}
