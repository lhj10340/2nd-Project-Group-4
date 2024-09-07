package kr.tf.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import kr.tf.spring.model.Review;

@Mapper
public interface ReviewDAO {

    // 일반 리뷰 목록을 가져오는 메서드
    List<Review> selectGeneralReviews(@Param("offset") int offset);

    // 영수증 리뷰 목록을 가져오는 메서드
    List<Review> selectReceiptReviews(@Param("offset") int offset);

    // 검색 결과를 가져오는 메서드
    List<Review> searchReviews(@Param("query") String query, @Param("offset") int offset);

    // 총 리뷰 개수를 세는 메서드
    int countTotalReviews(@Param("reviewType") String reviewType);

    // 리뷰 ID로 리뷰 상세 정보를 가져오는 메서드
    Review selectReviewById(@Param("id") int id);
}
