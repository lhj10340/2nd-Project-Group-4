package kr.tf.spring.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@Autowired
	private UserService userService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "/main/home";
	}
	
	@GetMapping("/login")
	public String login(Model mo, UserVO user) {
		// 화면
		return "/user/login";
	}
	
	@PostMapping("/login")
	public String login_post(Model mo, UserVO user_, HttpSession session) {
		// from테그에서 입력 받아용
		// user_ 는 화면에서 받아온 친구
		
		// 세션에 저장
		return "/main/msg";
	}
	
	@GetMapping("/signup")
	public String signup(Model mo, UserVO user) {
		// 화면
		return "/user/signup";
	}
	
	@PostMapping("/signup")
	public String signup_post(Model mo, UserVO user_) {
		// from테그에서 입력 받아용
		// user_ 는 화면에서 받아온 친구
		
		
		return "/main/msg";
	}
	
	@GetMapping("/logout")
	public String logout(Model mo, HttpSession session) {
		
		//user 가 있으면 삭제 해줍니당
		session.removeAttribute("user");
		return "/main/msg";
	}
	
	
}
