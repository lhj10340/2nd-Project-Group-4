package kr.tf.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.tf.spring.dao.MenuDao;
import kr.tf.spring.model.vo.MenuVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.UserVO;

@Service
public class MenuServiceImp implements MenuService{

	//Dao세팅
	@Autowired
	private MenuDao menuDao;

	@Override
	public List<MenuVO> getMenuListByRestId(RestaurantVO rest) {
		if (rest == null) {
			return null;
		}
		
		return menuDao.getMenuListByRestId(rest);
	}


	@Override
	public boolean setNewMenu(MenuVO menu, UserVO user) {
		if (menu == null) {
			return false;
		}
		
		if (user == null) {
			return false;
		}
		
		
		return menuDao.setMenuInDB(menu);
	}
	
}
