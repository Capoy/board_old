package ysite.vo;

public class UserVO {
	
	private Long user_no;
	private String id;
	private String password;
	private String email;
	
	public Long getUser_no() {
		
		return user_no;
	}
	public void setUser_no(Long user_no) {
		
		this.user_no = user_no;
	}
	public String getId() {
		
		return id;
	}
	public void setId(String id) {
		
		this.id = id;
	}
	public String getPassword() {
		
		return password;
	}
	public void setPassword(String password) {
		
		this.password = password;
	}
	public String getEmail() {
		
		return email;
	}
	public void setEmail(String email) {
		
		this.email = email;
	}
	
	@Override
	public String toString() {
		
		return "UserVO [user_no=" + user_no + ", id=" + id + ", password=" + password + ", email=" + email + "]";
	}
	
}
