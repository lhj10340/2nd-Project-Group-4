package kr.tf.spring.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.ReviewVO;
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
	public String home() {
		return "/main/home";
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
	
	@PostMapping("/ajax/res_data")
	@ResponseBody
	public Map<String, Object> restaurantData(@RequestBody RestaurantVO re){
		Map<String, Object> map = new HashMap<String, Object>();
		RestaurantVO rest = restaurantService.findRestById(re.getRe_id());
		map.put("rest", rest);
		return map;
	}

	
	@PostMapping("/ajax/rv_data")
	@ResponseBody
	public Map<String, Object> restaurantData(@RequestBody ReviewVO rv){
		Map<String, Object> map = new HashMap<String, Object>();
		//get rv_data 만들어 주세용
		System.out.println("리뷰를 보내주세용");
		System.out.println(rv);
		map.put("rv", "test");
		return map;
	}
	
}
