package ysite.controller;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ysite.security.AuthUser;
import ysite.service.UserService;
import ysite.vo.UserVO;

@Controller
@RequestMapping( "/user" )
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping( value="/join", method=RequestMethod.POST )
	public String join ( UserVO userVO, Model model ) {
		
		boolean insertResult = userService.join(userVO);
		
		model.addAttribute( "insertResult", insertResult );
		
		model.addAttribute( "userVO", null );
		
		return "main/index";
	}
	
	@RequestMapping( value="/modify", method=RequestMethod.POST )
	public String modify( @AuthUser UserVO userVO, 
						  @ModelAttribute UserVO vo,
						  Model model, 
						  HttpSession session) {
		
		vo.setUser_no(userVO.getUser_no());
	
		boolean modifyResult = userService.modify( vo );
		
		model.addAttribute( "modifyResult", modifyResult );
		
		session.setAttribute("userVO", userService.getUser( userVO.getUser_no() ));
					
		return "main/index";
	}
	
}
