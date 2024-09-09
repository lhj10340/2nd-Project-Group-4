package kr.tf.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReviewVO {
	/*
		rv_id int AI PK 
		rv_re_id int 
		rv_us_id varchar(20) 
		rv_title varchar(50) 
		rv_score int 
		rv_content longtext 
		rv_tf varchar(5) 
		rv_thumb longtext
	 */
	private int rv_id; 
	private int rv_re_id;
	private String rv_us_id;
	private String rv_title;
	private int rv_score;
	private String rv_content;
	private String rv_tf;
	private String rv_thumb; 
}
