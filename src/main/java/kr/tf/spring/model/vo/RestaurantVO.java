package kr.tf.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RestaurantVO {
	private int re_id;
	private String re_x;
	private String re_y;
	private String re_name;
	private String re_address;
	private String re_phone;
	private String re_tag;
	private String re_content;
	private int re_score;
}
