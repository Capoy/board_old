package ysite.controller.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ysite.service.CommentsService;
import ysite.vo.CommentsVO;

@Controller
@RequestMapping("/comments/api")
public class CommentsController {
	
	@Autowired
	private CommentsService commentsService;
	
	@ResponseBody
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public CommentsVO insert(CommentsVO commentVO) {
		
		CommentsVO vo = commentsService.insert( commentVO );
		
		return vo;
	}
	
	@ResponseBody
	@RequestMapping("/list")
	public List<CommentsVO> list( Long no ) {
		
		List<CommentsVO> list = commentsService.list( no );
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public Long delete( Long no ) {
		
		commentsService.delete( no );
		
		return no;
	}
}
