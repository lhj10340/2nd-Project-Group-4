package kr.tf.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReviewVO {
	private int re_id;
	private int rv_re_id;
	private String rv_us_id;
	private String rv_title;
	private int rv_score;
	private String rv_content;
	private String rv_tf;
	private String rv_thumb;
}

