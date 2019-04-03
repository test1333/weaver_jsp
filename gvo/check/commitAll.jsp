<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
    //BaseBean log = new BaseBean();
    String dqny = request.getParameter("dqny");
	String status = request.getParameter("status");
	String userid = request.getParameter("userid");
	String checkbmjl = Util.null2String(request.getParameter("checkbmjl"));
	String checkbmzg = Util.null2String(request.getParameter("checkbmzg"));
	//log.writeLog(dqny+"不处理22"+status+" "+checkbmjl+" "+checkbmzg);
	int khzt=Integer.valueOf(status)+1;
	String tiaojian=" where khny='"+dqny+"' and khzt='"+status+"'";
	
	if("1".equals(status)){
		tiaojian +=" and bmzg ='"+userid+"'";
	}
	if("2".equals(status)){
		tiaojian +=" and bmjl ='"+userid+"'"; 
	}
	if(!"".equals(checkbmjl)){
		tiaojian +=" and bmjl ='"+checkbmjl+"'";
	}
	if(!"".equals(checkbmzg)){
		tiaojian +=" and bmzg ='"+checkbmzg+"'";
	}
    String sql ="update uf_month_check set khzt='"+khzt+"' "+ tiaojian;
	//log.writeLog("不处理"+sql);
	RecordSet.executeSql(sql);
%>