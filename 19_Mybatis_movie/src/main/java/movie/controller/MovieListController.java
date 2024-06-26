package movie.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieBean;
import movie.model.MovieDao;
import utility.Paging;

@Controller
public class MovieListController {
	
	final String command = "/list.mv";
	final String getPage = "/movieList";
	
	@Autowired
	@Qualifier(value = "myMovieDao")
	MovieDao mdao;
	
	@RequestMapping(command)
	public ModelAndView movieList(@RequestParam(value = "whatColumn", required = false) String whatColumn
								, @RequestParam(value = "keyword", required = false) String keyword
								, @RequestParam(value = "pageNumber", required = false) String pageNumber
								, HttpServletRequest request) {
				
		ModelAndView mav = new ModelAndView();
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("pageNumber", pageNumber);
		
		System.out.println(whatColumn);
		System.out.println(keyword);
		System.out.println(pageNumber);
		
		int totalCount = mdao.getTotalCount(map);
		
		System.out.println("totalCount는 " + totalCount);
		
		String url = request.getContextPath() + this.command;
		
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);
		
		List<MovieBean> list = mdao.getMovieList(pageInfo, map);
		
		mav.addObject("list", list);
		mav.addObject("pageInfo", pageInfo);
		
		mav.setViewName(getPage);
		
		System.out.println("test : " + pageInfo.getPageNumber());
		System.out.println("test : " + pageInfo.getUrl());
		System.out.println("test : " + pageInfo.getPageSize());
		System.out.println("test : " + pageInfo.getTotalCount());
		
		System.out.println("test1 : " + pageInfo.getPageNumber());
		System.out.println("test2 : " + pageInfo.getPagingHtml());
		
		return mav;
	}
	
}
