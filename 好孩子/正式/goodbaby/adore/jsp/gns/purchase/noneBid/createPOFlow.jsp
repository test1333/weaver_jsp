<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="static ks.util.WorkflowActionUtil.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>
<%
    String[] ids;
    String sql;
    String idkey = "1";
    // 流程id
    int workflowid = 290;
    String dtId = Util.null2String(request.getParameter("id"));
    int userId = Util.getIntValue(request.getParameter("userId"));
    String dept = rci.getDepartmentID(Util.null2String(userId));
    dtId += "0";
    ids = dtId.split(",");

    for (String id : ids) {
        if (!"0".equals(id)) {
            String mainId = "";
            String contactReq = "";
            String payment = "";
            String paymentRemark = "";
            sql = " select * from gb_noneFrameworkContactFlow where id= " + id;
            rs.executeSql(sql);
            if (rs.next()) {
                mainId = Util.null2String(rs.getString("dtId"));
                contactReq = Util.null2String(rs.getString("contactReq"));
                payment = Util.null2String(rs.getString("fkje"));
                paymentRemark = Util.null2String(rs.getString("fkbfb"));
            }
            String dataid = "";
            String itemNum = "";
            String material = "";
            String needDate = ""; // 交货日期
            String costCenter = ""; // 成本中心
            // String poAmount = Util.null2String(request.getParameter("poAmount" + id));
            String poAmount = "";
            sql = " select * from gb_noneBidPurchaseView where id= " + mainId;
            rs.executeSql(sql);
            if (rs.next()) {
                dataid = Util.null2String(rs.getString("dataid"));
                itemNum = Util.null2String(rs.getString("WLBM"));
                needDate = Util.null2String(rs.getString("needDate"));
                poAmount = Util.null2String(rs.getString("sl"));
                costCenter = Util.null2String(rs.getString("cbzx"));
            }

            rs.executeSql("select id from uf_materialDatas where WLBM= '" + itemNum + "' ");
            if (rs.next()) {
                material = Util.null2String(rs.getString("id"));
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

            Map<String, String> flowMap = new HashMap<String, String>();
            // 建模物料价格库数据
            flowMap.put("wlxx", mainDataMap.get("id")); // 物料信息
            flowMap.put("WLMC", material); // 物料名称
            flowMap.put("WLLX", mainDataMap.get("gysbh")); // 物料类型
            flowMap.put("WLBM", mainDataMap.get("wlbm"));
            flowMap.put("PP", mainDataMap.get("pp"));
            flowMap.put("GG", mainDataMap.get("gg"));
            flowMap.put("XH", mainDataMap.get("xh"));
            flowMap.put("CGSL", mainDataMap.get("sl"));
            // flowMap.put("CGSL", poAmount);
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
            flowMap.put("HL", mainDataMap.get("hl1"));
            flowMap.put("taxRate", mainDataMap.get("rate"));
            flowMap.put("xtkh", mainDataMap.get("gys"));
            flowMap.put("cbzx", costCenter); // 成本中心
            flowMap.put("HJYBJE",mainDataMap.get("yjjg")); // 合计金额含税

            flowMap.put("SQRXX", Util.null2String(userId)); // 申请人信息
            flowMap.put("SQDW", dept); // 申请单位
            flowMap.put("YQJHRQ", needDate); // 要求交货日期

            flowMap.put("dtId", mainId); // PR明细id
            flowMap.put("contactReq", contactReq); // 所属合同流程
            flowMap.put("contactDtId", id); // 付款条件id
            flowMap.put("htfksm", paymentRemark); // 付款说明
            flowMap.put("bcfkje", payment); // 付款金额
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
    // out.print(idkey);
    response.sendRedirect("willOrder.jsp?idkey=" + idkey);
%>
