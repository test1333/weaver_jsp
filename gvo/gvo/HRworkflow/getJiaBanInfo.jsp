<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="gw" class="gvo.work.GetWebValue" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String yjqjksrq = request.getParameter("yjqjksrq");//开始日期
String yjqjjsrq = request.getParameter("yjqjjsrq");//结束日期
String yjqjkssj = request.getParameter("yjqjkssj");//开始时间
String yjqjjssj = request.getParameter("yjqjjssj");//结束时间
String gsrq = request.getParameter("gsrq");//归属日期
String qjr_code = request.getParameter("qjr_code");
// new BaseBean().writeLog("请假人工号--"+qjr_code);

double times = 0.0;

if(yjqjksrq.length()>0&&yjqjjsrq.length()>0&&yjqjkssj.length()>0&&yjqjjssj.length()>0){	
	
	times = gw.getOTValue(qjr_code, gsrq, yjqjksrq, yjqjjsrq, yjqjkssj, yjqjjssj);
	json.append("{");
// 	json.append("'test':").append("'").append("测试成功").append("'").append(",");
	json.append("xss:").append("'").append(times).append("'");
	json.append("}");
	
	
}
out.println(json.toString());

%>

