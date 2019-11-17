/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.SeatstatuspictureDao;
import cn.nova.bus.base.model.Seatstatuspicture;
import cn.nova.bus.base.service.SeatstatuspictureService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class SeatstatuspictureServiceImpl implements SeatstatuspictureService {


	private SeatstatuspictureDao dao = new SeatstatuspictureDao();

	@Override
	public Seatstatuspicture save(Seatstatuspicture picture) {
		if (!isEmpty(picture.getSeatstatus())) {
			return (Seatstatuspicture) dao.merge(picture);
		} else {
			Seatstatuspicture statuspicture = dao.getSeatstatuspicture(picture.getSeatstatus());
			picture.setSynccode(statuspicture.getSynccode());
			return (Seatstatuspicture) dao.merge(picture);
		}
	}

	@Override
	public boolean delete(Seatstatuspicture picture) {
		if (picture != null) {
			return dao.del(picture);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Seatstatuspicture.class, id);
	}

	@Override
	public List<Seatstatuspicture> query() {
		return dao.query(Seatstatuspicture.class, null);
	}

	@Override
	public Seatstatuspicture getByStatus(String status) {
		return dao.getSeatstatuspicture(status);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Seatstatuspicture.class,
				"createname", "orgname", "updatename", "statusname" },
				dao.query(propertyFilterList), new Object[] {
						Seatstatuspicture.class, String.class, String.class,
						String.class, String.class });
	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean isEmpty(String seatstatus) {
		List list = dao.getResult(seatstatus);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

}
