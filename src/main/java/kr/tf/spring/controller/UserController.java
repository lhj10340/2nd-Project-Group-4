package kr.tf.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.tf.spring.model.dto.LoginDTO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.service.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String login(Model model) {
        // 로그인 화면
        return "/user/login";
    }

    @PostMapping("/login")
    public String login_post(Model model, LoginDTO loginDTO, HttpSession session) {
        UserVO user = userService.login(loginDTO);
        if (user != null) {
            session.setAttribute("user", user); // 세션에 저장
            model.addAttribute("msg", user.getUs_id() + "님 환영합니다.");
            if (user.getUs_auth() == 9) { // 관리자
                return "redirect:/adminhome"; // 관리자 페이지로 이동
            } else {
                return "redirect:/"; // 일반 사용자 페이지로 이동
            }
        } else {
            model.addAttribute("msg", "잘못된 로그인입니다. 다시 확인해주세요.");
            return "redirect:/"; // 로그인 실패 시 메인 페이지로 리다이렉트
        }
    }

    @GetMapping("/signup")
    public String signup(Model model) {
        // 회원가입 화면
        return "/user/signup";
    }

    @PostMapping("/signup")
    public String signup_post(UserVO userVO, Model model) {
        boolean isRegistered = userService.registerUser(userVO);
        if (isRegistered) {
            model.addAttribute("message", "회원가입 성공!");
            return "redirect:/login"; // 회원가입 성공 후 로그인 페이지로 이동
        } else {
            model.addAttribute("message", "회원가입 실패. 다시 시도해주세요.");
            return "user/signup"; // 회원가입 실패 시 다시 회원가입 페이지로 이동
        }
    }

    @GetMapping("/logout")
    public String logout(Model model, HttpSession session) {
        // 세션에서 사용자 제거
        session.removeAttribute("user");
        model.addAttribute("msg", "로그아웃 완료");
        return "redirect:/"; // 로그아웃 후 메인 페이지로 이동
    }
}
