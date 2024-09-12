package kr.tf.spring.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.model.vo.MenuVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.UserVO;

public interface MenuService {

	List<MenuVO> getMenuListByRestId(RestaurantVO rest);

	boolean setNewMenu(MenuVO menu, UserVO user, MultipartFile me_thumb);

}
