package kr.tf.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ImageVO {
	int im_num;
	String im_ori_name;
	String im_name;
	int im_rv_id;
	
	public ImageVO(String im_name, String im_ori_name, int rv_id) {
		this.im_num = im_num;
		this.im_name = im_name;
		this.im_ori_name = im_ori_name;
		this.im_rv_id = im_rv_id;
	}
}
