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
				<td ></td>
				<td valign="top">
					<TABLE class=Shadow>
						<tr>
							<td valign="top">
								<FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
									<input type="hidden" name="multiRequestIds" value="">
									<input type="hidden" name="operation" value="">
									<TABLE width="100%"  class=ListStyle style="font-size: 8pt">
										<colgroup>
										<col width="40%"></col>
										<col width="30%"></col>
										<col width="30%"></col>
										</colgroup>
										<tbody>
											<tr class=Header>
												<td>�γ�����</td>
												<td>��ʦ����</td>
												<td>�μ�����</td>
											</tr>
											<%
											String sql =
											" select f.id,f.kcmc,h.lastname as js_name from formtable_main_193 f "
											+" left join formtable_main_192 fm on f.jsmc = fm.id "
											+" left join hrmresource h on fm.jsmc = h.id order by f.pxrq desc ";
											rs.executeSql(sql);
											//out.println("sql___________"+sql);
											new BaseBean().writeLog("sql___________"+sql);
											int num = 0;
											while(rs.next()){
											String kcmc = Util.null2String(rs.getString("kcmc"));
											String js_name = Util.null2String(rs.getString("js_name"));
											String kj_id = Util.null2String(rs.getString("id"));
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
														<Td><%=kcmc%></Td>
														<Td><%=js_name%></Td>
														<Td><a href="/formmode/view/AddFormMode.jsp?type=3&modeId=542&formId=-193&billid=<%=kj_id%>&opentype=0&customid=522&viewfrom=fromsearchlist" target="_blank" style="text-decoration:underline !important">������</a></Td>
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
			</BODY>
		</HTML>