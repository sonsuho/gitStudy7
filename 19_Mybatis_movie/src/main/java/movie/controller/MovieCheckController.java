package movie.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import movie.model.MovieDao;

@Controller
public class MovieCheckController {
	
	final String command = "/title_check_proc.mv";
	final String getPage = "/movieInsertForm";	
	
	@Autowired
	@Qualifier(value = "myMovieDao")       						// ajax를 사용해서 값을 받아와 보내주는 경우 response를 사용하여
	MovieDao mdao;
																// PrintWriter 객체를 만들고 print 메소드를 사용해 보내주자!!!
	@RequestMapping(value = command)
	public void check(@RequestParam(value = "movietitle") String movietitle, HttpServletResponse response) {
		
		System.out.println(movietitle);							// response를 내가 직접 따로 만들지 않고 
		
		String data = mdao.movieTitleCheck(movietitle);			// ResponseBody 어노테이션을 사용할 수도 있다!!
		
		System.out.println(data);
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.print(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
}
