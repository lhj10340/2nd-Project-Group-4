package kr.tf.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MenuVO {
	private int me_id; //메뉴고유 key값
	private int me_re_id; //레스토랑 이름
	private String me_title; // 메뉴이름
	private String me_category; //가지는 카테고리 명
	private String me_main_menu; // 메인 메뉴인가? null/on
	private String me_show; // 보여지는가? null/on //위아래 둘다 디폴트가 false입니다
	private int me_price; // 가격
	private String me_thumb; // 섬네일
}
