window.eventRegister.registerList('afterLogin', {
fn: function(){
return new Promise(function(resolve, reject){
window.location.href='/login/E9VerifyLogin.jsp';
// window.location.href='/gvo/gateway/main.jsp';
});
}
});
window.eventRegister.registerList('beforLogin', {
  fn: function(){
    return new Promise(function(resolve, reject) {
      var loginid = jQuery('#loginid').val();
      var userpassword = jQuery('#userpassword').val();
      var result = "0";
      jQuery.ajax({
                    type: "POST",
                    url: "/login/checkvistor.jsp",
                    data: {'loginid':loginid,'userpassword':userpassword},
                    dataType: "text",
                    async:false,//同步 true异步
                    success: function(data){
                                data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                                 result = data;
                            }
                    
                });
	if(result == "1"){
		window.location.href='/login/menweilogin.jsp';
	}else{
		resolve();
	}
    });
  }
});


