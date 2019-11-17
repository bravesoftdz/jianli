/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.system.action<br/>
 * <b>文件名：</b>FileUpdateAction.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-7-22-下午02:55:05<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.IOUtils;

import play.Play;
import play.mvc.Http.Request;
import util.CommonUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.util.FileNameSelector;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>FileUpdateAction<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */

public class FileUpdateAction extends BaseAction{
	private String filetype;
    private boolean isupdate=true;
    private String fileXML;
    
	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String getFileXML() {
		return fileXML;
	}

	public void setFileXML(String fileXML) {
		this.fileXML = fileXML;
	}
	
	private void walk(File rootFile,String prefix,StringBuilder tempSb){
		File[] bplFiles = null;
		
		if (filetype != null) {
			bplFiles = rootFile.listFiles(new FileNameSelector(filetype));
		} else {
			bplFiles = rootFile.listFiles();
		}
		
		for (File file : bplFiles) {
			if(file.isDirectory() && prefix.indexOf("svn")<=0  && file.getName().indexOf("svn")<=0){
				walk(file, prefix + file.getName() + "/", tempSb);
			} else if (file.canRead()) {
				// 下载所有文件，包括系统包
				if (tempSb.indexOf("svn") <= 0 && file.getName().indexOf("svn") <= 0) {
					FileInputStream fis;
					String md5 = "";
					try {
						fis = new FileInputStream(file);
						md5 = DigestUtils.md5Hex(IOUtils.toByteArray(fis));
						IOUtils.closeQuietly(fis);
					} catch (FileNotFoundException e) {
						play.Logger.error(file.getName() + "文件没有找到" + e.getMessage());
						e.printStackTrace();
					} catch (IOException e) {
						play.Logger.error(file.getName() + "文件流读取错误" + e.getMessage());
						e.printStackTrace();
					}
					tempSb.append("<file name='").append(prefix).append(file.getName()).append("' lastmodify='")
							.append(CommonUtil.dateToFullString(new Date(file.lastModified())))
							.append("' md5='" + md5 + "'#>");
				}
			}
		}
	}
	
	public String checkversion(){
		FileInputStream serverversion = null;
		FileInputStream version = null;
		BufferedReader serverbr = null;
		BufferedReader clientbr = null;
		String sstr = "";
		String cstr = "";
        try {
        	serverversion = new FileInputStream(Play.applicationPath+"/public/download/serverversion.txt");
        	version = new FileInputStream(Play.applicationPath+"/public/download/version.txt");
        	
        	serverbr = new BufferedReader(new InputStreamReader(serverversion)); 
        	clientbr = new BufferedReader(new InputStreamReader(version)); 
        	while ((sstr = serverbr.readLine()) != null) {
//        		sstr += sstr;
        		break;
        	}
        	while ((cstr = clientbr.readLine()) != null) {
//        		cstr += cstr;
        		break;
        	}
        	File chkfile = new File(Play.applicationPath, "/public/download/chk.txt");
        	if(chkfile!=null&&chkfile.canRead()){
        		SimpleDateFormat sf=new SimpleDateFormat("yyyyMMdd");
        		sstr = sstr+sf.format(new Date());
        	}
        	fileXML = "<filelist>" 
        			+ "<file name='checkversion' serverversion='" + sstr + "' clientversion='" + cstr + "'#>" 
        			+ "<#filelist>";
        	play.Logger.info("当前服务器中服务器版本=========>"+serverbr.readLine()!=null ? serverbr.readLine() : "");
        	play.Logger.info("当前服务器中客户端版本=========>"+clientbr.readLine()!=null ? clientbr.readLine() : "");
        } catch (IOException e) {
        	play.Logger.error("文件流读取错误,请检查serverversion.txt和version.txt是否存在====>" + e.getMessage());
        } finally {
        	try {
				serverversion.close();
				version.close();
				serverbr.close();
				clientbr.close();
			} catch (IOException e) {
				play.Logger.error("文件流关闭错误!" + e.getMessage());
			}
        }
		return "json";
	}

	public String updatefile() {
		try {
			//HttpServletResponse response=ServletActionContext.getResponse();
			//response.sendError(400);
			String remoteIP = Request.current().remoteAddress;
			System.out.println(remoteIP + " startup update file^^^^^^^^^^^^^");
			if(isupdate){
				File rootFile = new File(Play.applicationPath, "/public/download");
				System.out.println(rootFile.getAbsolutePath());

				String item = "";
				
				StringBuilder tempSb = new StringBuilder();
				walk(rootFile, "", tempSb);
				if(tempSb.length() == 0){
					item = "<file name='tst' lastmodify='" + CommonUtil.dateToFullString(new Date()) + "'#>";				
				}else{
						item = tempSb.toString();
				}
				
				fileXML = "<filelist>" + item + "<#filelist>";
				System.out.println(remoteIP + " end down file^^^^^^^^^^^^^");
			}
			else{
				System.out.println("no startup update file^^^^^^^^^^^^^^^^");
				String xml = "<filelist>";
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				
				String item = "<file name='tst' lastmodify='" + sf.format(new Date())
				+ "'#>" ;
				fileXML = xml + item + "<#filelist>";
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}

}
