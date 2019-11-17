package cn.nova.bus.query.action;

import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.security.Global;
import cn.nova.bus.util.QueryFromFile;
/**
 * 
 * <b>类描述：通用的分页查询action</b><br/>
 * <b>类名称：</b>PaginationQryAction<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@bus365.com">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
public class PaginationQryAction extends BaseAction{

	private List<Map<String,Object>>  reportlist;
	
	private int  pagesize;//每页记录数
	
	private int pages; //第N页

	private String reportname;

	public String commonQry() {
		try {
			Global global = CurrentUtil.getGlobal();
			QueryFromFile qry = new QueryFromFile();
			setReportlist(qry.query(global,reportname,pagesize,pages));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	

	public List<Map<String, Object>> getReportlist() {
		return reportlist;
	}

	public void setReportlist(List<Map<String, Object>> reportlist) {
		this.reportlist = reportlist;
	}
	public String getReportname() {
		return reportname;
	}



	public void setReportname(String reportname) {
		this.reportname = reportname;
	}
	public int getPagesize() {
		return pagesize;
	}



	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}



	public int getPages() {
		return pages;
	}



	public void setPages(int pages) {
		this.pages = pages;
	}
	
}
