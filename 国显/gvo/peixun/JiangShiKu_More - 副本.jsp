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
			<tr>
				<td valign="top">
					<TABLE class=Shadow>
						<tr>
							<td valign="top">
								<FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
									<input type="hidden" name="multiRequestIds" value="">
									<input type="hidden" name="operation" value="">
									<TABLE width="100%" class=ListStyle style="font-size: 8pt">
										<colgroup><col width="40%"></col><col width="30%"></col><col width="30%"></col></colgroup>
										<tbody>
											<tr class=Header>
												<td>所属事业部</td>
												<td>讲师名称</td>
												<td>授课经历</td>
											</tr>
											<%
											//String id=Util.fromScreen(request.getParameter("id"),user.getLanguage());
											String sql = " select (select subcompanyname from hrmsubcompany where id = sssyb)as syb_name,(select lastname from hrmresource where id = jsmc) as js_name,id as js_id from formtable_main_192 ";
											rs.executeSql(sql);
											new BaseBean().writeLog("sql___________"+sql);
											int num = 0;
											while(rs.next()){
											String syb_name = Util.null2String(rs.getString("syb_name"));
											String js_name = Util.null2String(rs.getString("js_name"));
											String js_id = Util.null2String(rs.getString("js_id"));
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
													<tr>
														<Td><%=syb_name%></Td>
														<Td><%=js_name%></Td>
														<Td><a href="/formmode/view/AddFormMode.jsp?type=0&modeId=541&formId=-192&billid=<%=js_id%>&opentype=0&customid=521&viewfrom=fromsearchlist" target="_blank" style="text-decoration:underline !important">详情点击</a></Td>
													</Tr>
													<%
													}
													%>
												</tbody>
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