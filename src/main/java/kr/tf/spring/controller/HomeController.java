package kr.tf.spring.controller;

import java.text.DateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.tf.spring.model.dto.LoginDTO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.service.RestaurantService;
import kr.tf.spring.service.UserService;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RestaurantService restaurantService;

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
	public String login_post(Model mo, LoginDTO user_, HttpSession session) {
		// from테그에서 입력 받아용
		// user_ 는 화면에서 받아온 친구
		// remember 는 on 혹은 null 값을 가지고 쿠키와 관련되서 사용
		UserVO user = userService.login(user_);
		System.out.println(user);
		if (user != null) {
			session.setAttribute("user", user);//세션에 저장해용
			mo.addAttribute("msg", user.getUs_id() + "님 환영합니다.");
			mo.addAttribute("url","/");
		} else {
			mo.addAttribute("msg", "잘못된 로그인입니다. 다시 확인해주세요.");
			mo.addAttribute("url","/");
		}
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
	
	@PostMapping("/ajax/list")
	@ResponseBody
	public List<RestaurantVO> ajaxPost(HttpServletRequest req, HttpServletResponse res) {
		List<RestaurantVO> list = restaurantService.searchList(null, null, null);
		return list;
	}
	
	@PostMapping("/ajax/info")
	@ResponseBody
	public RestaurantVO ajaxInfo(@RequestParam("lat") String lat, @RequestParam("lng") String lng, HttpServletRequest req, HttpServletResponse res) {
		RestaurantVO map = restaurantService.infoRest(lat, lng);
		return map;
	}
	
	@PostMapping("/ajax/search")
	@ResponseBody
	public List<RestaurantVO> ajaxSearch(@RequestParam("sfl") String sfl, @RequestParam("stx") String stx, @RequestParam("sort") String sort,HttpServletRequest req, HttpServletResponse res) {
		
		// 허용된 정렬 기준 리스트
		List<String> validSorts = Arrays.asList("re_name ASC", "re_name DESC", "re_score ASC", "re_score DESC");
		// 만약 정렬 기준이 유효하지 않으면 기본값 사용
	    if (!validSorts.contains(sort)) {
	        sort = "re_name ASC";
	    }
	    
		List<RestaurantVO> list = restaurantService.searchList(sfl, stx, sort);
		return list;
	}
}
