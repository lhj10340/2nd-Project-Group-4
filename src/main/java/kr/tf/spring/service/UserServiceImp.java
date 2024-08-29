package kr.tf.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.tf.spring.dao.UserDAO;
import kr.tf.spring.model.dto.LoginDTO;
import kr.tf.spring.model.vo.UserVO;

@Service
public class UserServiceImp implements UserService{
	
	// Dao 세팅
	@Autowired
	private UserDAO userDao;
	
	//암호화
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Override
	public UserVO login(LoginDTO user_) {
		//null 체크
		if (user_ == null) {
			return null;
		}
		
		//id 체크 => 아이디를 안적고 보내면 바로 리턴
		if (user_.getUs_id() == null ||user_.getUs_id().trim().length()==0) {
			return null;
		}
		//pw 체크 => 없으면 db에 들리지 않고 리턴할 수 있어서
		if (user_.getUs_pw() == null ||user_.getUs_pw().trim().length()==0) {
			return null;
		}
		
		//id로 db에서 값을 가져와용
		UserVO findUser = findById_InUserDB(user_.getUs_id());
		
		//가져온 user가 null이면 없는 아이디에용 
		if (findUser == null) {
			return null;
		}
		
		// 암호화된 비번 체크
		if (!passwordEncoder.matches(user_.getUs_pw(), findUser.getUs_pw())) {
			return null;
		}
		
		// 자동로그인이 된다면? => 나중에 쿠키굽기
		if (user_.getRemember().equals("on")) {
			System.err.println("자동로그인 on된 인원입니다. 후추");
		}
		
		//다 체크 완료되면 findUser 리턴
		return findUser;
	}

	private UserVO findById_InUserDB(String us_id) {
		
		
		return userDao.findById_InUserDB(us_id);
	}


}
