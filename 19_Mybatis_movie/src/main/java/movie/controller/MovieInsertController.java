package movie.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import movie.model.MovieBean;
import movie.model.MovieDao;

@Controller
public class MovieInsertController {
	
	final String command = "/insert.mv";
	final String getPage = "/movieInsertForm";
	final String gotoPage = "redirect:/list.mv";	
	
	@Autowired
	@Qualifier(value = "myMovieDao")
	MovieDao mdao;
	
	@RequestMapping(command)
	public String insertForm() {
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String insert(@ModelAttribute("movie") @Valid MovieBean mb, BindingResult result) {
		
		if(result.hasErrors()) {
			return getPage;
			//내가 추가 맨 맨 맨 맨 빼앰 
			// 수수수수수 수퍼노바
		}
		
		mdao.insertMovie(mb);
		
		return gotoPage;
	}
}
