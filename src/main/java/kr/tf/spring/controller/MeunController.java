package kr.tf.spring.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.tf.spring.dao.RestaurantDAO;
import kr.tf.spring.model.vo.MenuVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.service.MenuService;
import kr.tf.spring.service.RestaurantService;

@Controller
@RequestMapping("/menu")
public class MeunController {
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private RestaurantService restaurantService;
	
	@GetMapping("/menu")
	public String menu(Model mo, HttpSession session) {
		//로그인 유무 확인
		UserVO user = (UserVO)session.getAttribute("user");
		//로그인 된 유저 아이디로 가지고 있는 매장 확인
		RestaurantVO rest = restaurantService.findRestByUserId(user);
		//확인된 매장에 가지고 있는 매뉴를 긁어오기 
		//매뉴는 자기가 가지고 있는 매장의 정보를 가지고 있어요 list 로 가져올게용
		List<MenuVO> list = menuService.getMenuListByRestId(rest);
	
		//긁어온 매뉴를 화면으로 넘겨주기 (list로 넘겨주었습니다. 변경하셔도 되요)
		mo.addAttribute("list", list);
		return "/menu/menu";
	}
}
