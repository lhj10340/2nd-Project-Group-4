package kr.tf.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.dao.RestaurantDAO;
import kr.tf.spring.model.vo.RestaurantVO;

@Service
public class RestaurantServiceImp implements RestaurantService {
	@Autowired
	private RestaurantDAO restaurantDao;

	@Override
	public RestaurantVO infoRest(String lat, String lng) {
		if(lat == null || lng == null) return null;
		
		RestaurantVO restaurant = restaurantDao.getInfoRest(lat, lng);
		
		if(restaurant == null) return null;
		
		return restaurant;
	}

	@Override
	public List<RestaurantVO> searchList(String sfl, String stx, String sort) {
		return restaurantDao.getSearchList(sfl, stx, sort);
	}

	@Override
	public RestaurantVO getReviewName(int restId) {
		
		if(restId < 0) return null;
		
		return restaurantDao.getReviewName(restId);
	}

	@Override
	public boolean restaurantRegister(RestaurantVO rest, MultipartFile[] fileList) {
		/*if(fileList == null || fileList.length == 0) {
			return true;
		}*/
		return false;
	}
}
