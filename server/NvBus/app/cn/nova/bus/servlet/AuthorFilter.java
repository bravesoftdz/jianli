package cn.nova.bus.servlet;

import java.io.IOException;


import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;


public class AuthorFilter implements Filter {

	Logger log = Logger.getLogger(AuthorFilter.class);

	String errMsg = "";



	public String getErrMsg() {
		return errMsg;
	}

	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}

	@Override
	public void destroy() {
		  log.info("系统过滤器注销完毕......");
	}

	@Override
	public void doFilter(ServletRequest srequest, ServletResponse sresponse,
			FilterChain chain) throws IOException, ServletException {
		try {
			System.out.println("调用过滤器-------------------");
			HttpServletRequest request = (HttpServletRequest) srequest;
			HttpServletResponse response = (HttpServletResponse) sresponse;
			String secretKey=request.getParameter("secretKey");
			if (secretKey.equals("NOVAKEY"))
			{
				System.out.println("secretKey=---------------="+secretKey);
				errMsg = "很抱歉！您的连接密钥不对！请重新输入！";
			}
		/*	
			int flag = this.doAuthInit(request, response);
			log.info("flag:" + flag);
			if (flag == 1) {
				chain.doFilter(srequest, sresponse);
				return;
			}
			if (flag == 0)
				errMsg = "很抱歉！用户没有登录！请重新登录！";
			// response.sendRedirect(path+"/login.jsp");
			if (flag == 2)
				errMsg = "很抱歉！您没有访问该功能的权限！";
			if (flag == 3)
				errMsg = "很抱歉！系统权限认证错误，请与管理员联系！";
			// if (flag == 4){
			// errMsg = "很抱歉！您的账号已经在别处登录，请重新登录系统！";
			// }
			if (flag == 5) {
				errMsg = "警告！您正在非法操作系统，请重新登录系统！";
			}
			if (flag == 6) {
				log.info("系统过滤器开始记录日志......");
				srequest.getRequestDispatcher("/common/exportdata.jsp")
						.forward(srequest, sresponse);
			}
			*/
		} catch (Exception e) {
			this.log.error(e.getMessage());
		}

	}


	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

}
