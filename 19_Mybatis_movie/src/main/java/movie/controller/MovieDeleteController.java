package movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieDao;

@Controller
public class MovieDeleteController {
	
	final String command = "/delete.mv";
	final String getPage = "redirect:/list.mv";	
	
	@Autowired
	@Qualifier(value = "myMovieDao")
	MovieDao mdao;
	
	@RequestMapping(value = command)
	public ModelAndView delete(@RequestParam(value = "num") String num, 
						 @RequestParam(value = "pageNumber") String pageNumber, 
						 @RequestParam(value = "whatColumn") String whatColumn, 
						 @RequestParam(value = "keyword") String keyword) {
		
		mdao.deleteByNum(num);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		mav.setViewName(getPage);
		
		return mav;
	}
}
