package kr.tf.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.tf.spring.dao.UserDAO;

@Service
public class UserServiceImp implements UserService{
	
	@Autowired
	private UserDAO userDao;
}
