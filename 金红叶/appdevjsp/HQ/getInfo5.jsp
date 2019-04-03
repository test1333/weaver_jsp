<%@ page import="weaver.general.Util" %>
<%@ page import="APPDEV.HQ.SAPOAInterface.*" %>
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
 
		String zoataa="{'MANDT':'130','LC_TYPE':'test1','REF_NO':'1000010440','INDEX_NO':'100000000000001','CRDATE':'2017-09-07','CRTIME':'14:46:34','CREATEDBY':'BC_CONNECT','STATUS':'N','LC_NO':'','OA_MD5':'','UPD_FLAG':'','OA_DATE':'0000-00-00','OA_TIME':'00:00:00','OA_ENDDATE':'0000-00-00','OA_ENDTIME':'00:00:00','UPD_SUC':'','UPD_DATE':'0000-00-00','UPD_TIME':'00:00:00','PERNR_F':52001990,'REMARK':''}";
	    String headJson="{'REF_NO':'1000010431','INDEX_NO':'100000000000001','TEST':'金东纸业(江苏)股份有限公司工厂'}";
		String itemsJson="{'ITEM1':[{'REF_NO':10,'ITEM':'21000035测试'},{'REF_NO':10,'ITEM':'21000035测试'}],'ITEM2':[{'REF_NO':10,'ITEM':'21000035测试'},{'REF_NO':10,'ITEM':'21000035测试'}],'ITEM3':[{'REF_NO':10,'ITEM':'21000035测试'},{'REF_NO':10,'ITEM':'21000035测试'}]}";
		String textJson="[]";
	  CreateRequestAction sd = new CreateRequestAction();
	  String result=sd.createRequest(zoataa, headJson, itemsJson, textJson);
	  out.println("success:"+result);
%>