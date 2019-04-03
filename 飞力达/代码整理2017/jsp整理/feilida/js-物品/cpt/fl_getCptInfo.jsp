<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<jsp:useBean id="gci" class="feilida.finance.FlGetCptInfoNew" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String OADATE = Util.null2String(request.getParameter("OADATE"));//申请日期
String AMOUNT = Util.null2String(request.getParameter("AMOUNT"));//金额
String KOSTL = Util.null2String(request.getParameter("KOSTL"));//成本中心
String KSTAR = Util.null2String(request.getParameter("KSTAR"));//会计科目
String GSBER = Util.null2String(request.getParameter("GSBER"));//业务范围
String CURRENCY = Util.null2String(request.getParameter("CURRENCY"));//币种
String EXECTYPE = Util.null2String(request.getParameter("EXECTYPE"));//报销类型，1：资产报销
String OPTTYPE = Util.null2String(request.getParameter("OPTTYPE"));//操作类型
int STAFFID = Integer.parseInt(request.getParameter("STAFFID"));//员工id
int COMPID = Integer.parseInt(request.getParameter("COMPID"));//公司id
int DEPTID = Integer.parseInt(request.getParameter("DEPTID"));//部门id
String ANLKL = Util.null2String(request.getParameter("ANLKL"));//资产编号
String OAKEY = Util.null2String(request.getParameter("OAKEY"));//流程requestid


//if(yjqjksrq.length()>0&&yjqjjsrq.length()>0&&yjqjkssj.length()>0&&yjqjjssj.length()>0){	
	
	json = gci.getCptInfoNew(OADATE, AMOUNT, KOSTL, KSTAR, GSBER, CURRENCY, EXECTYPE, OPTTYPE, STAFFID, COMPID, DEPTID, ANLKL, OAKEY);
	
//}
out.println(json.toString());

%>

