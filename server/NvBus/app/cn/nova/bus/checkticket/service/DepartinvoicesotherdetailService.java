package cn.nova.bus.checkticket.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface DepartinvoicesotherdetailService {

	public List<Map<String, Object>> query(
			List<PropertyFilter> buildFromHttpRequest);

	public Long save(Departinvoicesotherdetail detail) throws ServiceException;

	public boolean delete(long id) throws ServiceException;
	/**
	 * @Title ticketnoDelete
	 * @Description 结算单补录票号 删除明细数据
	 * @param id
	 * @return
	 * @throws ServiceException 
	 * boolean 
	 * @author tianhb
	 * @date 2016年6月29日-上午8:49:48
	 * @update 
	 * @throws
	 */
	public Integer ticketnoDelete(long id,long departinvoicesotherId) throws ServiceException;

	public List<Map<String, Object>> queryByotherticketno(List<PropertyFilter> buildFromHttpRequest);
	
}
