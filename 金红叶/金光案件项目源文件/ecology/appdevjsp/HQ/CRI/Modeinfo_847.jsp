<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

int formid = Util.getIntValue(request.getParameter("formid"));
int types = Util.getIntValue(request.getParameter("type"));
int billid = Util.getIntValue(request.getParameter("billid"));
int xm=-1;   
int sfzh=-1;
int gh=-1;
int lx=-1;
int nr=-1;
int ssajbt=-1;

rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("xm".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		xm=fieldid;
	}else if("sfzh".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		sfzh=fieldid;
	}else if("gh".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		gh=fieldid;
	}else if("lx".equals(fieldname.toLowerCase()) && "uf_hq_cri_involpers_dt1".equals(detailtable) ){
		lx=fieldid;
	}else if("nr".equals(fieldname.toLowerCase()) && "uf_hq_cri_involpers_dt1".equals(detailtable) ){
		nr=fieldid;
	}else if("ssajbt".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		ssajbt=fieldid;
	}
}

String ssajval = "";
rs.executeSql(" select ssajbt from uf_hq_cri_involpers where id = '"+billid+"' ");
if(rs.next()){
	ssajval = rs.getString("ssajbt");
}

%>

<script type="text/javascript">

jQuery(document).ready(function(){
	
	var t = $('#field11870'); //获取到文本域对象  
	t.css("color","#A9A9A9"); //设置文本域的样式  
	t.val("涉案人员为集团员工时填写Just fill it on condition that individual involved works in APP Group"); //设置默认显示文字  
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
	
	jQuery("#field<%=xm%>").bind("keyup", function(){
		CheckXM();
	})
	
	jQuery("#field<%=sfzh%>").bind("keyup", function(){
		CheckSFZH();
	})
	
	jQuery("#field<%=gh%>").bind("keyup", function(){
		CheckGH();
	})
	
	all_browse_bind("#indexnum0",function(){
		CheckLXFS();
	})
	var indexnum0 = jQuery("#indexnum0").val()*1.0;
	if(indexnum0 > 0){
		CheckLXFS();
	}	
	
	//所属案件
	var aj = "<%=ssajval%>";
	if(aj!=""){		
		var type = "<%=types%>";
		if(type=="0"){
			var billid = "";
			var ssqj = jQuery("#field<%=ssajbt%>span").text();
			if(ssqj.indexOf(",")>0){
				var str = "";
				var ssqjarray = ssqj.split(",");
				for(var i=0;i<ssqjarray.length;i++){
					var ssqjxmbh = ssqjarray[i].split("@@@")[1];
					var ssqjxmmc = ssqjarray[i].split("@@@")[2];
					var ssqjdyry = ssqjarray[i].split("@@@")[3];
					var ssqjhtml = ssqjxmbh+"-"+ssqjxmmc+"-"+ssqjdyry;
					jQuery("#field<%=ssajbt%>").text(ssqjhtml);
					billid = ssqjarray[i].split("@@@")[0];
					str = str +  "<a href='/formmode/view/ViewMode.jsp?type=0&modeId=852&formId=-151&billid="+billid+"' target='_blank'>"+ssqjhtml+"</a>" + ",";
				}
				str=str.substring(0,str.length-1);
				jQuery("#field<%=ssajbt%>span").html(str);
			}else{
				var ssqjxmbh = ssqj.split("@@@")[1];
				var ssqjxmmc = ssqj.split("@@@")[2];
				var ssqjdyry = ssqj.split("@@@")[3];
				var ssqjhtml = ssqjxmbh+"-"+ssqjxmmc+"-"+ssqjdyry;
				jQuery("#field<%=ssajbt%>").text(ssqjhtml);
				if(ssqj!=""){
					billid = ssqj.split("@@@")[0];
				}
				var str = "<a href='/formmode/view/ViewMode.jsp?type=0&modeId=852&formId=-151&billid="+billid+"' target='_blank'>"+ssqjhtml+"</a>";
				jQuery("#field<%=ssajbt%>span").html(str);
			}
			
		}else if(type=="2"){
			var billid = "";
			var ssqj = jQuery("#field<%=ssajbt%>").val();
			if(ssqj.indexOf(",")>0){
				var str = "";
				var ssqjarray = ssqj.split(",");
				for(var i=0;i<ssqjarray.length;i++){
					var ssqjxmbh = ssqjarray[i].split("@@@")[1];
					var ssqjxmmc = ssqjarray[i].split("@@@")[2];
					var ssqjdyry = ssqjarray[i].split("@@@")[3];
					var ssqjhtml = ssqjxmbh+"-"+ssqjxmmc+"-"+ssqjdyry;
					jQuery("#field<%=ssajbt%>").html(ssqjhtml);
					billid = ssqjarray[i].split("@@@")[0];
					str = str +  "<a href='/formmode/view/ViewMode.jsp?type=0&modeId=852&formId=-151&billid="+billid+"' target='_blank'>"+ssqjhtml+"</a>" + ",";
				}
				str=str.substring(0,str.length-1);
				jQuery("#field<%=ssajbt%>span").html(str);
			}else{	
				var ssqjxmbh = ssqj.split("@@@")[1];
				var ssqjxmmc = ssqj.split("@@@")[2];
				var ssqjdyry = ssqj.split("@@@")[3];
				var ssqjhtml = ssqjxmbh+"-"+ssqjxmmc+"-"+ssqjdyry;
				jQuery("#field<%=ssajbt%>").html(ssqjhtml);
				if(ssqj!=""){
					billid = ssqj.split("@@@")[0];
				}
				var str = "<a href='/formmode/view/ViewMode.jsp?type=0&modeId=852&formId=-151&billid="+billid+"' target='_blank'>"+ssqjhtml+"</a>";
				jQuery("#field<%=ssajbt%>span").html(str);
			}			
		}
	}
	
	checkCustomize = function(){
		if (t.val() == default_value) {  
			t.val('');  
		} 
		return true;
	}
	
})

