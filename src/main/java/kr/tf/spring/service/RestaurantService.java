package kr.tf.spring.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.model.vo.RestaurantVO;

public interface RestaurantService {
	RestaurantVO infoRest(String lat, String lng);

	List<RestaurantVO> searchList(String sfl, String stx, String sort);

	RestaurantVO getReviewName(int restId);

	boolean restaurantRegister(RestaurantVO rest, MultipartFile[] fileList);
}
