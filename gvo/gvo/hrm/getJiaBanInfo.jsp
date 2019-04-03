<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rtv" class="gvo.work.RepeatTimeVerify" scope="page"/>
<%


String str = "1";
String requestID = request.getParameter("requestID"); //dtid
String dtID = request.getParameter("dtID"); //dtid
String empcode = request.getParameter("empcode"); //工号
String s_date = request.getParameter("s_date"); //开始日期
String s_time = request.getParameter("s_time"); //开始时间
String e_date = request.getParameter("e_date"); //结束日期
String e_time = request.getParameter("e_time"); //结束时间

if(dtID.length() < 1) dtID  = "-1";

if(dtID.length()>0&&empcode.length()>0&&s_date.length()>0&&s_time.length()>0&&e_date.length()>0&&e_time.length()>0){	
	
	boolean isRepeat = rtv.isRepeatTime(empcode, s_date, s_time, e_date, e_time, requestID,dtID);
	if(!isRepeat) str = "0";
}
out.println(str);
%>

