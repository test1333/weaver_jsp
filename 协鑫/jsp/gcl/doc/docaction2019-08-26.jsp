<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.CreateCYWorkFLow" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
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
        DocUtil du = new DocUtil();
        String wftablename = du.getWfTableName("CY");
        String billname = du.getBillTableName("CY");


        //发送 POST 请求
        Map map = new HashMap();
        MessageRevoke mr = new MessageRevoke();
        String sr = mr.sendPost("http://lanxin.gcl-power.com/cgi-bin/token?grant_type=client_credential&appid=100600&" +
                "secret=_1_@X@@_r@d_f@D6Y__@e_ngb71KE_", "0", map);
       // log.writeLog("sr=======" + sr);
        JSONObject jsStr = new JSONObject();
        try {
            jsStr = JSONObject.fromObject(sr);
        } catch (Exception e) {
            log.writeLog("jsStr解析出现异常！" + e);
           out.print("-1");
           result="-1";
           return;
        }

        String access_token = "";
        String errcode = jsStr.getString("errcode");
        if ("0".equals(errcode)) {
            access_token = jsStr.getString("access_token");
        }else{
           out.print("-1");
           result="-1";
           return;
        }
        log.writeLog("access_token==========" + access_token);
        String ss = mr.sendPost("http://10.31.2.118:8088/wxthirdapi/getLXMSGID?requestid=" + billid, "0", map);
        //log.writeLog("ss=======" + ss);
        JSONObject jsStr1 = new JSONObject();
        String msgids = "";
        String status = "";
        try {
            jsStr1 = JSONObject.fromObject(ss);
            status = jsStr1.getString("status");
        } catch (Exception e) {
            log.writeLog("jsStr1解析出现异常！" + e);
            out.print("-1");
            result="-1";
            return;
        }
//        JSONObject json = new JSONObject(sr);
        if ("0".equals(status)) {
            msgids = jsStr1.getString("msgids");
        }else{
           out.print("-1");
           result="-1";
           return;
        }
        if (msgids.length() > 0) {
            String[] aa = msgids.split("\"");
            String ww = mr.getOdd(aa);

            log.writeLog("ww=======" + ww);
            System.out.println(ww);
            if (ww.length() > 0) {
                String[] sm = ww.split(",");
                for (int j = 0; j < sm.length; j++) {
                    log.writeLog(sm[j]);
                    map.put("userMessageId", sm[j]);
                    String st = mr.sendPost("http://lanxin.gcl-power.com/cgi-bin/richMessage/revoke?access_token=" + access_token, "1", map);
//                    System.out.println(st);
                    //log.writeLog("st=======" + st);
                    if(j==0){
                          JSONObject jssm = new JSONObject();
                          String errcodesm = "";
                           try {
                                jssm = JSONObject.fromObject(st);
                                errcodesm = jssm.getString("errcode");
                            } catch (Exception e) {
                                log.writeLog("st解析出现异常！" + e);
                                out.print("-1");
                                result="-1";
                                return;
                            }
                            if (!"0".equals(errcodesm)) {
                                out.print("-1");
                                result="-1";
                                return;
                            }
                    }
                }
            }

        }

        if(!"-1".equals(result)){
            String sql = "delete workflow_currentoperator where requestid =" + billid;
            rs.executeSql(sql);
            sql = "delete workflow_form where requestid =" + billid;
            rs.executeSql(sql);
            sql = "delete workflow_formdetail where requestid =" + billid;
            rs.executeSql(sql);
            sql = "delete workflow_requestLog where requestid =" + billid;
            rs.executeSql(sql);
            sql = "delete workflow_requestViewLog where id =" + billid;
            rs.executeSql(sql);
            sql = "delete workflow_requestbase where requestid =" + billid;
            rs.executeSql(sql);
            sql = "delete " + wftablename + " where requestid =" + billid;
            rs.executeSql(sql);
            sql = "delete " + billname + " where requestid =" + billid + " and cllx = 0";
            rs.executeSql(sql);
            result = "1";
        }
    }
    out.print(result);

%>
