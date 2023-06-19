package ysite.controller.api;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import ysite.service.UserService;
import ysite.vo.UserVO;

@RequestMapping("/user/api")
@Controller( "userAPIController" )
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@ResponseBody
	@RequestMapping(value="/idcheck", method=RequestMethod.POST)
	public String idCheck(@RequestParam(value="id", required=true) String id) {
		
		UserVO userVO = userService.idCheck(id);
		
		if(userVO != null) {
			
			return "false";
		} 
		
		return "true";
	}
		
	@ResponseBody
	@RequestMapping(value="/emailcheck", method=RequestMethod.POST)
	public String emailCheck(@RequestParam(value="email", required=true) String email) {
							//@RequestBody
		
		UserVO userVO = userService.emailCheck(email);
		
		if(userVO != null) {
			
			return "false";
		}
		
		return "true";
	}
}
