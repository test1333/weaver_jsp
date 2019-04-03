<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="static ks.util.WorkflowActionUtil.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="weaver.general.TimeUtil" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<%
    String[] ids;
    String sql;
    String idkey = "1";
    String dtId = Util.null2String(request.getParameter("id"));
    int userId = Util.getIntValue(request.getParameter("userId"));
    dtId += "0";
    ids = dtId.split(",");

    for (String id : ids) {
        if (!"0".equals(id)) {
            String itemNumber = "";
            sql = " select CGSQWLJGK_1,WLBH_1 from gb_bidPurchaseView where dtid= " + id;
            rs.executeSql(sql);
            if (rs.next()) {
                itemNumber = Util.null2String(rs.getString("WLBH_1"));
            }

            // 这是招投标物料，所以要选合同，以下获取合同流程信息
            Map<String, String> contactReqMap = new HashMap<String, String>();
            rs.executeSql("select * from formtable_main_207 where WLBH='" + itemNumber + "'");
            while (rs.next()) {
                //遍历所有字段
                String[] colNames = rs.getColumnName();
                for (String name : colNames) {
                    name = name.toLowerCase();
                    contactReqMap.put(name, Util.null2String(rs.getString(name)));
                }
            }

            /*
             * 获取物料信息map(物料价格库uf_inquiryForm)
             */
            Map<String, String> mainDataMap = new HashMap<String, String>();
            rs.executeSql("select * from uf_inquiryForm where WLBM= '" + itemNumber + "' ");
            while (rs.next()) {
                //遍历所有字段
                String[] colNames = rs.getColumnName();
                for (String name : colNames) {
                    name = name.toLowerCase();
                    mainDataMap.put(name, Util.null2String(rs.getString(name)));
                }
            }

            Map<String, String> flowMap = new HashMap<String, String>();
            // 合同流程数据
            flowMap.put("WLMC", contactReqMap.get("tywljgk"));
//            flowMap.put("WLBM", contactReqMap.get("wlbh"));
//            flowMap.put("GYSBH", contactReqMap.get("gysbh"));
//            flowMap.put("GYSMC", contactReqMap.get("gysmc"));
//            flowMap.put("CGSL", contactReqMap.get("cgsl"));
//            flowMap.put("DJ", contactReqMap.get("cgdj"));
//            flowMap.put("BIZ", contactReqMap.get("htbz"));
//            flowMap.put("HL", contactReqMap.get("hl"));

            // 建模物料价格库数据
            flowMap.put("WLBM", mainDataMap.get("wlbm"));
            flowMap.put("PP", mainDataMap.get("pp"));
            flowMap.put("GG", mainDataMap.get("gg"));
            flowMap.put("XH", mainDataMap.get("xh"));
            flowMap.put("CGSL", mainDataMap.get("sl"));
            flowMap.put("DW", mainDataMap.get("dw"));
            flowMap.put("GYSBH", mainDataMap.get("gysbh"));
            flowMap.put("GYSLXR", mainDataMap.get("gyslxr"));
            flowMap.put("GYSLXDH", mainDataMap.get("gyslxdh"));
            flowMap.put("GYSYX", mainDataMap.get("gysyx"));
            flowMap.put("GYSDZ", mainDataMap.get("gysdz"));
            flowMap.put("GYSMC", mainDataMap.get("gysmc"));
            flowMap.put("DJ", mainDataMap.get("ygdj"));
            flowMap.put("BIZ", mainDataMap.get("bz1"));
            flowMap.put("YT", mainDataMap.get("ytjlb"));
            flowMap.put("YSBZ", mainDataMap.get("ysbz"));
            flowMap.put("HL", mainDataMap.get("hl"));
            String nowDate = TimeUtil.getCurrentDateString(); // 获取当前日期2018-07-13
            String title = "采购订单确认-" + rci.getResourcename(Util.null2String(userId)) + "-" + nowDate;
            out.println("flowMap:" + flowMap.toString());
            String newReq = createRequest(232, userId, title, "0", flowMap);
            if (!"".equals(newReq)) {
                idkey = "0";
            }
        }
    }

    response.sendRedirect("willOrder.jsp?idkey=" + idkey);
%>
