package kr.tf.spring.service;

import java.util.List;

import kr.tf.spring.model.dto.LoginDTO;
import kr.tf.spring.model.vo.UserVO;

public interface UserService {

	UserVO login(LoginDTO user_);

	List<UserVO> findUsersByName(String name);// 이름으로 회원 검색
	UserVO findUserById(String id); // ID로 회원 상세 정보 조회

	boolean  deleteUser(String userId);

	boolean  updateUser(UserVO user);


	


}
