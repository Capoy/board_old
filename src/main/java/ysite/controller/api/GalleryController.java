package ysite.controller.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import ysite.service.GalleryService;
import ysite.vo.GalleryVO;

@Controller
@RequestMapping("/gallery/api")
public class GalleryController {
	
	@Autowired
	private GalleryService galleryService;
	
	@RequestMapping( "" )
	public String index() {
		
		return "gallery/index";
	}
	
	@ResponseBody
	@RequestMapping( value="/insert", method=RequestMethod.POST )
	public GalleryVO insert( @RequestParam( value="gallery_img" ) MultipartFile multiPartFile,
							 GalleryVO galleryVO) {
		
		GalleryVO vo = galleryService.insert( multiPartFile, galleryVO );
		
		return vo;
	}
	
	@ResponseBody
	@RequestMapping( "/list" )
	public List<GalleryVO> list( @RequestParam( value="p", required=true, defaultValue="1" ) Integer page ) {
		
		List<GalleryVO> list = galleryService.getList(page);
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public Long delete( Long no ) {
		
		galleryService.delete( no );
		
		return no;
	}
}
