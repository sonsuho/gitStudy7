package movie.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component(value = "myMovieDao")
public class MovieDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public MovieDao() {
		System.out.println("MovieDao 생성자");
	}

	public List<MovieBean> getMovieList(Paging pageInfo, Map<String, String> map) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<MovieBean> list = sqlSessionTemplate.selectList("movie.MovieBean.getMovieList", map, rowBounds);
		
		System.out.println("getMovieList 수 : " + list.size());
		
		return list;
	}

	public int getTotalCount(Map<String, String> map) {
		
		int count = sqlSessionTemplate.selectOne("movie.MovieBean.getTotalCount", map);
		
		System.out.println("count : " + count);
		
		return count;
	}

	public void insertMovie(MovieBean mb) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.insert("movie.MovieBean.insertMovie", mb);
		
		System.out.println("insert cnt : " + cnt);
	}

	public String movieTitleCheck(String movietitle) {
		
		String title = sqlSessionTemplate.selectOne("movie.MovieBean.movieTitleCheck", movietitle);
		
		if(title == null || title.equals("")) {
			return "YES";
		}else {
			return "NO";
		}
	}

	public MovieBean getMovieByNum(String num) {
		
		MovieBean movie = sqlSessionTemplate.selectOne("movie.MovieBean.getMovieByNum", num);
		
		System.out.println("getMovieByNum : " + movie.getTitle());
				
		return movie;
	}

	public int deleteByNum(String num) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.delete("movie.MovieBean.deleteByNum", num);
		
		System.out.println("deleteByNum cnt : " + cnt);
		
		return cnt;
	}

	public int updateMovie(MovieBean movie) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.update("movie.MovieBean.updateMovie", movie);
		
		System.out.println("updateMovie cnt : " + cnt);
		
		return cnt;
	}
	
	
	
}
