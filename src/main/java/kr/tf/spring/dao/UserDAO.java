package kr.tf.spring.dao;

import org.apache.ibatis.annotations.Param;

import kr.tf.spring.model.vo.UserVO;

public interface UserDAO {
	
	UserVO findById_InUserDB(@Param("us_id")String us_id);
	
	UserVO findByIdAndAuth(@Param("us_id") String us_id, @Param("us_auth") int us_auth);

	boolean signup(@Param("us")UserVO user_);

	void updateMemberCookie(@Param("us")UserVO user);

	UserVO selectUserByCookie(@Param("us_cookie")String sid);

	void add_us_failed(@Param("us_id")String us_id);

	void reset_us_failed(@Param("us_id")String us_id);

	boolean updatePassword(@Param("us")UserVO user_);

}
