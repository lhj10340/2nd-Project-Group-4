package kr.tf.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.tf.spring.model.vo.MenuVO;
import kr.tf.spring.model.vo.RestaurantVO;

public interface MenuDao {

	List<MenuVO> getMenuListByRestId(@Param("rest")RestaurantVO rest);

}
