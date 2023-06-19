package ysite.service;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import ysite.repository.UserDAO;
import ysite.vo.UserVO;

@Service
public class UserService {

	@Autowired
	private UserDAO userDAO;

	public boolean join(UserVO userVO) {
		
		return userDAO.insert(userVO) == 1;
	}

	public UserVO login(String id, String password) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("password", password);

		UserVO vo = userDAO.login( map );

		return vo;
		
	}

	public UserVO idCheck(String id) {

		UserVO userVO = userDAO.idCheck(id);

		return userVO;
	}

	public UserVO emailCheck(String email) {

		UserVO userVO = userDAO.emailCheck(email);

		return userVO;
	}

	public UserVO getUser(Long user_no) {
		
		return userDAO.getUser(user_no);
	}

	public boolean modify( UserVO userVO ) {

		Map<String, Object> map = new HashMap<>();

		map.put("password", userVO.getPassword());
		map.put("email", userVO.getEmail());
		map.put("user_no", userVO.getUser_no());

		return userDAO.modify(map) == 1;
	}

}
