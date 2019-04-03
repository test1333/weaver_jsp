<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="seahonor.util.SysNoForSelf" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>
<%
    String customid = request.getParameter("customid");
	String sql_dt="";
	String sql="select tablename,columnname,keyname from uf_cm_tableinfo  where lb=0 ";
	String tablename="";
	String columnname="";
	String keyname="";
	rs.executeSql(sql);
	int count=0;
	while(rs.next()){
		tablename = Util.null2String(rs.getString("tablename"));
		columnname = Util.null2String(rs.getString("columnname"));
		keyname = Util.null2String(rs.getString("keyname"));
		if("formtable_main_306_dt1".equals(tablename)||"uf_custom".equals(tablename)||"formtable_main_266".equals(tablename)){
			continue;
		}
	  	sql_dt="select count(1) as count from "+tablename+" where "+columnname+"='"+customid+"'";
		log.writeLog("customid:"+customid+"sql_dt:"+sql_dt);
		rs_dt.executeSql(sql_dt);
		if(rs_dt.next()){
			count = rs_dt.getInt("count");
		}
		if(count >0){
			break;
		}

	}
    out.print(count);

%>