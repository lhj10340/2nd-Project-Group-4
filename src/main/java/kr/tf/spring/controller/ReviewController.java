package kr.tf.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import kr.tf.spring.service.ReviewService;
import kr.tf.spring.pagination.PageMaker;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
    @GetMapping("/list")
    public String listPosts(Model model) {
        // 게시글 목록을 모델에 추가
        return "/review/list"; // 반환값은 뷰 이름
    }
    
    @Autowired
    private ReviewService reviewService;

    // 일반 리뷰 목록을 처리하는 메서드
    @GetMapping("/general")
    public String generalReviews(@RequestParam(defaultValue = "1") int page, Model model) {
        model.addAttribute("reviews", reviewService.getGeneralReviews(page));
        model.addAttribute("pageMaker", reviewService.getPageMaker(page, "general"));
        model.addAttribute("reviewType", "general");
        return "reviewBoard";
    }

    // 영수증 리뷰 목록을 처리하는 메서드
    @GetMapping("/receipt")
    public String receiptReviews(@RequestParam(defaultValue = "1") int page, Model model) {
        model.addAttribute("reviews", reviewService.getReceiptReviews(page));
        model.addAttribute("pageMaker", reviewService.getPageMaker(page, "receipt"));
        model.addAttribute("reviewType", "receipt");
        return "reviewBoard";
    }

    // 검색 기능을 처리하는 메서드
    @GetMapping("/search")
    public String searchReviews(@RequestParam String query, @RequestParam(defaultValue = "1") int page, Model model) {
        model.addAttribute("reviews", reviewService.searchReviews(query, page));
        model.addAttribute("pageMaker", reviewService.getPageMaker(page, "search"));
        model.addAttribute("reviewType", "search");
        return "reviewBoard";
    }

    // 글쓰기 페이지로 이동하는 메서드
    @GetMapping("/write")
    public String writeReview(Model model) {
        return "writeReview"; // 글쓰기 폼을 표시하는 JSP 페이지
    }

    // 게시글 상세보기 처리하는 메서드
    @GetMapping("/detail/{id}")
    public String reviewDetail(@PathVariable("id") int id, Model model) {
        model.addAttribute("review", reviewService.getReviewById(id));
        return "reviewDetail"; // 상세보기 페이지를 위한 JSP 파일
    }
}
