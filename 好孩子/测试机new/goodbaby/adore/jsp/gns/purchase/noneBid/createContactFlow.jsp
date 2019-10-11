<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="static ks.util.WorkflowActionUtil.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.math.BigDecimal" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<%!
    /**
     * 乘法
     *
     * @param a 参数1
     * @param b 参数2
     * @return
     */
    public static String floatMultiply(String a, String b) {
        a = a.equals("") ? "0" : a;
        b = b.equals("") ? "0" : b;
        BigDecimal bg1 = new BigDecimal(a);
        BigDecimal bg2 = new BigDecimal(b);

        BigDecimal bd = bg1.multiply(bg2).setScale(2, BigDecimal.ROUND_HALF_UP);
        return bd.toString();
    }
%>
<%
    BaseBean log = new BaseBean();
    String[] ids;
    String sql;
    String idkey = "1";
    // 流程workflowid
    int workflowid = 289;
    String dtId = Util.null2String(request.getParameter("id"));
    int userId = Util.getIntValue(request.getParameter("userId"));
    dtId += "0";
    ids = dtId.split(",");

    for (String id : ids) {
        if (!"0".equals(id)) {
            String dataId = "";
            String taxMoney = "";
            String rmbMoney = "";
            String amount = "";
            String buydl = "";
            String nppdl = "";
            String ceoDept = "";
            sql = " select * from gb_noneBidPurchaseView where id= " + id;
            rs.executeSql(sql);
            if (rs.next()) {
                dataId = Util.null2String(rs.getString("dataid"));
                taxMoney = Util.null2String(rs.getString("JE_1"));
                rmbMoney = Util.null2String(rs.getString("BBJE_1"));
                amount = Util.null2String(rs.getString("sl"));
                buydl = Util.null2String(rs.getString("buydl"));
                nppdl = Util.null2String(rs.getString("nppdl"));
                ceoDept = Util.null2String(rs.getString("zjlbm"));
            }

            /*
             * 获取物料信息map(物料价格库uf_inquiryForm)
             */
            Map<String, String> mainDataMap = new HashMap<String, String>();
            rs.executeSql("select * from uf_inquiryForm where id= " + dataId + " ");
            while (rs.next()) {
                //遍历所有字段
                String[] colNames = rs.getColumnName();
                for (String name : colNames) {
                    name = name.toLowerCase();
                    mainDataMap.put(name, Util.null2String(rs.getString(name)));
                }
            }

            out.print("mainDataMap:" + mainDataMap);
            Map<String, String> flowMap = new HashMap<String, String>();
            // 建模物料价格库数据
            flowMap.put("TYWLJGK", mainDataMap.get("id")); // 物料信息
            flowMap.put("dtId", id); // PR明细id

            flowMap.put("WLBH", mainDataMap.get("wlbm")); // 物料编码--
            flowMap.put("FKTJ", mainDataMap.get("fkfs")); // 付款条件--
            flowMap.put("HTDF", mainDataMap.get("gysmc")); // 文件接收方/合同对方--
            flowMap.put("HTZJXX", taxMoney); // 合同总价小写--
            flowMap.put("CGSL", amount); // 数量 --
            flowMap.put("GYSBH", mainDataMap.get("gysbh")); // 供应商编号--
            flowMap.put("GYSMC", mainDataMap.get("gysmc")); // 供应商名称--
            flowMap.put("CGDJ", mainDataMap.get("ygdj")); // 单价(含税)--
            flowMap.put("HTBZ", mainDataMap.get("bz1")); // 币种--
            flowMap.put("HL", mainDataMap.get("hl1")); // 汇率--
            String money = floatMultiply(mainDataMap.get("yjjg"), mainDataMap.get("hl1"));
            log.writeLog("money:" + money);
            flowMap.put("BBJE", money); // 本币金额(含税)
            flowMap.put("HTMC", mainDataMap.get("wlmc")); // 合同/项目名称--
            flowMap.put("WLNAME", mainDataMap.get("wlmc")); // 物料名称--
            flowMap.put("taxRate", mainDataMap.get("rate")); // 税率--
            flowMap.put("BBJE", rmbMoney); // 本币金额（含税）--
            flowMap.put("kh", mainDataMap.get("gys")); // 客户--
            flowMap.put("buydl", buydl); // 采购大类--
            flowMap.put("NPPdl", nppdl); // NPP二级分类--
            flowMap.put("contactReq", ""); // 所属合同流程

            String operator = Util.null2String(userId);
            flowMap.put("JBRXM", operator); // 经办人姓名
            flowMap.put("JBRYX", rci.getEmail(operator)); // 经办人邮箱
            flowMap.put("JBRZW", rci.getJobTitle(operator)); // 经办人职务
            flowMap.put("JBRGH", rci.getWorkcode(operator)); // 经办人工号
            flowMap.put("JBRBM", rci.getDepartmentID(operator)); // 经办人部门

            String allDept = "";
            sql = " select departmentwidename from HrmDepartmentwide where id= " + rci.getDepartmentID(operator);
            rs.executeSql(sql);
            if (rs.next()) {
                allDept = Util.null2String(rs.getString("departmentwidename"));
            }
            flowMap.put("BM", allDept); // 部门
            flowMap.put("zjlbm", ceoDept); // 总经理部门

            String nowDate = TimeUtil.getCurrentDateString(); // 获取当前日期2018-07-13
            String workflowname = "";
            sql = " select id,workflowname from workflow_base where id= " + workflowid;
            rs.executeSql(sql);
            if (rs.next()) {
                workflowname = Util.null2String(rs.getString("workflowname"));
            }
            workflowname = Util.processBody(workflowname, "7");
            String title = workflowname + "-" + rci.getResourcename(Util.null2String(userId)) + "-" + nowDate;
            log.writeLog("flowMap:" + flowMap.toString());
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

    response.sendRedirect("willContact.jsp?idkey=" + idkey);
%>
