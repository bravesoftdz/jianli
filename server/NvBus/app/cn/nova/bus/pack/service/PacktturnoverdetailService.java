package cn.nova.bus.pack.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packtturnoverdetail;
import cn.nova.bus.sale.model.Depositcash;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.utils.orm.PropertyFilter;

public interface PacktturnoverdetailService {

	
	/**
	 * 查询行包缴款明细
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> query(
			List<PropertyFilter> buildFromHttpRequest);

	public Packtturnoverdetail getById(long id);

	public boolean wastePackcanclepacktturnoverdetail(Pack p, long userid);

	public Packtturnoverdetail getCurPackturnoverdetail(long id, Pack pack);
}
