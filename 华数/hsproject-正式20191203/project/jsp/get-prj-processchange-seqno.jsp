﻿<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="hsproject.util.SysnoUtil"%>
<%@page import="org.json.JSONObject"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
SysnoUtil su = new SysnoUtil();
String seqNo=su.getNum("PPC", "uf_prj_prochgrecord", 4);
out.print(seqNo);
%>

