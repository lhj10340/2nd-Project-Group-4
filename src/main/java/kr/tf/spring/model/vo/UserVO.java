package kr.tf.spring.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class UserVO {
	
	private String us_id;// varchar(20) PK 
	private String us_pw;// varchar(255)
	private int us_auth;// int 
	private String us_name;// varchar(20) 
	private String us_gender;// varchar(6) 
	private Date us_hbd;// date 
	private String us_phone;// varchar(15) 
	private String us_email;// varchar(30) 
	private int us_failed;// int 
	private String us_cookie;// varchar(255) 
	private Date us_limit;// datetime 
	private int us_report;// int 
	private Date us_stop;// datetime 
	private String us_icon;// longtext 
	private String us_say;// varchar(150)
	
}
