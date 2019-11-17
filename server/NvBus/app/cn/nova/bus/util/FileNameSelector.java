/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.util<br/>
 * <b>文件名：</b>FileNameSelector.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-7-22-下午05:06:25<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.util;

import java.io.File;
import java.io.FilenameFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>FileNameSelector<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class FileNameSelector implements FilenameFilter {

	String extension = ".";

	/*
	 * accept方法：<br/> <br/>
	 * 
	 * @param dir
	 * 
	 * @param name
	 * 
	 * @return
	 * 
	 * @see java.io.FilenameFilter#accept(java.io.File, java.lang.String)
	 * 
	 * @exception
	 */
	@Override
	public boolean accept(File dir, String name) {
		return name.endsWith(extension);
	}

	public FileNameSelector(String fileExtensionNoDot) {
		extension += fileExtensionNoDot;
	}

}
