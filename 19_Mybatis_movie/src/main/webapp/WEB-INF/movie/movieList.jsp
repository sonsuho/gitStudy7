<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>

    movieList.jsp<br>
    
    <style type="text/css">
    	
    	body{
    	    margin: 0 auto;
    		text-align: center;
    	}
    	
    	table{
    		margin: 0 auto;
    		text-align: center;
    		border-collapse: collapse;
    	}
    	
    	th{
    		background-color: #FFEECC;
    	}
    	
    	a{
    		color: red;
    	}
    	
    	th, td{
    		padding: 5px;
    	}
    	
    </style>
    
    <h1>영화 리스트 화면</h1>
    
    <form action="list.mv">
    	
    	<select name="whatColumn">
    		<option value="all">전체 검색</option>
    		<option value="genre">장르</option>
    		<option value="actor">배우</option>
    	</select> 
    	
    	<input type="text" name="keyword">
    	
    	<input type="submit" value="검색">
    	
    </form>
    <br>
    
    <table border="1">
    	
    	<tr>
    		<th colspan="9" align="right"><a href="insert.mv">추가하기</a></th>
    	</tr>
    	
    	<tr>
    		<th>번호</th>
    		<th>제목</th>
    		<th>대륙</th>
    		<th>국가</th>
    		<th>장르</th>
    		<th>성적</th>
    		<th>배우</th>
    		<th>수정</th>
    		<th>삭제</th>
    	</tr>
    	
    	<c:forEach var="movie" items="${list}">									<!-- 기존 페이지로 돌아가기 위해 pageNumber와 -->
    		
    		<tr>																<!-- whatColum + keyword를 함께 넘긴다!!! -->
    			<td>${movie.num}</td>
    			<td><a href="content.mv?num=${movie.num}&pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">${movie.title}</a></td>
    			<td>${movie.continent}</td>
    			<td>${movie.nation}</td>
    			<td>${movie.genre}</td>
    			<td>${movie.grade}</td>
    			<td>${movie.actor}</td>
    			<td><a href="update.mv?num=${movie.num}&pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">수정</a></td>
    			<td><a href="delete.mv?num=${movie.num}&pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">삭제</a></td>
    		</tr>
    		
    	</c:forEach>
    	
    </table>
    
    <br>
    
    ${pageInfo.pagingHtml }
    