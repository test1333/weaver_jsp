<%@ page import="weaver.general.Util" %>
<%@ page import="gvo.displaycenter.GetBOMDataForUpdate" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
    String I_BANFN = Util.null2String(request.getParameter("I_BANFN"));//采购申请编号
	String I_ITEMNOS = Util.null2String(request.getParameter("I_ITEMNOS"));//
	GetBOMDataForUpdate gbd= new GetBOMDataForUpdate();
	 String result=gbd.getDetialinfo(I_BANFN,I_ITEMNOS);

	out.print(result);
%>