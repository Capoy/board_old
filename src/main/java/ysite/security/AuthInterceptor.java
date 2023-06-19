package ysite.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ysite.vo.UserVO;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if( handler instanceof HandlerMethod == false ) {
			
			return true;
		}
		
		Auth auth = ((HandlerMethod)handler).getMethodAnnotation( Auth.class );
		
		if( auth == null ) {
			
			return true;
		}
		
		HttpSession session = request.getSession();
		
		if( session == null ) {
			
			response.sendRedirect(
					request.getContextPath() + "/main" );
			
			return false;
		}
		
		UserVO userVO = (UserVO)session.getAttribute( "userVO" );
		
		if( userVO == null ){
			
			response.sendRedirect(
					request.getContextPath() + "/main" );
			
			return false;
		}
		
		return true;
	}
	
	

}
