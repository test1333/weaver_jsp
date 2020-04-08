﻿
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="hsproject.impl.AddDocShare" %>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
	<script type="text/javascript">	
				
		function onCheckup1(){
			if(window.confirm('你是否同步文档权限？')){
				document.report.multiIds.value = "1";
				document.report.submit();
			}
		}
				
		function onBtnSearchClick() {
			report.submit();
		}
					
	</script>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
boolean isShow = false;

int userid = user.getUID();

String multiIds = Util.null2String(request.getParameter("multiIds"));

%>

<BODY>

<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%

	RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{同步文档权限,javascript:onCheckup1(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=/hsproject/test/updatedocqx.jsp method=post>
		<input type="hidden" name="multiIds" value="-1">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>

			</tr>
		</table>
			<%
		if("1".equals(multiIds)){
				AddDocShare aa = new AddDocShare();
				String sql = "select id from hs_projectinfo";
				rs.executeSql(sql);
				while(rs.next()){
					String prjid=Util.null2String(rs.getString("id"));
					aa.addShareByPrj(prjid);
				}

			boolean isOver = true;
			if(isOver){
				out.println("<font size=\"5px\" color=\"red\">执行完成，同步成功!</font>");
			}else{
				out.println("<font size=\"5px\" color=\"red\">执行完成，同步失败，请联系管理员或者重新同步!</font>");
			}
		}
		
			
	%>

<wea:layout type="2col">
<wea:group context="同步文档权限" attributes="test">

<wea:item>&nbsp;&nbsp;</wea:item><wea:item>&nbsp;&nbsp;</wea:item><wea:item>&nbsp;&nbsp;</wea:item>
		<wea:item>
		<table width="30%">
			<tr>
				<td><input name="hi1" type="button" value="同步数据" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:100px;height:30px;font-size:15px;" onClick="onCheckup()"></td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!--<td><input name="hi" type="button" value="刷新" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:80px;height:30px;font-size:15px;" onClick="onBtnSearchClick1()"></td>-->
			</tr>
		</table>
			<script type="text/javascript">	
				
				function onCheckup(){
					if(window.confirm('你是否同步文档权限？')){
						document.report.multiIds.value = "1";
						document.report.submit();
				    }
				}
								
				function onBtnSearchClick1() {
					report.submit();
				}
					
			</script>
		
			 </wea:item>
		


</wea:group>
</wea:layout>	
			
	</FORM>

</BODY>
</HTML>
	

