<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />

<%
    String id_dt1 = Util.null2String(request.getParameter("ids"));
    String id_old = Util.null2String(request.getParameter("id_old"));  
    String sql = "";
    String idkey="";
    String badgeNo = Util.null2String(request.getParameter("badgeNo"));
    String quantity = Util.null2String(request.getParameter("quantity"));
    String vehicleNo = Util.null2String(request.getParameter("vehicleNo"));
    String issuedBy = Util.null2String(request.getParameter("issuedBy"));
    String issuedTime = Util.null2String(request.getParameter("issuedTime"));
    String receivedBy = Util.null2String(request.getParameter("receivedBy"));
    String receivedTime = Util.null2String(request.getParameter("receivedTime"));
    out.print("id_dt1="+id_dt1);
    out.print("id_old="+id_old);
    out.print("badgeNo="+badgeNo);
    out.print("quantity="+quantity);
    out.print("vehicleNo="+vehicleNo);
    out.print("issuedBy="+issuedBy);
    out.print("issuedTime="+issuedTime);
    out.print("receivedBy="+receivedBy);
    out.print("receivedTime="+receivedTime);
    if(!"".equals(issuedTime)||!"".equals(receivedTime)){
        sql = " update formtable_main_91 set badgeNo='"+badgeNo+"',quantity='"+quantity+"',vehicleNo='"+vehicleNo+"', "
        +" issuedBy='"+issuedBy+"',issuedTime='"+issuedTime+"',receivedBy='"+receivedBy+"',receivedTime='"+receivedTime+"' "
        +" where requestId ="+id_dt1+" ";
        rs.executeSql(sql);
        //log.writeLog("sql1="+sql);
        idkey="0";
        out.print("sql="+sql);
		
    }else{
        idkey="1";
        //return;
    }
     out.print("idkey="+idkey);
    response.sendRedirect("/mubea/guard/jsp/GuardEditDemo.jsp?id="+id_old+"&idkey="+idkey+" ");
%>


