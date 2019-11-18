package controllers.DepartinvoicesotherJl.action;

import cn.nova.bus.action.BaseAction;
import cn.nova.utils.web.ServletPropertyFilterUtil;
import controllers.DepartinvoicesotherJl.service.DepartinvoicesotherJlService;
import controllers.DepartinvoicesotherJl.service.impl.DepartinvoicesotherJlServiceImpl;

import java.util.List;
import java.util.Map;

public class DepartinvoicesotherJlAction extends BaseAction {
    DepartinvoicesotherJlService service;

    public List<Map<String, Object>> getDepartinvoicemap() {
        return departinvoicemap;
    }

    public void setDepartinvoicemap(List<Map<String, Object>> departinvoicemap) {
        this.departinvoicemap = departinvoicemap;
    }

    private List<Map<String, Object>> departinvoicemap;

    public String query(){
        try {
            service = new DepartinvoicesotherJlServiceImpl();
            setDepartinvoicemap(service.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
        }catch (Exception e){
            play.Logger.error(e.getMessage(), e);
        }
        return "json";
    }
}
