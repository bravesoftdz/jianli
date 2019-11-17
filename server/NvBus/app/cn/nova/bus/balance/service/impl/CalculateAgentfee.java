package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;

import groovy.lang.Binding;
import groovy.lang.GroovyShell;
import cn.nova.bus.balance.vo.CalculateItem;
import cn.nova.bus.util.GroovydataFormatUtil;
/**
 * 
 * <b>类描述：根据复杂公式计算客运站代理费</b><br/>
 * <b>类名称：</b>CalculateAgentfee<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
public class CalculateAgentfee {
	public static BigDecimal calculate(CalculateItem citem, String formalu) {
		BigDecimal agentfee = new BigDecimal(0);
		try {
			Binding binding = new Binding();
			binding.setVariable("peoples", citem.getPeoples());
			binding.setVariable("totalprice", citem.getTotalprice());
			binding.setVariable("stationfee", citem.getStationfee());
			binding.setVariable("computefee", citem.getComputefee());
			binding.setVariable("coolairfee", citem.getCoolairfee());
			binding.setVariable("additionfee", citem.getAdditionfee());
			binding.setVariable("fueladditionfee", citem.getFueladditionfee());
			binding.setVariable("waterfee", citem.getWaterfee());
			binding.setVariable("insurefee", citem.getInsurefee());
			binding.setVariable("otherfee", citem.getOtherfee());
			binding.setVariable("departdate", citem.getDepartdate());
			binding.setVariable("intervalmonths", citem.getIntervalmonths());
			binding.setVariable("balancedate", citem.getBalancedate());
			binding.setVariable("intervalsday", citem.getIntervalsday());
			GroovyShell shell = new GroovyShell(binding);
			Object o = shell.evaluate(formalu);
			agentfee = GroovydataFormatUtil.format(o);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return agentfee;
	}

}
