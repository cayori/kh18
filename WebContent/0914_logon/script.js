/**
 * 
 */

function focusIt(){
	document.inform.id.focus();
}
function checkIt(){
	inputForm=eval("document.inform");
	if(!inputForm.id.value){
		alert("아이디를 입력하세요");
		inputForm.id.focus();
		return false;
	}
	if(!inputForm.passwd.value){
		alert("비밀번호를 입력하세요");
		inputForm.passwd.focus();
		return false;
	}
}