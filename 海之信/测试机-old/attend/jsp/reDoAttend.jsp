<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
    String sql = "";
    String fromdate = Util.null2String(request.getParameter("fromdate"));
	String recipient = Util.null2String(request.getParameter("recipient"));
    String options = Util.null2String(request.getParameter("options"));
    if(!"".equals(fromdate)&&!"".equals(recipient)){
        sql = " exec sh_atten_info_insert  '"+fromdate+"' ";
        rs.executeSql(sql);
        sql = " exec one_sh_atten_info_clear_up_new '"+fromdate+"',"+recipient+" ";
        rs.executeSql(sql);
        out.println("sql="+sql);
    }
    //response.sendRedirect("/seahonor/attend/jsp/ManualDoAttend.jsp?fromdate="+fromdate+"&recipient="+recipient+"&options="+options+"");
    response.sendRedirect("/seahonor/attend/jsp/ManualDoAttend.jsp");
%>


