package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Printtemplate;
import cn.nova.bus.system.model.Printtemplateitem;
import cn.nova.bus.system.service.PrinttemplateService;
import cn.nova.bus.system.service.impl.PrinttemplateServiceImpl;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author ice
 *
 */
public class PrinttemplateAction extends BaseAction{
	private PrinttemplateService printtemplateService;
	
	private List<Map<String,Object>> printtemplatelist;
	private List<Map<String,Object>> printtemplateitemlist;
	private Printtemplate printtemplate;
	private List<Printtemplateitem> printtemplateitems;
	private boolean autoGenerateItem; //添加模板时是否自动生成打印模板项目
	private long operationid;  //添加修改结果回传
	private String pictures;
	private Long printtemplateId;
	
	public String getPictures() {
		return pictures;
	}

	public void setPictures(String pictures) {
		this.pictures = pictures;
	}

	public String queryPrinttemplate(){
		try {
			printtemplateService = new PrinttemplateServiceImpl();
			setPrinttemplatelist(printtemplateService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String queryPrinttemplateitem(){
		try {
			printtemplateService = new PrinttemplateServiceImpl();
			setPrinttemplateitemlist(printtemplateService.queryItem(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String savePrinttemplate(){

		Global global = CurrentUtil.getGlobal();
		try {
			printtemplateService = new PrinttemplateServiceImpl();
			if(printtemplate.getId()<=0){
				printtemplate = printtemplateService.add(printtemplate,autoGenerateItem,global.getUserinfo().getId());
				if(printtemplate!=null){
					setMsg("添加打印模板成功，需重新登录才能生效！");
				}
			}
			else{
				printtemplate = printtemplateService.udpate(printtemplate,global.getUserinfo().getId());
				if(printtemplate!=null){
					setMsg("修改打印模板成功，需重新登录才能生效！");
				}
			}
			setOperationid(printtemplate.getId());
			markFlag(1);
		} catch (ServiceException e) {
			markFlag(-1);
			setMsg(e.getExceptionMessage());
		} catch (Exception e){
			setMsg(e.getMessage());
		}
		return "json";
	}

	public String deletePrinttemplate(){
		Global global = CurrentUtil.getGlobal();
		try {
			printtemplateService = new PrinttemplateServiceImpl();
			if (printtemplateService.delete(printtemplate,global.getUserinfo().getId())){
				setMsg("删除打印模板成功");
				markFlag(1);
			}
		} catch (Exception e){
			markFlag(-1);
			setMsg(e.getMessage());
		}
		return "json";
	}

	public String savePrinttemplateitems(){
		
		setPrinttemplateitemlist(ListUtil.listToMap(new Object[]{Printtemplateitem.class}, null));
		Global global = CurrentUtil.getGlobal();
		try {
			for (Printtemplateitem printtemplateitem : printtemplateitems) {
				if(printtemplateitem.getPicture()!=null && printtemplateitem.getPicture().length()>0){
					byte[] pc=ConversionUtil.toByteArr(pictures);
					if(pictures==null || pictures.equals("")){
						play.Logger.info("pictures==null");
						 pc=ConversionUtil.toByteArr(printtemplateitem.getPicture());
					}else{
						play.Logger.info("pictures!=null");
					}
					printtemplateitem.setPrintpicture(pc);
				}
			}
			printtemplateService = new PrinttemplateServiceImpl();
			if(printtemplateService.saveItems(printtemplateitems, global.getUserinfo().getId())==true){
				setMsg("保存打印模板明细成功，需重新登录才能生效！");
				markSuccess();
			}
			else{
				setMsg("保存打印模板明细失败");
			}
		} catch (ServiceException e) {			
			setMsg(e.getExceptionMessage());
		} catch (Exception e){
			setMsg(e.getMessage());
		}
		return "json";
	}

	public String deleteInVisibleItem(){
		Global global = CurrentUtil.getGlobal();
		try {
			printtemplateService = new PrinttemplateServiceImpl();
			if (printtemplateService.deleteInVisibleItem(printtemplate,global.getUserinfo().getId())){
				setMsg("删除打印模板不可见项目成功");
				markSuccess();
			}
		} catch (Exception e){
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}
	
	/**
	 * 打印模板复制
	 * @return
	 */
	public String copyPrinttemplate(){
		Global global = CurrentUtil.getGlobal();
		try {
			printtemplateService = new PrinttemplateServiceImpl();
			printtemplate = printtemplateService.copyPrinttemplate(printtemplate, global);//模板复制
			if(printtemplate != null){
				setPrinttemplateId(printtemplate.getId());
				setMsg("打印模板复制成功！");
				markSuccess();
			}else{
				setMsg("打印模板复制失败！");
				markFail();
			}
		} catch (ServiceException e) {
			play.Logger.error(e.getMessage());
			markFail();
			setMsg(e.getExceptionMessage());
		} catch (Exception e){
			play.Logger.error(e.getMessage());
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}
	
	public void setPrinttemplatelist(List<Map<String,Object>> printtemplatelist) {
		this.printtemplatelist = printtemplatelist;
	}

	public List<Map<String,Object>> getPrinttemplatelist() {
		return printtemplatelist;
	}

	public void setPrinttemplate(Printtemplate printtemplate) {
		this.printtemplate = printtemplate;
	}

//	@JSON(serialize=false)
//	public Printtemplate getPrinttemplate() {
//		return printtemplate;
//	}

	public void setPrinttemplateitemlist(
			List<Map<String,Object>> printtemplateitemlist) {
		this.printtemplateitemlist = printtemplateitemlist;
	}

	public List<Map<String,Object>> getPrinttemplateitemlist() {
		return printtemplateitemlist;
	}

	public void setPrinttemplateitems(List<Printtemplateitem> printtemplateitems) {
		this.printtemplateitems = printtemplateitems;
	}

	@Transient
	public List<Printtemplateitem> getPrinttemplateitems() {
		return printtemplateitems;
	}

	public void setOperationid(long operationid) {
		this.operationid = operationid;
	}

	public long getOperationid() {
		return operationid;
	}
	
	@Transient
	public boolean isAutoGenerateItem() {
		return autoGenerateItem;
	}

	public void setAutoGenerateItem(boolean autoGenerateItem) {
		this.autoGenerateItem = autoGenerateItem;
	}

	public Long getPrinttemplateId() {
		return printtemplateId;
	}

	public void setPrinttemplateId(Long printtemplateId) {
		this.printtemplateId = printtemplateId;
	}
	
}