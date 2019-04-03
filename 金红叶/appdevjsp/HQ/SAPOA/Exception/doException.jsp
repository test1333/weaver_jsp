<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ara" class="APPDEV.HQ.SAPOAInterface.Action.AgainRunAction" scope="page" />
<%
 
    String requestids = request.getParameter("requestids");
	requestids = requestids+"0";
	String mandt="";
	String index_no="";
	String lc_no="";
	String sql="select mandt,index_no,lc_no from v_excep_zoat00020 where lc_no in ("+requestids+") ";
	rs.executeSql(sql);
	while(rs.next()){
		mandt = Util.null2String(rs.getString("mandt"));
	    index_no = Util.null2String(rs.getString("index_no"));
	    lc_no = Util.null2String(rs.getString("lc_no"));
		    
		if(!"".equals(lc_no)){
		    ara.runmap(lc_no,mandt,index_no);
		}
	}
	//out.print("aa"+requestids);
%>