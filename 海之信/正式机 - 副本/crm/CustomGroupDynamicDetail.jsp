
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
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

<style>
.checkbox {
	display: none
}
</style>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";

String customID = Util.null2String(request.getParameter("customID"));

String buff = "";
String sql = "select Content from uf_custom_dynamic where id= " + customID;
RecordSet.executeSql(sql);
if(RecordSet.next()){
	buff = Util.null2String(RecordSet.getString("Content"));
}

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
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>

			</tr>
		</table>
<wea:layout type="2col">
<wea:group context="提醒信息" attributes="test">
<wea:item attributes="{'colspan':'full'}">
<font color="#FF0000">信息提醒</font>
</wea:item>	

	<wea:item>开始提醒时间</wea:item>
	<wea:item> </wea:item>

	<wea:item>结束提醒时间</wea:item>
	<wea:item> </wea:item>	
		
	<wea:item>提醒时间段</wea:item>
	<wea:item> </wea:item>	
		
	<wea:item>提醒频率</wea:item>
	<wea:item> </wea:item>	
	
	<wea:item>其他提醒人员</wea:item>
	<wea:item> </wea:item>	
		
	<wea:item>提醒内容</wea:item>
	<wea:item> <textarea clos="20"rows="5" ><%=buff%></textarea></wea:item>				
    </wea:group>					
	</FORM>

</BODY>
</HTML>
