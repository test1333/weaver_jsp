<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.system.SystemComInfo" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="ghy.service.GhyRequestService" %>
<%@ page import="CHQ.InsertUtil" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.general.Util,java.sql.Timestamp" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	String workflowCode = "TPM_OA_03_08";
	String jsonStr = "{\"HEADER\":{\"ZZI_CRM_ID\":\"5000900021\",\"ZZ_IS_HEADER\":\"X\",\"ZZ_ISCONTACT\":\"\",\"ZZ_CUST_GROUP\":\"01\",\"ZZ_PARTNER1\":\"\",\"ZZI_PART_NAME\":\"\",\"ZZ_SHIP_TO\":\"\",\"ZZI_SHIP_TO_NAME\":\"\",\"CRDAT\":\"2016-07-15\",\"REQ_BP\":\"88800503\""+
	",\"REQ_NM\":\"旭高陈\",\"REQ_TIME\":\"2016-07-21\",\"ZB_QY\":\"X\",\"ZZ_REGION\":\"A\",\"ZZ_REGION_DES\":\"华东大区\",\"ZZ_SALES_ORG\":\"\",\"ZZF_DIS_DEPART\":\"KA\",\"ZZ_CHANNEL\":\"KA\",\"ZZ_DIS_DEPART_S\":\"50\",\"ZZ_DIS_DEPART_S_DES\":\"LKA TOP20\",\"ZZ_SHENG\":\"DSHA\""+
	",\"ZZ_SHENG_DES\":\"金红叶上海省办\",\"ZZ_SALES_GROUP\":\"\",\"ZZ_SALES_GROUP_DES\":\"\"},\"ITEMS\":[],\"PRICE\":[],\"TEXT\":[],\"ATTACHS\":[]}";
	GhyRequestService grs = new GhyRequestService();
	//String aa=grs.getRequestState("208");
	out.println("流程编号："+workflowCode + " ; JSON的内容： " + jsonStr +"<br>");
	String strCode = grs.createRequest(workflowCode,jsonStr);
	
	out.println("流程执行结果："+strCode+"<br>");
%>