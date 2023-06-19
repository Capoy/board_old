package ysite.vo;

import java.util.List;

public class GalleryVO {
	
	private Long gallery_no;
	private String id;
	private String content;
	private String reg_date;
	private Long user_no;
	private String orgFileName;
	private String saveFileName;
	private String fileExtName;
	private Long fileSize;
	private List<CommentsVO> list;
	
	public Long getGallery_no() {
		
		return gallery_no;
	}
	public void setGallery_no(Long gallery_no) {
		
		this.gallery_no = gallery_no;
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
	public String getOrgFileName() {
		
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		
		this.orgFileName = orgFileName;
	}
	public String getSaveFileName() {
		
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		
		this.saveFileName = saveFileName;
	}
	public String getFileExtName() {
		
		return fileExtName;
	}
	public void setFileExtName(String fileExtName) {
		
		this.fileExtName = fileExtName;
	}
	public Long getFileSize() {
		
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		
		this.fileSize = fileSize;
	}
	public List<CommentsVO> getList() {
		
		return list;
	}
	public void setList(List<CommentsVO> list) {
		
		this.list = list;
	}
	
}
