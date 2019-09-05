<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
   String tyshxydm = Util.null2String(request.getParameter("tyshxydm"));
  rs.execute("{Call ks_calEmpDayAtten("+ryid+",'"+cldate+"')}")
%>