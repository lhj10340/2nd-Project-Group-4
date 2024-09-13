package kr.tf.spring.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.service.RestaurantService;
import kr.tf.spring.service.ReviewService;
import kr.tf.spring.model.vo.ImageVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.ReviewVO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.pagination.PageMaker;
import kr.tf.spring.pagination.ReviewCriteria;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
    @Autowired
    public ReviewService reviewService;
    @Autowired
    public RestaurantService restaurantService;
	
    @GetMapping("/list")
    public String list(Model model, ReviewCriteria cri) {
        // 'rv_tf'가 제공되지 않은 경우 모든 리뷰를 가져옴
        List<ReviewVO> list;
        List<ReviewVO> reviewList;
        
        cri.setPerPageNum(5);

        // 'rv_tf'가 null이거나 빈 값인지 확인
        if (cri.getRv_tf() == null || cri.getRv_tf().isEmpty()) {
            // 'rv_tf'가 설정되지 않은 경우 모든 리뷰를 가져옴
            list = reviewService.getCommunityList();
            reviewList = reviewService.getAllReviewList(cri);
        } else {
            // 필터링된 리뷰를 가져옴
            list = reviewService.getCommunityList();
            reviewList = reviewService.getReviewList(cri);
        }

        // 페이지네이션 정보 가져오기
        PageMaker pm = reviewService.getPageMaker(cri);

        // 화면에 데이터 전송
        model.addAttribute("list", list);
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("pm", pm);

        return "/review/list";
    }
    
    @GetMapping("/insert")
    public String insert(Model model, Integer rv_tf) {
    	model.addAttribute("rv_tf", rv_tf);
    	List<RestaurantVO> rest = restaurantService.getAllRestaurant();
    	model.addAttribute("rest", rest);
        return "/review/insert";
    }
    
    @PostMapping("/insert")
    private String insertReview(Model model, ReviewVO review, MultipartFile [] fileList,
    		HttpSession session) {
    	
        // 허용할 파일 확장자 목록
        String[] allowedExtensions = {"jpg", "jpeg", "png"};
        
        if (review == null || review.getRv_title() == null || review.getRv_title().trim().isEmpty() ||
        		review.getRv_name() == null || review.getRv_score() == 0.0 || 
                review.getRv_content() == null || review.getRv_content().trim().isEmpty()) {

                model.addAttribute("url", "/review/insert?rv_tf=" + review.getRv_tf());
                model.addAttribute("msg", "모든 내용을 입력해주세요: 제목, 매장명, 별점, 내용");
                return "/main/msg";
            }
        
        // 영수증 번호가 입력된 경우 rv_tf 값을 1로 설정
        if (review.getRv_receipt() != null && !review.getRv_receipt().trim().isEmpty()) {
            review.setRv_tf("1");  // 영수증 번호가 있으면 rv_tf를 1로 설정
        } else {
            review.setRv_tf("0");  // 영수증 번호가 없으면 rv_tf를 0으로 설정
        }
        
        // 파일 확장자 검사
        for (MultipartFile file : fileList) {
            if (!file.isEmpty()) {  // 파일이 비어 있지 않으면 검사
                String extension = FilenameUtils.getExtension(file.getOriginalFilename()).toLowerCase();
                
                // 허용된 확장자에 포함되지 않으면
                if (!Arrays.asList(allowedExtensions).contains(extension)) {
                    model.addAttribute("url", "/review/insert?rv_tf=" + review.getRv_tf());
                    model.addAttribute("msg", "JPG, JPEG, PNG 파일만 업로드할 수 있습니다.");
                    return "/main/msg";  // 유효하지 않은 파일이 있으면 메시지 반환
                }
            }
        }
    	
    	UserVO user = (UserVO)session.getAttribute("user");
    	
    	if (reviewService.insertReview(review, user, fileList)) {
			model.addAttribute("url", "/review/list/?rv_tf=" + review.getRv_tf());
			model.addAttribute("msg", "리뷰를 등록했습니다.");
		}else {
			model.addAttribute("url", "/review/insert?rv_tf=" + review.getRv_tf());
			model.addAttribute("msg", "리뷰를 등록하지 못했습니다.");
		}
    	return "/main/msg";
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
    
	@GetMapping("/update")
	public String update(Model model, Integer rv_id, ReviewCriteria cri) {
		//게시글 가져옴
		ReviewVO review = reviewService.getReview(rv_id);
		//첨부파일 가져옴
		List<ImageVO> imageList = reviewService.getImageList(rv_id);
		//화면에 전송 
		model.addAttribute("review", review);
		model.addAttribute("list", imageList);
		model.addAttribute("cri", cri);
		return "/review/update";
	}
	@PostMapping("/update")
	public String updateReview(Model model, ReviewVO review, 
			int []im_nums, MultipartFile[] imageList, ReviewCriteria cri, HttpSession session) {
		
		UserVO user = (UserVO)session.getAttribute("user");
		
		if(reviewService.updateReview(review, im_nums, imageList, user)) {
			model.addAttribute("url", "/review/detail?rv_id="+review.getRv_id()+"&"+cri);
			model.addAttribute("msg", "게시글을 수정했습니다.");
		}else {
			model.addAttribute("url", "/review/detail?rv_id="+review.getRv_id()+"&"+cri);
			model.addAttribute("msg", "게시글을 수정하지 못했습니다.");
		}
		return "/main/msg";
	}
	@GetMapping("/delete")
	public String delete(Model model, HttpSession session, int rv_id, ReviewCriteria cri) {
		UserVO user = (UserVO)session.getAttribute("user");
		
		if(reviewService.deleteReview(rv_id, user)) {
			model.addAttribute("url", "/review/list");
			model.addAttribute("msg", "게시글을 삭제했습니다.");
		}else {
			model.addAttribute("url", "/review/detail?rv_id="+rv_id+"&"+cri);
			model.addAttribute("msg", "게시글을 삭제하지 못했습니다.");
		}
		return "/main/msg";
	}
	
	
}
