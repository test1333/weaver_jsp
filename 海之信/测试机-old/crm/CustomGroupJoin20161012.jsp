
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
<script type="text/javascript">
	function openNewInfo(id) {
	//	openFullWindowForXtable("/formmode/view/AddFormMode.jsp?modeId=14&formId=-18&type=0&field5979="+id);
		
		var title = "";
		var url = "/formmode/view/AddFormMode.jsp?modeId=58&formId=-65&type=1&field6748="+id;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 800;		
		diag_vote.Height = 700;
		diag_vote.Modal = true;		
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
		
	}
	function openDyInfo(id) {
	//	openFullWindowForXtable("/formmode/view/AddFormMode.jsp?modeId=58&formId=-65&type=1&field6747="+id);
		
		var title = "";
		var url = "/formmode/view/AddFormMode.jsp?modeId=58&formId=-65&type=1&field6747="+id;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 800;		
		diag_vote.Height = 700;
		diag_vote.Modal = true;		
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
	}
	
		function openLookInfo(id) {
	//	openFullWindowForXtable("/formmode/view/AddFormMode.jsp?modeId=14&formId=-18&type=1&field5978="+id);
		
		var title = "";
		var url = "/formmode/view/AddFormMode.jsp?type=0&modeId=58&formId=-65&opentype=0&customid=38&viewfrom=fromsearchlist&billid="+id;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 800;		
		diag_vote.Height = 700;
		diag_vote.Modal = true;		
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
	}
	
</script>
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
String lookID = Util.null2String(request.getParameter("lookID"));
String lookGID = Util.null2String(request.getParameter("lookGID"));
String otherID = Util.null2String(request.getParameter("otherID"));

String sqlWhere = "";
boolean isGroup = false;
if("".equals(lookGID)){
	if("".equals(lookID)){
		lookID = customID;
	}
	sqlWhere = " (CustomName1 is null or CustomName1='') and  CustomName="+lookID;
}else{
	sqlWhere = " (CustomName1 is null or CustomName1='') and GroupName="+lookGID;
	isGroup = true;
}


