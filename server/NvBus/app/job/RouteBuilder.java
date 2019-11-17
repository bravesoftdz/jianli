package job;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import cn.nova.bus.common.NvBusVerifyConst;
import cn.nova.bus.system.model.Version;
import cn.nova.bus.system.model.VersionVerify;
import models.ActionNode;
import play.Logger;
import play.Play;
import play.db.jpa.JPA;
import play.jobs.Job;
import play.jobs.OnApplicationStart;
import play.vfs.VirtualFile;
import util.Appvar;
import util.FileUtil;
import util.SystemException;
import util.UserTransaction;

@OnApplicationStart
public class RouteBuilder extends Job {
	public static final String SPECIAL_P = "_P_";
	public void doJob() throws Exception{
		super.doJob();
		Map<String, ActionNode> routes = new HashMap<String, ActionNode>();
		VirtualFile vf = VirtualFile.fromRelativePath("/conf/switch");
		File realFile = vf.getRealFile();
		if(realFile == null){
			throw new Exception("haven't switch file, cann't do builder!");
		}
		BufferedReader br = new BufferedReader( new FileReader(realFile));
		String line = null;
		while ((line = br.readLine()) != null) {
			String[] params = line.trim().split("\\s+");
			routes.put(params[0].toUpperCase(), new ActionNode(params[1],params[2]));
		}
		br.close();
		//加载插件switch
		vf = VirtualFile.fromRelativePath("/modules");
		File root = vf.getRealFile();
	    File[] files = root.listFiles();
	    if(files!=null){
			for (File file : files) {
				if (!"NvJavaUtil".equals(file.getName())
						&& !file.getName().contains(".")) {
					realFile = new File(file.getPath() + "/conf/switch");
					if (!realFile.exists()) {
						play.Logger.error(file.getPath()
								+ " haven't switch file, cann't do builder!");
					} else {
						br = new BufferedReader(new FileReader(realFile));
						line = null;
						while ((line = br.readLine()) != null) {
							String[] params = line.trim().split("\\s+");
							routes.put(params[0].toUpperCase(), new ActionNode(
									params[1], params[2]));
						}
					}
				}
			}

			br.close();
			// 加载插件plugins
			for (File file : files) {
				if (!"NvJavaUtil".equals(file.getName())
						&& !file.getName().contains(".")) {
					realFile = new File(file.getPath() + "/conf/pluginReg");
					if (!realFile.exists()) {
						play.Logger.error(file.getPath()
								+ " haven't plugins file, cann't do builder!");
					} else {
						br = new BufferedReader(new FileReader(realFile));
						line = null;
						while ((line = br.readLine()) != null) {
							String[] params = line.trim().split("\\s+");
							routes.put(params[0].toUpperCase(), new ActionNode(
									params[1], params[2]));
						}
					}
				}
			}
			br.close();
			boolean iscopy=false;
			//拷贝插件中的public\download下面的文件到主工程public\download下
			for (File file : files) {
				if (!"NvJavaUtil".equals(file.getName()) && !file.getName().contains(".") && file.getName().indexOf("svn")<=0) {
					boolean iscopytmp=FileUtil.copyFolder(file.getPath() + "/public/download", Play.applicationPath.getPath() + "/public/download");
					if(iscopytmp){
						play.Logger.info("copy file="+file.getName()+" successed");
						iscopy=true;
					}else{
						play.Logger.info("iscopytmp=false");
					}					
				}
			}
			//若需要拷贝则更新版本号信息，让客户端进行下载
			if(iscopy){
				play.Logger.info("updateVersion  begin ");
				updateVersion();
				play.Logger.info("updateVersion  end ");				
			}else{
				play.Logger.info("iscopy=false updateVersion  fail");
			}
	    }
		Appvar.routes = routes;
		Logger.log4j.info("load switch file successed!");
		//暂时不处理序列问题
		/*CreateSequence seq=new CreateSequence();
		JPA.newEntityManager();
		seq.createSeq(JPA.getCurrentConfigName());*/
	}
	
	
	public void updateVersion() {
		File file = new File(getClass().getProtectionDomain().getCodeSource().getLocation().getPath()
				+ "/public/download/serverversion.txt");
		File cfile = new File(getClass().getProtectionDomain().getCodeSource().getLocation().getPath()
				+ "/public/download/version.txt");		
		BufferedReader reader = null;
		BufferedWriter wirter=null;
		String serverversion="";
		boolean flag=false;
		try {
			SimpleDateFormat sf=new SimpleDateFormat("yyyyMMddHHmmss");
			if (file!=null && file.exists()) {
				reader = new BufferedReader(new FileReader(file));
				serverversion = reader.readLine();
				play.Logger.info("before serverversion.txt serverversion="+serverversion);
				//获取要修改的版本号  ps:FIX5.2_01_P_01
				String serverversionstr = getserverversionstr(serverversion);
				if(serverversionstr.equals(serverversion)){//如果没有获取到则按原逻辑取时间戳
					serverversion=serverversion.substring(0, 8)+"_"+sf.format(new Date());		
				}else{
					serverversion =serverversionstr;
				}
//				serverversion=serverversion.substring(0, 8)+"_"+sf.format(new Date());				
				reader.close();
				wirter = new BufferedWriter(new FileWriter(file));
				wirter.write(serverversion);
				wirter.close();
				play.Logger.info("after serverversion.txt serverversion="+serverversion);
			}		
			if (cfile!=null && cfile.exists()) {
				play.Logger.info("before version.txt version="+serverversion);		
				wirter = new BufferedWriter(new FileWriter(cfile));
				wirter.write(serverversion);
				wirter.close();
				play.Logger.info("after version.txt version="+serverversion);
				flag=true;
			}
			if(flag){
				play.Logger.info("serverversion="+serverversion);
				updateserverVersion(serverversion);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		
	}
	//获取插件版本号
	private String getserverversionstr(String serverversion) {
		//传值过来的服务端版本号
		String serverversionold = serverversion;
		//返回的服务端版本号
		String serverversionstr = "";
		//临时的序号
		String temp="00";
		//FIX5.2_01_P_01     5.2 版本第一个增量之后的插件
		//FIX5.2_01_01_P_01  5.2版本第一个增量的第一个临时后的插件
		int j = 1;
		 //优先判断当前版本是否是插件版本 如果是 获得当前的主版本和插件的
		if(serverversion.indexOf(SPECIAL_P)!=-1){ 
			//如果存在这种情况说明是在升级某个版本的插件之后再次升级插件(并且数据库和这个serverversion一定是一样的)  在序号之后+1 为新的版本号
			String[] arr =  serverversion.split(SPECIAL_P);
			j=Integer.valueOf(arr[1].toString());
			temp = temp+(j+1);
			serverversion = arr[0].toString();
		    serverversionstr = serverversion + SPECIAL_P + temp.substring(temp.length() - 2, temp.length()); 
		 }else{
			 serverversionstr =serverversion + SPECIAL_P + "01";
		 }
		if("".equals(serverversionstr)){
			serverversionstr = serverversionold;
		}
		return serverversionstr;
	}
	private UserTransaction userTransaction = new UserTransaction();

		public boolean updateserverVersion(String versionnum) {
			int res = 0;
			try {
				userTransaction.begin();
				/*StringBuffer sql = new StringBuffer();
				sql.append("update  Version v  set v.versionnum=:versionnum ");
				Query query =JPA.em().createNativeQuery(sql.toString());
				query.setParameter("versionnum", versionnum);
				res = query.executeUpdate();*/
				String appName = Play.applicationPath.getName();
				if(NvBusVerifyConst.NVBUS_VERIFY_APP_NAME.equals(appName)){
					//工程名为测试版，则更新测试版本表VersionVerify
					VersionVerify versionVerify = new VersionVerify();
					versionVerify.setVersionnum(versionnum);
					versionVerify.setUpdatetime(new Date());
					JPA.em().merge(versionVerify);
				}else{
					//正式版：更新Version表
					Version ver=new Version();
					ver.setVersionnum(versionnum);
					ver.setUpdatetime(new Date());
					JPA.em().merge(ver);
				}
				userTransaction.commit();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				play.Logger.error("更新版本号异常！",e1);
				try {
					userTransaction.rollback();
				} catch (SystemException e) {
					play.Logger.error(e.getMessage(),e);
					e.printStackTrace();
				}
			}
			return res > 0 ? true : false;
		}
}
