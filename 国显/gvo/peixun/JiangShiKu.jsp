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
									<TABLE width="100%" class="ListStyle_xg" style="font-size: 8pt">
										<colgroup><col width="50%"></col><col width="25%"></col><col width="25%"></col></colgroup>
										<tbody>
											<tr class=Header>
												<td height="30px"><span style="font-size: 13px;">所属事业部</span></td>
												<td><span style="font-size: 13px;">讲师名称</span></td>
												<td><span style="font-size: 13px;">讲师介绍</span></td>
											</tr>
											<%
											String sql = " select (select subcompanyname from hrmsubcompany where id = sssyb)as syb_name,(select lastname from hrmresource where id = jsmc) as js_name,id as js_id from formtable_main_192 where rownum <=6 ";
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
														<Td height="18px"><span style="font-size: 12px;"><%=syb_name%></span></Td>
														<Td><span style="font-size: 12px;"><%=js_name%></span></Td>
														<Td><a href="/formmode/view/AddFormMode.jsp?type=0&modeId=541&formId=-192&billid=<%=js_id%>&opentype=0&customid=521&viewfrom=fromsearchlist" target="_blank" style="text-decoration:underline !important"><span style="font-size: 12px;">详情点击</span></a></Td>
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