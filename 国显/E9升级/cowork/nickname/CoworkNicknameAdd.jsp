
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

.fieldName{
  vertical-align: top !important;
  padding-top: 4px;
}

</style>
	</HEAD>
<%

//if(! HrmUserVarify.checkUserRight("Email:monitor", user)) { 
 //   response.sendRedirect("/notice/noright.jsp") ;
  //  return ; 
//}

String settype = Util.null2String(request.getParameter("settype"));
String cotypeid = Util.null2String(request.getParameter("cotypeid"));
String loca=Util.null2String(request.getParameter("loca"),"1");
String coworkid=Util.null2String(request.getParameter("coworkid"),"-1");
	
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
%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<% 
    RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doSubmit(this),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

 


<div class="zDialog_div_content" style="height:185px;">
<FORM name="weaver" method="post"  action="/cowork/nickname/CoworkNicknameOperation.jsp?method=addname" enctype="multipart/form-data">		
 								
<input type="hidden" value="<%=loca%>" name="loca" id="loca"> 
<input type="hidden" value="<%=coworkid%>" name="coworkid" id="coworkid"> 
 <br><br>
<wea:layout >
<wea:group context="" attributes="{groupDisplay:none}">
<wea:item><div style="margin-top: 3px;"> 用户名</div></wea:item>
		<wea:item>
			<div style="width: 165px;float: left;display:block;margin-left:auto;margin-right:auto;margin-top: 3px;">
			<wea:required id="namespan" required="true">
				<input class="inputstyle" type="text" name="name" id="name" 
					onkeydown="if(window.event.keyCode==13) return false;" onChange="checkinput('name','namespan')" 
					style="width:150px" onblur="checkLength('name',100,'<%=SystemEnv.getHtmlLabelName(344,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>','<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>')">
					
			</wea:required> </div> &nbsp;&nbsp;
	<div style="float: left;width: 125px;margin: 0;text-align: left;margin-top: 5px;color: red;" id="notice">
			 设置后不可更改 
			</div>
		</wea:item>  
		<wea:item></wea:item>
		<wea:item>
			<div style=""><input type="checkbox" tzCheckbox="false" name="isUsed_1" id="isUsed_1"  value="1" /><label>&nbsp;&nbsp;&nbsp;阅读并接受《<a href="/docs/docs/DocDsp.jsp?id=361391" id="regulationsContent" target="_blank" style="text-decoration: none;color: dodgerblue;">V来心声论坛管理规定</a>》</label>
			<input type="hidden" name="isClickRules" id="isClickRules"  value="0" /></div>
		</wea:item>
	</wea:group>
</wea:layout>

 <input class="e8_btn_top middle" onclick="doSave(this)" type="button" style="width: 150px;margin-left: 130px; top: 145px;position: absolute;" value="注册"/> 
 
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
  
  
jQuery("#regulationsContent").live("click",function(){
   	jQuery("#isClickRules").val("1");
});
  
var dialog = parent.getDialog(window); 
var parentWin = parent.getParentWindow(window);
 

function doSave(obj){
	
var isClickRules = jQuery("#isClickRules").val();
if(isClickRules !="1"){
	window.top.Dialog.alert("请点击《V来心声论坛管理规定》后进行注册！");
    return false;
}

var isUsed_1 = $("#isUsed_1").attr("checked");
var name = $("#name").val().trim();
if(isUsed_1!=true){
window.top.Dialog.alert("请阅读并接受《V来心声论坛管理规定》！"); 
return;
}
 
if(name==""){
window.top.Dialog.alert("请填写用户名!"); 
return;
}
if(name.length<2||name.length>10){
window.top.Dialog.alert("用户名在2-10位之间!"); 
return;
}
var patrn = /^[0-9]*$/;
if(patrn.test(name)) {
 window.top.Dialog.alert("不能为纯数字!"); 
return;
 }
   var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>《》/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
        if(pattern.test(name)){
            window.top.Dialog.alert("不能包含特殊字符!"); 
      return;
}

obj.disabled = true;	 
var url = '/cowork/nickname/CoworkNicknameOperation.jsp?method=checkname&name='+name;
         $.ajax({
            url: encodeURI(url),
            async : false,
            cache:false,
            success: function(result){
              // result = eval('('+result+')');
               if(result==2){
                 document.weaver.submit();
               }else if(result==1){
               obj.disabled = false;	
               window.top.Dialog.alert("该用户名已存在，请重新提交!"); 
				return;
               }else if(result==3){
                  obj.disabled = false;	
              $("#notice").text("您注册的昵称中包含不合法内容**，请您修改！");
				return;                
               }else{
                 obj.disabled = false;	
             $("#notice").text(""+result.trim());
				return; 
               }
             
            }
        })

  
}



 
</SCRIPT>
</BODY>
</HTML>
