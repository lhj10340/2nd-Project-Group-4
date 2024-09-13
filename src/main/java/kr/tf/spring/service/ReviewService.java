package kr.tf.spring.service;

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
	
	public boolean updateReview(ReviewVO review, int[] im_nums, MultipartFile[] imageList, UserVO user) {
		if(review == null ) {
			return false;
		}
		if(user == null) {
			return false;
		}
		
		//작성자인지 확인 
		if(!checkWriter(review.getRv_id(), user.getUs_id())) {
			return false;
		}
		
		boolean res;
		
		try {
			res = reviewDao.updateReview(review);
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		if(!res) {
			return false;
		}
		
		//첨부파일 삭제
		if(im_nums != null) {
			for(int im_num : im_nums) {
				deleteImage(im_num);
			}
		}
		//첨부파일 추가
		if(imageList == null || imageList.length == 0) {
			return true;
		}
		for(MultipartFile file : imageList) {
			uploadFile(file, review.getRv_id());
		}
		return true;
	}

	private boolean checkWriter(int rv_id, String us_id) {
		ReviewVO review = reviewDao.selectReview(rv_id);
		if(review == null) {
			return false;
		}
		return review.getRv_us_id().equals(us_id);
	}

	private void deleteImage(int im_num) {
		//첨부파일 정보를 가져옴
		ImageVO image = reviewDao.selectImage(im_num);
		deleteImage(image);
	}
	private void deleteImage(ImageVO image) {
		if(image == null) {
			return;
		}
		//첨부파일을 서버에서 삭제
		UploadFileUtils.deleteFile(uploadPath, image.getIm_name());
		//첨부파일 정보를 DB에서 삭제
		reviewDao.deleteImage(image.getIm_num());
	

		/*
		 * try { String im_ori_name = file.getOriginalFilename(); // 첨부파일을 서버에 업로드 후 경로가
		 * 포함된 파일명을 가져옴 String im_name = UploadFileUtils.uploadFile(uploadPath,
		 * file.getOriginalFilename(), file.getBytes()); // DB에 첨부파일 정보를 추가 ImageVO
		 * imageVO = new ImageVO(im_name, im_ori_name, rv_id);
		 * reviewDao.insertImage(imageVO); } catch (Exception e) { e.printStackTrace();
		 * }
		 */
    }

    public boolean deleteReview(int rv_id) {
        try {
            // 리뷰의 이미지 리스트를 가져와서 이미지 파일을 삭제합니다.
            List<ImageVO> imageList = reviewDao.selectImageList(rv_id);
            if (imageList != null) {
                for (ImageVO imageVO : imageList) {
                    // 이미지 파일 삭제
                    String fileName = imageVO.getIm_name();
                    UploadFileUtils.deleteFile(uploadPath, fileName);
                }
            }

            // 리뷰 삭제
            boolean result = reviewDao.deleteReview(rv_id);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            // 로그를 기록하거나 사용자에게 알리는 방법을 고려할 수 있습니다.
            return false;
        }
    }	
    

	public ReviewVO getReviewByRestId(ReviewVO rv_) {
		//널 체크 해주고
		if(rv_ == null){
			return null;
		}

		
		return reviewDao.getReviewByRestId(rv_);
	}
    
	public boolean deleteReview(int rv_id, UserVO user) {
		if(user == null) {
			return false;
		}
		if(!checkWriter(rv_id, user.getUs_id())) {
			return false;
		}
		//서버에서 첨부파일 삭제
		List<ImageVO> list = reviewDao.selectImageList(rv_id);
		for(ImageVO image : list) {
			deleteImage(image);
		}
		//DB에서 첨부파일 삭제(구현할 필요가 없음. 왜? 게시글 삭제 시 DB에서 해당 첨부파일을 삭제하기로 했기 때문)
		
		return reviewDao.deleteReview(rv_id);
	}
}
