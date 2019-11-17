package cn.nova.bus.bill.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface BillinuseService {
	
	public Long save(Billinuse billinuse);

	public boolean backinuse(Billinuse billinuse, Billinuse newbillinuse);

	public boolean backinuse(Billinuse billinuse, long startno, long endno);

	public Billinuse findById(Long id);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	@SuppressWarnings("rawtypes")
	public List query(String sql);

	/**
	 * 初始化当前使用票据
	 * 
	 * @author ice
	 * @return methodResult类型为Billinuse
	 * @param billinuse
	 *            billinuse.billtypeid、billinuse.recipients、billinuse.nextno需要赋值
	 */
	public MethodResult initBillNo(Billinuse billinuse);

	/**
	 * 往后跳号，一般用于打印时调用
	 * @param billtypecode
	 * @param startbillno
	 * @param jumpnum
	 * @return
	 * @throws ServiceException 
	 */
	public Billinuse jumpBillinuse(long userid,String billtypecode,String startbillno,long jumpnum) throws ServiceException;

		/**
	 * 获取当前的票据领用信息
	 * 
	 * @author lck
	 * @return Billinuse
	 * @param
	 */
	public Billinuse getBilluse(long billtypeid, long recipients,long billno);

	/**
	 * 票证退领 ice 20120417重写
	 * @param billinuseid
	 * @param backstartno
	 * @param backendno
	 * @param userid
	 * @return
	 */
	public boolean backinuse(long billinuseid,long backstartno,long backendno,long userid) throws ServiceException;
	
}
