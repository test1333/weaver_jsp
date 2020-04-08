window.eventRegister.registerList('afterLogin', {
fn: function(){
return new Promise(function(resolve, reject){
window.location.href='/gvo/gateway/main.jsp';
});

}
});
