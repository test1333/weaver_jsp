<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.conn.RecordSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*,java.net.*" %>
<%@ page import="weaver.general.Util" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%
String operation = Util.fromScreen(request.getParameter("operation"),user.getLanguage());
int emp_id = user.getUID();
char flag = Util.getSeparator() ;

if(operation.equals("deleteworkflow")){
    
    String deleteworkflowidstr=Util.null2String(request.getParameter("multiRequestIds"));
    
    gvo.emc.MoreDocEmcLoad mde = new gvo.emc.MoreDocEmcLoad();
    mde.execute(deleteworkflowidstr);
    
    response.sendRedirect("/gvo/docment/FileBatchList.jsp");
}
 

%>