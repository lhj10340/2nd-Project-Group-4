package kr.tf.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.tf.spring.model.vo.ImageVO;
import kr.tf.spring.model.vo.ReviewVO;
import kr.tf.spring.pagination.ReviewCriteria;

public interface ReviewDAO {

    // 모든 커뮤니티 리뷰 리스트 조회
    List<ReviewVO> selectCommunityList();

    // 필터링된 리뷰 목록 조회
    List<ReviewVO> selectReviewList(@Param("cri") ReviewCriteria cri);

    // 필터링된 리뷰 총 개수 조회
    int selectReviewTotalCount(@Param("cri") ReviewCriteria cri);

    // 리뷰 추가
    boolean insertReview(@Param("review") ReviewVO review);

    // 이미지 추가
    void insertImage(@Param("image") ImageVO imageVO);

    // 리뷰 조회
    ReviewVO selectReview(@Param("rv_id") Integer rv_id);

    // 리뷰의 이미지 목록 조회
    List<ImageVO> selectImageList(@Param("rv_id") Integer rv_id);

    // 모든 리뷰 조회 (페이지네이션 포함)
    List<ReviewVO> getAllReviews(@Param("cri") ReviewCriteria cri);

    // 모든 리뷰 총 개수 조회
    int selectTotalReviewCount();

    // 리뷰 삭제
    int deleteReview(@Param("rv_id") int rv_id);

    // 리뷰에 연관된 모든 이미지 삭제
    int deleteImagesByReviewId(@Param("rv_id") int rv_id);
    
    // 홈에서 사용하는 미리보기 리뷰에용
	ReviewVO getReviewByRestId(@Param("rv")ReviewVO rv_);
}
