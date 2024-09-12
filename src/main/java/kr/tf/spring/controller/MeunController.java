package kr.tf.spring.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
		int total = 0; // 사이즈를 이걸로 넘겨주죠? 굳이 저기 멀리가서 db에서 받아올 필요가 없어보여요
		
		//null 일경우 0을 보내주는 식
		if (list == null) {
			total = 0;
		} else {
			total = list.size();
		}
		
		//긁어온 매뉴를 화면으로 넘겨주기 (list로 넘겨주었습니다. 변경하셔도 되요)
		mo.addAttribute("list_total", total);
		mo.addAttribute("list", list);
		return "/menu/menu";
	}
	
	@PostMapping("/add_menu")
	public String add_menu(Model mo, HttpSession session, MenuVO menu) {
		UserVO user = (UserVO)session.getAttribute("user");//세션에서 유저 가져오고
		RestaurantVO rest = restaurantService.findRestByUserId(user);//가져온 유저가 가지고있는 레스토랑 확인
		//menuVO 받아온 것에서 아이디랑 레스토랑 아이디 추가한 뒤 (set) db에 저장 후 성공 유무 반환 
		menu.setMe_re_id(rest.getRe_id());
		boolean res = menuService.setNewMenu(menu, user, me_thumb);
		
		if (res) {
			mo.addAttribute("msg", "새로운 매뉴 추가 완료.");
			mo.addAttribute("url","/menu/menu");
		} else {
			mo.addAttribute("msg", "오류.");
			mo.addAttribute("url","/menu/menu");
		}

		return "/main/msg";
	}
	@GetMapping("/delete_menu")
	public String delete_menu(Model mo, String me_id) {
		
		boolean res = menuService.deleteMenuById(me_id);
		if (res) {
			mo.addAttribute("msg", "메뉴 삭제 완료.");
			mo.addAttribute("url","/menu/menu");
		} else {
			mo.addAttribute("msg", "오류.");
			mo.addAttribute("url","/menu/menu");
		}
		
		return "/main/msg";
	}
	
	@PostMapping("/update_menu")
	public String update_menu(Model mo, MenuVO menu, HttpSession session) {
		UserVO user = (UserVO)session.getAttribute("user");//세션에서 유저 가져오고
		RestaurantVO rest = restaurantService.findRestByUserId(user);//가져온 유저가 가지고있는 레스토랑 확인
		menu.setMe_re_id(rest.getRe_id());
		boolean res = menuService.updateMenu(menu);

			
		if (res) {
			mo.addAttribute("msg", "메뉴 수정 완료.");
			mo.addAttribute("url","/menu/menu");
		} else {
			mo.addAttribute("msg", "오류.");
			mo.addAttribute("url","/menu/menu");
		}
		
		
		return "/main/msg";
	}
	
	
}
