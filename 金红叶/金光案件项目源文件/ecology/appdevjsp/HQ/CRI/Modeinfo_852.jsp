<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>

<%
User usertemp = HrmUserVarify.getUser (request , response) ;
int userid=usertemp.getUID();
int formid = Util.getIntValue(request.getParameter("formid"));	
int billid = Util.getIntValue(request.getParameter("billid"));	
int types = Util.getIntValue(request.getParameter("type"));	
int zt=-1;   
int ajsyts=-1; 
int dcy=-1;
int xmbh=-1;
int gdgz=-1;
int afddgj=-1;
int afddqt=-1;
int afddsqt=-1;
int afdds=-1;
int dyzr=-1;
int xydx=-1;
int ajsyzs=-1;
int user=-1;
rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("zt".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		zt=fieldid;
	}else if("ajsyts".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		ajsyts=fieldid;
	}else if("dcy".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dcy=fieldid;
	}else if("xmbh".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		xmbh=fieldid;
	}else if("gdgz".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		gdgz=fieldid;
	}else if("afddgj".equals(fieldname.toLowerCase()) && "uf_hq_cri_casedp_dt1".equals(detailtable) ){
		afddgj=fieldid;
	}else if("afddqt".equals(fieldname.toLowerCase()) && "uf_hq_cri_casedp_dt1".equals(detailtable) ){
		afddqt=fieldid;
	}else if("afdds".equals(fieldname.toLowerCase()) && "uf_hq_cri_casedp_dt1".equals(detailtable) ){
		afdds=fieldid;
	}else if("dyzr".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dyzr=fieldid;
	}else if("xydx".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		xydx=fieldid;
	}else if("ajsyzs".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		ajsyzs=fieldid;
	}else if("userid".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		user=fieldid;
	}
}

%>

