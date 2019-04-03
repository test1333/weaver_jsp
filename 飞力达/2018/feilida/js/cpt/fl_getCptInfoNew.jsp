<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="org.json.JSONObject"%>

<jsp:useBean id="gci" class="feilida.finance.FlGetCptInfoNew" scope="page"/>
<%

StringBuffer json = new StringBuffer();
BaseBean log = new BaseBean();
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
String Project = Util.null2String(request.getParameter("Project"));
int STAFFID = 1;//员工id
int COMPID = 1;//公司id
int DEPTID = Integer.parseInt(request.getParameter("DEPTID"));//部门id


if(OADATE.length()>0&&AMOUNT.length()>0){
	Map<String,String> mapStr = new HashMap<String, String>();
	OADATE = OADATE.replace("-", ".");
	mapStr.put("OADATE", OADATE);
	mapStr.put("KOSTL", KOSTL);
	mapStr.put("PROJECT", Project);
	mapStr.put("GSBER", GSBER);
	mapStr.put("KSTAR", KSTAR);
	if(OAKEY.length() < 1 ){
		OAKEY = "0";
	}
	mapStr.put("OAKey",  OAKEY);
    weaver.general.BaseBean wgb = new weaver.general.BaseBean();	
//	json = gci.getCptInfoNew(OADATE, AMOUNT, KOSTL, KSTAR, GSBER, CURRENCY, EXECTYPE, OPTTYPE, STAFFID, COMPID, DEPTID, ANLKL, OAKEY,Project);
//	json = gci.getCptInfoNew(OADATE, AMOUNT, KOSTL, KSTAR, GSBER, CURRENCY, EXECTYPE, OPTTYPE, STAFFID, COMPID, DEPTID, ANLKL, OAKEY);
	feilida.util.WebApi wb = new feilida.util.WebApi();
	String ss = wb.getJsonStr(mapStr);
	log.writeLog("SSSSS = " + ss + "<br>");
	//out.println("SSSSS = " + ss + "<br>");	
	String jsonNew = wb.getPostConn("QueryBudgetCode",ss);
	//out.println("RRRRR = " + jsonNew + "<br>");
	log.writeLog("RRRRR = " + jsonNew + "<br>");
	JSONObject json1 = null;
	if(jsonNew.length() > 0 ){
      	        json1 = new JSONObject(jsonNew);
		if(json1.isNull("list")){
      	     	     out.print(jsonNew);
					 log.writeLog("jsonNew = " + jsonNew + "<br>");
		}else{
          	     out.print(json1.get("list"));
				 log.writeLog("list = " + json1.get("list") + "<br>");
       	 	}
	}
}else{
	json.append("{");
	json.append("MSGTYP:").append("'").append("failed").append("'").append(",");
 	json.append("MSGTXT:").append("'").append("数据传输有误！请检查").append("'");
 	json.append("}");
	out.print(json.toString());
}


%>

