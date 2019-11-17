package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Contractor;
import cn.nova.bus.archive.service.ContractorService;
import cn.nova.bus.archive.service.impl.ContractorServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class ContractorAction extends BaseAction{
	ContractorService contractorService;
	
	private Contractor contractor;
	private long contractorid;
	//返回结果
	private List<Map<String,Object>>  contractormap;
	
	//参数
	private Long delid;

	public String saveContractor(){
		contractorService = new ContractorServiceImpl();
		Contractor c = null;
		String show ="";
		Global global = CurrentUtil.getGlobal();
		contractor.setIsactive(true);
		if(contractor.getId()!=0){
			contractor.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			contractor.setUpdateby(global.getUserinfo().getId());
			show="修改";
		}else{
			contractor.setCreateby(global.getUserinfo().getId());
			contractor.setCreatetime(new Timestamp(System.currentTimeMillis()));	
			contractor.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			contractor.setUpdateby(global.getUserinfo().getId());
			show="添加";
		}
		try {
			c = contractorService.saveContractor(contractor);
			if(c != null){
				contractorid = c.getId();
				setMsg(show+"成功!");
				markSuccess();
			}
		} catch (ServiceException e) {
			setMsg(show+"失败:"+e.getExceptionMessage());
			markFailure();
		}
		return "json";
	}
	
	public String findContractor(){
		contractorService = new ContractorServiceImpl();
		try{
			 setContractormap(contractorService.queryContractor(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
		}		
		return "json";
	}
	
	public String delContractor(){
		contractorService = new ContractorServiceImpl();
		if(contractorService.delContractor(delid)){
			setMsg("删除承包者档案成功");
			markSuccess();
		}else{
			setMsg("删除承包者档案失败");
			markFail();
		}
		return "json";
	}
	
	public Contractor getContractor() {
		return contractor;
	}

	public void setContractor(Contractor contractor) {
		this.contractor = contractor;
	}

	public List<Map<String, Object>> getContractormap() {
		return contractormap;
	}

	public void setContractormap(List<Map<String, Object>> contractormap) {
		this.contractormap = contractormap;
	}

	public Long getDelid() {
		return delid;
	}

	public void setDelid(Long delid) {
		this.delid = delid;
	}

	public long getContractorid() {
		return contractorid;
	}

	public void setContractorid(long contractorid) {
		this.contractorid = contractorid;
	}
	
}
