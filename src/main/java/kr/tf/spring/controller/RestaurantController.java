package kr.tf.spring.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.service.RestaurantService;

@Controller
@RequestMapping("/restaurant")
public class RestaurantController {
	private static final Logger logger = LoggerFactory.getLogger(RestaurantController.class);
	
	@Autowired
	private RestaurantService restaurantService;
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String reviewList(Model model) {
		return "/restaurant/register";
	}

	
	@PostMapping("/register")
	public String restaurantRegister(Model model, RestaurantVO rest, MultipartFile [] fileList, 
			HttpSession session) {
		//MemberVO user = (MemberVO)session.getAttribute("user");
		if(restaurantService.restaurantRegister(rest, fileList)) {
			model.addAttribute("url", "/");
			model.addAttribute("msg", "매장을 등록했습니다.");
		}else {
			model.addAttribute("url", "/");
			model.addAttribute("msg", "매장을 등록하지 못했습니다.");
		}
		
		return "/main/message";
	}
}
