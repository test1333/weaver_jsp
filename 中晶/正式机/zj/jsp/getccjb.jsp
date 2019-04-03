<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="zj.reimbursement.DoTravelAllowance" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
    String ccrq = Util.null2String(request.getParameter("ccrq"));
	String ccsj =Util.null2String(request.getParameter("ccsj"));
	 String jsrq = Util.null2String(request.getParameter("jsrq"));
	String jssj = Util.null2String(request.getParameter("jssj"));
	DoTravelAllowance dl= new DoTravelAllowance();
	
	String sql="";
	int days=0;
	int money=0;
	String result="";
	String startDay=ccrq+" "+ccsj;
	String endDay=jsrq+" "+jssj;
	if(endDay.compareTo(startDay)<=0){
		result="0";
	}else{
		sql="select DATEDIFF(DAY,'"+ccrq+"','"+jsrq+"') as days";
		//log.writeLog("aa"+sql);
		rs.executeSql(sql);
		if(rs.next()){
			days = rs.getInt("days");
		}
		if(days == 0){
			money=money+dl.getDayMoney(ccsj,jssj);
		}else if(days == 1){
			money=money+dl.getDayMoney(ccsj,"24:00");
			money=money+dl.getDayMoney("00:00",jssj);
		}else if(days > 1){
			money=money+dl.getDayMoney(ccsj,"24:00");
			money=money+(days-1)*65;
			money=money+dl.getDayMoney("00:00",jssj);
		}
		result=money+"";
	}
	out.print(result);
%>