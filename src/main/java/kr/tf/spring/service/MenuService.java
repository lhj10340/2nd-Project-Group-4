package kr.tf.spring.service;

import java.util.List;

import kr.tf.spring.model.vo.MenuVO;
import kr.tf.spring.model.vo.RestaurantVO;

public interface MenuService {

	List<MenuVO> getMenuListByRestId(RestaurantVO rest);

}
