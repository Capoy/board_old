package ysite.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ysite.vo.BoardVO;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<BoardVO> getList ( Map<String, Object> sqlMap ) {
		
		return sqlSession.selectList("board.getList", sqlMap);
	}
	
	public int getTotalCount( Map<String, Object> sqlMap ) {
		
		return sqlSession.selectOne("board.getTotalCount", sqlMap);
	}
	
	public void insert( BoardVO boardVO ) {
		
		sqlSession.insert("board.insert", boardVO);
	}
	
	public void updateHit( Long no ) {
		
		sqlSession.update("board.updateHit", no);
	}
	
	public BoardVO get( Long no ) {
		
		return sqlSession.selectOne("board.getByNo", no);
	}
	
	public void update( BoardVO boardVO ) {
		
		sqlSession.update("board.update", boardVO);
	}
	
	public void replyShape( BoardVO boardVO ) {
		
		sqlSession.update("board.replyShape", boardVO);
	}
	
	public void reply( BoardVO boardVO ) {
		
		sqlSession.insert("board.reply", boardVO);
	}
	
	public void delete( Long no ) {
		
		sqlSession.delete("board.delete", no);
	}
	
	public void deleteComment( Long no ) {
		
		sqlSession.delete("board.deleteComments", no);
	}
	
	public int getCommentsTotal( Long no ) {
		
		return sqlSession.selectOne("board.getCommentsTotal", no );
	}
	
}
