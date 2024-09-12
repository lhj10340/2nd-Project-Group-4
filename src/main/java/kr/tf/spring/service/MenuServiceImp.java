package kr.tf.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.tf.spring.dao.MenuDao;

@Service
public class MenuServiceImp implements MenuService{

	//Dao세팅
	@Autowired
	private MenuDao menuDao;
	
}
