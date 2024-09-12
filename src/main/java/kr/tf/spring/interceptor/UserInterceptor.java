package kr.tf.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.tf.spring.model.vo.UserVO;

public class UserInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
		
				UserVO user = (UserVO)request.getSession().getAttribute("user");

				if(user == null) {
					response.setContentType("text/html; charset=UTF-8");
					response.getWriter().write("<script>alert(\"회원만 접근할 수 있습니다.\")</script>");
					response.getWriter().write("<script>location.href=\""+request.getContextPath() 
						+ "/"+"\"</script>");
					response.flushBuffer();
					return false;
				}
				//아니면 가려던 길을 감
				return true;
	}
	
}
