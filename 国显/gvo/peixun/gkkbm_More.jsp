<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
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
										<colgroup>
										<col width="20%"></col>
										<col width="20%"></col>
										<col width="30%"></col>
										<col width="15%"></col>
										<col width="15%"></col>
										</colgroup>
										<tbody>
											<tr class=Header>
												<td>培训组织方</td>
												<td>日期</td>
												<td>课程名称</td>
												<td>讲师名称</td>
												<td>报名按钮</td>
											</tr>
											<%
											//String kc_id=Util.fromScreen(request.getParameter("id"),user.getLanguage());
											String sql =
											" select (select subcompanyname from hrmsubcompany where id = f.pxzzf)as zzf_name,f.pxrq,f.id as kc_id,f.kcmc,h.lastname as js_name from    formtable_main_193 f "
											+" left join formtable_main_192 fm on f.jsmc = fm.id "
											+" left join hrmresource h on fm.jsmc = h.id order by f.pxrq desc ";
											rs.executeSql(sql);
											new BaseBean().writeLog("sql___________"+sql);
											int num = 0;
											while(rs.next()){
											String zzf_name = Util.null2String(rs.getString("zzf_name"));
											String pxrq = Util.null2String(rs.getString("pxrq"));
											String kcmc = Util.null2String(rs.getString("kcmc"));
											String js_name = Util.null2String(rs.getString("js_name"));
											String kc_id = Util.null2String(rs.getString("kc_id"));
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
														<Td><%=zzf_name%></Td>
														<Td><%=pxrq%></Td>
														<Td><%=kcmc%></Td>
														<Td><%=js_name%></Td>
														<Td><a href="/workflow/request/AddRequest.jsp?workflowid=1021&field11565=<%=kc_id%>" target="_blank" style="text-decoration:underline !important">我要报名</a></Td>
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