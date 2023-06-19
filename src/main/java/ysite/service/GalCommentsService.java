package ysite.service;



import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ysite.repository.GalCommentsDAO;
import ysite.vo.CommentsVO;



@Service
public class GalCommentsService {
	
	@Autowired
	private GalCommentsDAO commentsDAO;
	
	public Map<String, Object> insert( CommentsVO commentsVO ) {
		
		CommentsVO vo = null;
		
		Long no = commentsDAO.insert( commentsVO );
		Long commentsCount = commentsDAO.getTotalCount( commentsVO.getGallery_no() );
		
		vo = commentsDAO.get( no );
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("commentsCount", commentsCount);
		map.put("vo", vo);
		
		return map;
	}
	
	public Long delete( Long no, Long gallery_no ) {
	
		commentsDAO.delete( no );
		Long commentsCount = commentsDAO.getTotalCount( gallery_no );
		
		return commentsCount;
	}
}
