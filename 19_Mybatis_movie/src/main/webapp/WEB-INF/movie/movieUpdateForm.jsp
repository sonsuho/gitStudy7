<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>

	movieUpdateForm.jsp<br>
	
	<style type="text/css">
		
		.err{
			font-size: 9pt;
			color: red;
			font-weight: bold;
		}
		
		body{
			margin: 0 auto;
			text-align: center;
		}
		
		table{
			margin: 0 auto;
			text-align: left;
			border-collapse: collapse;
			width: 800px;
		}
		
		td:first-child{
			text-align: center;
			background-color: #FFEEDD;
			width: 150px;
		}

    	th, td{
    		padding: 5px;
    	}
		
	</style>
	
	<h1>영화 정보 수정 화면</h1>
	
	<%
		String[] genre = {"액션", "스릴러", "코미디", "판타지", "애니메이션"};
		String[] grade = {"19", "15", "12", "7"};
	%>
	
	<script type="text/javascript">
	
		    var f_selbox = ['아시아', '아프리카', '유럽', '아메리카', '오세아니아'];
		    var s_selbox = [
		        ['한국', '중국', '베트남', '네팔'],
		        ['케냐', '가나', '세네갈'],
		        ['스페인', '영국', '덴마크', '러시아', '체코'],
		        ['미국', '캐나다'],
		        ['뉴질랜드', '오스트레일리아'
		    ];
	
	          
	          function firstChange() {
	             var index = document.myform.first.selectedIndex; // 아프리카:2
	             
	             for(i=document.myform.second.length-1; i>0; i--) {
	                document.myform.second.options[i] = null;
	             } 
	             
	             for(i=0; i<s_selbox[index-1].length; i++) {
	                document.myform.second.options[i+1] = new Option(s_selbox[index-1][i]);
	             }  
	          } //firstChange
	    
	</script>
															<!-- script에서 $ 안쓰고 아래 onload 매개변수로 넘길수도 있다 -->
	<%
		
		String[] f_selbox = {"아시아", "아프리카", "유럽", "아메리카", "오세아니아"};
		
		String[][] s_selbox = {
					        {"한국", "중국", "베트남", "네팔"},
					        {"케냐", "가나", "세네갈"},
					        {"스페인", "영국", "덴마크", "러시아", "체코"},
					        {"미국", "캐나다"},
					        {"뉴질랜드", "오스트레일리아"}
		        			};
	%>
	
	<c:set var="f_selbox" value="<%=f_selbox %>" />
	<c:set var="s_selbox" value="<%=s_selbox %>" />
	
	<body>
	    <form:form commandName="movie" name="myform" action="update.mv" method="post">
	    
	    	<input type="hidden" name="num" value="${movie.num}">
	    	
	    	<input type="hidden" name="pageNumber" value="${param.pageNumber}">
	    	<input type="hidden" name="whatColumn" value="${param.whatColumn}">
	    	<input type="hidden" name="keyword" value="${param.keyword}">
	    	
	        <table border="1">
	            <tr>
	                <td>영화 제목</td>
	                <td>
	                	<input type="text" name="title" value="${movie.title}"> 
	                	<form:errors path="title" cssClass="err"/> 
	                </td>
	            </tr>
	
	            <tr>
	                <td>대륙</td>
	                <td>
	                    <select id="first" name="continent" onchange="firstChange()">
	                    	<option value="">대륙 선택하세요</option>
	                    	<c:forEach var="i" items="<%=f_selbox%>">
	                    		<option value="${i}" <c:if test="${movie.continent eq i}">selected="selected"</c:if>>${i}</option>
	                    	</c:forEach>
	                    </select>
	                    <form:errors path="continent" cssClass="err"/>
	                </td>
				</tr>
				
				<tr>
	                <td>나라</td>
	                <td>
	                    <select id="second" name="nation">
	                    	<option value="">나라 선택하세요</option>
	                    	<c:forEach var="i" begin="0" end="${fn:length(f_selbox) - 1}" step="1">
								<c:if test="${movie.continent ==  f_selbox[i]}">
	                    			<c:forEach var="j" begin="0" end="${fn:length(s_selbox[i])-1}" step="1">
	                    				<option value="${s_selbox[i][j]}" <c:if test="${fn:contains(movie.nation, s_selbox[i][j])}">selected="selected"</c:if>>${s_selbox[i][j]}</option>
	                    			</c:forEach>
								</c:if>
	                    	</c:forEach>
	                    </select>
	                    <form:errors path="nation" cssClass="err"/>
	                </td>
	            </tr>
	
	            <tr>
	                <td>장르</td>
	                <td>
	                	<c:forEach var="i" items="<%=genre %>">
	                		<input type="checkbox" name="genre" value="${i}" <c:if test="${fn:contains(movie.genre, i)}">checked="checked"</c:if>> ${i}
	                	</c:forEach>
	                	<form:errors path="genre" cssClass="err"/>
	                </td>
	            </tr>
	
	            <tr>
	                <td>등급</td>
	                <td>
	                	<c:forEach var="i" items="<%=grade %>">
	                		<input type="radio" name="grade" value="${i}" <c:if test="${movie.grade == i}">checked="checked"</c:if>> ${i}
	                	</c:forEach>
	                	<form:errors path="grade" cssClass="err"/>
	                </td>
	            </tr>
	
	            <tr>
	                <td>출연 배우</td>
	                <td><input type="text" name="actor" value="${movie.actor}"> <form:errors path="actor" cssClass="err"/></td>
	            </tr>
	
	            <tr>
	                <td colspan="2"><input type="submit" id="sub" value="수정하기"></td>
	            </tr>
	        </table>
	    </form:form>
	</body>
	
		