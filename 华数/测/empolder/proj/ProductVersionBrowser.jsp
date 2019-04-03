<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="tools" class="tool.tools" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Browser.css>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<%

String name =  Util.null2String(request.getParameter("name"));

String sqlwhere = "";
String sql = "";

if(!"".equals(name)){
		sqlwhere += " and t1.name like '%"+name+"%'";
}


%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="10" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
<FORM NAME=SearchForm STYLE="margin-bottom:0" action="" method=post>
<DIV align=right style="display:none">

<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.SearchForm.submit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btnSearch accessKey=S type=submit><U>S</U>-<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:document.SearchForm.reset(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btnReset accessKey=T type=reset><U>T</U>-<%=SystemEnv.getHtmlLabelName(199,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.close(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btn accessKey=1 onclick="window.parent.close()"><U>1</U>-<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:submitClear(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>	
<BUTTON class=btn accessKey=2 id=btnclear><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
</DIV>

		<table width=100% class=ViewForm>
<TR class=Spacing style="height: 1px"><TD class=Line1 colspan=4></TD></TR>
<TR>
<TD width=15%>名称</TD>
<TD width=35% class=field colspan="3"><input class=inputstyle name=name value="<%=name%>"></TD>

<TR style="height: 1px"><TD class=Line colSpan=6></TD></TR> 
</table>

<TABLE ID=BrowseTable class="BroswerStyle"  cellspacing="1" STYLE="margin-top:0" width="100%">
<TR class=DataHeader>
<TH style="display: none;"></TH>
<TH width=35%>名称</TH>
<TH width=35%>描述</TH>
<TH width=35%>描述</TH>
<TH style="display: none;">上线时间</TH>
<TH style="display: none;">参与人员ID</TH>
<TH style="display: none;">参与人员名称</TH>
<!-- <TH style="display: none;">项目经理ID</TH> -->
<!-- <TH style="display: none;">项目经理名称</TH> -->
<!-- <TH style="display: none;">产品经理ID</TH> -->
<!-- <TH style="display: none;">产品经理名称</TH> -->
</tr><TR class=Line style="height: 1px"><TH colspan="4" ></TH></TR>
<%
int i=0;
sql = "select t1.*,t2.name as cname,t1.productmanager,t1.projectmanager,t1.timeLine,t1.members from projectInfo t1 left join serviceLine t2 on t1.forline = t2.id"+
      " where t1.isShow = '0' and t1.forline in (select id from serviceLine where personnel_1 like '%,"+user.getUID()+",%' or personnel_1 like '%,"+user.getUID()+"' or personnel_1 like '%"+user.getUID()+",%' or personnel_1 = '"+user.getUID()+"')"+sqlwhere+" order by t1.timeLine,t1.id";
RecordSet.execute(sql);
while(RecordSet.next()){
	if(i==0){
		i=1;
%>
<TR class=DataLight>
<%
	}else{
		i=0;
%>
<TR class=DataDark>
	<%
	}
	%>
	<TD style="display: none;"><%=RecordSet.getString("id")%></TD>
	<TD><%=tools.getProductLineName(RecordSet.getString("name"))%></TD>
	<TD><%=RecordSet.getString("version")%></TD>
	<TD><%=RecordSet.getString("cname")%></TD>
	<TD style="display: none;"><%=RecordSet.getString("timeLine")%></TD>
	<TD style="display: none;"><%=RecordSet.getString("members")%></TD>
	<TD style="display: none;"><%=ResourceComInfo.getMulResourcename1(RecordSet.getString("members"))%></TD>
<%-- 	<TD style="display: none;"><%=RecordSet.getString("productmanager")%></TD> --%>
<%-- 	<TD style="display: none;"><%=ResourceComInfo.getResourcename(RecordSet.getString("productmanager"))%></TD> --%>
<%-- 	<TD style="display: none;"><%=RecordSet.getString("projectmanager")%></TD> --%>
<%-- 	<TD style="display: none;"><%=ResourceComInfo.getResourcename(RecordSet.getString("projectmanager"))%></TD> --%>
	
</TR>
<%}%>
</TABLE></FORM>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<script src="/js/jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript">

jQuery(document).ready(function(){
	//alert(jQuery("#BrowseTable").find("tr").length)
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("click",function(){
			
// 		window.parent.returnValue = {id:jQuery(this).find("td:first").text(),name:jQuery(this).find("td:first").next().text()+'('+jQuery(this).find("td:first").next().next().next().text()+')',productID:jQuery(this).find("td:first").next().next().next().next().text(),productName:jQuery(this).find("td:first").next().next().next().next().next().text(),projectID:jQuery(this).find("td:first").next().next().next().next().next().next().text(),projectName:jQuery(this).find("td:first").next().next().next().next().next().next().next().text()};
		window.parent.returnValue = {id:jQuery(this).find("td:first").text(),name:jQuery(this).find("td:first").next().text()+'('+jQuery(this).find("td:first").next().next().next().text()+')',timeLine:jQuery(this).find("td:first").next().next().next().next().text(),membersID:jQuery(this).find("td:first").next().next().next().next().next().text(),membersName:jQuery(this).find("td:first").next().next().next().next().next().next().text()};
			window.parent.close()
		})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseover",function(){
			jQuery(this).addClass("Selected")
		})
		jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseout",function(){
			jQuery(this).removeClass("Selected")
		})

})


function submitClear()
{
// 	window.parent.returnValue = {id:"0",name:"",productID:"",productName:"",projectID:"",projectName:""};
	window.parent.returnValue = {id:"0",name:"",productID:"",timeLine:""};
	window.parent.close()
}

</script>
</BODY></HTML>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>

