package ysite.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ysite.repository.GalleryDAO;
import ysite.vo.CommentsVO;
import ysite.vo.GalleryVO;

@Service
public class GalleryService {
	
	private static final String SAVE_PATH = "c:/upload";
	
	@Autowired
	private GalleryDAO galleryDAO;
	
	public GalleryVO insert( MultipartFile multiPartFile, GalleryVO galleryVO ) {
		
		String orgFileName = multiPartFile.getOriginalFilename();
		String fileExtName = orgFileName.substring(orgFileName.lastIndexOf('.') + 1, orgFileName.length());
		String saveFileName = generateSaveFileName(fileExtName);
		Long fileSize = multiPartFile.getSize();

		writeFile(multiPartFile, saveFileName);

		galleryVO.setOrgFileName(orgFileName);
		galleryVO.setFileExtName(fileExtName);
		galleryVO.setSaveFileName(saveFileName);
		galleryVO.setFileSize(fileSize);
		
		Long no = galleryDAO.insert( galleryVO );
		
		GalleryVO vo = galleryDAO.get( no );
		
		List<CommentsVO> cList = galleryDAO.getComments( vo.getGallery_no() );
		
		vo.setList(cList);
		
		return vo;
	}
	
	public List<GalleryVO> getList( Integer page ) {
		
		List <GalleryVO> list = galleryDAO.getList( page );
		
		for(int i=0; i<list.size(); i++) {
				
			Long no = list.get(i).getGallery_no();
			List<CommentsVO> cList = galleryDAO.getComments( no );
			
			list.get(i).setList(cList);
			
		}
		
		return list;
	}
	
	public void delete( Long no ) {
		
		GalleryVO galleryVO = galleryDAO.get(no);
		
		File file = new File(SAVE_PATH + "/" + galleryVO.getSaveFileName());
		file.delete();
		
		galleryDAO.deleteComments( no );
		galleryDAO.delete( no );
		
	}

	private void writeFile(MultipartFile multiPartFile, String saveFileName) {

		try {

			byte[] fileData = multiPartFile.getBytes();
			FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
			fos.write(fileData);
			fos.flush();
			fos.close();

		} catch (IOException ex) {}

	}

	private String generateSaveFileName(String fileExtName) {
		
		String saveFileName = "";
		Calendar calendar = Calendar.getInstance();

		saveFileName += calendar.get(Calendar.YEAR);
		saveFileName += calendar.get(Calendar.MONTH);
		saveFileName += calendar.get(Calendar.DATE);
		saveFileName += calendar.get(Calendar.HOUR);
		saveFileName += calendar.get(Calendar.MINUTE);
		saveFileName += calendar.get(Calendar.SECOND);
		saveFileName += calendar.get(Calendar.MILLISECOND);
		saveFileName += ("." + fileExtName);

		return saveFileName;
	}
}
