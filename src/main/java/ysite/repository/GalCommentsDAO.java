package ysite.repository;



import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ysite.vo.CommentsVO;

@Repository
public class GalCommentsDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public Long insert( CommentsVO commentsVO ) {
		
		sqlSession.insert("gal_comments.insert", commentsVO);
		
		return commentsVO.getComments_no();
	}
	
	public CommentsVO get( Long no ) {
		
		CommentsVO vo = sqlSession.selectOne("gal_comments.getByNo", no);
		
		return vo;
	}
	
	public Long getTotalCount( Long gallery_no ) {
		
		Long commentsCount = sqlSession.selectOne("gal_comments.getTotalCount", gallery_no);
		
		return commentsCount;
	}
	
	public void delete( Long no ) {
		
		sqlSession.delete("gal_comments.delete", no);
	}
}
