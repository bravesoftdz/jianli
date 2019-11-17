package cn.nova.bus.pack.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packarriver;
import cn.nova.bus.pack.service.PackWarehousingService;
import cn.nova.bus.pack.service.impl.PackServiceImpl;
import cn.nova.bus.pack.service.impl.PackWarehousingServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackWarehousingAction extends BaseAction{
	private Packarriver packarriver;
	private Pack pack;
	private long packid;
	private List<Map<String, Object>> packnomap;
	
	private String param;
	
	private PackWarehousingService packWarehousingService;
	
	public String queryPackWarehousing(){
		packWarehousingService = new PackWarehousingServiceImpl();
		setPacknomap(packWarehousingService.query(ServletPropertyFilterUtil
				.buildFromHttpRequest()));
		return "json";
	}
	
	public String savePackWarehousing(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				packWarehousingService = new PackWarehousingServiceImpl();
				if (pack != null) {
					if (pack.getId() != 0) {
						pack.setUpdateby(global.getUserinfo().getId());
						pack.setUpdatetime(new Date());
						packarriver.setUpdateby(global.getUserinfo().getId());
						packarriver.setUpdatetime(new Date());
						packarriver.setOrgid(global.getUserinfo().getOrgid());
						
						packarriver = packWarehousingService.savePackWarehousing(pack,packarriver);
						setPackarriver(packarriver);
						
						setMsg("修改成功！");
						markSuccess();
					} else {
						pack.setCreateby(global.getUserinfo().getId());
						pack.setCreatetime(new Date());
						pack.setUpdateby(global.getUserinfo().getId());
						pack.setUpdatetime(new Date());
						packarriver.setCreateby(global.getUserinfo().getId());
						packarriver.setCreatetime(new Date());
						packarriver.setUpdateby(global.getUserinfo().getId());
						packarriver.setUpdatetime(new Date());
						packarriver.setOrgid(global.getUserinfo().getOrgid());
						
						packarriver = packWarehousingService.savePackWarehousing(pack,packarriver);
						setPackarriver(packarriver);
						
						setMsg("添加成功！");
						markSuccess();
					}
					
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	
	public String whackPackarriver(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (packarriver != null) {
					packarriver.setUpdatetime(new Date());
					packarriver.setUpdateby(global.getUserinfo().getId());
					packWarehousingService = new PackWarehousingServiceImpl();
					packarriver = packWarehousingService.whackpack(packarriver);
					setPackid(packarriver.getId());
					setMsg("");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	
	public String packnoUpStatus(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (pack != null) {

					pack.setUpdateby(global.getUserinfo().getId());
					pack.setUpdatetime(new Date());
					setMsg("修改成功！");
					markSuccess();
					packWarehousingService = new PackWarehousingServiceImpl();
					int result = packWarehousingService.packnoUpStatus(pack);
					if(result==0){
						setMsg("没有单号为"+pack.getPackno()+"的行包!");
						markFail();
					}else if(result==-1){
						setMsg("数据异常,单号为"+pack.getPackno()+"存在多条数据!");
						markFail();
					}else if(result==-2){
						setMsg("单号为"+pack.getPackno()+"行包已入仓,无需再次入仓!");
						markFail();
					}else if(result==-3){
						setMsg("单号为"+pack.getPackno()+"行包已提领!");
						markFail();
					}else if(result==-4){
						setMsg("单号为"+pack.getPackno()+"行包已废弃,不能入仓!");
						markFail();
					}else if(result==-5){
						setMsg("单号为"+pack.getPackno()+"行包始发站未签发,不能入仓!");
						markFail();
					}else{
						setMsg("单号为"+pack.getPackno()+"行包入仓成功！");
						markSuccess();
					}
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	
	/**
	 * 根据条件查询行包单号           未使用
	 */
	public String queryPackno(){
		packWarehousingService = new PackWarehousingServiceImpl();
		setPacknomap(packWarehousingService.queryPackno(param,
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	public Packarriver getPackarriver() {
		return packarriver;
	}

	public void setPackarriver(Packarriver packarriver) {
		this.packarriver = packarriver;
	}

	public Pack getPack() {
		return pack;
	}

	public void setPack(Pack pack) {
		this.pack = pack;
	}

	public long getPackid() {
		return packid;
	}

	public void setPackid(long packid) {
		this.packid = packid;
	}

	public List<Map<String, Object>> getPacknomap() {
		return packnomap;
	}
	public void setPacknomap(List<Map<String, Object>> packnomap) {
		this.packnomap = packnomap;
	}
	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}
	
}