function CheckLXFS(){
	jQuery("select[name^='field<%=lx%>_']").each(function(){
		var id_tmp = this.id.split("_")[1];
		jQuery("#field<%=lx%>_"+id_tmp).unbind("change");
		jQuery("#field<%=lx%>_"+id_tmp).bind("change", function(){
			DetailTs(id_tmp);
		}) 
		
		var nrDocum=document.getElementById("field<%=nr%>_"+id_tmp) ;
		var alreadyBind=nrDocum.getAttribute("alreadyBind");
		if(alreadyBind!="ok"){
			nrDocum.setAttribute("alreadyBind","ok");
			all_browse_bind("#field<%=nr%>_"+id_tmp ,function(){
				DetailTs(id_tmp);
			})
		}	
	})	
}

function DetailTs(id){
	var lx = jQuery("#field<%=lx%>_"+id).val();
	var nr = jQuery("#field<%=nr%>_"+id).val();
	if(lx!=""&&nr!=""){
		jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_847.jsp?time=" + new Date(),{opt:'getCheckLXFS',lx:lx,nr:nr},function(result){
			var lx1 = result.resulta;
			var lx2 = result.resultb;
			var lx3 = result.resultc;
			var lx4 = result.resultd;
			var lx5 = result.resulte;
			var lx6 = result.resultf;
			if(lx1!=200 && lx==0){
				alert("已有相同的电话存在！");
				jQuery("#field<%=nr%>_"+id).val(nr.replace(lx1,""));
			}
			if(lx2!=200 && lx==1){
				alert("已有相同的邮箱存在！");
				jQuery("#field<%=nr%>_"+id).val(nr.replace(lx2,""));
			}
			if(lx3!=200 && lx==2){
				alert("已有相同的微信号存在！");
				jQuery("#field<%=nr%>_"+id).val(nr.replace(lx3,""));
			}
			if(lx4!=200 && lx==3){
				alert("已有相同的家庭住址存在！");
				jQuery("#field<%=nr%>_"+id).val(nr.replace(lx4,""));
			}
			if(lx5!=200 && lx==4){
				alert("已有相同的QQ存在！");
				jQuery("#field<%=nr%>_"+id).val(nr.replace(lx5,""));
			}
			if(lx6!=200 && lx==5){
				alert("已有相同的其他信息存在！");
				jQuery("#field<%=nr%>_"+id).val(nr.replace(lx6,""));
			}
		},'json');
	}
}

function CheckXM(){
	var xm =  jQuery.trim(jQuery("#field<%=xm%>").val());
	jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_847.jsp?time=" + new Date(),{opt:'getCheckXM',xm:xm},function(result){
		var xm = result.result;
		if(xm==500){
			alert("已有相同的姓名存在！");
		}
	},'json');
}

function CheckSFZH(){
	var sfzh = jQuery.trim(jQuery("#field<%=sfzh%>").val());
	if((sfzh.trim())==""){
		
	}else{
		jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_847.jsp?time=" + new Date(),{opt:'getCheckSFZH',sfzh:sfzh},function(result){
			var sfzhresult = result.result;
			if(sfzhresult!=200){
				alert("已有相同的身份证号存在！");
				jQuery("#field<%=sfzh%>").val(sfzh.replace(sfzhresult,""));
			}
		},'json');
	}
}

function CheckGH(){
	var gh = jQuery.trim(jQuery("#field<%=gh%>").val());
	jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_847.jsp?time=" + new Date(),{opt:'getCheckGH',gh:gh},function(result){
		var gh = result.result;
		if(gh==500){
			alert("已有相同的工号存在！");
		}
	},'json');
}

function all_browse_bind( id ,func_browse){	
    var id_val_last=jQuery(id).val();
    setInterval(function(){
        var id_val = jQuery(id).val();
        if( id_val != id_val_last){
           func_browse();
        }
        id_val_last = id_val;
    },50);
}

</script>