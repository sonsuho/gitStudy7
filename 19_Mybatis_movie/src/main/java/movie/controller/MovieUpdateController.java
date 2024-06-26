package movie.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieBean;
import movie.model.MovieDao;

@Controller
public class MovieUpdateController {
	
	final String command = "update.mv";
	final String getPage = "movieUpdateForm";
	final String gotoPage = "redirect:/list.mv";
	
	@Autowired
	@Qualifier(value = "myMovieDao")
	MovieDao mdao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView updateForm(@RequestParam(value = "num") String num, 
								   @RequestParam(value = "pageNumber") String pageNumber, 
								   @RequestParam(value = "whatColumn") String whatColumn, 
								   @RequestParam(value = "keyword") String keyword) {
		
		MovieBean movie = mdao.getMovieByNum(num);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("movie", movie);
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView update(@ModelAttribute("movie") @Valid MovieBean mb, BindingResult resul, 
								@RequestParam(value = "pageNumber") String pageNumber, 
							    @RequestParam(value = "whatColumn") String whatColumn, 
							    @RequestParam(value = "keyword") String keyword) {
		
		ModelAndView mav = new ModelAndView();

		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);

		if(resul.hasErrors()) {
			
			mav.setViewName(getPage);
			
			return mav;
		}
		
		mdao.updateMovie(mb);
		
		mav.setViewName(gotoPage);
		
		return mav;
	}
}
