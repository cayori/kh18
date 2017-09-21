<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file = "../view/color.jsp" %>

<html>
<head>
<link href="../style.css" type="text/css" rel="stylesheet">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script language="Javascript">
	// 입력항목 유효성 검사
	function checkIt() {
		var userinput = eval("document.userinput");
		if(!userinput.id.value){
			alert("ID를 입력하세요");
			return false;
		}
		if(!userinput.passwd.value){
			alert("비밀번호를 입력하세요");
			return false;
		}
		if(!userinput.passwd2.value){
			alert("비밀번호 확인을 입력하세요");
			return false;
		}
		if(userinput.passwd.value != userinput.passwd2.value){
			alert("비밀번호를 동일하게 입력하세요");
			return false;
		}
		if(!userinput.name.value){
			alert("사용자 이름을 입력하세요");
			return false;
		}
		if(!userinput.jumin1.value || !userinput.jumin2.value){
			alert("주민등록번호를 입력하세요");
			return false;
		}
	}
	
	//아이디 중복여부를 판단
	function openConfirmid(userinput){
		// 아이디를 입력했는지 검사
		if (userinput.id.value == ""){
			alert("아이디를 입력하세요");
			return;
		}
		// url 과 사용자 입력 id를 조합합니다.
		url = "confirmId.jsp?id="+userinput.id.value;
		//새로운 윈도우를 엽니다.
		open(url,"confirm","toolbar=no,location=no,status=no,scrollbar=no,resizable=no,width=300,height=200");
	}
    function zipCheck(){
    	url="ZipCheck.jsp?check=y";
    	window.open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
    }
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>
<title>회원가입</title>
</head>

<body bgcolor="<%= bodyback_c %>">
	
	<form method="post" action="./inputPro.jsp" name="userinput" onSubmit="return checkIt()">
		<table width="600" border="1" align="center">
			<tr>
				<td colspan="2" height="39" align="center" bgcolor="<%= value_c %>"><font size="+1"><b>회원가입</b></font></td>
			</tr>
			<tr>
				<td width="200" bgcolor="<%= value_c %>"><b>아이디 입력</b></td>
				<td width="400" bgcolor="<%= value_c %>"></td>
			</tr>
			<tr>
				<td width="200">사용자 ID</td>
				<td width="400">
					<input type="text" name="id" size="10" maxlength="12">
					<input type="button" name="confirm_id" value="ID중복확인" onclick="openConfirmid(this.form)">
				</td>
			</tr>
			<tr>
				<td width="200">비밀번호</td>
				<td width="400">
					<input type="password" name="passwd" size="15" maxlength="12">
				</td>
			</tr>
			<tr>
				<td width="200">비밀번호 확인</td>
				<td width="400">
					<input type="password" name="passwd2" size="15" maxlength="12">
				</td>
			</tr>
			<tr>
				<td width="200" bgcolor="<%= value_c %>"><b>개인정보 입력</b></td>
				<td width="400" bgcolor="<%= value_c %>"></td>
			</tr>
			<tr>
				<td width="200">사용자 이름</td>
				<td width="400">
					<input type="text" name="name" size="15" maxlength="10">
				</td>
			</tr>
			<tr>
				<td width="200">주민등록번호</td>
				<td width="400">
					<input type="text" name="jumin1" size="7" maxlength="6">
					<input type="text" name="jumin2" size="7" maxlength="7">
				</td>
			</tr>
			<tr>
				<td width="200">E-main</td>
				<td width="400">
					<input type="text" name="email" size="40" maxlength="30">
				</td>
			</tr>
			<tr>
				<td width="200">Blog</td>
				<td width="400">
					<input type="text" name="blog" size="60" maxlength="50">
				</td>
			</tr>
		    <tr> 
		       <td width="200">우편번호</td>
		       <td> <input type="text" name="zipcode" size="7" id="sample6_postcode">
		            <input type="button" value="우편번호찾기" onclick="sample6_execDaumPostcode()">
		               우편번호를 검색 하세요.</td>
		    </tr>
		    <tr>
		    <tr> 
		       <td>주소</td>
		       <td><input type="text" name="addr1" size="70" id="sample6_address"></td>
		    </tr>
		    
		    <tr> 
		       <td>주소2</td>
		       <td><input type="text" name="addr2" size="70" id="sample6_address2">
		       </td>
		    </tr>	  
			<tr>
				<td colspan="2" align="center" bgcolor="<%= value_c %>">
					<input type="submit" name="confirm" value="등   록">
					<input type="reset" name="reset" value="초기화">
					<input type="button" value="가입안함" onclick="javascript:window.location='../main.jsp'">
				</td>
			</tr>
		</table>
		
	</form>
	
</body>

</html>