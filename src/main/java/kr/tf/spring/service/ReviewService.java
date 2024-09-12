package kr.tf.spring.service;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.dao.ReviewDAO;
import kr.tf.spring.model.vo.ImageVO;
import kr.tf.spring.model.vo.ReviewVO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.pagination.PageMaker;
import kr.tf.spring.pagination.ReviewCriteria;
import kr.tf.spring.utils.UploadFileUtils;

@Service
public class ReviewService {
	
    @Autowired
    ReviewDAO reviewDao;
    @Resource
    String uploadPath;

	public List<ReviewVO> getCommunityList() {
		return reviewDao.selectCommunityList();
	}

	public List<ReviewVO> getReviewList(ReviewCriteria cri) {
		if (cri == null) {
			return null;
		}
		return reviewDao.selectReviewList(cri);
	}

	public List<ReviewVO> getAllReviewList(ReviewCriteria cri) {
		if (cri == null) {
			return null;
		}
		return reviewDao.getAllReviews(cri);
	}
	
	public PageMaker getPageMaker(ReviewCriteria cri) {
		if (cri == null) {
			return null;
		}
		int totalCount = reviewDao.selectReviewTotalCount(cri);
		return new PageMaker(3, cri, totalCount);
	}

	public boolean insertReview(ReviewVO review, UserVO user, MultipartFile[] fileList) {
		if (review == null || user == null) {
			return false;
		}
		
		boolean res;
		try {
			review.setRv_us_id(user.getUs_id());
			res = reviewDao.insertReview(review);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		if (!res) {
			return false;
		}

		if (fileList == null || fileList.length == 0) {
			return true;
		}
		
		//첨부파일 추가
		for(MultipartFile file : fileList) {
			uploadFile(file, review.getRv_id());
		}
		return true;
	}

	private void uploadFile(MultipartFile file, int rv_id) {
		
		if (file == null || file.getOriginalFilename().length() == 0) {
			return;
		}
		
		try {
			String im_ori_name = file.getOriginalFilename();
			//첨부파일을 서버에 업로드 후 경로가 포함된 파일명을 가져옴
			String im_name = 
			UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
			//DB에 첨부파일 정보를 추가
			ImageVO imageVO = new ImageVO(im_name, im_ori_name, rv_id);
			reviewDao.insertImage(imageVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ReviewVO getReview(Integer rv_id) {
		return reviewDao.selectReview(rv_id);
	}

	public List<ImageVO> getImageList(Integer rv_id) {
		return reviewDao.selectImageList(rv_id);
	}

	public ReviewVO getReviewByRestId(ReviewVO rv_) {
		//널 체크 해주고
		if(rv_ == null){
			return null;
		}

		
		return reviewDao.getReviewByRestId(rv_);
	}
	
}
