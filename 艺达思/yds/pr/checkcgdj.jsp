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
    String lh = request.getParameter("lh");
	String gys = request.getParameter("gys");
	String dw = request.getParameter("dw");
	String bb = request.getParameter("bb");
	String kssj = request.getParameter("kssj");
	String jssj = request.getParameter("jssj");
     String sql="";
	 String flag="1";
    int count=0;
	sql="select count(b.id) as count from formtable_main_21 a,formtable_main_21_dt1 b where a.id=b.mainid and b.PartNo='"+lh+"' and b.SuppilerCode='"+gys+"' and b.Unit='"+dw+"' and b.Currency='"+bb+"' and (b.WorkDate<='"+jssj+"' and b.WorkDate2>='"+kssj+"')";
	//log.writeLog("aaaabb"+sql);
	rs.executeSql(sql);
	if(rs.next()){
		count = rs.getInt("count");
	}
	if(count == 0){
		flag="0";
	}
    
	out.print(flag);
	
%>