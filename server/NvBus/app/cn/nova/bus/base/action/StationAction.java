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

import java.io.File;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import util.CurrentUtil;
import util.ExcelUtil;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Stationstandard;
import cn.nova.bus.base.service.StationService;
import cn.nova.bus.base.service.impl.StationServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class StationAction extends BaseAction{
	private List<Map<String, Object>> stationmap;

	public HttpServletRequest httpServletRequest;

	private StationService stationService;
	// private Page<station> page = new Page<station>(5);//每页5条记录
	private Station station;
	private Long id;

	public String list() {
		try {
			stationService = new StationServiceImpl();
			setStationmap(stationService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		stationService = new StationServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (station != null) {
				if (station.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					Station st = stationService.findById(station.getId());
					station.setSynccode(st.getSynccode());
					station.setUpdateby(global.getUserinfo().getId());
					station.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					if (!st.getName().equals(station.getName())) {
						if (stationService.isUnique(station.getName(), null)) {
							msg = "站点名称已存在！";
							markFail();
							return "json";
						}
					}
					if (!st.getHelpcode().equals(station.getHelpcode())) {
						if (stationService.isUnique(null, station.getHelpcode())) {
							msg = "站点操作码已存在！";
							markFail();
							return "json";
						}
					}
				} else {
					msg = "添加成功！";
					markSuccess();
					station.setIsactive(true);
					station.setIslocaldelete(false);
					station.setCreateby(global.getUserinfo().getId());
					station.setUpdateby(global.getUserinfo().getId());
					station.setOrgid(global.getOrganization().getId());
					station.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					station.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					if (stationService.getId(station.getName()) > 0) {
						Station st = stationService.findById(stationService
								.getId(station.getName()));
						if(StringUtils.isNotEmpty(station.getCode())){
						}else{
							station.setCode(st.getCode());
						}
						station.setId(st.getId());
						station.setSynccode(st.getSynccode());
					} else {
						if (stationService.isUnique(station.getName(), null)) {
							msg = "站点名称已存在！";
							markFail();
							return "json";
						}
						if (stationService.isUnique(null, station.getHelpcode())) {
							msg = "站点操作码已存在！";
							markFail();
							return "json";
						}
					}
				}
				station = stationService.save(station);
				setId(station.getId());
			}
		}catch (ServiceException ex) {
			//
			msg = ex.getMessage();
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作异常" + e.getMessage();
			markFail();
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		if (station.getId() > 0) {
			try {
				stationService = new StationServiceImpl();
				if (!stationService.hasApplyRoutestop(station.getId())) {
					Station st = stationService.findById(station.getId());
					st.setIsactive(false);
					st.setIslocaldelete(true);
					st.setUpdateby(global.getUserinfo().getId());
					st.setUpdatetime(new Date());
					msg = "删除成功！";
					markSuccess();
					st = stationService.save(st);
				}
			} catch (ServiceException ex) {
				setMsg(ex.getMessage());
				markSuccess();
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				setMsg(e.getMessage());
				markSuccess();
			}
		} else {
			msg = "请选择你要删除的记录！";
			markFail();
		}
		return "json";
	}

	public List<Map<String, Object>> getStationmap() {
		return stationmap;
	}

	public void setStationmap(List<Map<String, Object>> stationmap) {
		this.stationmap = stationmap;
	}

	public Station getStation() {
		return station;
	}

	public void setStation(Station station) {
		this.station = station;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
