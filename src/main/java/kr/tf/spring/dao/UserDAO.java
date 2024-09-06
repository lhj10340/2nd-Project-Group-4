package kr.tf.spring.dao;

import org.apache.ibatis.annotations.Param;

import kr.tf.spring.model.vo.UserVO;

public interface UserDAO {
	
	UserVO findById_InUserDB(@Param("us_id")String us_id);
	
	UserVO findByIdAndAuth(@Param("us_id") String us_id, @Param("us_auth") int us_auth);

	boolean signup(@Param("us")UserVO user_);
}
