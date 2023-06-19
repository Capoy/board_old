package ysite.repository;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ysite.vo.UserVO;

@Repository
public class UserDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insert(UserVO userVO) {
		
		return sqlSession.insert("user.insert", userVO);
	}
	
	public UserVO login( Map<String, Object> map ) {
		
		UserVO vo = sqlSession.selectOne("user.getByIdAndPw", map);
		
		return vo;
	}
	
	public UserVO idCheck( String id ) {
		
		UserVO userVO = sqlSession.selectOne("user.getById", id);
		
		return userVO;
	}
	
	public UserVO emailCheck( String email ) {
		
		UserVO userVO = sqlSession.selectOne("user.getByEmail", email);
		
		return userVO;
	}
	
	public UserVO getUser( Long user_no ) {
		
		return sqlSession.selectOne("user.getByNo", user_no);
	}
	
	public int modify ( Map<String, Object> map) {
		
		return sqlSession.update("user.modify", map);
	}
}
