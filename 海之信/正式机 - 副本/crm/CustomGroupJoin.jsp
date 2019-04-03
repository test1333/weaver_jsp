<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	int user_id = user.getUID();
%>
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

String customID = (String)session.getAttribute("customID");
String lookID = (String)session.getAttribute("lookID");
String lookGID = (String)session.getAttribute("lookGID");
String otherID = (String)session.getAttribute("otherID");

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

int isCon = 0;
sql = "select id from uf_holdingInfo where "+sqlWhere;
RecordSet.executeSql(sql);
if(RecordSet.next()){
	isCon = RecordSet.getInt("id");
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
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<%
					if(isCon > 0){%>
					      <input type="button" value="编辑" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="openLookInfo();"/> 						
					<%}else{%>
					      <input type="button" value="新增" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="openDyInfo();"/> 						
						
					<%}%>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>										
					</td>
				</tr>
		</table>

		
		
			
	</FORM>
	 
	
		<br/>
	<table width=80% cellspacing="1px" style="margin-left: 10%;margin-top: 1px;margin-right: 10%;border-collapse:collapse;"  border="1px" bordercolor="#DADADA" >
          <colgroup><col width="40%"/><col width="40%"/><col width="20%"/></colgroup>
			
			<tr ><td style="background:#87CEEB">控股公司</td><td style="background:#87CEEB">被控股公司</td><td style="background:#87CEEB">股权比例</td></tr>
			<%
			        String count="1";
			     	sql = "select count(1) as num from uf_holdingInfo_dt2 where mainid in(select id from uf_holdingInfo where "+sqlWhere+")";
					RecordSet.executeSql(sql);
					if(RecordSet.next()){
					count = Util.null2String(RecordSet.getString("num"));
					}
				sql = "select * from uf_holdingInfo_dt2 where mainid in(select id from uf_holdingInfo where "+sqlWhere+")";
				RecordSet.executeSql(sql);
				int a=0;
				while(RecordSet.next()){
                 
					String tmp_customName = Util.null2String(RecordSet.getString("custom"));
					String tmp_GroupScale= Util.null2String(RecordSet.getString("ratio"));
					if(a==0){
                      out.println("<tr><td rowspan="+count+">");out.println(mainName);
				    out.println("</td><td>");out.println(tmp_customName);
					out.println("</td><td>");out.println(tmp_GroupScale);
					out.println("%</td> </tr>");
					}else{
                      out.println("<tr><td>");out.println(tmp_customName);
					out.println("</td><td>");out.println(tmp_GroupScale);
					out.println("%</td> </tr>");
					}
					a++;
				}
			%>
			<tr></tr>
	    </table>
		<br/><br/>
		<table width=80% cellspacing="1px" style="margin-left: 10%;margin-top: 1px;margin-right: 10%;border-collapse:collapse;font-size: 9pt;"  border="1px" bordercolor="#DADADA">
          <colgroup><col width="40%"/><col width="40%"/><col width="20%"/></colgroup>				
			<tr ><td style="background:#87CEEB">被控股公司</td><td style="background:#87CEEB">控股公司</td><td style="background:#87CEEB">股权比例</td></tr>
			<%
			    String count1="1";
			    sql = "select count(1) as num from uf_holdingInfo_dt1 where mainid in(select id from uf_holdingInfo where "+sqlWhere+")";
				RecordSet.executeSql(sql);
				if(RecordSet.next()){
				   count1 = Util.null2String(RecordSet.getString("num"));
			    }  
			    
				sql = "select * from uf_holdingInfo_dt1 where mainid in(select id from uf_holdingInfo where "+sqlWhere+")";
				RecordSet.executeSql(sql);
				int b=0;
				while(RecordSet.next()){
					String tmp_customName = Util.null2String(RecordSet.getString("custom"));
					String tmp_GroupScale= Util.null2String(RecordSet.getString("ratio"));
					if(b == 0){
                      out.println("<tr><td>");out.println(tmp_customName);
						out.println("</td><td  rowspan="+count1+">");out.println(mainName);
					out.println("</td><td>");out.println(tmp_GroupScale);
					out.println("%</td> </tr>");
					}else{
                     out.println("<tr><td>");out.println(tmp_customName);
					out.println("</td><td>");out.println(tmp_GroupScale);
					out.println("%</td> </tr>");
					}
					b++;
				}
			%>
			<tr></tr>
	    </table>
<script type="text/javascript">
	function shuaxin(){
		location.reload();
	}
</script>
<script type="text/javascript">
var diag_vote;
	function openNewInfo(id) {
	//	openFullWindowForXtable("/formmode/view/AddFormMode.jsp?modeId=14&formId=-18&type=0&field5979="+id);
		
		var title = "";
		var url = "/formmode/view/AddFormMode.jsp?modeId=58&formId=-65&type=1&field6748="+id;
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 700;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show("");	
		
	}
	function openDyInfo() {
	//	openFullWindowForXtable("/formmode/view/AddFormMode.jsp?modeId=58&formId=-65&type=1&field6747="+id);
		
		var title = "";
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=groupnew,<%=lookID%>";
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 700;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show("");	
	}
	
		function openLookInfo() {
	//	openFullWindowForXtable("/formmode/view/AddFormMode.jsp?modeId=14&formId=-18&type=1&field5978="+id);
		
		var title = "";
		
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=groupedit,<%=isCon%>";
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 700;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.isIframe=false;
		diag_vote.URL = url;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show("");	
	}
	
</script>
</BODY>
</HTML>
