function updatedpid(){
	
	
	jQuery.ajax({
             type: "POST",
             url: "/hsproject/project/aciton/update-departmentid.jsp",
             data: {},
             dataType: "text",
             async:false,//同步   true异步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        window.top.Dialog.alert("更新成功");
                      }
         });



}