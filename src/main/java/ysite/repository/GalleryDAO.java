package ysite.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ysite.vo.CommentsVO;
import ysite.vo.GalleryVO;

@Repository
public class GalleryDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public Long insert( GalleryVO galleryVO ) {
		
		sqlSession.insert("gallery.insert", galleryVO);
		
		return galleryVO.getGallery_no();
	}
	
	public GalleryVO get( Long no ) {
		
		GalleryVO vo = sqlSession.selectOne("gallery.getByNo", no);
		
		return vo;
	}
	
	public List<GalleryVO> getList( Integer page ) {
		
		return sqlSession.selectList("gallery.getList", page);
	}
	
	public List<CommentsVO> getComments( Long no ) {
		
		return sqlSession.selectList("gallery.getComments", no);
	}
	
	public void deleteComments( Long no ) {
		
		sqlSession.delete("gallery.deleteComments", no);
	}
	
	public void delete( Long no ) {
		
		sqlSession.delete("gallery.delete", no);
	}
}