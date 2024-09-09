package kr.tf.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
    public String userManagement(@RequestParam(value = "name", required = false) String name, Model model) {
        List<UserVO> users;
        if (name != null && !name.trim().isEmpty()) {
            // 이름으로 검색
            users = userService.findUsersByName(name);
        } else {
            // 전체 사용자 목록 가져오기
            users = userService.getAllUsers();
        }
        model.addAttribute("users", users);
        return "admin/user";
    }


    @GetMapping("/user/search")
    public String searchUser(@RequestParam("name") String name, Model model) {
        // 회원 이름으로 검색
        List<UserVO> users = userService.findUsersByName(name);
        model.addAttribute("users", users); // 검색 결과를 모델에 추가
        return "admin/user_search_popup"; // 팝업 창에서 검색 결과 표시
    }

    @GetMapping("/user/info")
    public String userInfo(@RequestParam("id") String userId, Model model) {
        // 특정 회원의 상세 정보를 가져옴
        UserVO user = userService.findUserById(userId);
        model.addAttribute("user", user);
        return "admin/userinfo"; // 회원 정보 페이지로 이동
    }
    

    @PostMapping("/updateUser")
    public String updateUser(UserVO user, Model model) {
        boolean success = userService.updateUser(user);
        if (success) {
            model.addAttribute("msg", "회원 정보가 성공적으로 수정되었습니다.");
        } else {
            model.addAttribute("msg", "회원 정보 수정에 실패하였습니다.");
        }
        return "admin/userinfo";
    }

    @PostMapping("/deleteUser")
    public String deleteUser(@RequestParam("us_id") String us_id, Model model) {
        boolean success = userService.deleteUser(us_id);
        if (success) {
            model.addAttribute("msg", "회원 정보가 성공적으로 삭제되었습니다.");
        } else {
            model.addAttribute("msg", "회원 정보 삭제에 실패하였습니다.");
        }
        return "admin/user";
    }
}
