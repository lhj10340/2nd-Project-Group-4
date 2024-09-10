package kr.tf.spring.interceptor;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.service.UserService;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	UserService userService;
	
	@Override
	public void postHandle(
	    HttpServletRequest request, 
	    HttpServletResponse response, 
	    Object handler, 
	    ModelAndView modelAndView)
	    throws Exception {
		
		UserVO user = (UserVO)modelAndView.getModel().get("user");
		
		System.out.println(user);
		
		if(user == null) {
			return;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		
		if(!user.isRemeber()) {
			return;
		}
		
		String sid = session.getId();
		
		Cookie cookie = new Cookie("LC", sid);
		
		int time = 60 * 60 * 24 * 10; // 자동 로그인 유효시간 10일. ( 초로 계산 )
		
		cookie.setMaxAge(time);
		cookie.setPath("/");
		
		Date date = new Date(System.currentTimeMillis() + time * 1000);
		user.setUs_cookie(sid);
		user.setUs_limit(date);
		
		userService.updateUserCookie(user);
		
		response.addCookie(cookie);
		
	}
}
