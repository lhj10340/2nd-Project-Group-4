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
			String fi_ori_id = file.getOriginalFilename();
			//첨부파일을 서버에 업로드 후 경로가 포함된 파일명을 가져옴
			String fi_path = 
			UploadFileUtils.uploadFile(uploadPath, fi_ori_id, file.getBytes());
			//DB에 첨부파일 정보를 추가
			FileVO fileVo = new FileVO(fi_path, fi_ori_id, re_id);
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
	
	public List<FileVO> selectFileRestaurant(Integer re_id) {
		if(re_id == null) return null;
		
		List<FileVO> files = restaurantDao.selectFileRestaurant(re_id);
		
		if(files == null) return null;
		
		return files;
	}

	@Override
	public List<RestaurantVO> getAllRestaurant() {
		
		 return restaurantDao.getAllRestaurant();
		
	}

	@Override
	public boolean updateRestaurant(RestaurantVO rest, int[] fi_nums, MultipartFile[] fileList, UserVO user) {
		if(rest == null ) {
			return false;
		}
		if(user == null) {
			return false;
		}
		
		boolean res;
		
		try {
			res = restaurantDao.updateRestaurant(rest);
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		if(!res) {
			return false;
		}
		
		//첨부파일 삭제
		if(fi_nums != null) {
			for(int fi_id : fi_nums) {
				deleteFile(fi_id);
			}
		}
		//첨부파일 추가
		if(fileList == null || fileList.length == 0) {
			return true;
		}
		for(MultipartFile file : fileList) {
			uploadFile(file, rest.getRe_id());
		}
		return true;
	}

	private void deleteFile(int fi_id) {
		//첨부파일 정보를 가져옴
		FileVO file = restaurantDao.selectFile(fi_id);
		deleteFile(file);
	}
	
	private void deleteFile(FileVO file) {
		if(file == null) {
			return;
		}
		//첨부파일을 서버에서 삭제
		UploadFileUtils.deleteFile(uploadPath, file.getFi_path());
		//첨부파일 정보를 DB에서 삭제
		restaurantDao.deleteFile(file.getFi_id());
	}
}

