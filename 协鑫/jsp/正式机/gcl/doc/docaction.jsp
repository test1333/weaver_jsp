<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.CreateCYWorkFLow" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="gcl.doc.workflow.DeleteCyReq" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="gcl.doc.workflow.MessageRevoke" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
    BaseBean log = new BaseBean();
    String billid = Util.null2String(request.getParameter("billid"));
    String creater = Util.null2String(request.getParameter("creater"));
    String type = Util.null2String(request.getParameter("type"));
    String reason = Util.null2String(request.getParameter("reason"));
    String result = "";
    String sql1 = "";
    if ("cw".equals(type)) {
        CreateCYWorkFLow ta = new CreateCYWorkFLow();
        result = ta.CreateWF(billid, creater);
    }
    if ("check".equals(type)) {
        DocUtil du = new DocUtil();
        String wftablename = du.getWfTableName("CY");
        String rqid = "";
        String sql = "select t.requestid from " + wftablename + " t,workflow_requestbase t1 where t1.requestid = t.requestid and t1.currentnodetype=0 and t.sjcyid='" + billid + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            rqid = Util.null2String(rs.getString("requestid"));
        }
        if (!"".equals(rqid)) {
            result = rqid;
        } else {
            result = "0";
        }

    }
    if ("checksw".equals(type)) {
        DocUtil du = new DocUtil();
        String wftablename = du.getWfTableName("SW");
        String billtablename = du.getBillTableName("CY");
        String rqid = "";
        int count = 0;
        String sql = "select t.requestid from " + wftablename + " t,workflow_requestbase t1 where t1.requestid = t.requestid and t1.currentnodetype=0 and t.sjcyid='" + billid + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            rqid = Util.null2String(rs.getString("requestid"));
        }
        if (!"".equals(rqid)) {
            result = rqid;
        } else {
            sql = "select count(1) as count from " + billtablename + " where swlcid in (select requestid from " + wftablename + ") and id=" + billid;
            log.writeLog("sw---sql=======" + sql);
            rs.executeSql(sql);
            if(rs.next()){
                count = rs.getInt("count");
            }
            log.writeLog("sw---count=======" + count);
            if(count>0){
                result = "1";
            }else{
                result = "0";
            }

        }


    }
    if ("sw".equals(type)) {
        CreateCYWorkFLow ta = new CreateCYWorkFLow();
        result = ta.CreateSW(billid, creater);
    }
    if ("upstatus".equals(type)) {
        DocUtil du = new DocUtil();
        String billtablename = du.getBillTableName("CY");
        sql1 = "update " + billtablename + " set cllx='1',reason='" + reason + "' where id=" + billid;
        rs.executeSql(sql1);
        result = "1";
    }
    if ("deleterq".equals(type)) {
        DeleteCyReq dcr =  new DeleteCyReq();
        result = dcr.deleteRq(billid);
    }
    out.print(result);

%>
