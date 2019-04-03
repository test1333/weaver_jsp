<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>

<%
//if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
   // response.sendRedirect("/notice/noright.jsp");
    //return;
//}
String sql="";
String workflowid = Util.null2String(request.getParameter("workflowid")); 
//out.print("departmentid="+departmentid);
sql=" select * from uf_systemform where id in(select mainid from uf_systemform_dt1 where lcmc="+workflowid+") ";
//select mudi,fanwei,zhize,dingyi,zdmc,zdbh,neir from uf_systemform where id in(select mainid from uf_systemform_dt1 where lcmc=63)
%>

<%    
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(21590,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="">
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<%if(HrmUserVarify.checkUserRight("AnnualLeave:All", user)){ %>
				<input type=button class="e8_btn_top" onclick="onSave();" value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%>"></input>
				<input type=button class="e8_btn_top" onclick="BatchProcess();" value="<%=SystemEnv.getHtmlLabelName(21611,user.getLanguage())%>"></input>
			<%} %>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<wea:layout attributes="{'expandAllGroup':'true'}">
	<div id="TimeDate">
	<wea:group context="制度文件条文">
		<wea:item attributes="{'isTableList':'true'}">
			<wea:layout type="table" attributes="{'cols':'7','cws':'14%,14%,14%,14%,14%,14%,14%'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
			    <wea:item type="thead">制度文件名称</wea:item>
			    <wea:item type="thead">制度文件编号</wea:item>
			    <wea:item type="thead">目的</wea:item>
			    <wea:item type="thead">范围</wea:item>
			    <wea:item type="thead">职责</wea:item>
			    <wea:item type="thead">定义</wea:item>
			    <wea:item type="thead">内容</wea:item>
					<%
			    RecordSet.executeSql(sql);
			    while(RecordSet.next()){
					String billid = Util.null2String(RecordSet.getString("id"));
			        String mudi = Util.null2String(RecordSet.getString("mudi"));
			        String fanwei = Util.null2String(RecordSet.getString("fanwei"));
			        String zhize = Util.null2String(RecordSet.getString("zhize"));
					String dingyi = Util.null2String(RecordSet.getString("dingyi"));
					String zdmc = Util.null2String(RecordSet.getString("zdmc"));
					String zdbh = Util.null2String(RecordSet.getString("zdbh"));
					String neir = Util.null2String(RecordSet.getString("neir"));
			  %>
			     <wea:item><a href=javascript:this.openFullWindowForXtable('/formmode/view/AddFormMode.jsp?modeId=1562&formId=-439&billid=<%=billid%>')><%=zdmc%></a></wea:item>
			     <wea:item><%=zdbh%></wea:item>
			     <wea:item><%=mudi%></wea:item>
			     <wea:item><%=fanwei%></wea:item>
			     <wea:item><%=zhize%></wea:item>
			     <wea:item><%=dingyi%></wea:item>
			     <wea:item><%=neir%></wea:item>
			     
			  <%
			    }
			  %>
				</wea:group>
			</wea:layout>
		</wea:item>
	</wea:group>
	</div>
</wea:layout>
</form>
<script language=javascript>
function onSave(){
    frmmain.submit();
}

function firm(){

    if(confirm("是否确认同步？"))
    {
        sycal();
    }
    else
    {

    }
}

function BatchProcess(){
    document.frmmain.operation.value="batchprocess";
    frmmain.submit();
}

</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" src="/seahonor/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/seahonor/attend/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</HTML>
