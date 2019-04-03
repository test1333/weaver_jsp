<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="goodbaby.order.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>
<%
    String fkqx = Util.null2String(request.getParameter("fkqx"));
    String bz = Util.null2String(request.getParameter("bz"));
    String com = Util.null2String(request.getParameter("com"));
    String cgdl = Util.null2String(request.getParameter("cgdl"));
    String idkey = "1";
    String sql = "";
    // 流程id
    String workflowid = "218";
    String skyhmc = "";//收款银行名称
    String skyhzh = "";//收款银行账号
    String syje = "";//剩余未付
    String gysmc = "";//供应商名称
    String gsmc = "";
    String id = "";
    String temp = "";
    String tempAll = "";
    String flag = "";
    String flag2 = "";
    int userId = Util.getIntValue(request.getParameter("userId"));
    String dept = rci.getDepartmentID(Util.null2String(userId));
    String workcode = rci.getWorkcode(Util.null2String(userId));
    String result = "";
    JSONObject json = new JSONObject();
    JSONObject header = new JSONObject();
    JSONObject details = new JSONObject();
    JSONArray dt1 = new JSONArray();
    String nowDate = TimeUtil.getCurrentDateString(); // 获取当前日期2018-07-13
    try {
        header.put("SQR", userId);
        header.put("SQRBM", dept);
        header.put("SQRQ", nowDate);
        header.put("SQRGH", workcode);
        header.put("FKBB", bz);
       
    } catch (JSONException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
    sql = "select *  from gb_payReqView2 t where t.fkqx<= '" + fkqx + "' and t.bz = '" +
            bz + "' and gs = '" + com + "' and cgdl ='"+cgdl+"'";
   
    rs.executeSql(sql);
    log.writeLog("sql----------->" + sql);
    while (rs.next()) {
        flag = "";
        temp = "";
        gysmc = Util.null2String(rs.getString("gysmc"));
        syje = Util.null2String(rs.getString("ybje"));
        skyhzh = Util.null2String(rs.getString("yhzh"));
        skyhmc = Util.null2String(rs.getString("khh"));
        gsmc = Util.null2String(rs.getString("gs"));
        cgdl = Util.null2String(rs.getString("cgdl"));

        String sqldt = "select t.* from (select isnull(b.sfpk,'1') as sfpk,b.id,b.gysmc,b.fph,b.fkqx," +
                "b.company,b.bz,b.jeyb,b.jermb,a.GYSMC as gys,a.YHZH,a.LHH, a.KHH,a.JGH,a.CNAPS," +
                "b.fkid,(select d.selectname from workflow_billfield e, workflow_bill c," +
                "workflow_selectitem d where e.billid=c.id and d.fieldid=e.id and " +
                "c.tablename='uf_suppmessForm' and e.fieldname='ZHSK' and d.cancel=0 and " +
                "d.selectvalue = a.ZHSK) as ZHSK,b.cgdl from uf_payinternal b join uf_suppmessForm a" +
                " on a.id =b.gysmc where a.id not in (select gys from uf_ztpkgys ) and b.fph not" +
                " in (select fphm from uf_ztpkfp )) t where t.sfpk='1' and fkqx<= '" + fkqx + "' " +
                "and bz = '" + bz + "' and gysmc = " + gysmc + " and company ='" + gsmc + "' and cgdl='"+cgdl+"' ";
        res.executeSql(sqldt);
        log.writeLog("sqldt----------->" + sqldt);
        while (res.next()) {
            id = Util.null2String(res.getString("id"));
            String sqldt2 = "update uf_payinternal set sfpk = 0 where id =" + id;
            res1.executeSql(sqldt2);
            temp = temp + flag + id;
            flag = ",";

        }
        tempAll = tempAll + flag2 + temp;
        flag2 = ",";
        log.writeLog("gysmc-->" + gysmc + ",syje-->" + syje + "skyhzh-->" + skyhzh + "skyhmc-->" + skyhmc +
                "bz-->" + bz + "fkqx-->" + fkqx);
        JSONObject node = new JSONObject();
        try {
            node.put("YHMC_NPP", skyhmc);//銀行名稱
            node.put("YHZH_NPP", skyhzh);//銀行賬號
            node.put("GYSMC_NPP", gysmc);//供应商名称
            node.put("JHFKJE_NPP", syje);//付款金额
            node.put("fkje", syje);//付款金额
            node.put("SJFKJE_NPP", syje);//付款金额
            node.put("FKQX_NPP", fkqx);//付款期限
            node.put("sffk", "1");//付款期限
            node.put("dpkid", temp);//待排款id(排的是哪笔单子)
            node.put("cgdl", cgdl);//待排款id(排的是哪笔单子)
            dt1.put(node);
        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            log.writeLog("exception----->" + e.getMessage());
        }

        try {
            details.put("DT1", dt1);
        } catch (JSONException e) {
            e.printStackTrace();
            log.writeLog("exception----->" + e.getMessage());
        }

    }
    json.put("HEADER", header);
    json.put("DETAILS", details);
    AutoRequestService as = new AutoRequestService();
    log.writeLog("doServer start json:" + json);
    String creater = String.valueOf(userId);
    result = as.createRequest(workflowid, json.toString(), creater, "1");
    String oaid = "";
    try {
        JSONObject json1 = new JSONObject(result);
        log.writeLog("json1=" + json1);
        oaid = json1.getString("OA_ID");
    } catch (Exception e) {
        e.printStackTrace();
    }
    if (!"".equals(oaid)) {
        String sqldt3 = "insert into uf_flow_payinternal (pklcid,pkzjbid,fkid,fkqx,dfje,sfje,gysmc,company,bz,jeyb,jermb,skyh,skyhzh,sfpk,fph,kprq,lsfk,cgdl) " +
                "select '" + oaid + "',id, fkid,fkqx,dfje,sfje,gysmc,company,bz,jeyb,jermb,skyh,skyhzh,sfpk,fph,kprq,lsfk,cgdl from uf_payinternal where id in(" + tempAll + ")";
        res1.executeSql(sqldt3);
        idkey = "0";
    }
    out.print(idkey);
%>
