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
public class ParamDepartStationsOut extends MethodResult {
	private static final long serialVersionUID = 5880080917389057326L;
	private List<ParamDepartStationOut> departstations;//发车站列表

	public List<ParamDepartStationOut> getDepartstations() {
		return departstations;
	}

	public void setDepartstations(List<ParamDepartStationOut> departstations) {
		this.departstations = departstations;
	}

}
