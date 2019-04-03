function  countbonus(){
    alert(123);
    var startdate = "#startdate";
    var enddate = "#enddate";

    $.ajax({
                type : "post",  
                url : "/seahonor/CountBonus.jsp",
                dataType: "json",  
                data:{'startdate':startdate,'enddate':enddate},
                async : false,
                success : function(data){
                    alert(data);     
                }  
            }); 

}