<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@page import="weaver.hrm.User"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="seahonor.util.InsertUtil"%>
<%@page import="weaver.formmode.setup.ModeRightInfo"%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%
User user = HrmUserVarify.getUser (request , response) ;
int userid = user.getUID();
String sql = "";
InsertUtil iu = new InsertUtil();
String operation = Util.null2String(request.getParameter("operation"));
String remindID = Util.null2String(request.getParameter("remindID"));

if(operation.equals("colsex")) {
	
	String uqid = "";
	sql = "select NEWID() AS UQID";
	RecordSet.executeSql(sql);		
	if(RecordSet.next()){
		uqid = RecordSet.getString("UQID");
	}
	
	Map<String,String> mapStr = new HashMap<String,String>();
	mapStr.put("remindID",remindID);
	mapStr.put("coloseFlag","0");
	//mapStr.put("formmodeid","23");
	mapStr.put("remindEmp",""+userid);
	mapStr.put("creater",""+userid);
	mapStr.put("created_time","##CONVERT(varchar(100),GETDATE(),21)");
	mapStr.put("is_active","0");
	mapStr.put("uqID",uqid);
	
	iu.insert(mapStr, "uf_remindFilter");
	
	int m_billid = 0;
	sql = "select id from uf_remindFilter where uqID='"+uqid+"'";
	RecordSet.executeSql(sql);		
	if(RecordSet.next()){
		m_billid = RecordSet.getInt("id");
	}
	
	//ModeRightInfo ModeRightInfo = new ModeRightInfo();
//	ModeRightInfo.editModeDataShare(userid,23,m_billid);
}
	response.sendRedirect("/seahonor/remind/RemindGiveEmp.jsp?remindID="+remindID);
%>