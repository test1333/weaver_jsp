<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
	
<html>
<head>
<script type="text/javascript" src="/js/weaver.js"></script>
<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>


<BODY>
	<!--
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">

<tr>
	
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">

<FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
	<input type="hidden" name="multiRequestIds" value="">
	<input type="hidden" name="operation" value="">
 -->
<TABLE width="100%" class=ListStyle>
	<colgroup>
<col width="40%"></col>
<col width="20%"></col>
<col width="20%"></col>	
<col ></col>
	</colgroup>
<tr class=Header>
	<td>图书名称</td>
		<td>作者</td>
			<td>借阅次数</td>
				<td>当前状态</td>
</tr>

<%
	String sql = "select * from ( "+
	 "select x.tsmc as tsmcid,fm.tsmc,x.num_cc,fm.zz,decode(fm.tszt,0,'空闲',1,'申请中',2,'借出','无记录')as bookzt from ( "+
     "select tsmc,count(*) as num_cc from formtable_main_94 where requestid  in( "+
     "select requestid from workflow_requestbase where currentnodetype=3) and trim(tsmc) is not null " +
     "group by tsmc order by num_cc desc) x "+
     "join formtable_main_91 fm on(x.tsmc=fm.id)) t ";
	rs.executeSql(sql);
	new BaseBean().writeLog("sql___________"+sql);
	int num = 0;
	while(rs.next()){
		num++;
		if(num == 0){
			num = 1;
			%>
			<tr class=datalight>
			<%
		}else{
			num = 0;
			%>
			<tr class=datalight>
			<%
		}
		%>
		<Td><a href="/formmode/view/AddFormMode.jsp?type=0&modeId=142&formId=-91&billid=<%=rs.getString("tsmcid")%>&opentype=0&customid=123&viewfrom=fromsearchlist" target=_blank><%=rs.getString("tsmc") 
		
		%></a></Td>
		<Td><%=rs.getString("zz") %></Td>
		<Td><%=rs.getString("num_cc") %></Td>
		<Td><%=rs.getString("bookzt") %></Td>
		</Tr>
		<%
	}
%>

</TABLE>
	<!--
</FORM>
		</td>
		</tr>
		</TABLE>
	</td>
	
</tr>


</table>
-->
	<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>