String mainName = "";
int flag = 1;
String superID = "";
String superName = "";
String sql = "select uc.customName,ug.GroupName,ug.id from uf_custom uc left join uf_custom_group ug on ug.id=uc.CustomGroup  where uc.id = " + customID;
RecordSet.executeSql(sql);
if(RecordSet.next()){
	mainName = Util.null2String(RecordSet.getString("customName"));
	superID = Util.null2String(RecordSet.getString("id"));
	superName = Util.null2String(RecordSet.getString("GroupName"));
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
RCMenu += "{刷新,javascript:shuaxin(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>

			</tr>
		</table>
<wea:layout type="2col">
<wea:group context="集团关系" attributes="test">


	<wea:item>
		<table>	
			<tr>
			<%
				if(!"".equals(lookGID)&&"".equals(otherID)){
					out.println("<td style=\"background:yellow\">");
				}else{
					out.println("<td>");
				}
			%>
			<a href="CustomGroupJoin.jsp?lookGID=<%=superID%>&customID=<%=customID%>">
			<font color="red" size="4px">&nbsp;&nbsp;&nbsp;
			<%=superName%></font></a> </font> 
			<%
				if(!"".equals(lookGID)){
					out.println("<font color=\"red\"><b>&#8730;</b></font>");
				}
			%>	
				
			</td></tr>
				
			<tr>
			<%
				if(lookID.equals(customID)){
					out.println("<td style=\"background:yellow\">");
				}else{
					out.println("<td>");
				}
			%>
			<font  size="6px">&bull;</font><font  size="4px">&nbsp;
			<a href="CustomGroupJoin.jsp?customID=<%=customID%>"><%=mainName%> </a></font>
			<%
				if(lookID.equals(customID)){
					out.println("<font color=\"red\"><b>&#8730;</b></font>");
				}
			%>	
			</td></tr>
	<%
		if(!"".equals(superID)){
			sql = "select id,customName from uf_custom where superid is null and CustomGroup="+superID+" and id!="+customID;
		//	out.println("sql = " + sql);
			RecordSet.executeSql(sql);
			while(RecordSet.next()){
				flag++;
				String customName = Util.null2String(RecordSet.getString("customName"));
				String tmp_customID = Util.null2String(RecordSet.getString("id"));
				if(lookID.equals(tmp_customID)){
					out.println("<tr><td style=\"background:yellow\">");
				}else{
					out.println("<tr><td>");
				}
				out.println("<font  size=\"4px\">&nbsp;&nbsp;&nbsp;<a href=\"CustomGroupJoin.jsp?lookID="+tmp_customID+"&customID="+customID+"\">");
				out.println(customName);
				out.println("</a></font>");
				if(lookID.equals(tmp_customID)){
					out.println("<font color=\"red\"><b>&#8730;</b></font>");
				}
				out.println("</td></tr>");
			}
		}
	%>
		<tr></tr><tr></tr><tr></tr><tr></tr>
		</table>
		
    </wea:item>
	<wea:item> 
		<%
			int isCon = 0;
			sql = "select id from uf_holdingInfo where "+sqlWhere;
			RecordSet.executeSql(sql);
			if(RecordSet.next()){
				isCon = RecordSet.getInt("id");
			}
		%>
		<table width=80% cellspacing="1">
			<colgroup><col width="30%"/><col width="70%"/></colgroup>
			<tr><td colspan=2 style="background:#87CEEB"><font size=4px >被控股关系</font>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<%
					if(isCon > 0){
					//	out.println("<a href=\"/formmode/view/AddFormModeIframe.jsp?modeId=14&formId=-18&type=0&billid=");
					//	out.println(isCon+"&customid=15&opentype=0&viewfrom=fromsearchlist\" target=\"_blank\">");
						out.println("<a href=\"javascript:openLookInfo("+isCon+")\";>");
						out.println("查看信息</a>");
					}else{
						if(isGroup){
						//	out.println("<a href=\"/formmode/view/AddFormMode.jsp?modeId=14&formId=-18&type=0&field5979="+lookGID+"\" target=\"_blank\">");
							out.println("<a href=\"javascript:openNewInfo("+lookGID+")\";>");
						}else{
						//	out.println("<a href=\"/formmode/view/AddFormMode.jsp?modeId=14&formId=-18&type=1&field5978="+lookID+"\" target=\"_blank\">");
							out.println("<a href=\"javascript:openDyInfo("+lookID+")\";>");
						}
						out.println("新增控股信息</a>");
					}
				%>
			</td></tr>
			<%
				sql = "select * from uf_holdingInfo_dt1 where mainid in(select id from uf_holdingInfo where "+sqlWhere+")";
				RecordSet.executeSql(sql);
				while(RecordSet.next()){
					String tmp_customName = Util.null2String(RecordSet.getString("custom"));
					String tmp_GroupScale= Util.null2String(RecordSet.getString("ratio"));
					out.println("<tr><td><font size=3px>");out.println(tmp_customName);
					out.println("</font></td><td><font size=3px>");out.println(tmp_GroupScale);
					out.println("%</font></td> </tr>");
				}
			%>
			<tr></tr>
		</table>
		<table width=80% cellspacing="1">
			<colgroup><col width="30%"/><col width="70%"/></colgroup>
			<tr><td colspan=2 style="background:#87CEEB"><font size=4px>控股关系</font></td></tr>
			<%
				sql = "select * from uf_holdingInfo_dt2 where mainid in(select id from uf_holdingInfo where "+sqlWhere+")";
				RecordSet.executeSql(sql);
				while(RecordSet.next()){
					String tmp_customName = Util.null2String(RecordSet.getString("custom"));
					String tmp_GroupScale= Util.null2String(RecordSet.getString("ratio"));
					out.println("<tr><td><font size=3px>");out.println(tmp_customName);
					out.println("</font></td><td><font size=3px>");out.println(tmp_GroupScale);
					out.println("%</font></td> </tr>");
				}
			%>
			<tr></tr>
		</table>
		<table width=80% cellspacing="1">
			<% 
				flag = flag - 3;
				for(int index=0;index<flag;index++){%>	
					<tr><Td>&nbsp;</td><td>&nbsp;</td></tr><%}%>
		</table>
	</wea:item>	
	
	<%
		if(!"".equals(superID)){	
	%>
	<wea:item>

		<input type=button class="e8_btn_top" onclick="openNewInfo(<%=superID%>);" value="添加非系统关联客户"></input>
		
	</wea:item><wea:item></wea:item>
		
	<wea:item>
		<table>
		<%
			if("".equals(otherID)) otherID="-1";
			sql = "select id,customName1  from uf_holdingInfo where groupName='"+superID+"'";
			RecordSet.executeSql(sql);			
			while(RecordSet.next()){
			   String tmp_id = Util.null2String(RecordSet.getString("id"));
		           String tmp_customName1= Util.null2String(RecordSet.getString("customName1"));
			   if(otherID.equals(tmp_id)){		
				out.println("<tr><td style=\"background:yellow\">");
			   }else{
				out.println("<tr><td>");
			   }
				out.println("<font  size=\"4px\">&nbsp;&nbsp;&nbsp;"
					+"<a href=\"CustomGroupJoin.jsp?lookGID="+superID+"&otherID="+tmp_id+"&customID="+customID+"\">");
				out.println(tmp_customName1);
				out.println("</a></font></tr>");
			}
		%>
		</table>
	</wea:item>
	<wea:item>
		<table width=80% cellspacing="1">
			<colgroup><col width="30%"/><col width="70%"/></colgroup>
			<tr><td colspan=2 style="background:#87CEEB"><font size=4px>被控股关系&nbsp;&nbsp;&nbsp;&nbsp; 
				<%out.println("<a href=\"javascript:openLookInfo("+otherID+")\";>");%></font></td></tr>
			<%
				sql = "select * from uf_holdingInfo_dt1 where mainid in(select id from uf_holdingInfo where id="+otherID+")";
				RecordSet.executeSql(sql);
				while(RecordSet.next()){
					String tmp_customName = Util.null2String(RecordSet.getString("custom"));
					String tmp_GroupScale= Util.null2String(RecordSet.getString("ratio"));
					out.println("<tr><td><font size=3px>");out.println(tmp_customName);
					out.println("</font></td><td><font size=3px>");out.println(tmp_GroupScale);
					out.println("%</font></td> </tr>");
				}
			%>
			<tr></tr>
		</table>
		<table width=80% cellspacing="1">
			<colgroup><col width="30%"/><col width="70%"/></colgroup>
			<tr><td colspan=2 style="background:#87CEEB"><font size=4px>控股关系</font></td></tr>
			<%
				sql = "select * from uf_holdingInfo_dt2 where mainid in(select id from uf_holdingInfo where id="+otherID+")";
				RecordSet.executeSql(sql);
				while(RecordSet.next()){
					String tmp_customName = Util.null2String(RecordSet.getString("custom"));
					String tmp_GroupScale= Util.null2String(RecordSet.getString("ratio"));
					out.println("<tr><td><font size=3px>");out.println(tmp_customName);
					out.println("</font></td><td><font size=3px>");out.println(tmp_GroupScale);
					out.println("%</font></td> </tr>");
				}
			%>
			<tr></tr>
		</table>
	</wea:item>	
	
	
	<%}%>			
	</FORM>
<script type="text/javascript">
	function shuaxin(){
		location.reload();
	}
</script>
</BODY>
</HTML>
