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
<jsp:useBean id="irf" class="zj.certificate.InsertRequestFKRecord" scope="page" />
<%
 
    String requestids = request.getParameter("requestids");
	requestids = requestids+"0";
	String requestid[] = requestids.split(",");
	String rqid="";
	for (int i = 0; i < requestid.length; i++) {
		rqid = requestid[i];
		if ("".equals(rqid) || "0".equals(rqid)) {
				continue;
		}
		irf.insertInfo(rqid);
	}
	
%>