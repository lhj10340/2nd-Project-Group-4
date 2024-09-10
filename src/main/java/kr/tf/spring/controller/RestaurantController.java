package kr.tf.spring.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.ReviewVO;
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
}
