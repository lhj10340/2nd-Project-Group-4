package kr.tf.spring.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpSession;

import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.service.UserService;
import kr.tf.spring.service.ReviewService; // ReviewService 추가

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private ReviewService reviewService; // ReviewService 추가

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
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        if(user.getUs_hbd() == null) {
            try {
                user.setUs_hbd(dateFormat.parse("0000-00-00"));
            } catch (java.text.ParseException e) {
                e.printStackTrace();
            }
        }
        if(user.getUs_limit() == null) {
            try {
                user.setUs_limit(dateFormat.parse("0000-00-00"));
            } catch (java.text.ParseException e) {
                e.printStackTrace();
            }
        }
        if(user.getUs_stop() == null) {
            try {
                user.setUs_stop(dateFormat.parse("0000-00-00"));
            } catch (java.text.ParseException e) {
                e.printStackTrace();
            }
        }
        model.addAttribute("user", user);
        return "admin/userinfo"; // 회원 정보 페이지로 이동
    }

    @RequestMapping("/user")
    public String backspace(Model model) {
        return "redirect:/admin/user";
    }

    @PostMapping("/updateUser")
    public String updateUser(@ModelAttribute UserVO user, Model model) {
        // 날짜 형식 설정
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        try {
            // us_hbd가 null일 경우 기본값으로 설정
            if (user.getUs_hbd() == null) {
                user.setUs_hbd(dateFormat.parse("2000-01-01"));
            }

            // us_limit가 null일 경우 기본값으로 설정
            if (user.getUs_limit() == null) {
                user.setUs_limit(datetimeFormat.parse("2000-01-01 00:00:00"));
            }

            // us_stop가 null일 경우 기본값으로 설정
            if (user.getUs_stop() == null) {
                user.setUs_stop(datetimeFormat.parse("2000-01-01 00:00:00"));
            }

        } catch (ParseException e) {
            e.printStackTrace();
            model.addAttribute("msg", "날짜 형식 변환 중 오류가 발생했습니다.");
            return "redirect:/admin/user";
        }

        // User 정보 업데이트 처리
        boolean success = userService.updateUser(user);
        if (success) {
            model.addAttribute("msg", "회원 정보가 성공적으로 수정되었습니다.");
        } else {
            model.addAttribute("msg", "회원 정보 수정에 실패하였습니다.");
        }

        return "redirect:/admin/user";
    }

    @PostMapping("/deleteReview")
    public String deleteReview(@RequestParam("rv_id") Integer rv_id, Model model) {
        // 리뷰 삭제 처리
        boolean success = reviewService.deleteReview(rv_id);

        // 삭제 성공 여부에 따라 메시지 설정
        if (success) {
            model.addAttribute("msg", "리뷰가 성공적으로 삭제되었습니다.");
        } else {
            model.addAttribute("msg", "리뷰 삭제에 실패했습니다.");
        }

        return "redirect:/admin/review";  // 리뷰 관리 페이지로 리다이렉트
    }

    @PostMapping("/deleteUser")
    public String deleteUser(@RequestParam("us_id") String us_id, Model model) {
        boolean success = userService.deleteUser(us_id);
        if (success) {
            model.addAttribute("msg", "회원 정보가 성공적으로 삭제되었습니다.");
        } else {
            model.addAttribute("msg", "회원 정보 삭제에 실패하였습니다.");
        }
        return "redirect:/admin/user";
    }
}
