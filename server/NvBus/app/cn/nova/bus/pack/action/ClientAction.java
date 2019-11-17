package cn.nova.bus.pack.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Client;
import cn.nova.bus.pack.service.ClientService;
import cn.nova.bus.pack.service.impl.ClientServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class ClientAction extends BaseAction{
	private Client client;
	private long clientid;
	private List<Map<String, Object>> clientmap;
	
	private String param;
	
	private ClientService clientService;
	
	public String queryClient(){
		clientService = new ClientServiceImpl();
		setClientmap(clientService.queryClient(	ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	public String saveClient(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (client != null) {
					if (client.getId() != 0) {
						client.setUpdateby(global.getUserinfo().getId());
						client.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						client.setCreateby(global.getUserinfo().getId());
						client.setCreatetime(new Date());
						client.setUpdateby(global.getUserinfo().getId());
						client.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
					clientService = new ClientServiceImpl();
					client = clientService.saveClient(client);
					setClientid(client.getId());
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
	
	public String delCustomer(){		
		clientService = new ClientServiceImpl();
		if(clientService.delClient(clientid)){
			setMsg("删除行包客户档案成功");
			markSuccess();
		}else{
			setMsg("删除行包客户档案失败");
			markFail();
		}
		return "json";
	}
	
	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public long getClientid() {
		return clientid;
	}

	public void setClientid(long clientid) {
		this.clientid = clientid;
	}

	public List<Map<String, Object>> getClientmap() {
		return clientmap;
	}

	public void setClientmap(List<Map<String, Object>> clientmap) {
		this.clientmap = clientmap;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

}
