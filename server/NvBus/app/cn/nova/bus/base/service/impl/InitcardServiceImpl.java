/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.InitcardDao;
import cn.nova.bus.base.model.Initcard;
import cn.nova.bus.base.service.InitcardService;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class InitcardServiceImpl implements InitcardService {
	
	private InitcardDao dao = new InitcardDao();

	@Override
	public Initcard save(Initcard initcard, Long count, String ip) throws ServiceException {
		if (initcard.getId() == 0) {
			if (count != null && count > 0) {
				Long cardno = Long.parseLong(initcard.getCardno());
				for (int i = 0; i < count; i++) {
					String no = initcard.getCardno();
					Billtype billtype = dao.getBilltype(initcard.getCardtype());// 要修改
					if (billtype.getTicketnolength() != no.length()) {
						no = StringUtils.strPad(no,
								(int) billtype.getTicketnolength(), "0");
					}
					initcard.setCardno(no);
					if (dao.isExist(initcard.getCardno(),
							initcard.getCardtype())) {
						throw new ServiceException("卡号" + initcard.getCardno(),
								"0243");
					}
					if (dao.isExist(initcard.getSerialnumber())) {
						if (dao.findById(initcard.getSerialnumber()) > 0) {
							throw new ServiceException("0427");//该卡已经被使用过，不能再次使用！
//							Initcard init = getById(dao.findById(initcard
//									.getSerialnumber()));
//							initcard.setId(init.getId());
//							initcard.setCardno(init.getCardno());
//							initcard.setCardtype(init.getCardtype());
						}
					}
					String result = "智能卡：" + initcard.getCardno() + "添加成功";
					Operationlog operationLog = new Operationlog();
					operationLog.setIp(ip);
					operationLog.setContent(result.toString());
					operationLog.setModule("业务管理->智能卡初始化");
					operationLog.setOperatetime(new Date());
					operationLog.setOperation("智能卡初始化");
					operationLog.setSessionid("无session");
					operationLog.setUserid(initcard.getCreateby());
					dao.merge(operationLog);
					initcard = (Initcard) dao.merge(initcard);
					cardno = cardno + 1;
				}
				return initcard;
			} else {
				initcard.setSerialnumber(initcard.getCardno());
				return (Initcard) dao.merge(initcard);
			}
		} else {
			return (Initcard) dao.merge(initcard);
		}
	}

	@Override
	public boolean delete(Initcard initcard) {
		if (initcard != null) {
			return dao.del(initcard);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Initcard.class, id);
	}

	@Override
	public List<Initcard> query() {
		return dao.query(Initcard.class, null);
	}

	@Override
	public Initcard getById(Long id) {
		return (Initcard) dao.get(Initcard.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Initcard.class, "createname",
				"orgname" }, dao.query(propertyFilterList), new Object[] {
				Initcard.class, String.class, String.class });
	}

	@Override
	public boolean isExist(String serialnumber) {
		return dao.isExist(serialnumber);
	}

	@Override
	public boolean isExist(String cardno, String cardtype) {
		return dao.isExist(cardno, cardtype);
	}

	@Override
	public Long findId(String serialnumber) {
		return dao.findById(serialnumber);
	}

}
