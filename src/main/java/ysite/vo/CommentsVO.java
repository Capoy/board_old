package ysite.vo;

public class CommentsVO {
	
	private Long comments_no;
	private String id;
	private String content;
	private String reg_date;
	private Long user_no;
	private Long board_no;
	private Long gallery_no;
	
	public Long getComments_no() {
		
		return comments_no;
	}
	public void setComments_no(Long comments_no) {
		
		this.comments_no = comments_no;
	}
	public String getId() {
		
		return id;
	}
	public void setId(String id) {
		
		this.id = id;
	}
	public String getContent() {
		
		return content;
	}
	public void setContent(String content) {
		
		this.content = content;
	}
	public String getReg_date() {
		
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		
		this.reg_date = reg_date;
	}
	public Long getUser_no() {
		
		return user_no;
	}
	public void setUser_no(Long user_no) {
		
		this.user_no = user_no;
	}
	public Long getBoard_no() {
		
		return board_no;
	}
	public void setBoard_no(Long board_no) {
		
		this.board_no = board_no;
	}
	public Long getGallery_no() {
		
		return gallery_no;
	}
	public void setGallery_no(Long gallery_no) {
		
		this.gallery_no = gallery_no;
	}
	
	@Override
	public String toString() {
		
		return "CommentsVO [comments_no=" + comments_no + ", id=" + id + ", content=" + content + ", reg_date="
				+ reg_date + ", user_no=" + user_no + ", board_no=" + board_no + ", gallery_no=" + gallery_no + "]";
	}
	
}
