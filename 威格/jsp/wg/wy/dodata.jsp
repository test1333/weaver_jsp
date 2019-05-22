<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="wg.bank.PostToBank"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
BaseBean log = new BaseBean();
String ids = Util.null2String(request.getParameter("clids"));
PostToBank ptb = new PostToBank();
String result = ptb.doPost(ids);
out.print(result);
%>