package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Complexfee;
import cn.nova.bus.balance.service.ComplexfeeService;
import cn.nova.bus.balance.service.impl.ComplexfeeServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：综合收费信息设置</b><br/>
 * <b>类名称：</b>ComplexfeeAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class ComplexfeeAction extends BaseAction{
	
	private ComplexfeeService complexfeeservice;
	
	private Complexfee complexfee;
	private Long id;
	private List<Map<String, Object>> complexfeemap;
	
	public String query() {
		complexfeeservice = new ComplexfeeServiceImpl();
		setComplexfeemap(complexfeeservice.query((ServletPropertyFilterUtil
					.buildFromHttpRequest())));
		return "json";
	}

	public String save() {
		complexfeeservice = new ComplexfeeServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if (complexfee != null) {
			if (complexfee.getId() > 0) {
				msg = "修改成功！";
				complexfee.setUpdateby(global.getUserinfo().getId());
				complexfee.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			} else {
				msg = "添加成功！";
				complexfee.setCreateby(global.getUserinfo().getId());
				complexfee.setUpdateby(global.getUserinfo().getId());
				complexfee.setPrinttime(new Timestamp(System.currentTimeMillis()));
				complexfee.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				complexfee.setCreatetime(new Timestamp(System.currentTimeMillis()));
			}
			complexfee = complexfeeservice.merge(complexfee);
			if(complexfee != null){
				setId(complexfee.getId());
				markSuccess();
			} else{
				markFail();
				msg = "操作失败！";
			}
		}
		return "json";
	}

	public String delete() {
		complexfeeservice = new ComplexfeeServiceImpl();
		if(complexfeeservice.delete(complexfee)){
			msg = "删除成功！";
			markSuccess();
		}else{
			msg = "删除失败！";
			markFail();
		}
		return "json";
	}

	public Complexfee getComplexfee() {
		return complexfee;
	}

	public void setComplexfee(Complexfee complexfee) {
		this.complexfee = complexfee;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<Map<String, Object>> getComplexfeemap() {
		return complexfeemap;
	}

	public void setComplexfeemap(List<Map<String, Object>> complexfeemap) {
		this.complexfeemap = complexfeemap;
	}
	
}
