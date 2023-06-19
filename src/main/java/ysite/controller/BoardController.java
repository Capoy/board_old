package ysite.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ysite.security.Auth;
import ysite.security.AuthUser;
import ysite.service.BoardService;
import ysite.spring.web.util.WebUtil;
import ysite.vo.BoardVO;
import ysite.vo.UserVO;

@Controller
@RequestMapping( "/board" )
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping( "" )
	public String index(@RequestParam( value="p", defaultValue="1") Integer page,
						@RequestParam( value="kwd", defaultValue="") String kwd, Model model) {
		
		Map<String, Object> map = boardService.getMessageList( page, kwd );
		
		model.addAttribute( "map", map );
		
		return "board/index";
	}
	
	@Auth
	@RequestMapping( value="/write", method=RequestMethod.GET )
	public String write() {
		
		return "board/write";
	}
	
	@Auth
	@RequestMapping( value="/write", method=RequestMethod.POST )
	public String write( @AuthUser UserVO userVO, 
						 BoardVO boardVO ) {
		
		boardVO.setUser_no( userVO.getUser_no() );
		boardService.writeMessage( boardVO );
		
		return "redirect:/board";
	}
	
	@RequestMapping( value="/view", method=RequestMethod.GET )
	public String view( @RequestParam( value="p", defaultValue="1" ) Integer page,
					    @RequestParam( value="kwd", defaultValue="" ) String kwd,
					    @RequestParam( value="view", defaultValue="y" ) String view,
					    Long no, Model model ) {
		
		BoardVO boardVO = boardService.getMessage( no, view );
		
		model.addAttribute( "page", page );
		model.addAttribute( "kwd", kwd );
		model.addAttribute( "boardVO", boardVO );
	
		return "board/view";
	}
	
	@Auth
	@RequestMapping( value="/modify", method=RequestMethod.GET )
	public String modify( @RequestParam( value="p", defaultValue="1" ) Integer page, 
						  @RequestParam( value="kwd", defaultValue="" ) String kwd,
						  @RequestParam( value="view", defaultValue="n" ) String view,
						  Long no, Model model ) {
		
		BoardVO boardVO = boardService.getMessage( no, view );
		
		model.addAttribute( "page", page );
		model.addAttribute( "kwd", kwd );
		model.addAttribute( "boardVO", boardVO );
		
		return "board/modify";
	}
	
	@Auth
	@RequestMapping( value="/modify", method=RequestMethod.POST )
	public String modify( BoardVO boardVO, 
						  @RequestParam( value="p", defaultValue="1" ) Integer page, 
						  @RequestParam( value="kwd", defaultValue="" ) String kwd) {
		
		boardService.updateMessage( boardVO );
		
		return "redirect:/board/view" + 
			   "?no=" + boardVO.getBoard_no() + "&p=" + page + 
			   "&kwd=" + WebUtil.encodeURL( kwd, "UTF-8");
	}
	
	@Auth
	@RequestMapping( value="/reply", method=RequestMethod.GET )
	public String reply( @RequestParam( value="p", defaultValue="1" ) Integer page, 
						 @RequestParam( value="kwd", defaultValue="" ) String kwd, 
						 @RequestParam( value="view", defaultValue="n" ) String view,
						  Long no, Model model ) {
		
		BoardVO boardVO = boardService.getMessage( no, view );
		
		model.addAttribute( "page", page );
		model.addAttribute( "kwd", kwd );
		model.addAttribute( "boardVO", boardVO );
		
		return "board/reply";
	}
	
	@Auth
	@RequestMapping( value="/reply", method=RequestMethod.POST )
	public String reply( @AuthUser UserVO userVO,
						 BoardVO boardVO,
						 @RequestParam( value="p", defaultValue="1" ) Integer page, 
			             @RequestParam( value="kwd", defaultValue="" ) String kwd ) {
		
		boardVO.setUser_no(userVO.getUser_no());
		boardService.replyMessage( boardVO );
		
		return "redirect:/board" + "?p=" + page + 
			   "&kwd=" + WebUtil.encodeURL( kwd, "UTF-8");
	}
	
	@Auth
	@RequestMapping( value="/delete" )
	public String delete( @RequestParam( value="p", defaultValue="1" ) Integer page, 
						  @RequestParam( value="kwd", defaultValue="" ) String kwd, 
						  Long no ) {
		
		boardService.deleteMessage( no );
		
		return "redirect:/board" + 
			   "?p=" + page + 
			   "&kwd=" + WebUtil.encodeURL( kwd, "UTF-8");
	}
		
}
