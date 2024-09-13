package kr.tf.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.tf.spring.model.vo.UserVO;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
			
			UserVO user = (UserVO)request.getSession().getAttribute("user");
			
			if(user == null || user.getUs_auth() != 9) {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write("<script>alert(\"관리자만 접근할 수 있습니다.\")</script>");
				response.getWriter().write("<script>location.href=\""+request.getContextPath() 
					+ "/"+"\"</script>");
				response.flushBuffer();
				return false;
			}
		
			//구현
			return true;
	}
	
}
