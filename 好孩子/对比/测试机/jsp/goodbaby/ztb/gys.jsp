 <%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	String jgkxx = Util.null2String(request.getParameter("jgkxx"));
	String sql = "select GYS,psry from  uf_bidsupForm where jgkxx ='"+jgkxx+"'";
	RecordSet.executeSql(sql);
	String gys = "";
	String psry ="";
	if(RecordSet.next()){
		gys = Util.null2String(RecordSet.getString("GYS"));
		psry = Util.null2String(RecordSet.getString("psry"));
		
	}
	out.print(gys+"@"+psry);
%>