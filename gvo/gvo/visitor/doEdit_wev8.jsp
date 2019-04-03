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
	String fzc = Util.null2String(request.getParameter("fzc"));
	String zjh = Util.null2String(request.getParameter("zjh"));
	String lfsjbn = Util.null2String(request.getParameter("monstarttime1"));
    String lksjbn = Util.null2String(request.getParameter("monstarttime2"));
	if("".equals(fzc)&&"".equals(zjh)&&"".equals(lfsjbn)&&"".equals(lksjbn)){
			idkey="1";	
	}else{
    		RecordSet.executeSql("update formtable_main_124 set lfsjbn ='"+lfsjbn+"',lksjbn = '"+lksjbn+"',fzc = '"+fzc+"',zjh = '"+zjh+"' where requestid="+id);
			idkey="0";
	}
	
	response.sendRedirect("/gvo/visitor/visitorEdit_wev8.jsp?id="+id+"&idkey="+idkey+" ");
%>