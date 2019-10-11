<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="static ks.util.WorkflowActionUtil.createRequest" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="weaver.general.TimeUtil" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<%
    String result = "";
    String[] ids;
    String sql;
    String dtId = Util.null2String(request.getParameter("id"));
    int userId = Util.getIntValue(request.getParameter("userId"));
    dtId += "0";
    ids = dtId.split(",");

    for (String id : ids) {
        String modeId = "";
        sql = " select CGSQWLJGK_1,WLBH_1 from gb_bidPurchaseView where dtid= " + id;
        rs.executeSql(sql);
        if (rs.next()) {
            modeId = Util.null2String(rs.getString("CGSQWLJGK_1"));
        }

        /*
         * 获取物料信息map
         */
        Map<String, String> mainDataMap = new HashMap<String, String>();
        rs.executeSql("select * from uf_materialDatas where id=" + modeId);
        while (rs.next()) {
            //遍历所有字段
            String[] colNames = rs.getColumnName();
            for (String name : colNames) {
                name = name.toLowerCase();
                mainDataMap.put(name, Util.null2String(rs.getString(name)));
            }
        }
        String nowDate = TimeUtil.getCurrentDateString(); // 获取当前日期2018-07-13
        String title = "采购订单确认-" + rci.getResourcename(Util.null2String(userId)) + "-" + nowDate;
        createRequest(0, userId, title, "0", mainDataMap);
    }
    out.print(result);
%>
