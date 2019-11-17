/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.util.List;

import cn.nova.utils.commons.MethodResult;

/**
 * @author ice
 *
 */
public class ParamStationsOut extends MethodResult {
	private static final long serialVersionUID = -5839909141759521400L;
	private List<ParamStationOut> wsstations;//站点列表

	public List<ParamStationOut> getWsstations() {
		return wsstations;
	}

	public void setWsstations(List<ParamStationOut> wsstations) {
		this.wsstations = wsstations;
	}

}
