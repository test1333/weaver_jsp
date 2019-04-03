<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	String idkey="";
	String id = Util.null2String(request.getParameter("mid"));
    String sjfxrq = Util.null2String(request.getParameter("monstarttime2"));

	if("".equals(sjfxrq)){
			idkey="1";	
	}else{
            RecordSet.executeSql("update formtable_main_234 set sjfxrq ='"+sjfxrq+"' where requestid="+id);
			idkey="0";
	}
	
	response.sendRedirect("/gvo/release/releaseEdit_wev8.jsp?id="+id+"&idkey="+idkey+" ");
%>