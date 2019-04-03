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
 JSONObject a = new JSONObject();
	   try {
		a.put("MANDT", "");
		a.put("LC_TYPE", "IPL");
		   a.put("REF_NO", "12");
		   a.put("INDEX_NO", "123");
		   a.put("CRDATE", "");
		   a.put("CRTIME", "");
		   a.put("CREATEDBY", "");
		   a.put("STATUS", "");
		   a.put("LC_NO", "");
		   a.put("OA_MD5", "");
		   a.put("UPD_FLAG", "");
		   a.put("OA_DATE", "");
		   a.put("OA_TIME", "");
		   a.put("OA_ENDDATE", "");
		   a.put("OA_ENDTIME", "");
		   a.put("UPD_SUC", "");
		   a.put("UPD_DATE", "");
		   a.put("UPD_TIME", "");
		   a.put("PERNR_F", 52001990);
		   a.put("REMARK", "");
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   
	   
	//System.out.println(a.toString());
	  JSONObject b = new JSONObject();
	
	  try {
		b.put("INDEX_NO", "123");
		  b.put("REF_NO", "12");
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		
	}
	  System.out.println(b.toString());
	  JSONObject f = new JSONObject();
	  try{
	  JSONArray d = new JSONArray();
	  JSONObject node = new JSONObject();
	  node.put("REF_NO", "12");
	  node.put("ITEM", "1");
	  d.put(node);
	  JSONObject node1 = new JSONObject();
	  node1.put("REF_NO", "12");
	  node1.put("ITEM", "2");
	  d.put(node1);
	  
	  JSONArray e = new JSONArray();
	  JSONObject node3 = new JSONObject();
	  node3.put("REF_NO", "12");
	  node3.put("ITEM", "3");
	  e.put(node);
	  JSONObject node4 = new JSONObject();
	  node4.put("REF_NO", "12");
	  node4.put("ITEM", "4");
	  e.put(node1);
	  f.put("ITEM1", d);
	  f.put("ITEM2", e);
	  System.out.println(f.toString());
	  } catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		String zoataa="{'MANDT':'130','LC_TYPE':'OA002','REF_NO':'1000010440','INDEX_NO':'100000000000010','CRDATE':'2017-09-07','CRTIME':'14:46:34','CREATEDBY':'BC_CONNECT','STATUS':'N','LC_NO':'','OA_MD5':'','UPD_FLAG':'','OA_DATE':'0000-00-00','OA_TIME':'00:00:00','OA_ENDDATE':'0000-00-00','OA_ENDTIME':'00:00:00','UPD_SUC':'','UPD_DATE':'0000-00-00','UPD_TIME':'00:00:00','PERNR_F':52001990,'REMARK':''}";
	    String headJson="{'BANFN':'1000010431','WERKS':'7600','NAME1':'金东纸业(江苏)股份有限公司工厂','ORGTX':'CIT','BSART':'NB','BATXT':'11','NETWR':15582.97,'WAERS':'RMB','BEDNR':'630000','PERNR':52001990}";
		String itemsJson="{'ITEM1':[{'BNFPO':10,'TXZ01':'21000035测试','MATNR':'000000000021000035','MENGE':1.000,'MEINS':'909','PREIS':5194.97,'WAERS':'RMB','BADAT':'2017-09-05','LFDAT':'2017-09-05','EKGRP':'F0C','BEDNR':'630000','ERNAM':'WEIHUIQING','AFNAM':'zhurongxin','LABST':105.000,'PRLAB':0,'INSME':247.000,'SPEME':0,'KLABS':-8.000,'KINSM':18.000,'KSPEM':0},{'BNFPO':20,'TXZ01':'21000035测试','MATNR':'000000000021000035','MENGE':2.000,'MEINS':'909','PREIS':10388.00,'WAERS':'JPY','BADAT':'2017-09-07','LFDAT':'2011-09-07','EKGRP':'F0C','BEDNR':'630000','ERNAM':'WEIHUIQING','AFNAM':'weihuiqing','LABST':105.000,'PRLAB':0,'INSME':247.000,'SPEME':0,'KLABS':-8.000,'KINSM':18.000,'KSPEM':0}],'ATT':[{'REF_NO':'','ITEM':1,'ATT_ID':'00237D4570E21ED7A4F1CD78AD174306','ATT_NAME':'2016电子贺卡.jpg','ATT_TYPE':'JPG','ATT_URL':'http://172.18.95.47:8080/archive?get&pVersion=0045&contRep=EA&docId=005056A878BB1EE7B6C6C1828655E609','ATT_BZ':'','REMARK1':'1000010431采购申请信息图片','REMARK2':'','CRUNAME':'DENGWEIJUN','CRDATE':'2017-09-07','CRTIME':'13:36:21'}],'WD':[{'ITEM':1000,'WD_NAME':'采购申请信息','WD_URL':'https://eccsvrd.app.com.cn:1443/sap/bc/webdynpro/sap/zwd_oa001_app?index_no=100000000000052','REMARK1':''}]}";
		String textJson="[{'NAME':'LTXT1','TLINE':'据报道，因害怕被与其有经济往来的、被捕的赵某牵出，山东省济南市委原书记王敏惶惶不可终日，极度煎熬，几乎崩溃。他在《忏悔书》中说：\"夜夜难以入睡，几乎天天半夜惊出一身冷汗，醒来就再也睡不着，总想不知道什么时候就出事。白天常常魂不守舍，省委通知开会，怕在会场被带走；上班时怕回不了家；上级领导约去谈工作，也怕是借题下菜。开会时在台上坐着，往往心不在焉，只得强打精神撑着；一个人时，唉声叹气，多次用拳头敲打自己的脑袋，发泄胸中压力。\"\r\n有此感触的不止王敏。不少两面人都有类似的心理困境。到底是什么让王敏们变得惶恐不安？\r\n乍一看，转折点似乎是那个与他有经济往来之人的被捕，由此带来不安全感。其实，这不过是一个导火索，点燃了原本就埋藏在他们心中的恐惧之火，冲垮了他们维持两面人的最后一道精神防线。'}]";
	  CreateRequestAction sd = new CreateRequestAction();
	  String result=sd.createRequest(zoataa, headJson, itemsJson, textJson);
	  out.println("success:"+result);
%>