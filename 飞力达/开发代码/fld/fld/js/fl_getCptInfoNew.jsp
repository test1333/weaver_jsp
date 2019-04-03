<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<jsp:useBean id="gci" class="feilida.finance.FlGetCptInfoNew" scope="page"/>
<%
//接口调用jsp
StringBuffer json = new StringBuffer();
String OADATE = Util.null2String(request.getParameter("OADATE"));//申请日期
String AMOUNT = Util.null2String(request.getParameter("AMOUNT"));//金额
String KOSTL = Util.null2String(request.getParameter("KOSTL"));//成本中心
String KSTAR = Util.null2String(request.getParameter("KSTAR"));//会计科目
String GSBER = Util.null2String(request.getParameter("GSBER"));//业务范围
String CURRENCY = Util.null2String(request.getParameter("CURRENCY"));//币种
String EXECTYPE = Util.null2String(request.getParameter("EXECTYPE"));//报销类型，1：资产报销
String OPTTYPE = Util.null2String(request.getParameter("OPTTYPE"));//操作类型
//int STAFFID = Integer.parseInt(request.getParameter("STAFFID"));//员工id
//int COMPID = Integer.parseInt(request.getParameter("COMPID"));//公司id
//int DEPTID = Integer.parseInt(request.getParameter("DEPTID"));//部门id
String ANLKL = Util.null2String(request.getParameter("ANLKL"));//资产编号
String OAKEY = Util.null2String(request.getParameter("OAKEY"));//流程requestid
int STAFFID = 1;//员工id
int COMPID = 1;//公司id
int DEPTID = Integer.parseInt(request.getParameter("DEPTID"));//部门id


if(OADATE.length()>0&&AMOUNT.length()>0){	
	
	json = gci.getCptInfoNew(OADATE, AMOUNT, KOSTL, KSTAR, GSBER, CURRENCY, EXECTYPE, OPTTYPE, STAFFID, COMPID, DEPTID, ANLKL, OAKEY);
	
}else{
	json.append("{");
	json.append("MSGTYP:").append("'").append("failed").append("'").append(",");
 	json.append("MSGTXT:").append("'").append("数据传输有误！请检查").append("'");
 	json.append("}");
}
out.println(json.toString());

%>

