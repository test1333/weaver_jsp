<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: 100%;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 35px;
		}
		</style>
		<%
		 
		
	
		 boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
		 String isrsut =Util.null2String(request.getParameter("isrsut"));
		 
		  
		  
		%>
	</head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
  <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
  <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
	<BODY >
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="requestid" value="">
			<table  cellpadding="0" cellspacing="0">
				<tr>
					
				</tr>
			</table>
			
		
			
		</FORM>
		<%
		 
		String backfields = "";
														
		String fromSql  = " ";
		String sqlWhere = "";
		String orderby = " ";
		String tableString = "";
	
		%>
		
	<table class="ViewForm1  outertable" >
    <tbody>
        <tr>			
            <td><br />
			
			<div align="right"> 
				
			<input type="button" value="保存" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="onBtnSaveClick();"/>
				
			<span >&nbsp;&nbsp;&nbsp;&nbsp;</span>				 
			</div>
            <div align="center"><font class="reqname">建议</font></div>
            <title></title>
			<FORM id=report1 name=report1 action="/shukun/addOpinion.jsp" method=post>
            <table class="ViewForm1  maintable">
				<input type="text" value="1" id="flag" name="flag" hidden="true">
                <colgroup>  <col width="100px"></col><col width="175px"></col> <col width="400px"></col><col width="100px"></col> </colgroup>
                <tbody>
                    <tr>
						
			
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;建议概要</td>
                        <td class="fvalue">&nbsp;&nbsp;<input  id="yjgy" type="text" value="" name="yjgy" <textarea id="yjnr" name="yjnr" style="width: 390px; "/><img src="/images/BacoError_wev8.gif" align="absmiddle"></td>                                                
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;建议说明</td>
                         <td class="fvalue">&nbsp;&nbsp;<textarea id="yjnr" name="yjnr" style="width: 390px; height: 100px"></textarea><img src="/images/BacoError_wev8.gif" align="absmiddle"></td>                                                        
	                    <td>&nbsp;</td>		
                 </tr>
				
                </tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
</FORM>
	<script type="text/javascript">

		jQuery(document).ready(function () {
		var isrsut="<%=isrsut%>";
			if(isrsut == "1"){
				alert("提交成功");
			}
		})
		var parentWin;
		try{
		parentWin = parent.getParentWindow(window);
		}catch(e){}
		function onBtnSearchClick() {
			report.submit();
		}
        	var parentWin="";
		function refersh() {
  			window.location.reload();
  		}
		  function onBtnSaveClick() {	
			var yjgy_val = jQuery(yjgy).val();
			var yjnr_val = jQuery(yjnr).val();
			if(yjgy_val == "" || yjnr_val == ""){
				alert("建议概要和建议说明必填");
				return;
			}
			$('#report1').submit();	
		}
	   

	</script>
</BODY>
</HTML>