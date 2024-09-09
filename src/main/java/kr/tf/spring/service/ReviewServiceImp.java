package kr.tf.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.tf.spring.dao.ReviewDAO;
import kr.tf.spring.model.vo.ReviewVO;

@Service
public class ReviewServiceImp implements ReviewService {
	@Autowired
	private ReviewDAO reviewDao;
	
	@Override
	public List<ReviewVO> getReviewList() {
		List<ReviewVO> list = reviewDao.getReviewList();
		if(list == null) return null;
		return list;
	}

}
