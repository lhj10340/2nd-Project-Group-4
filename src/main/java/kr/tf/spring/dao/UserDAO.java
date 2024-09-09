package kr.tf.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import kr.tf.spring.model.vo.UserVO;

public interface UserDAO {
	
	UserVO findById_InUserDB(@Param("us_id") String us_id);
	UserVO findByIdAndAuth(@Param("us_id") String us_id, @Param("us_auth") int us_auth);
	
	// 이름으로 사용자 검색
	List<UserVO> findUsersByName(@Param("us_name") String us_name);
	
	// ID로 사용자 정보 조회
	UserVO findUserById(@Param("us_id") String us_id);
	
	// 사용자 정보 수정
	int  updateUser(UserVO user);
	
	// 사용자 삭제
	int  deleteUser(@Param("us_id") String userId);
	int  insertUser(UserVO user);
	// 전체 사용자 목록 가져오기

	List<UserVO> getAllUsers();
	
}
