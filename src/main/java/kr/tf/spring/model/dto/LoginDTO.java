package kr.tf.spring.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LoginDTO {

	private String us_id;// varchar(20) PK 
	private String us_pw;// varchar(20) 
	private String remember; //no or null
}
