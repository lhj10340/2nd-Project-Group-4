package kr.tf.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.tf.spring.dao.CommentDAO;
import kr.tf.spring.model.vo.CommentVO;
import kr.tf.spring.model.vo.UserVO;
import kr.tf.spring.pagination.Criteria;
import kr.tf.spring.pagination.PageMaker;

@Service
public class CommentService {

	@Autowired
	CommentDAO commentDao;

	public boolean insertComment(CommentVO comment, UserVO user) {
		if(comment == null || user == null) {
			return false;
		}
		comment.setCo_us_id(user.getUs_id());
		return commentDao.insertComment(comment);
	}

	public List<CommentVO> getCommentList(Criteria cri) {
		if(cri == null) {
			return null;
		}
		return commentDao.seelctCommentList(cri);
	}

	public PageMaker getCommentPageMaker(Criteria cri) {
		if(cri == null) {
			return null;
		}
		int totalCount = commentDao.selectCommentTotalCount(cri);
		return new PageMaker(5, cri, totalCount);
	}

	public boolean deleteComment(CommentVO comment, UserVO user) {
		if(user == null || comment == null) {
			return false;
		}
		return commentDao.deleteComment(comment.getCo_id());
	}

	public boolean deleteComment(int cm_num, UserVO user) {
		if(user == null) {
			return false;
		}
		if(!isWriter(cm_num, user.getUs_id())) {
			return false;
		}
		return commentDao.deleteComment(cm_num);
	}

	public boolean updateComment(CommentVO comment, UserVO user) {
		if(user == null || comment == null) {
			return false;
		}
		if(!isWriter(comment.getCo_id(), user.getUs_id())) {
			return false;
		}
		return commentDao.updateComment(comment);
	}
	public boolean isWriter(int cm_num, String us_id) {
		CommentVO comment = commentDao.selectComment(cm_num);
		if(comment == null ) {
			return false;
		}
		return comment.getCo_us_id().equals(us_id);

	}
}
