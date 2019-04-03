<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
    String sql = "";
    String workflowid = request.getParameter("workflowid");
    String enddate = request.getParameter("enddate");
    String num_count = "";
    sql = " select count(id) as num_count from uf_systemform where id in(select mainid from uf_systemform_dt1 where lcmc="+workflowid+") ";
    rs.executeSql(sql);
    if(rs.next()){
        num_count = Util.null2String(rs.getString("num_count"));
    }
    if(num_count.compareTo("0") > 0){
        sql = " select * from uf_systemform where id in(select mainid from uf_systemform_dt1 where lcmc="+workflowid+") ";
        //rs.executeSql(sql);
        if("1".equals(num_count)){
            rs.executeSql(sql);
            out.print("sql="+sql);
            if(rs.next()){
                String billid = Util.null2String(rs.getString("id"));
                out.print("billid="+billid);
                response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=1562&formId=-439&billid="+billid+"");
            }   
        }else{
            //rs.executeSql(sql);
            //while(rs.next()){
               // String billid = Util.null2String(rs.getString("id"));
                response.sendRedirect("/gvo/sysDoc/workflowDocDetail.jsp?workflowid="+workflowid+" ");
            //}  
        }
    }
    //response.sendRedirect("LeaveDeductionAll_2.jsp");
%>