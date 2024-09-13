package kr.tf.spring.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CommentVO {
	private int co_id;
	private String co_content;
	private int co_rv_id;
	private Date co_date;
	private String co_us_id;
}
