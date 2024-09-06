package kr.tf.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.tf.spring.model.dto.LoginDTO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

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
		System.out.println(user_);
		UserVO user = userService.login(user_);
		System.out.println(user);
		
		if (user != null) {
			session.setAttribute("user", user);//세션에 저장해용
			mo.addAttribute("msg", user.getUs_id() + "님 환영합니다.");
			
		    if (user.getUs_auth() == 9) {   // us_auth 값이 9인 경우
		    	 return "redirect:/adminhome"; // 관리자 페이지로 이동
		    } else {
			mo.addAttribute("url","/"); // 일반 사용자페이지로 이동 
		    	}
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
		System.out.println(user_);
		// from테그에서 입력 받아용
		// user_ 는 화면에서 받아온 친구

		return "/main/msg";
	}

	@GetMapping("/logout")
	public String logout(Model mo, HttpSession session) {

		// user 가 있으면 삭제 해줍니당
		session.removeAttribute("user");
		mo.addAttribute("msg", "로그아웃 완료");
		mo.addAttribute("url", "/");
		return "/main/msg";
	}
}
