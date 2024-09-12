package kr.tf.spring.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReviewCriteria extends Criteria{
	
	private String rv_tf;

	@Override
	public String toString() {
		return "[rv_tf=" + rv_tf +"]  "+ super.toString();
	}
}
