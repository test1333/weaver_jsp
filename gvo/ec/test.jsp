<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.hrm.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
  int userid = user.getUID();
  out.print(userid);
  String workcode="";
  String sql="select workcode from hrmresource where id="+userid;
  rs.executeSql(sql);
  if(rs.next()){
    workcode = Util.null2String(rs.getString("workcode"));
  }
   response.sendRedirect("http://222.92.108.195:8083/gvo/test222.jsp?workcode="+workcode);
%>