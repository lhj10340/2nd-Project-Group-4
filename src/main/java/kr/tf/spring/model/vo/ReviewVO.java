package kr.tf.spring.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReviewVO {

	private int rv_id; 
	private String rv_re_id;
	private String rv_us_id;
	private String rv_title;
	private String rv_content;
	private String rv_name;
	private Date rv_date; 
	private int rv_score;
	private String rv_tf;
	private String rv_receipt;
}
