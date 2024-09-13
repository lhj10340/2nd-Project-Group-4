package kr.tf.spring.service;

import java.util.List;

import kr.tf.spring.model.vo.MenuVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.UserVO;

public interface MenuService {

	List<MenuVO> getMenuListByRestId(RestaurantVO rest); 

	boolean setNewMenu(MenuVO menu, UserVO user, MultipartFile me_thumb); 

	boolean deleteMenuById(String me_id);

	boolean updateMenu(MenuVO menu);

}
