/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Seatstatuspicture;
import cn.nova.bus.base.service.SeatstatuspictureService;
import cn.nova.bus.base.service.impl.SeatstatuspictureServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class SeatstatuspictureAction extends BaseAction{

	private Seatstatuspicture seatstatuspicture;
	private String picture; // 接收传回的图片数据
	private String status;
	private List<Seatstatuspicture> seatstatuspicturelist;
	private List<Map<String, Object>> seatstatuspicturemap;

	private SeatstatuspictureService seatstatuspictureService;

	public String query() {
		try {
			seatstatuspictureService = new SeatstatuspictureServiceImpl();
			setSeatstatuspicturemap(seatstatuspictureService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			seatstatuspictureService = new SeatstatuspictureServiceImpl();
			if (seatstatuspicture != null) {
				seatstatuspicture.setPicture(ConversionUtil.toByteArr(picture));
				if (seatstatuspictureService.isEmpty(seatstatuspicture
						.getSeatstatus())) {
					Seatstatuspicture seatstatus = seatstatuspictureService
							.getByStatus(seatstatuspicture.getSeatstatus());
					if (seatstatuspicture.getCreateby() == null) {
						msg = "添加成功！";
						markSuccess();
					} else {
						msg = "修改成功！";
						markSuccess();
					}
					seatstatuspicture.setIsactive(true);
					seatstatuspicture.setIslocaldelete(false);
					seatstatuspicture
							.setOrgid(global.getOrganization().getId());
					seatstatuspicture.setSeatstatus(seatstatus.getSeatstatus());
					seatstatuspicture.setCreateby(seatstatus.getCreateby());
					seatstatuspicture.setCreatetime(seatstatus.getCreatetime());
					seatstatuspicture.setUpdateby(global.getUserinfo().getId());
					seatstatuspicture.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					seatstatuspicture.setIsactive(true);
					seatstatuspicture.setIslocaldelete(false);
					seatstatuspicture.setCreateby(global.getUserinfo().getId());
					seatstatuspicture.setUpdateby(global.getUserinfo().getId());
					seatstatuspicture
							.setOrgid(global.getOrganization().getId());
					seatstatuspicture.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					seatstatuspicture.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				seatstatuspicture = seatstatuspictureService
						.save(seatstatuspicture);
				setStatus(seatstatuspicture.getSeatstatus());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作异常！";
			markFail();
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		try {
			seatstatuspictureService = new SeatstatuspictureServiceImpl();
			if (seatstatuspicture != null) {
				Seatstatuspicture picture = seatstatuspictureService
						.getByStatus(seatstatuspicture.getSeatstatus());
				picture.setIsactive(false);
				picture.setIslocaldelete(false);
				picture.setUpdateby(global.getUserinfo().getId());
				picture.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				msg = "删除成功！";
				markSuccess();
				picture = seatstatuspictureService.save(picture);
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "删除失败！";
			markFail();
		}
		return "json";
	}

	public Seatstatuspicture getSeatstatuspicture() {
		return seatstatuspicture;
	}

	public void setSeatstatuspicture(Seatstatuspicture seatstatuspicture) {
		this.seatstatuspicture = seatstatuspicture;
	}

	public List<Seatstatuspicture> getSeatstatuspicturelist() {
		return seatstatuspicturelist;
	}

	public void setSeatstatuspicturelist(
			List<Seatstatuspicture> seatstatuspicturelist) {
		this.seatstatuspicturelist = seatstatuspicturelist;
	}

	public List<Map<String, Object>> getSeatstatuspicturemap() {
		return seatstatuspicturemap;
	}

	public void setSeatstatuspicturemap(
			List<Map<String, Object>> seatstatuspicturemap) {
		this.seatstatuspicturemap = seatstatuspicturemap;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
