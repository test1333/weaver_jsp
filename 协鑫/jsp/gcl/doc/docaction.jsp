<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.CreateCYWorkFLow" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String billid = Util.null2String(request.getParameter("billid")); 
String creater = Util.null2String(request.getParameter("creater")); 
String type = Util.null2String(request.getParameter("type")); 
String reason = Util.null2String(request.getParameter("reason")); 
String result = "";
String sql1="";
if("cw".equals(type)){
    CreateCYWorkFLow ta = new CreateCYWorkFLow();
    result = ta.CreateWF(billid,creater);
}
if("check".equals(type)){
    DocUtil du = new DocUtil();
    String wftablename = du.getWfTableName("CY");
    String rqid = "";
    String sql = "select t.requestid from "+wftablename+" t,workflow_requestbase t1 where t1.requestid = t.requestid and t1.currentnodetype=0 and t.sjcyid='"+billid+"'";
    rs.executeSql(sql);
    if(rs.next()){
        rqid = Util.null2String(rs.getString("requestid"));
    }
    if(!"".equals(rqid)){
        result = "1";
    }else{
        result = "0";
    }

}
if("upstatus".equals(type)){
    DocUtil du = new DocUtil();
    String billtablename = du.getBillTableName("CY");
     sql1 = "update "+billtablename+" set cllx='1',reason='"+reason+"' where id="+billid;
    rs.executeSql(sql1);
   result = "1";
}
if("deleterq".equals(type)){
    DocUtil du = new DocUtil();
    String wftablename = du.getWfTableName("CY");
    String sql="delete workflow_currentoperator where requestid ="+billid;
    rs.executeSql(sql);
    sql="delete workflow_form where requestid ="+billid;
    rs.executeSql(sql);
    sql="delete workflow_formdetail where requestid ="+billid;
    rs.executeSql(sql);
    sql="delete workflow_requestLog where requestid ="+billid;
    rs.executeSql(sql);
    sql="delete workflow_requestViewLog where id ="+billid;
    rs.executeSql(sql);
    sql="delete workflow_requestbase where requestid ="+billid;
    rs.executeSql(sql);
    sql="delete "+wftablename+" where requestid ="+billid;
    rs.executeSql(sql);
   result = "1";
}
out.print(result);

%>
