jQuery(document).ready(function(){
	jQuery("#Logout").click(function(){
		var isLogout = confirm("确定要退出系统吗？");
		if(isLogout){
			window.location.href="/login/Logout.jsp";
		}
	});
	//hideMe();//隐藏新建流程
})