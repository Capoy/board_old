package ysite.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ysite.service.UserService;
import ysite.vo.UserVO;

public class AuthLoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle (
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler )
			throws Exception {
		
		String id = request.getParameter( "id" );
		String password = request.getParameter( "password" );
		
		ApplicationContext ac = 
				WebApplicationContextUtils.getWebApplicationContext( request.getServletContext() );
		
		UserService userService = ac.getBean( UserService.class );
		
		UserVO userVO = userService.login(id, password);
		
		if( userVO == null ) {
			
			response.sendError(401);
			
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("userVO", userVO);
		
		return false;
	}
}
