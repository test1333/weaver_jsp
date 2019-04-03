<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

int formid = Util.getIntValue(request.getParameter("formid"));	
int gsmc=-1;   
int zch=-1;
int zzjgdm=-1;
rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("gsmc".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		gsmc=fieldid;
	}else if("zch".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		zch=fieldid;
	}else if("zzjgdm".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		zzjgdm=fieldid;
	}
}

%>

<script type="text/javascript">

jQuery(document).ready(function(){
	
	jQuery("#field<%=gsmc%>").bind("keyup", function(){
		CheckGSMC();
	})
	
	jQuery("#field<%=zch%>").bind("keyup", function(){
		CheckTYDM();
	})
	
	jQuery("#field<%=zzjgdm%>").bind("keyup", function(){
		CheckZZDM();
	})
	
})

function CheckGSMC(){
	var gsmc =  jQuery.trim(jQuery("#field<%=gsmc%>").val());
	jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_845.jsp?time=" + new Date(),{opt:'getCheckGCMC',gsmc:gsmc},function(result){
		var mc = result.result;
		if(mc==500){
			alert("已有相同的公司名称存在！");
		}
	},'json');
}

function CheckTYDM(){
	var tydm = jQuery.trim(jQuery("#field<%=zch%>").val());
	jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_845.jsp?time=" + new Date(),{opt:'getCheckTYDM',tydm:tydm},function(result){
		var shdm = result.result;
		if(shdm==500){
			alert("已有相同的统一社会信用代码/注册号存在！");
		}
	},'json');
}

function CheckZZDM(){
	var zzdm = jQuery.trim(jQuery("#field<%=zzjgdm%>").val());
	jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_845.jsp?time=" + new Date(),{opt:'getCheckZZDM',zzdm:zzdm},function(result){
		var jgdm = result.result;
		if(jgdm==500){
			alert("已有相同的组织机构代码存在！");
		}
	},'json');
}



</script>