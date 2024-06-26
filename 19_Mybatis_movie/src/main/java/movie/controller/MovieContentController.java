package movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieBean;
import movie.model.MovieDao;

@Controller
public class MovieContentController {
	
	final String command = "/content.mv";
	final String getPage = "/movieContent";
	
	@Autowired
	@Qualifier(value = "myMovieDao")
	MovieDao mdao;
	
	@RequestMapping(value = command)
	public ModelAndView content(@RequestParam(value = "num") String num, 
								@RequestParam(value = "pageNumber") String pageNumber, 
								@RequestParam(value = "whatColumn") String whatColumn, 
								@RequestParam(value = "keyword") String keyword) {
		
		MovieBean movie = mdao.getMovieByNum(num);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("movie", movie);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
}
