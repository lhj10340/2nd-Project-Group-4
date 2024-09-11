package kr.tf.spring.service;

import kr.tf.spring.model.dto.LoginDTO;
import kr.tf.spring.model.vo.UserVO;

public interface UserService {

	UserVO login(LoginDTO user_);

	boolean signup(UserVO user_);

	void updateUserCookie(UserVO user);

	UserVO getUserByCookie(String sid);

}