<script type="text/javascript">

	jQuery(document).ready(function(){
		
		var billid = "<%=billid%>";
		var dcy = jQuery("#field<%=dcy%>").val();
		var xmbh = jQuery("#field<%=xmbh%>").val();
		
		jQuery("#field<%=zt%>").unbind("change");
		jQuery("#field<%=zt%>").bind("change", function(){
			CheckZt();
		}) 
		
		//获取当前用户
		jQuery("#field<%=user%>").val("<%=userid%>");
		
		var t = $('#field12794'); //获取到文本域对象  
        t.css("color","#A9A9A9"); //设置文本域的样式  
        t.val("填写金额Fill Loss Amount"); //设置默认显示文字  
        var default_value = t.val(); //把默认显示的文字赋给一个变量                 
        t.focus(function() {  //当鼠标点击文本域时修改文本域的样式，判断文本域内的文字是否等于默认值，如果等于就把文本域内设空  
			t.css("color","black");  
			if (t.val() == default_value) {  
				t.val('');  
			}  
	    });  
        t.blur(function() { //当文本域失去鼠标焦点时判断文本域中的值是否为空，如果为空就把文本域的值设置为默认显示的文字并修改样式  
			t.css("color","black");  
			if (t.val() == '') {  
				t.val(default_value);  
				t.css("color","#A9A9A9");  
			}  
	    });  

        var t1 = $('#field12795'); //获取到文本域对象  
        t1.css("color","#A9A9A9"); //设置文本域的样式  
        t1.val("填写金额Fill Loss Amount"); //设置默认显示文字  
        var default_value1 = t1.val(); //把默认显示的文字赋给一个变量                 
        t1.focus(function() {  //当鼠标点击文本域时修改文本域的样式，判断文本域内的文字是否等于默认值，如果等于就把文本域内设空  
			t1.css("color","black");  
			if (t1.val() == default_value1) {  
				t1.val('');  
			}  
	    });  
        t1.blur(function() { //当文本域失去鼠标焦点时判断文本域中的值是否为空，如果为空就把文本域的值设置为默认显示的文字并修改样式  
			t1.css("color","black");  
			if (t1.val() == '') {  
				t1.val(default_value1);  
				t1.css("color","#A9A9A9");  
			}  
        });  

        var t2 = $('#field12796'); //获取到文本域对象  
        t2.css("color","#A9A9A9"); //设置文本域的样式  
        t2.val("填写金额Fill Loss Amount"); //设置默认显示文字  
        var default_value2 = t2.val(); //把默认显示的文字赋给一个变量                 
        t2.focus(function() {  //当鼠标点击文本域时修改文本域的样式，判断文本域内的文字是否等于默认值，如果等于就把文本域内设空  
			t2.css("color","black");  
			if (t2.val() == default_value2) {  
				t2.val('');  
			}  
        });  
        t2.blur(function() { //当文本域失去鼠标焦点时判断文本域中的值是否为空，如果为空就把文本域的值设置为默认显示的文字并修改样式  
			t2.css("color","black");  
			if (t2.val() == '') {  
				t2.val(default_value2);  
				t2.css("color","#A9A9A9");  
			}  
        });  
		
		checkCustomize = function(){
			var flag = "";
			var flaga = "";
			
			if (t.val() == default_value) {  
				t.val('');  
			}  
			if (t1.val() == default_value1) {  
				t1.val('');  
			}  
			if (t2.val() == default_value2) {  
				t2.val('');  
			}  
			
			var gdgz = jQuery("#field<%=gdgz%>").val();
			//var afddgj =jQuery("#field<%=afddgj%>").val();
			//var afddsqt = jQuery("#field<%=afddsqt%>").val();
			//var dyzr = jQuery("#field<%=dyzr%>").val();
			var xydx = jQuery("#field<%=xydx%>").val();
			//if(!(gdgz=="" || xydx=="")){//案件详情-“嫌疑对象”现在改为不必填，但不填值“保存”按钮触发不了，需检查UpdateAjxqXgxxAction 代码
			if(!(gdgz=="")){
				var zt = jQuery("#field<%=zt%>").val();
				var billid = "<%=billid%>";
				var dcy = jQuery("#field<%=dcy%>").val();
				var xmbh = jQuery("#field<%=xmbh%>").val();
				jQuery.ajax({
					url:"/appdevjsp/HQ/CRI/Ajax_Modeinfo_852.jsp",
					type:"post",
					data:{opt:'opt',zt:zt,billid:billid,dcy:dcy,xmbh:xmbh,gdgz:gdgz},
					async:false,
					dataType:"json",
					success:function(data){
						var result = data.resultzt;
						if(result == "0"){
							flag = "success";
							alert("开放流程已创建成功！");
							jQuery("#disfield<%=zt%>").val("4");
							jQuery("#field<%=zt%>").val("4");
						}else if(result == "1"){
							alert("结案流程已创建成功！");
							flag = "success";
							jQuery("#disfield<%=zt%>").val("5");
							jQuery("#field<%=zt%>").val("5");
						}else if(result == "2"){
							alert("搁置流程已创建成功！");
							flag = "success";
							jQuery("#disfield<%=zt%>").val("6");
							jQuery("#field<%=zt%>").val("6");
						}else if(result == "3"){
							alert("取消流程已创建成功！");
							flag = "success";
							jQuery("#disfield<%=zt%>").val("7");
							jQuery("#field<%=zt%>").val("7");
						}else if(result == "100"){
							alert("该通知流程创建失败！");
							flaga = "stop";
						}else if(result == "500"){
							flaga = "stop";
						}
					}
				},'json');
				
				if(flag=="success" || flaga == "stop"){
					return true;
				}else{
					return false;
				}
			
			}
			
		} 
		
		var ztval = jQuery("#disfield<%=zt%>").val();
		if(ztval=="4" ||ztval=="5" || ztval=="6" || ztval=="7"){
			jQuery("#disfield<%=zt%>").attr("style","color:red");
		}
		
		
		all_browse_bind("#indexnum0",function(){
			Detail_1();
		})
		
		var indexnum0 = jQuery("#indexnum0").val()*1.0;
		if(indexnum0 > 0){
			Detail_1();
		}	
		
	})
	
	function CheckZt(){
		var zt = jQuery("#field<%=zt%>").val();
		if(zt=="4" || zt=="5" || zt=="6" || zt=="7"){
			alert("只能选择前面4种状态的值，请重新选择！");
			jQuery("#field<%=zt%>").val("");
		}
	}
	
	function Detail_1(){
		jQuery("input[name^='field<%=afddgj%>_']").each(function(){
			var id_tmp = this.id.split("_")[1];
			all_browse_bind("#field<%=afddgj%>_"+id_tmp,function(){
				getCheckGJ(id_tmp);
			})	
			all_browse_bind("#field<%=afddqt%>_"+id_tmp,function(){
				getCheckSf(id_tmp);
			})
		});
	}
	
	function getCheckGJ(id){
		var gjval = jQuery("#field<%=afddgj%>_"+id).val();
		var document = jQuery("#field<%=afddgj%>_"+id);
		if(gjval!=""){
			jQuery("#field<%=afddqt%>_"+id).val("");
			jQuery("#field<%=afddqt%>_"+id+"span").html("");
			jQuery("#field<%=afdds%>_"+id).val("");
			jQuery("#field<%=afdds%>_"+id+"span").html("");
		}
	}
	
	function getCheckSf(id){
		var sfval = jQuery("#field<%=afddqt%>_"+id).val();
		if(sfval!=""){
			jQuery("#field<%=afdds%>_"+id).val("");
			jQuery("#field<%=afdds%>_"+id+"span").html("");
		}
	}
	
	function all_browse_bind( id ,func_browse){	
		var id_val_last=jQuery(id).val();
		setInterval(function(){
			var id_val = jQuery(id).val();
			if( id_val != id_val_last)
			{
			   func_browse();
			}
			id_val_last = id_val;
		},50);
	}

</script>
