package kr.tf.spring.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.dao.RestaurantDAO;
import kr.tf.spring.model.vo.FileVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.utils.UploadFileUtils;

@Service
public class RestaurantServiceImp implements RestaurantService {
	@Autowired
	private RestaurantDAO restaurantDao;
	
	@Resource
	String uploadPath;

	@Override
	public List<RestaurantVO> searchList(String sfl, String stx, String sort) {
		return restaurantDao.getSearchList(sfl, stx, sort);
	}

	@Override
	public RestaurantVO findRestById(int re_id) {	
		return restaurantDao.findRestById(re_id);
	}

	public RestaurantVO getReviewName(int restId) {
		
		if(restId < 0) return null;
		
		return restaurantDao.getReviewName(restId);
	}

	@Override
	public boolean restaurantRegister(RestaurantVO rest, MultipartFile[] fileList) {
		if(rest == null) return false;
		
		boolean res = restaurantDao.restaurantRegistert(rest);
		if(fileList == null || fileList.length == 0) {
			return true;
		}
		
		if(!res) {
			return false;
		}
		
		//첨부파일 추가
		for(MultipartFile file : fileList) {
			uploadFile(file, rest.getRe_id());
		}
		return res;
	}
	
	private void uploadFile(MultipartFile file, int re_id) {

		if(file == null || file.getOriginalFilename().length() == 0) {
			return;
		}
		
		try {
			String fi_ori_name = file.getOriginalFilename();
			//첨부파일을 서버에 업로드 후 경로가 포함된 파일명을 가져옴
			String fi_name = 
			UploadFileUtils.uploadFile(uploadPath, fi_ori_name, file.getBytes());
			//DB에 첨부파일 정보를 추가
			FileVO fileVo = new FileVO(fi_name, fi_ori_name, re_id);
			restaurantDao.insertFile(fileVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public RestaurantVO findRestByUserId(UserVO user) {
		if (user == null) {
			return null;
		}
		//restaurant 은 re_us_id 를 유저 아이디로 가지고있어서 그걸 찾아오는 작업이에용
		
		return restaurantDao.findRestByUserId(user);
	}
}
