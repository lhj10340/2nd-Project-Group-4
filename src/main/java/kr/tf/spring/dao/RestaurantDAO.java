package kr.tf.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.tf.spring.model.vo.RestaurantVO;

public interface RestaurantDAO {
	
	RestaurantVO getInfoRest(@Param("re_y")String lat, @Param("re_x")String lng);
	
	List<RestaurantVO> getSearchList(@Param("sfl")String sfl, @Param("stx")String stx, @Param("sort")String sort);
	
	RestaurantVO getReviewName(@Param("re_id")int restId);
}
