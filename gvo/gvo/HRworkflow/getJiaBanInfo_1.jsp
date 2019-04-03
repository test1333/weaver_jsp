<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="gw" class="gvo.work.GetWebValue" scope="page"/>
<%

String json = "";
String gsrq = request.getParameter("gsrq");//归属日期
String qjr_code = request.getParameter("qjr_code");
String sfztx = request.getParameter("sfztx_s");

//  new BaseBean().writeLog("请假人工号--"+qjr_code);

double times = 0.0;

if("0".equals(sfztx)){

	if(gsrq.length()>0&&qjr_code.length()>0){	
		json = gw.getOTType(qjr_code, gsrq).toString();
	}
}else{
	if(gsrq.length()>0&&qjr_code.length()>0){	
		json = gw.getOTOther(qjr_code, gsrq);
	}
}
out.println(json);

%>

