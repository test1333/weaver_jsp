
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.hrm.job.JobTitlesComInfo"%> <%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="java.util.*,java.sql.Timestamp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="rolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page"/>
<jsp:useBean id="subCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>

<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type="text/css" rel="STYLESHEET">
		<SCRIPT language="javascript" src="/js/weaver_wev8.js"></SCRIPT>
		<script type="text/javascript" src="/cowork/js/cowork_wev8.js"></script>
		<SCRIPT language="javascript"  defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript"  src="/js/selectDateTime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src='/js/JSDateTime/WdatePicker_wev8.js?rnd="+Math.random()+"'></script>
<style>
.e8_btn_top{

color:white;
background-color: dodgerblue;
}

#ee{
margin-left: 32px;
}

#ee .intervalDivClass{
height: 0px !important;
}
</style>
	</HEAD>
<%
 

String settype = Util.null2String(request.getParameter("settype"));
String cotypeid = Util.null2String(request.getParameter("cotypeid"));
	
String imagefilename = "/images/hdReport_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(17718,user.getLanguage())+"：";
String headname = "";
if(settype.equals("manager")){
    titlename += SystemEnv.getHtmlLabelName(2097,user.getLanguage());
    headname = SystemEnv.getHtmlLabelName(2097,user.getLanguage());
}else if(settype.equals("members")){
    titlename +=SystemEnv.getHtmlLabelName(271,user.getLanguage());
    headname =SystemEnv.getHtmlLabelName(271,user.getLanguage());
}
String needfav ="1"; 
String needhelp ="";
Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String currentdate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);


String id = Util.null2String(request.getParameter("id"));
String sql= "select name from nickname where id = ?";
String nickname = "";
rs.executeQuery(sql,id);
while(rs.next()){
	nickname = rs.getString("name");
}
//new BaseBean().writeLog(nickname);
%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<% 
    RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doSubmit(this),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

 


<div class="zDialog_div_content" style="height:120px;">
<FORM name="weaver" method="post"  action="/cowork/nickname/CoworkNicknameOperation.jsp?method=editname" enctype="multipart/form-data">		
 								
 <input type="hidden" value="<%=id%>" name="id" id="id">

 <br><br>
<wea:layout attributes="{layoutTableId:'ee'}">
<wea:group context="" attributes="{groupDisplay:none}">
      <wea:item  ><div style="width: 70px;margin-left: -10px">用户名</div></wea:item>
		<wea:item >
			<wea:required id="namespan" required="true">
				<input class="inputstyle" type="text" name="name" id="name" value="<%=nickname%>"
					onkeydown="if(window.event.keyCode==13) return false;" onChange="checkinput('name','namespan')" 
					style="width:150px" onblur="checkLength('name',100,'<%=SystemEnv.getHtmlLabelName(344,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')">
					
			</wea:required>  
		</wea:item> 
		 
	 
	</wea:group>
</wea:layout>

 <input class="e8_btn_top middle" onclick="doSave(this)" type="button" style="width: 150px;margin-left: 90px;margin-top: 17px;" value="修改"/> 
 
</FORM>
</div>

 
<jsp:include page="/systeminfo/commonTabFoot.jsp"></jsp:include>  

<SCRIPT language="JavaScript">

jQuery(function(){
  	hideEle("showrolelevel","true");
  	checkinput("seclevel","seclevelimage");
  	checkinput("seclevelMax","seclevelMaximage");
  	
  		hideEle("item_seclevel");
	hideEle("item_jobtitlelevel");
  	
  	jQuery("#resourceDiv").hide();
	jQuery("#subcompanyDiv").hide();
	jQuery("#roleDiv").hide();
	
	jQuery("select[name='sharetype']").live("change",function(){
		onChangeSharetype();
	})
  });
  
  
var dialog = parent.getDialog(window); 
var parentWin = parent.getParentWindow(window);
 

function doSave(obj){
var isUsed_1 = $("#isUsed_1").attr("checked");
var name = $("#name").val().trim();
if(name==""){
window.top.Dialog.alert("请填写用户名!"); 
return;
}
obj.disabled = true;	 
         $.ajax({
            url: '/cowork/nickname/CoworkNicknameOperation.jsp?method=checkname&name='+name,
            async : false,
            cache:false,
            success: function(result){
              // result = eval('('+result+')');
               if(result==1){
				 obj.disabled = false;	
               window.top.Dialog.alert("该用户名已存在，请重新提交!"); 
				return;
               }else{
	                document.weaver.submit();
               }
             
            }
        })

  
}

 
</SCRIPT>
</BODY>
</HTML>
