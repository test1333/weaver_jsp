<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />

<%
	BaseBean log = new BaseBean();
    String kmzhall = request.getParameter("kmzhall");
     String sql="";
	 String flag="0";
	String arr[] = kmzhall.split("##");
    for(int i=0;i<arr.length;i++){
		int count=0;
		sql="select count(1) as count from AccountMasterINFO where accountcomb='"+arr[i]+"'";
		rs.executeSql(sql);
		if(rs.next()){
			count = rs.getInt("count");
		}
		if(count == 0){
			flag=1;
			break;
		}
    }
	out.print(flag);
	
%>