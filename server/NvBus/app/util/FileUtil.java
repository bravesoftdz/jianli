package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.IOUtils;

public class FileUtil {
	/**
	 * 复制文件
	 * 
	 * @param sourceFile：源文件
	 * @param desFile：目标文件
	 */
	public static void copyFile(String sourceFile, String desFile) {
		FileInputStream fis = null;// 创建输入流
		FileOutputStream fos = null;// 创建输出流

		try {
			fis = new FileInputStream(sourceFile);// 将io流和文件关联
			fos = new FileOutputStream(desFile);
			byte[] buf = new byte[1024];
			int len;
			while ((len = fis.read(buf)) != -1) {
				fos.write(buf, 0, len);
			}
		} catch (FileNotFoundException e) {
			play.Logger.error("复制文件报错：" + e.getMessage());
		} catch (IOException e) {
			play.Logger.error("复制文件报错：" + e.getMessage());
		} finally {
			try {
				fis.close();
				fos.close();
			} catch (IOException e) {
				play.Logger.error("复制文件报错：" + e.getMessage());
			}
		}
	}
	
	public static boolean compareFileMD5(File file1,File file2){
		boolean res=false;
		FileInputStream fis;
		String md5_a = "";
		String md5_b = "";
		try {
			//file1源,file2目的
			if(file1==null ||!file1.exists()){
				return false; 
			}
			if(file2==null ||!file2.exists()){
				return true; 
			}
			fis = new FileInputStream(file1);
			md5_a = DigestUtils.md5Hex(IOUtils.toByteArray(fis));
			IOUtils.closeQuietly(fis);
			fis = new FileInputStream(file2);
			md5_b = DigestUtils.md5Hex(IOUtils.toByteArray(fis));
			IOUtils.closeQuietly(fis);
			if(md5_b.equals(md5_a)){
				res=false;
			}else{
				res=true;
			}
		} catch (FileNotFoundException e) {
			play.Logger.error(e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			play.Logger.error(e.getMessage());
			e.printStackTrace();
		}
		return res;
	}

	/**
	 * 拷贝文件夹下所有文件到目标文件夹
	 * 
	 * @param sourceFolerPath：源文件夹路径
	 * @param desFolderPath：目标文件夹路径
	 */
	public static boolean copyFolder(String sourceFolerPath, String desFolderPath) {
		boolean iscopy=false;
		try {
			File fileList = new File(sourceFolerPath);// 读取整个文件夹的内容到file字符串数组，下面设置一个游标i，不停地向下移开始读这个数组
			String[] file = fileList.list();
			if (file != null ) {
				File desFolder = new File(desFolderPath);
				// 如果文件夹不存在则创建
				if (!desFolder.exists() && !desFolder.isDirectory()) {
					play.Logger.info(desFolderPath + "//不存在");
					desFolder.mkdir();
				}/* else {
					play.Logger.info(desFolderPath + "//目录存在");
				}*/

				File temp = null;// temp仅仅是一个临时文件指针,整个程序并没有创建临时文件
				for (int i = 0; i < file.length; i++) {
					// 如果sourceFolerPath以路径分隔符/或者\结尾，那么取sourceFolerPath/文件名就可以了
					// 否则要在sourceFolerPath后面补个路径分隔符再加文件名
					// 原因是：无法确定传递过来的参数是f:/a还是f:/a/
					if (sourceFolerPath.endsWith(File.separator)) {
						temp = new File(sourceFolerPath + file[i]);
					} else {
						temp = new File(sourceFolerPath + File.separator + file[i]);
					}
					play.Logger.info("temp.getName()="+temp.getName());
					if(temp.exists()&& temp.getName().indexOf("svn")<=0&&temp.getAbsolutePath().indexOf("svn")<=0){
						if(compareFileMD5(temp,new File(desFolderPath + "/" + (temp.getName()).toString()))){
							// 如果游标遇到文件
							if (temp.isFile()) {
								play.Logger.info("filename="+temp.getName());
								FileInputStream input = new FileInputStream(temp);
								FileOutputStream output = new FileOutputStream(desFolderPath + "/" + (temp.getName()).toString());
								byte[] bufferarray = new byte[1024 * 64];
								int prereadlength;
								while ((prereadlength = input.read(bufferarray)) != -1) {
									output.write(bufferarray, 0, prereadlength);
								}
								output.flush();
								output.close();
								input.close();
								iscopy=true;
							}
						}
					}
					// 如果游标遇到文件夹
					if (temp.isDirectory()) {
						copyFolder(sourceFolerPath + "/" + file[i], desFolderPath + "/" + file[i]);
					}
				}
			}else{
				play.Logger.info(sourceFolerPath + "文件夹为空文件夹，不包含任何文件");
			}
		} catch (Exception e) {
			play.Logger.error("复制文件夹内容操作出错: " + e.getMessage(),e);
		}
		return iscopy;
	}
}
