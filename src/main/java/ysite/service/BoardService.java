package ysite.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ysite.repository.BoardDAO;
import ysite.vo.BoardVO;

@Service
public class BoardService {
	private static final int COUNT_LIST = 10;
	private static final int COUNT_PAGE = 5;
	
	@Autowired
	private BoardDAO boardDAO;
	
	public Map<String, Object> getMessageList( Integer page, String kwd ) {
		
		int startRnum = ( page-1 ) * COUNT_LIST;
		int endRnum = startRnum + COUNT_LIST;
		
		Map<String, Object> sqlMap = new HashMap<String, Object>();
		sqlMap.put( "startRnum", startRnum );
		sqlMap.put( "endRnum", endRnum );
		sqlMap.put( "kwd", kwd );
		
		List<BoardVO> list = new ArrayList<BoardVO>();
		
		list = boardDAO.getList( sqlMap );
		
		for(int i=0; i<list.size(); i++) {
			
			Long no = list.get(i).getBoard_no();
			int comments_total = boardDAO.getCommentsTotal( no );
			
			list.get(i).setComments_total(comments_total);
			
		}
		
		int totalCount = boardDAO.getTotalCount( sqlMap );
		int totalPage = totalCount / COUNT_LIST;
		
		if( totalCount % COUNT_LIST > 0 ) {
			
			totalPage++;
			
		} else if ( page > totalPage ) {
			
			page = totalPage;
		}
		
		int startPage = ( (page - 1) / COUNT_PAGE ) * 5 + 1;
		int endPage = ( startPage + COUNT_PAGE ) - 1;
		
		if( endPage > totalPage ) {
			
			endPage = totalPage;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put( "list", list );
		map.put( "totalCount", totalCount );
		map.put( "totalPage", totalPage );
		map.put( "startPage", startPage );
		map.put( "endPage", endPage );
		map.put( "page", page );
		map.put( "kwd", kwd );
		
		return map;
	}
	
	public void writeMessage( BoardVO boardVO ) {
		
		boardDAO.insert( boardVO );
		
	}
	
	public BoardVO getMessage( Long no, String view ) {
		
		BoardVO boardVO = boardDAO.get( no );
		
		if( view.equals("y") ) {
			boardDAO.updateHit( no );
		}
		
		return boardVO;
	}
	
	public void updateMessage( BoardVO boardVO ) {
		
		boardDAO.update( boardVO );
	}
	
	public void replyMessage( BoardVO boardVO ) {
		
		boardDAO.replyShape( boardVO );
		boardDAO.reply( boardVO );
	}
	
	public void deleteMessage( Long no ) {
		
		boardDAO.deleteComment( no );
		boardDAO.delete( no );
	}
}
