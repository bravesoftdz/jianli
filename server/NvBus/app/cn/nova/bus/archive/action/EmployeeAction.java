package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Employee;
import cn.nova.bus.archive.service.EmployeeService;
import cn.nova.bus.archive.service.impl.EmployeeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class EmployeeAction extends BaseAction{
	EmployeeService employeeService;
	
	private Employee employeer;
	//返回结果
	private List<Map<String,Object>> employeemap;
	private List<Map<String,Object>> employeePicture;
	private long employeeid;

	//参数
	private Long delid;
	private String pictures;
	
	public String saveEmployee(){
		employeeService = new EmployeeServiceImpl();
		Employee e = null;
		String show ="";
		Global global = CurrentUtil.getGlobal();
		try{
			byte[] pc=ConversionUtil.toByteArr(pictures);
			employeer.setPicture(pc);	
			employeer.setIsactive(true);
			if(employeer.getId()!=0){
				employeer.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				employeer.setUpdateby(global.getUserinfo().getId());
				show="修改";
			}else{
				employeer.setCreateby(global.getUserinfo().getId());
				employeer.setCreatetime(new Timestamp(System.currentTimeMillis()));	
				employeer.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				employeer.setUpdateby(global.getUserinfo().getId());
				show="添加";
			}
			e = employeeService.saveEmployee(employeer);
			if(e!=null){
				employeeid = e.getId();
				setMsg(show+"成功");
				markSuccess();
			}
			else{
				setMsg(show+"失败");
				markFailure();
			}
		}catch(ServiceException ex){
			setMsg(show+"失败;" +ex.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String findEmployee(){		
		employeeService = new EmployeeServiceImpl();
		try{
			 setEmployeemap(employeeService.queryEmployee(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
		}		
		return "json";
	}
	
	public String findEmployeePicture(){
		employeeService = new EmployeeServiceImpl();
		try{
			setEmployeePicture(employeeService.findPicturebyId(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String delEmployee(){
		employeeService = new EmployeeServiceImpl();
		if(employeeService.delEmployee(delid)){
			setMsg("删除员工成功");
			markSuccess();
		}else{
			setMsg("删除员工失败");
			markFail();
		}
		return "json";
	}

	public Employee getEmployeer() {
		return employeer;
	}

	public void setEmployeer(Employee employeer) {
		this.employeer = employeer;
	}

	public List<Map<String, Object>> getEmployeemap() {
		return employeemap;
	}

	public void setEmployeemap(List<Map<String, Object>> employeemap) {
		this.employeemap = employeemap;
	}

	public Long getDelid() {
		return delid;
	}

	public void setDelid(Long delid) {
		this.delid = delid;
	}

	public String getPictures() {
		return pictures;
	}

	public void setPictures(String pictures) {
		this.pictures = pictures;
	}

	public List<Map<String, Object>> getEmployeePicture() {
		return employeePicture;
	}

	public void setEmployeePicture(List<Map<String, Object>> employeePicture) {
		this.employeePicture = employeePicture;
	}

	public long getEmployeeid() {
		return employeeid;
	}

	public void setEmployeeid(long employeeid) {
		this.employeeid = employeeid;
	}

}
