package kr.tf.spring.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.tf.spring.dao.MenuDao;
import kr.tf.spring.model.vo.FileVO;
import kr.tf.spring.model.vo.MenuVO;
import kr.tf.spring.model.vo.RestaurantVO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.utils.UploadFileUtils;

@Service
public class MenuServiceImp implements MenuService{

	//Dao세팅
	@Autowired
	private MenuDao menuDao;
	
	@Resource
	String uploadPath;
	
	@Override
	public List<MenuVO> getMenuListByRestId(RestaurantVO rest) {
		if (rest == null) {
			return null; 
		}
		
		return menuDao.getMenuListByRestId(rest);
	}


	@Override
	public boolean setNewMenu(MenuVO menu, UserVO user, MultipartFile me_thumb) { 
		if (menu == null) {
			return false;
		}
		
		if (user == null) {
			return false; 
		}
		
		if(me_thumb != null) {
			System.out.println(uploadFile(me_thumb));
			menu.setMe_thumb(uploadFile(me_thumb));
		}
		
		return menuDao.setMenuInDB(menu);
	}


	@Override
	public boolean deleteMenuById(String me_id) {
		
		if (me_id == null) {
			return false;
		}
		return menuDao.deleteMenuById(me_id);
	}


	@Override
	public boolean updateMenu(MenuVO menu) {
		if (menu == null) {
			return false;
		}
		
		return menuDao.updateMenu(menu);
	}
	
	
	private String uploadFile(MultipartFile file) {

		if(file == null || file.getOriginalFilename().length() == 0) {
			return null;
		}
		
		try {
			String fi_ori_id = file.getOriginalFilename();
			//첨부파일을 서버에 업로드 후 경로가 포함된 파일명을 가져옴
			String fi_path = 
			UploadFileUtils.uploadFile(uploadPath, fi_ori_id, file.getBytes());
			return fi_path;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
}
