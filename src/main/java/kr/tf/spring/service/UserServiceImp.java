package kr.tf.spring.service;

import java.util.regex.Pattern;

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
		if (user_.getRemember() != null) {
			System.out.println("자동로그인 on된 인원입니다. 후추");
			//쿠키 굽기
		}
		
		//다 체크 완료되면 findUser 리턴
		return findUser;
	}

	
	//아이디 String 값을 넣으면 userVO를 찾아줘용
	private UserVO findById_InUserDB(String us_id) {
		
		return userDao.findById_InUserDB(us_id);
	}

	@Override
	public boolean signup(UserVO user_) {
		if (user_ == null) {
			return false;
		}
		
		//id 공백 체크
		if (user_.getUs_id() == null ||user_.getUs_id().trim().length()==0) {
			return false;
		}
		
		//id Regex 
		if (!check_Regex(user_.getUs_id(), "^\\w{8,13}$")) {
			return false;
		}
		
		//pw 공백 체크
		if (user_.getUs_pw() == null ||user_.getUs_pw().trim().length()==0) {
			return false;
		}
		
		//pw Regex
		if (!check_Regex(user_.getUs_pw(), "^[a-zA-Z0-9!@#$]{8,15}$")) {
			return false;
		}
		
		//중복 체크
		UserVO findUser = findById_InUserDB(user_.getUs_id());
		
		//아이디가 있으면? 중복이니까 false
		if (findUser != null) {
			return false;
		}
		
		//암호화
		String encPw = passwordEncoder.encode(user_.getUs_pw());
		
		//암호화 적용
		user_.setUs_pw(encPw);
		
		//만약 us_say를 여기서 한다면 >> 마크업언어가 가능해집니다 >> 태그 제거 반드시해줘야해용
		
		
		//이메일 쪼게기 (이물질 제거)
		String email_arr[] = user_.getUs_email().split(",");
		
		//길이가 2보다 클 수 있는 경우는 ,를 2개 이상 넣었을 때
		if (email_arr.length > 2) {
			return false;
		}
		
		//붙이기
		String email_res = email_arr[0] + email_arr[1];
		user_.setUs_email(email_res);
		
		
		return userDao.signup(user_);
	}


	//regex 체크 str = 입력받은 문자열, regex = 규칙
	private boolean check_Regex(String str, String regex) {
		
		if (str != null && Pattern.matches(regex, str)) {
			return true;
		}
		
		return false;
	}


}
