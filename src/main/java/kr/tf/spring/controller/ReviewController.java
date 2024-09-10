package kr.tf.spring.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.service.ReviewService;
import kr.tf.spring.model.vo.ImageVO;
import kr.tf.spring.model.vo.ReviewVO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.pagination.PageMaker;
import kr.tf.spring.pagination.ReviewCriteria;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
    @Autowired
    ReviewService reviewService;
	
    @GetMapping("/list")
    public String list(Model model, ReviewCriteria cri) {	
    	//리뷰 게시판 리스트를 가져옴
    	List<ReviewVO> list = reviewService.getCommunityList();
    	//현재 페이지 정보를 주면서 게시글 리스트를 가져오라고 시킴
    	cri.setPerPageNum(2);	//지금은 페이지가 별로 없어서 2개로 설정
    	List<ReviewVO> reviewList = reviewService.getReviewList(cri);
    	
    	//현재 페이지 정보를 주면서 페이지네이션 정보를 가져오라고 시킴
    	PageMaker pm = reviewService.getPageMaker(cri);
    	//화면에 전송
    	model.addAttribute("list", list);
    	model.addAttribute("reviewList", reviewList);
        return "/review/list";
    }
    
    @GetMapping("/insert")
    public String insert(Model model, Integer rv_tf) {
    	model.addAttribute("rv_tf", rv_tf);
        return "/review/insert";
    }
    
    @PostMapping("/insert")
    private String insertReview(Model model, ReviewVO review, MultipartFile [] fileList,
    		HttpSession session) {
    	
        // 허용할 파일 확장자 목록
        String[] allowedExtensions = {"jpg", "jpeg", "png"};
        
        // 파일 확장자 검사
        for (MultipartFile file : fileList) {
            if (!file.isEmpty()) {  // 파일이 비어 있지 않으면 검사
                String extension = FilenameUtils.getExtension(file.getOriginalFilename()).toLowerCase();
                
                // 허용된 확장자에 포함되지 않으면
                if (!Arrays.asList(allowedExtensions).contains(extension)) {
                    model.addAttribute("url", "/review/insert?rv_tf=" + review.getRv_tf());
                    model.addAttribute("msg", "JPG, JPEG, PNG 파일만 업로드할 수 있습니다.");
                    return "/main/message";  // 유효하지 않은 파일이 있으면 메시지 반환
                }
            }
        }
    	
    	UserVO user = (UserVO)session.getAttribute("user");
    	
    	if (reviewService.insertReview(review, user, fileList)) {
			model.addAttribute("url", "/revie	w/list/?rv_tf="+review.getRv_tf());
			model.addAttribute("msg", "리뷰를 등록했습니다.");
		}else {
			model.addAttribute("url", "/review/insert?rv_tf="+review.getRv_tf());
			model.addAttribute("msg", "리뷰를 등록하지 못했습니다.");
		}
    	return "/main/message";
	}
    
    @GetMapping("/detail")
    public String detail(Model model, Integer rv_id, ReviewCriteria cri) {
    	
    	//게시글 가져옴
    	ReviewVO review = reviewService.getReview(rv_id);
    	//첨부파일 가져옴
    	List<ImageVO> imageList = reviewService.getImageList(rv_id);
    	//화면에 전송
    	model.addAttribute("review", review);
    	model.addAttribute("list", imageList);
    	model.addAttribute("cri", cri);
    	return "/review/detail";
    }
}
