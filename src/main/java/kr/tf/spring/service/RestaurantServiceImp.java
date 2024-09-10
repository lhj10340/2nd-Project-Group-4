package kr.tf.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public RestaurantVO findRestById(int re_id) {
		
		
		return restaurantDao.findRestById(re_id);
	}
}
