<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>

	movieInsertForm.jsp<br>
	
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
	
	<h1>영화 정보 등록 화면</h1>
	
	<%
		String[] genre = {"액션", "스릴러", "코미디", "판타지", "애니메이션"};
		String[] grade = {"19", "15", "12", "7"};
	%>
	
	<script type="text/javascript" src="resources/js/jquery.js"></script>
	<script type="text/javascript">
	
		$(document).ready(function(){
			
			var isCheck = false;
			var use = "";
			
			$('#title_check').click(function(){
				
				$.ajax({
					
					url : "title_check_proc.mv",
					post : "post",
					data : ({
						movietitle : $('input[name=title]').val()
					}),
					success : function(data){
						
						if($('input[name=title]').val() == ""){
							$('#titleMessage').html("<font color = red>입력 누락됐습니다</font>");
							$('#titleMessage').show();
							use = "missing";
							isCheck = true;
						}else if(data == "YES"){
							$('#titleMessage').html("<font color = blue>등록 가능합니다</font>");
							$('#titleMessage').show();
							use = "possible";
	                        isCheck = true;
						}else{
							$('#titleMessage').html("<font color = red>이미 등록된 도서입니다</font>");
							$('#titleMessage').show();
							use = "impossible";
	                        isCheck = true;
						}
					}
					
				});
				
			});
			
			$('input[name=title]').keydown(function(){
				$('#titleMessage').css('display','none');
				isCheck = false;
				use = "";
			});
			
			$('#sub').click(function(){
				
				if(isCheck == false){
		        	alert('중복체크를 하세요');
		            return false;
				}else{
		            if(use == "missing"){
		            	alert('영화 제목 누락되었습니다');
		                $('input[name=title]').focus();
		                return false;
					}else if(use == "impossible"){
		            	alert('이미 등록된 영화 제목입니다');
		                return false;
					}
		        }
			});

		})
	
	    var f_selbox = ['아시아', '아프리카', '유럽', '아메리카', '오세아니아'];
	    var s_selbox = [
	        ['한국', '중국', '베트남', '네팔'],
	        ['케냐', '가나', '세네갈'],
	        ['스페인', '영국', '덴마크', '러시아', '체코'],
	        ['미국', '캐나다'],
	        ['뉴질랜드', '오스트레일리아']
	    ];
	
	    function init() {												// jsp에 들어오면 시작
	        var firstSelect = document.forms["myform"].first;
	
	        for (var i = 0; i < f_selbox.length; i++) {					// 첫번째 select option을 채우는데
	            firstSelect.options[i + 1] = new Option(f_selbox[i]);
	            
	            if ("${movie.continent}" == f_selbox[i]) {				// 만일 이전에 넘어온 movie의 continent가
	                firstSelect.options[i + 1].selected = true;			// 해당 option과 같다면 선택한다
	            }
	        }
	        
	        change();													// 첫번째 select option을 선택했다면 두번째 옵션도 바꾸자
	    }
	
	    function change() {												// 첫번째 select option이 선택될때마다 실행
	        var firstSelect = document.forms["myform"].first;
	        var secondSelect = document.forms["myform"].second;

	        // Clear existing options in the second select box
	        for (var i = secondSelect.options.length - 1; i > 0; i--) {	// 기존 2번째 select option을 초기화하고
	            secondSelect.options[i] = null;
	        }

	        var index = firstSelect.selectedIndex - 1;

	        if (index >= 0) {											// 2번째 select option을 다시 채운다
	            var countries = s_selbox[index];
	            for (var j = 0; j < countries.length; j++) {
	                secondSelect.options[j + 1] = new Option(countries[j], countries[j]);

	                // 선택된 나라 설정										// 이때 이전에 넘어온 movie의 nation이
	                if ("${movie.nation}" == countries[j]) {			// 해당 option과 같다면 선택한다!!!
	                    secondSelect.options[j + 1].selected = true;
	                }
	            }
	        }
	    }
	    
	</script>
															<!-- script에서 $ 안쓰고 아래 onload 매개변수로 넘길수도 있다 -->
	<body onload="init()">
	    <form:form commandName="movie" name="myform" action="insert.mv" method="post">
	        <table border="1">
	            <tr>
	                <td>영화 제목</td>							<!-- 중복체크도 이전에 했던 방식 그대로 똑같이 하자!! -->
	                <td>
	                	<input type="text" name="title" value="${movie.title}"> 
	                	<input type="button" id="title_check" value="중복체크"> 
	                	<span id="titleMessage"></span>
	                	<form:errors path="title" cssClass="err"/> 
	                </td>
	            </tr>
	
	            <tr>
	                <td>대륙</td>
	                <td>
	                    <select id="first" name="continent" onchange="change()">
	                    	<option value="">대륙 선택하세요</option>
	                    </select>
	                    <form:errors path="continent" cssClass="err"/>
	                </td>
				</tr>
				
				<tr>
	                <td>나라</td>
	                <td>
	                    <select id="second" name="nation">
	                    	<option value="">나라 선택하세요</option>
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
	                <td colspan="2"><input type="submit" id="sub" value="추가하기"></td>
	            </tr>
	        </table>
	    </form:form>
	</body>
		