package kr.tf.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.tf.spring.dao.ReviewDAO;
import kr.tf.spring.model.Review;
import kr.tf.spring.pagination.PageMaker;

@Service
public class ReviewService {
	
    @Autowired
    private ReviewDAO reviewDAO;

    // 일반 리뷰 데이터를 가져오는 메서드
    public List<Review> getGeneralReviews(int page) {
        int offset = (page - 1) * 10; // 10개의 리뷰를 한 페이지에 표시
        return reviewDAO.selectGeneralReviews(offset);
    }

    // 영수증 리뷰 데이터를 가져오는 메서드
    public List<Review> getReceiptReviews(int page) {
        int offset = (page - 1) * 10;
        return reviewDAO.selectReceiptReviews(offset);
    }

    // 검색 결과를 가져오는 메서드
    public List<Review> searchReviews(String query, int page) {
        int offset = (page - 1) * 10;
        return reviewDAO.searchReviews(query, offset);
    }

    // 페이지네이션을 위한 PageMaker 객체를 반환하는 메서드
    public PageMaker getPageMaker(int page, String reviewType) {
        int totalCount = reviewDAO.countTotalReviews(reviewType);
        return new PageMaker(page, totalCount);
    }

    // 리뷰 ID를 기반으로 리뷰 상세 정보를 가져오는 메서드
    public Review getReviewById(int id) {
        return reviewDAO.selectReviewById(id);
    }
}
