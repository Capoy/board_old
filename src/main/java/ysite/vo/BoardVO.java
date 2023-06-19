package ysite.vo;

public class BoardVO {
	
	private Long board_no;
	private String id;
	private String title;
	private String content;
	private String reg_date;
	private Integer hit;
	private Integer group_no;
	private Integer order_no;
	private Integer depth;
	private Integer comments_total;
	private Long user_no;
	
	public Long getBoard_no() {
		
		return board_no;
	}
	public void setBoard_no(Long board_no) {
		
		this.board_no = board_no;
		
	}
	public String getId() {
		
		return id;
	}
	public void setId(String id) {
		
		this.id = id;
	}
	public String getTitle() {
		
		return title;
	}
	public void setTitle(String title) {
		
		this.title = title;
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
	public Integer getHit() {
		
		return hit;
	}
	public void setHit(Integer hit) {
		
		this.hit = hit;
	}
	public Integer getGroup_no() {
		
		return group_no;
	}
	public void setGroup_no(Integer group_no) {
		
		this.group_no = group_no;
	}
	public Integer getOrder_no() {
		
		return order_no;
	}
	public void setOrder_no(Integer order_no) {
		
		this.order_no = order_no;
	}
	public Integer getDepth() {
		
		return depth;
	}
	public void setDepth(Integer depth) {
		
		this.depth = depth;
	}
	public Integer getComments_total() {
		
		return comments_total;
	}
	public void setComments_total(Integer comments_total) {
		
		this.comments_total = comments_total;
	}
	public Long getUser_no() {
		
		return user_no;
	}
	public void setUser_no(Long user_no) {
		
		this.user_no = user_no;
	}
	
	@Override
	public String toString() {
		
		return "BoardVO [board_no=" + board_no + ", id=" + id + ", title=" + title + ", content=" + content
				+ ", reg_date=" + reg_date + ", hit=" + hit + ", group_no=" + group_no + ", order_no=" + order_no
				+ ", depth=" + depth + ", comments_total=" + comments_total + ", user_no=" + user_no + "]";
	}
	
}
