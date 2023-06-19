package ysite.controller.api;



import java.util.ArrayList;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ysite.service.GalCommentsService;
import ysite.vo.CommentsVO;



@Controller
@RequestMapping("gal/comments/api")
public class GalCommentsCon {
	
	@Autowired
	private GalCommentsService commentsService;
	
	@ResponseBody
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public Map<String, Object> insert(CommentsVO commentVO) {
		
		Map<String, Object> map = commentsService.insert( commentVO );
		
		return map;
	}
	

	@ResponseBody
	@RequestMapping("/delete")
	public List<Long> delete( Long no, Long gallery_no ) {
		
		Long commentsCount = commentsService.delete( no , gallery_no );
		
		List<Long> list = new ArrayList<>();
		list.add(no);
		list.add(commentsCount);
		
		return list;
	}
}
