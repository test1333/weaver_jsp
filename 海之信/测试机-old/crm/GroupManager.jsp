
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
String sonCustom = Util.null2String(request.getParameter("sonCustom"));
String uqID = "";

if("".equals(sonCustom)) sonCustom = "-1";
 
String groupName = "";
String sql = "select GroupName from uf_custom_group where id= " + customID;
RecordSet.executeSql(sql);
if(RecordSet.next()){
	groupName = Util.null2String(RecordSet.getString("groupName"));
}


HashMap<String,String> map = new HashMap<String,String>();
sql = "select id,customName from uf_custom where id in(select customName from uf_customJoinGroup where GroupName="+customID+")";
RecordSet.executeSql(sql);
while(RecordSet.next()){  
	String tmp_id1 = Util.null2String(RecordSet.getString("id"));
	String tmp_name1 = Util.null2String(RecordSet.getString("customName"));
	map.put(tmp_id1,tmp_name1);
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
	<FORM id=report name=report action=GroupManager.jsp method=post>
		<input class=inputstyle type="hidden" name="customID" value="<%=customID%>">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr >
					&nbsp;<br/>
				  	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;
	选择下级公司  
				<select name="sonCustom">
					<option value ="-1"></option>
					<%
						Iterator<String> it = map.keySet().iterator();
						while(it.hasNext()){
							String tmp_id_x = it.next();
							String tmp_name_x = map.get(tmp_id_x);
	
					%>
				  	<option value ="<%=tmp_id_x%>" <%if(tmp_id_x.equals(sonCustom)){%>selected<%}%>><%=tmp_name_x%></option>
				  	<%}%>
				</select>
			</tr>
		</table>
<wea:layout type="2col">
<wea:group context="管理集团关系" attributes="test">
<wea:item attributes="{'colspan':'full'}">
<font color="#FF0000">集团公司<%=groupName%></font>
</wea:item>	
&deg;
	<wea:item>所属控股公司</wea:item> <wea:item>控股比例</wea:item>
	<%
		String groupScale = "";
		sql = "select id,GroupScale from uf_customJoinGroup where customName="+sonCustom;
		RecordSet.executeSql(sql);
		if(RecordSet.next()){  
			groupScale = Util.null2String(RecordSet.getString("GroupScale"));
		}
	%>
	<wea:item>&radic;&nbsp;&nbsp;<%=groupName%></wea:item> <wea:item>
		<input type="text" name="fname" value="<%=groupScale%>"style="width:60px;"/>%</wea:item>
	<%
		Iterator<String> it1 = map.keySet().iterator();
		while(it1.hasNext()){
			String tmp_id_x = it1.next();
			String tmp_name_x = map.get(tmp_id_x);
			sql = "select id,100-GroupScale as GroupScale1 from uf_customJoinGroup where customName="+tmp_id_x;
			RecordSet.executeSql(sql);
			String tmp_id_2 = "";
			String tmp_scale_2 = "";
			if(RecordSet.next()){  
				tmp_id_2 = Util.null2String(RecordSet.getString("id"));
				tmp_scale_2 = Util.null2String(RecordSet.getString("GroupScale1"));
			}
	%>
	
		<%if(tmp_id_2.equals(sonCustom)){ 
			uqID = tmp_id_2;
			%> 
			<wea:item>&radic;&nbsp;&nbsp; <%=tmp_name_x%></wea:item> 
			<wea:item> <input type="text" name="fnamex" value="<%=tmp_scale_2%>"/>%</wea:item>
		<%}else{%>
			<wea:item><%=tmp_name_x%></wea:item> <wea:item>&nbsp;</wea:item>
		<%}%>
	<%}%>
		<input class=inputstyle type="hidden" name="uqID" value="<%=uqID%>">
	</FORM>

</BODY>
	<script type='text/javascript'>
		function onBtnSearchClick() {
			report.submit();
		}
	</script>
</HTML>
