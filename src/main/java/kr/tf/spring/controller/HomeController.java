package kr.tf.spring.controller;

import java.text.DateFormat;
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
		
	//	return "/main/home";	// 매인
		return "/admin/adminHome"; // 테스트용
	}

	
	@PostMapping("/ajax/list")
	@ResponseBody
	public List<RestaurantVO> ajaxPost(HttpServletRequest req, HttpServletResponse res) {
		List<RestaurantVO> list = restaurantService.listRest();
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
	public List<RestaurantVO> ajaxSearch(@RequestParam("sfl") String sfl, @RequestParam("stx") String stx,HttpServletRequest req, HttpServletResponse res) {
		List<RestaurantVO> list = restaurantService.searchList(sfl, stx);
		return list;
	}
}
