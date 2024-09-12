package kr.tf.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.tf.spring.model.vo.UserVO;

public class GuestInterceptor extends HandlerInterceptorAdapter {
	
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
			
				UserVO user = (UserVO)request.getSession().getAttribute("user");

				if(user != null) {
					response.setContentType("text/html; charset=UTF-8");
					response.getWriter().write("<script>alert(\"회원은 접근할 수 없습니다.\")</script>");
					response.getWriter().write("<script>location.href=\""+request.getContextPath() 
						+ "/"+"\"</script>");
					response.flushBuffer();
					return false;
				}
				//아니면 가려던 길을 감
				return true;
	}
	
}
