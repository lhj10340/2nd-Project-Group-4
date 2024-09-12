package kr.tf.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FileVO {
	int fi_id;
	String fi_path;
	String fi_ori_id;
	int fi_re_id;
	int fi_rv_id;
	
	public FileVO(String fi_path, String fi_ori_id, int re_id) {
		this.fi_path = fi_path;
		this.fi_ori_id = fi_ori_id;
		this.fi_re_id = re_id;
	}
}
