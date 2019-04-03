<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />

<%
    String sql = "";
    String ExpressCompany = "";//快递公司
    String ids = request.getParameter("ids");
	
	int sid = user.getUID();
	
    ExpressCompany = request.getParameter("ExpressCompany");
    //out.print("ids="+ids);
    /*sql = "update formtable_main_39 set State = 1 where id in( " + ids + "0 )";
    rs.executeSql(sql);*/

   // sql = "select * from formtable_main_39 where id in( " + ids + "0 )";
   // rs.executeSql(sql);
   // while(rs.next()){
   //      ExpressCompany = Util.null2String(rs.getString("ExpressCompany"));
   // }        
    //out.print("sql="+sql);
    log.writeLog("sql="+sql);   
    log.writeLog("ExpressCompany="+ExpressCompany); 
    //response.sendRedirect("ForTheCost.jsp");  
    //  field7026
    //AddRequestIframe.jsp中去掉Iframe变为AddRequestIframe.jsp，弹出的流程就有提交按钮
    response.sendRedirect("/workflow/request/AddRequest.jsp?workflowid=52&isagent=0&beagenter=0&isfromtab=false&hrmid=1&f_weaver_belongto_usertype=null&s="
    	+Math.random()+"&field7039="+ids+"&field10267="+sid+"&field7026="+sid+"&field7038="+ExpressCompany);

%>


