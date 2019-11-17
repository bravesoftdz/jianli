/**
 * 打印模板类型
 */
package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Printtemplatetype;
import cn.nova.bus.system.model.Printtemplatetypeitem;
import cn.nova.bus.system.service.PrinttemplatetypeService;
import cn.nova.bus.system.service.impl.PrinttemplatetypeServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author ice
 *
 */
public class PrinttemplatetypeAction extends BaseAction{
	private PrinttemplatetypeService printtemplatetypeService;
	
	private List<Map<String,Object>> printtemplatetypelist;
	private List<Map<String,Object>> printtemplatetypeitemlist;
	private Printtemplatetype printtemplatetype;
	private Printtemplatetypeitem printtemplatetypeitem;
	private long operationid;  //添加修改结果回传
	
	public String queryPrinttemplatetype(){
		try {
			printtemplatetypeService = new PrinttemplatetypeServiceImpl();
			setPrinttemplatetypelist(printtemplatetypeService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String queryPrinttemplatetypeitem(){
		try {
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQB_t!islist", printtemplatetypeitem.getIslist()));
			propertyFilters.add(new PropertyFilter("EQO_t!printtemplatetype", printtemplatetypeitem.getPrinttemplatetype()));
			printtemplatetypeService = new PrinttemplatetypeServiceImpl();
			setPrinttemplatetypeitemlist(printtemplatetypeService.queryItem(propertyFilters));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String queryPrinttemplatetypeitemAddDefault(){
		try {
			printtemplatetypeService = new PrinttemplatetypeServiceImpl();
			setPrinttemplatetypeitemlist(printtemplatetypeService.queryItemAddDefault(printtemplatetype.getId()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String savePrinttemplatetype(){
		try {
			printtemplatetypeService = new PrinttemplatetypeServiceImpl();
			if(printtemplatetype.getId()<=0){
				printtemplatetype = printtemplatetypeService.add(printtemplatetype);
				if(printtemplatetype!=null){
					setMsg("添加打印模板类型成功");
				}
			}
			else{
				printtemplatetype = printtemplatetypeService.udpate(printtemplatetype);
				if(printtemplatetype!=null){
					setMsg("修改打印模板类型成功");
				}
			}
			setOperationid(printtemplatetype.getId());
			markSuccess();
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getExceptionMessage());
		} catch (Exception e){
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}

	public String deletePrinttemplatetype(){
		try {
			printtemplatetypeService = new PrinttemplatetypeServiceImpl();
			if (printtemplatetypeService.delete(printtemplatetype)){
				setMsg("删除打印模板类型成功");
				markSuccess();
			}
		} catch (Exception e){
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}

	public String savePrinttemplatetypeitem(){
		try {
			printtemplatetypeService = new PrinttemplatetypeServiceImpl();
			if(printtemplatetypeitem.getId()<=0){
				printtemplatetypeitem = printtemplatetypeService.addItem(printtemplatetypeitem);
				if(printtemplatetypeitem!=null){
					setMsg("添加打印模板类型明细成功");
				}
			}
			else{
				printtemplatetypeitem = printtemplatetypeService.udpateItem(printtemplatetypeitem);
				if(printtemplatetypeitem!=null){
					setMsg("修改打印模板类型明细成功");
				}
			}
			setOperationid(printtemplatetypeitem.getId());
			markSuccess();
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getExceptionMessage());
		} catch (Exception e){
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}

	public String deletePrinttemplatetypeitem(){
		try {
			printtemplatetypeService = new PrinttemplatetypeServiceImpl();
			if (printtemplatetypeService.deleteItem(printtemplatetypeitem)){
				setMsg("删除打印模板类型项目成功");
				markSuccess();
			}
		} catch (Exception e){
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}
	
	public void setPrinttemplatetypelist(List<Map<String,Object>> printtemplatetypelist) {
		this.printtemplatetypelist = printtemplatetypelist;
	}

	public List<Map<String,Object>> getPrinttemplatetypelist() {
		return printtemplatetypelist;
	}

	public void setPrinttemplatetype(Printtemplatetype printtemplatetype) {
		this.printtemplatetype = printtemplatetype;
	}

	@Transient
	public Printtemplatetype getPrinttemplatetype() {
		return printtemplatetype;
	}

	public void setPrinttemplatetypeitem(Printtemplatetypeitem printtemplatetypeitem) {
		this.printtemplatetypeitem = printtemplatetypeitem;
	}

//	@JSON(serialize=false)
//	public Printtemplatetypeitem getPrinttemplatetypeitem() {
//		return printtemplatetypeitem;
//	}

	public void setPrinttemplatetypeitemlist(
			List<Map<String,Object>> printtemplatetypeitemlist) {
		this.printtemplatetypeitemlist = printtemplatetypeitemlist;
	}

	public List<Map<String,Object>> getPrinttemplatetypeitemlist() {
		return printtemplatetypeitemlist;
	}

	public void setOperationid(long operationid) {
		this.operationid = operationid;
	}

	public long getOperationid() {
		return operationid;
	}
	
}
