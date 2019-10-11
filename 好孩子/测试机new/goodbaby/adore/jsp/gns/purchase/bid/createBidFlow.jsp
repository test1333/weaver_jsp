<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="static ks.util.WorkflowActionUtil.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<%
    String[] ids;
    String sql;
    String idkey = "1";
    // 流程id
    int workflowid = 296;
    String dtId = Util.null2String(request.getParameter("id"));
    int userId = Util.getIntValue(request.getParameter("userId"));
    dtId += "0";
    ids = dtId.split(",");

    for (String id : ids) {
        if (!"0".equals(id)) {
            String dataid = "";
            String amount = "";
            String ceoDept = "";
            sql = " select * from gb_bidPurchaseView where id= " + id;
            rs.executeSql(sql);
            if (rs.next()) {
                dataid = Util.null2String(rs.getString("dataid"));
                amount = Util.null2String(rs.getString("sl"));
                ceoDept = Util.null2String(rs.getString("zjlbm"));
            }

            /*
             * 获取物料信息map(物料价格库uf_inquiryForm)
             */
            Map<String, String> mainDataMap = new HashMap<String, String>();
            rs.executeSql("select * from uf_inquiryForm where id= " + dataid);
            while (rs.next()) {
                //遍历所有字段
                String[] colNames = rs.getColumnName();
                for (String name : colNames) {
                    name = name.toLowerCase();
                    mainDataMap.put(name, Util.null2String(rs.getString(name)));
                }
            }

            String operator = Util.null2String(userId);
            Map<String, String> flowMap = new HashMap<String, String>();

            // 建模物料价格库数据
            flowMap.put("jgkxx", mainDataMap.get("id")); // 价格库物料信息
            flowMap.put("WLBM", mainDataMap.get("wlbm")); // 物料编码
            flowMap.put("PP", mainDataMap.get("pp")); // 品牌
            flowMap.put("GG", mainDataMap.get("gg")); // 规格
            flowMap.put("XH", mainDataMap.get("xh")); // 型号
            flowMap.put("WLLX", mainDataMap.get("wllx1")); // 物料类型
            flowMap.put("DW", mainDataMap.get("dw")); // 单位
            flowMap.put("SL", amount); // 数量
            flowMap.put("CGY", operator); // 采购员
            flowMap.put("YT", mainDataMap.get("ytjlb")); // 用途
            flowMap.put("YSBZ", mainDataMap.get("ysbz")); // 验收标准
            flowMap.put("zjlbm", ceoDept); // 总经理部门

            flowMap.put("dtId", id);
            String nowDate = TimeUtil.getCurrentDateString(); // 获取当前日期2018-07-13
            String workflowname = "";
            sql = " select id,workflowname from workflow_base where id= " + workflowid;
            rs.executeSql(sql);
            if (rs.next()) {
                workflowname = Util.null2String(rs.getString("workflowname"));
            }
            workflowname = Util.processBody(workflowname, "7");
            String title = workflowname + "-" + rci.getResourcename(Util.null2String(userId)) + "-" + nowDate;
            log.writeLog("flowMap1:" + flowMap.toString());
            // 判断数据是否为空，如果为空就不传，防止字段为数字型时，Update语句出错，导致流程看不到
            Set<Map.Entry<String, String>> keySet = flowMap.entrySet();
            Iterator<Map.Entry<String, String>> iterator = keySet.iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, String> entry = iterator.next();
                // String name = entry.getKey();
                String value = entry.getValue();
                if ("".equals(value)) {
                    //特别注意：不能使用map.remove(name)  否则会报同样的错误
                    iterator.remove();
                }
            }
            log.writeLog("flowMap2:" + flowMap.toString());
            String newReq = createRequest(workflowid, userId, title, "0", flowMap);
            log.writeLog("requestid:" + newReq);
            if (!"".equals(newReq)) {
                idkey = "0";
            }
        }
    }

    response.sendRedirect("willBid.jsp?idkey=" + idkey);
%>
