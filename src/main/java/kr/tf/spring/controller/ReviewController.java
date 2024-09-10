package kr.tf.spring.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.tf.spring.model.vo.ReviewVO;
import kr.tf.spring.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String reviewList(Model model) {
		List<ReviewVO> lists =  reviewService.getReviewList();
		model.addAttribute("lists", lists);
		return "/review/list";
	}
}
