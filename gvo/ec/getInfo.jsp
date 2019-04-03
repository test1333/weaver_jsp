<%@ page import="weaver.general.Util" %>
<%@ page import="gvo.webservice.CreateRequestServiceEC" %>
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
    CreateRequestServiceEC aa = new CreateRequestServiceEC();
	

		String result = aa.CreatePurchaseOrder("3448","{'HEADER':{'EBELN':'1100007170','BEDAT':'20170726','LIFNR':'1000978','NAME1':'河北新光华有限公司','EKORG':'G001','EKOTX':'昆山国显光电采购组织','EKGRP':'P01','EKNAM':'陈平','BUKRS':'1000','BUTXT':'昆山国显光电有限公司','BRTWR':'6300.00'},'DETALIS':{'DT1':[{'EBELP':'00010','MATNR':'500000221','TXZ01':'栈板_塑料,尺寸：1100X1100X150cm','MENGE':'70.000','MEINS':'块','EINDT':'20170726','NETPR':'76.92','KBETR':'90.00','WAERS':'CNY','MWSKZ':'J5','TEXT1':'17% 进项税，中国','PEINH':'1','BPRME':'块','NAME1':'国显光电昆山工厂','LGOBE':'','WGBEZ':'生产耗材','AFNAM':'','INFNR':'5300008103','BANFN':'3500004268','BNFPO':'00010','KNTTP':'','PSTYP':'0','SAKTO':'','TXT20':'','KOSTL':'','LTEXT':'','AUFNR':'','KTEXT':'','ANLN1':'','ANLN2':'','BRTWR':'6300.00','LOEKZ':'','TXT50':''}]}}");

	out.print(result);
%>