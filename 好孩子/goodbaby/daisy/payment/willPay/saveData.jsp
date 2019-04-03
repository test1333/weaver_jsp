<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="goodbaby.order.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="ks.util.TmcUtil" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>
<%
    String[] ids;
    String sql = "";
    String idkey = "1";
    String dtId = Util.null2String(request.getParameter("ids"));//流程明细id
    String requestid = Util.null2String(request.getParameter("requestid"));//排款流程id

    ids = dtId.split(",");
    boolean result = true;
    String nowDate = TimeUtil.getCurrentDateString(); // 获取当前日期2018-07-13

    for (String id : ids) {
        if (!"0".equals(id)) {
            String sffk = Util.null2String(request.getParameter("sffk" + id));
            String sjfkje = Util.null2String(request.getParameter("sjfkje" + id));
            String pkid = Util.null2String(request.getParameter("pkids" + id));
            String fkqx = Util.null2String(request.getParameter("fkqx" + id));
            String jhfkje = Util.null2String(request.getParameter("jhfkje" + id));
            String gysmc = Util.null2String(request.getParameter("gysmc" + id));
            String khh = Util.null2String(request.getParameter("khh" + id));
            String lhh = Util.null2String(request.getParameter("lhh" + id));
            String jgh = Util.null2String(request.getParameter("jgh" + id));
            String CNAPS = Util.null2String(request.getParameter("CNAPS" + id));
            String ZHSK = Util.null2String(request.getParameter("ZHSK" + id));
            String yhzh = Util.null2String(request.getParameter("yhzh" + id));
            log.writeLog("sffk-->" + sffk + "sjfkje-->" + sjfkje + "pkid-->" + pkid + "jhfkje-->" + jhfkje
                    + "gysmc-->" + gysmc + "khh-->" + khh + "lhh-->" + lhh + "jgh-->" + jgh + "CNAPS-->" + CNAPS
                    + "ZHSK-->" + ZHSK + "yhzh-->" + yhzh);
            if("1".equals(sffk)){
                sql = "update uf_payinternal set sfpk = '1' where id in (" + pkid + ")";
                rs.executeSql(sql);
            }
            sql = "update formtable_main_205_dt1 set sffk = '0' where id = " + id;
            rs.executeSql(sql);
            log.writeLog("sql-->" + sql);
            sql = "select cgdl from formtable_main_205_dt1 where id = " + id;
            rs.executeSql(sql);
            String cgdl = "";
            if(rs.next()){
                cgdl = Util.null2String(rs.getString("cgdl"));
            }
            if ("0".equals(sffk)) {
                Map map = new HashMap();
                map.put("GYS",gysmc);
                map.put("yfkmxid",id);
                map.put("cnqr","0");
                map.put("flag","0");
                map.put("BCSF",sjfkje);
                map.put("BCYF",jhfkje);
                map.put("pklcid",requestid);

                map.put("KHH",khh);
                map.put("LHH",lhh);
                map.put("JGH",jgh);
                map.put("CNAPS",CNAPS);
                map.put("ZHSK",ZHSK);
                map.put("YHZH",yhzh);
                map.put("cgdl",cgdl);
                TmcUtil tu = new TmcUtil();
                result = tu.insert("uf_fkzjb",map);
            }

        }
    }

    if (!"".equals(requestid)) {
        idkey = "0";
    }
    out.print(idkey);
%>
