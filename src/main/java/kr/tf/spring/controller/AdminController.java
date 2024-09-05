package kr.tf.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.tf.spring.service.UserService;
import kr.tf.spring.model.vo.UserVO;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @GetMapping("/adminhome")
    public String adminHome() {
        // 관리자 대시보드 페이지로 이동
        return "admin/adminhome";
    }

    @GetMapping("/store")
    public String storeManagement(Model model) {
        // 매장 관리 페이지로 이동
        return "admin/store";
    }

    @GetMapping("/review")
    public String reviewManagement(Model model) {
        // 리뷰 관리 페이지로 이동
        return "admin/review";
    }

    @GetMapping("/user")
    public String userManagement(Model model) {
        // 회원 관리 페이지로 이동
        return "admin/user";
    }

    @GetMapping("/user/search")
    public String searchUser(@RequestParam("name") String name, Model model) {
        // 회원 이름으로 검색
        List<UserVO> users = userService.findUsersByName(name);
        model.addAttribute("users", users);
        return "admin/user"; // 검색 결과를 admin/user.jsp에 전달
    }

    @GetMapping("/user/info")
    public String userInfo(@RequestParam("id") String userId, Model model) {
        // 특정 회원의 상세 정보를 가져옴
        UserVO user = userService.findUserById(userId);
        model.addAttribute("user", user);
        return "admin/userinfo"; // 회원 정보 페이지로 이동
    }
}
