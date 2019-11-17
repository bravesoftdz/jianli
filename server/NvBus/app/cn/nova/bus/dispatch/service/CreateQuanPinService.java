package cn.nova.bus.dispatch.service;

import cn.nova.bus.archive.model.Driver;

/**
 * 给driver的姓名生成全拼
 * @author Administrator
 *
 */
public interface CreateQuanPinService {

	/**
	 * 查询全拼内容为空的Driver
	 * @return
	 */
	public void queryDriver();
}
