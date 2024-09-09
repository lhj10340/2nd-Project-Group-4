package kr.tf.spring.dao;

import java.util.List;

import kr.tf.spring.model.vo.ReviewVO;

public interface ReviewDAO {

	List<ReviewVO> getReviewList();

}
