
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="seahonor.util.GeneralNowInsert"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	int userid = user.getUID();
	GeneralNowInsert gni = new GeneralNowInsert();
	String multiIds =Util.null2String(request.getParameter("multiIds"));
	out.println("multiIds = " + multiIds);
	String resArr[] = multiIds.split(",");
	for(int index=0;index<resArr.length;index++){
		String id = resArr[index];
		
		// 更新状态为校对，版本更新为1
		String sql = "UPDATE  uf_Contacts set dealStatus=1,Version=1,ModifyTime=CONVERT(varchar(30),getdate(),21),modifier="+userid+" where id="+id;
		rs.executeSql(sql);
		
		// 存储目前版本
		gni.insertNow("-63", "uf_Contacts", "id", id);
	}
	
	response.sendRedirect("/seahonor/crm/NpForGroupContacts.jsp");
%>