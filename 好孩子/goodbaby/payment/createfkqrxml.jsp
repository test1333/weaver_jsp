<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<%@ page import="goodbaby.pz.CreateKJQRPZXML"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
BaseBean log = new BaseBean();
String scids = Util.null2String(request.getParameter("scids"));
String scr = Util.null2String(request.getParameter("scr"));
String pzmlid = Util.null2String(request.getParameter("pzmlid"));
String result = "";
CreateKJQRPZXML ckrp = new CreateKJQRPZXML();
result = ckrp.CreateXML(scids,scr,pzmlid);
out.print(result);

%>