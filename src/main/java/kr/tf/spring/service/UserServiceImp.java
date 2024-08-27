package kr.tf.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.tf.spring.dao.UserDAO;

@Service
public class UserServiceImp implements UserService{
	
	// Dao 세팅
	@Autowired
	private UserDAO userDao;
	
	//암호화
	@Autowired
	BCryptPasswordEncoder passwordEncoder;


}
