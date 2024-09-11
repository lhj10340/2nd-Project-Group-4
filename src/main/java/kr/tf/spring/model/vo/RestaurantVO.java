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
	private String re_address2;
	private String re_state;
	private String re_phone;
	private int re_views;
	private String re_tag;
	private String re_content;
	private double re_score;
}
