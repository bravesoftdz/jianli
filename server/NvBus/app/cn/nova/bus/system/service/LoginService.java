package cn.nova.bus.system.service;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;

public interface LoginService {
	public Global login(String code, String userpwd, String ipAddress,
			String sessionid,String ticketoutletcode,String servernum,String clientversion) throws ServiceException;

	public boolean loginaudit(String username, String md5password, String permissionkey) throws ServiceException;

	public boolean checkVersion(String clientversion);

	public MethodResult verifyValidityOfPassword(Global global);

	public Integer getExpiretime(Global global);

}
