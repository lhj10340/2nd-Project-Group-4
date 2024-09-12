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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.tf.spring.model.vo.FileVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.ReviewVO;
import kr.tf.spring.service.RestaurantService;
import kr.tf.spring.service.ReviewService;
import kr.tf.spring.service.UserService;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RestaurantService restaurantService;

	@Autowired
	private  ReviewService reviewService;

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
	public Map<String, Object> ajaxInfo(@RequestParam("re_id") String str_re_id, HttpServletRequest req, HttpServletResponse res) {

	    Integer re_id = Integer.parseInt(str_re_id);

	    RestaurantVO map = restaurantService.findRestById(re_id);
	    List<FileVO> files = restaurantService.selectFileRestaurant(re_id);

	    // 데이터를 담기 위한 Map 생성
	    Map<String, Object> response = new HashMap<>();
	    response.put("restaurant", map); // RestaurantVO 객체
	    response.put("files", files);    // 파일 리스트

	    return response;  // Map 반환
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
	
	@PostMapping("/ajax/files")
	@ResponseBody
	public List<FileVO> ajaxFiles(@RequestParam("re_id") Integer re_id,HttpServletRequest req, HttpServletResponse res) {
		
		List<FileVO> files = restaurantService.selectFileRestaurant(re_id);
	
		return files;
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
	public Map<String, Object> restaurantData(@RequestBody ReviewVO rv_){
		Map<String, Object> map = new HashMap<String, Object>();
		// rv_ 는 화면에서 받아왔어용
		//rv = rv_re_id 값만 가지고 있고 나머지 값은 가지지 않음

		//rv 는 db에서 받아옵니다.
		//하나만 받아올 것이기 때문에 limit 1 로 받아옵니다.
		ReviewVO rv = reviewService.getReviewByRestId(rv_);

		System.out.println("홈컨트롤러 리뷰데이터 ajax로 전송하는 부분 line 108 입니다.");
		System.out.println(rv);

		if (rv == null) {
			//만약 리뷰가 없는 매장일 경우 필요한 데이터를전송하고싶으면 이곳에 넣어주세요
		} else {
			//리뷰가 하나라도 있으면
			map.put("rv", rv);
		}
		//map에 담아서 rv를 전송합니다 ( -> 사용예제 data.rv. 리뷰VO에 있는 값들)(홈으로 전송)
		return map;
	}
	
}
