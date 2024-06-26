<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    movieContent.jsp<br>
    
    <style>
    	
    	h1, table{
    		margin: 0 auto;
    	}
    	
    	table{
    		width: 400px;
    	}
    	
    	td:first-child {
			width: 100px;
			font-weight: bold;
		}
		
		td{
			padding-top: 15px;
			padding-bottom: 15px;
		}
    	
    </style>
    
    <h1 style="text-align: center;">영화 상세 화면</h1><br>
    
    <table border="1">
    	
    	<tr>
    		<td>번호</td>
    		<td>${movie.num}</td>
    	</tr>
    	
    	<tr>
    		<td>영화제목</td>
    		<td>${movie.title}</td>
    	</tr>
    	
    	<tr>
    		<td>제작국가</td>
    		<td>${movie.nation}</td>
    	</tr>
    	
    	<tr>
    		<td>장르</td>
    		<td>${movie.genre}</td>
    	</tr>
    	
    	<tr>
    		<td>등급</td>
    		<td>${movie.grade}</td>
    	</tr>
    	
    	<tr>
    		<td>배우</td>
    		<td>${movie.actor}</td>
    	</tr>
    	
    	<tr>
    		<td colspan="2" align="center"><a href="list.mv?pageNumber=${param.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}">영화 리스트로 돌아감</a></td>
    	</tr>
    	
    </table>
    