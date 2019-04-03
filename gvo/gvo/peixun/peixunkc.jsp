<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<html>
	<head>
		<script type="text/javascript" src="/js/weaver.js"></script>
		<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
	</head>
	<BODY>
		<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
			<colgroup>
			<col width="10">
			<col width="">
			<col width="10">
			<tr>
			</tr>
			<tr>
				<td ></td>
				<td valign="top">
					<TABLE class=Shadow>
						<tr>
							<td valign="top">
								<FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
									<input type="hidden" name="multiRequestIds" value="">
									<input type="hidden" name="operation" value="">
									<TABLE width="100%">
										<tr>
											<%
											String id=Util.fromScreen(request.getParameter("jsmc"),user.getLanguage());
											String sql = " select id,jsmc,kcmc,pxrq,ks from formtable_main_193 where jsmc = " +id + " order by pxrq desc ";
											rs.executeSql(sql);
											new BaseBean().writeLog("sql___________"+sql);
											int num = 0;
											while(rs.next()){
												String courseid = Util.null2String(rs.getString("id"));
												String kcmc = Util.null2String(rs.getString("kcmc"));
												String pxrq = Util.null2String(rs.getString("pxrq"));
											// String ks = Util.null2String(rs.getString("ks"));
											num++;
											%>
											<Td width="25%"><a href="/formmode/view/AddFormMode.jsp?type=0&modeId=542&formId=-193&billid=<%=courseid%>&opentype=0&customid=683&viewfrom=fromsearchlist" target=_blank><%=kcmc%></a>   <font size="1px">(<%=pxrq%>)</font></Td>
											<%if(num%4==0){%>
										</tr><tr>
										<%}%>
										<%
										}
										%>
									</tr>
								</TABLE>
							</FORM>
						</td>
					</tr>
				</TABLE>
			</td>
		</tr>
	</table>
	<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>