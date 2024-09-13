package kr.tf.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.tf.spring.model.vo.ImageVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.ReviewVO;
import kr.tf.spring.pagination.ReviewCriteria;

public interface ReviewDAO {

	List<ReviewVO> selectCommunityList();
	
	List<ReviewVO> selectReviewList(@Param("cri")ReviewCriteria cri);

	int selectReviewTotalCount(@Param("cri")ReviewCriteria cri);

	boolean insertReview(@Param("review")ReviewVO review);

	void insertImage(@Param("image")ImageVO imageVO);

	ReviewVO selectReview(@Param("rv_id")Integer rv_id);

	List<ImageVO> selectImageList(@Param("rv_id")Integer rv_id);

	List<ReviewVO> getAllReviews(@Param("cri")ReviewCriteria cri);

	int selectTotalReviewCount();
	
	void updateView(@Param("rv_id")Integer rv_id);

	ImageVO selectImage(@Param("im_num")int im_num);

	void deleteImage(@Param("im_num")int fi_num);

	boolean updateReview(@Param("review")ReviewVO review);

	boolean deleteReview(@Param("rv_id")int rv_id);
}
