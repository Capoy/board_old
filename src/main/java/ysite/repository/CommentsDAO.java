package ysite.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ysite.vo.CommentsVO;

@Repository
public class CommentsDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public Long insert( CommentsVO commentsVO ) {
		
		sqlSession.insert("comments.insert", commentsVO);
		
		return commentsVO.getComments_no();
	}
	
	public CommentsVO get( Long no ) {
		
		CommentsVO vo = sqlSession.selectOne("comments.getByNo", no);
		
		return vo;
	}
	
	public List<CommentsVO> list( Long no ) {
		
		List<CommentsVO> list = sqlSession.selectList("comments.getList", no);
		return list;
	}
	
	public void delete( Long no ) {
		
		sqlSession.delete("comments.delete", no);
	}
}
