package kr.tf.spring.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.model.vo.FileVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.UserVO;

public interface RestaurantService {
	List<RestaurantVO> searchList(String sfl, String stx, String sort);

	RestaurantVO findRestById(int re_id);
	
	RestaurantVO getReviewName(int restId);

	boolean restaurantRegister(RestaurantVO rest, MultipartFile[] fileList);

	RestaurantVO findRestByUserId(UserVO user);
	List<FileVO> selectFileRestaurant(Integer re_id);

	List<RestaurantVO> getAllRestaurant();

	boolean updateRestaurant(RestaurantVO rest, int[] fi_nums, MultipartFile[] fileList, UserVO user);
}
