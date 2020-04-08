<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
   String loginid = Util.null2String(request.getParameter("loginid"));
   String userpassword = Util.null2String(request.getParameter("userpassword"));
   String sql = " select count(id) as count from formtable_main_127 where dlzh='"+loginid+"' and dlmm='"+userpassword+"'";
   int count = 0;
   String result = "0";
   rs.execute(sql);
   if(rs.next()){
      count = rs.getInt("count");
   }
   if(count >0){
      result = "1";
   }
   out.print(result);
%>