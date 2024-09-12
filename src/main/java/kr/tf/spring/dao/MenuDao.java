package kr.tf.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.tf.spring.model.vo.MenuVO;
import kr.tf.spring.model.vo.RestaurantVO;

public interface MenuDao {

	List<MenuVO> getMenuListByRestId(@Param("rest")RestaurantVO rest);

	boolean setMenuInDB(@Param("menu")MenuVO menu);

	boolean deleteMenuById(@Param("me_id")String me_id);

	boolean updateMenu(@Param("menu")MenuVO menu);

}
