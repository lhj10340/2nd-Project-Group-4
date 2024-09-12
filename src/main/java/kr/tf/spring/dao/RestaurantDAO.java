package kr.tf.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.tf.spring.model.vo.FileVO;
import kr.tf.spring.model.vo.RestaurantVO;

public interface RestaurantDAO {
	RestaurantVO getInfoRest(@Param("re_y")String lat, @Param("re_x")String lng);
	
	List<RestaurantVO> getSearchList(@Param("sfl")String sfl, @Param("stx")String stx, @Param("sort")String sort);

	RestaurantVO findRestById(@Param("re_id")int re_id);
	
	RestaurantVO getReviewName(@Param("re_id")int restId);
	
	boolean restaurantRegistert(@Param("rest")RestaurantVO rest);

	void insertFile(@Param("file")FileVO fileVo);
	
	List<FileVO> selectFileRestaurant(@Param("re_id")int re_id);
}
