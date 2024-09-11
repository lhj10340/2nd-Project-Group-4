package kr.tf.spring.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.service.UserService;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter{

	@Autowired
	UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		
		if(user != null) {
			return true;
		}
		
		Cookie cookie = WebUtils.getCookie(request, "LC");
		
		if(cookie == null) {
			return true;
		}
		
		String sid = cookie.getValue();
		user = userService.getUserByCookie(sid);
		
		if(user != null) {
			session.setAttribute("user", user);
		}
		
		return true;
	}
	
}
