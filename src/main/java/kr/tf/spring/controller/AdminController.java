package kr.tf.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

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
}
