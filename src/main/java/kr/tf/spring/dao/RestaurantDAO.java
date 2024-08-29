package kr.tf.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.tf.spring.model.vo.RestaurantVO;

public interface RestaurantDAO {
	List<RestaurantVO> getListRest();

	RestaurantVO getInfoRest(@Param("re_x")String lat, @Param("re_y")String lng);

	List<RestaurantVO> getSearchList(@Param("sfl")String sfl, @Param("stx")String stx);
}
