package ysite.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ysite.repository.CommentsDAO;
import ysite.vo.CommentsVO;

@Service
public class CommentsService {
	
	@Autowired
	private CommentsDAO commentsDAO;
	
	public CommentsVO insert( CommentsVO commentsVO ) {
		
		CommentsVO vo = null;
		
		Long no = commentsDAO.insert( commentsVO );
		
		vo = commentsDAO.get( no );
		
		return vo;
	}
	
	public List<CommentsVO> list( Long no ) {
		
		List<CommentsVO> list = commentsDAO.list( no );
		return list;
	}
	
	public void delete( Long no ) {
		
		commentsDAO.delete( no );
	}
}
