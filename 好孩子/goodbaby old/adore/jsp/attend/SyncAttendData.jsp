<%@page language="java" contentType="text/html; charset=GBK" %>
<%@page import="weaver.general.Util" %>
<%@page import="ks.util.TmcUtil" %>
<%@page import="weaver.conn.RecordSetDataSource" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@ page import="weaver.formmode.setup.ModeRightInfo" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>

<%
    String attendDay = Util.null2String(request.getParameter("attendDay"));
    RecordSetDataSource rsds = new RecordSetDataSource("HR_Attend");
    String sql_attend = " select EmpID,convert(varchar(20),Time,23) attendDate,convert(varchar(5),Time,24) attendTime "
            + " from atd_CardPunch_Origin where convert(varchar(20),Time,23)= '" + attendDay + "' ";
    // log.writeLog("sql_attend=" + sql_attend);
    rsds.executeSql(sql_attend);
    TmcUtil tmcUtil = new TmcUtil();
    boolean flag;
    while (rsds.next()) {
        String workcode = Util.null2String(rsds.getString("EmpID"));
        String attendDate = Util.null2String(rsds.getString("attendDate"));
        String attendTime = Util.null2String(rsds.getString("attendTime"));
        String sql_emp = " select id from HrmResource where workcode= '" + workcode + "' ";
        res.executeSql(sql_emp);
        String empid = "";
        if (res.next()) {
            empid = Util.null2String(res.getString("id"));
        }

        if (!"".equals(empid)) {
            Map<String, String> mapStr = new HashMap<String, String>();
            Map<String, String> whereMap = new HashMap<String, String>();
            mapStr.put("name", empid);
            mapStr.put("workcode", workcode);
            mapStr.put("attendDate", attendDate);
            mapStr.put("attendTime", attendTime);
            mapStr.put("type", "0");
            mapStr.put("valid", "0");
            mapStr.put("formmodeid", "9");
            mapStr.put("modedatacreater", "1");

            whereMap.put("name", empid);
            whereMap.put("workcode", workcode);
            whereMap.put("attendDate", attendDate);
            whereMap.put("attendTime", attendTime);
            flag = tmcUtil.saveOrUpdate("uf_AttendRecord", mapStr, whereMap);
            // out.println("flag=" + flag);
            if (flag) {
                String sql = "select max(id) as mid from uf_AttendRecord where name =" + empid + " and "
                        + " workcode='" + workcode + "' and  attendDate='" + attendDate + "' and attendTime='" + attendTime + "' ";
                // log.writeLog("SQL------" + sql);
                rs.executeSql(sql);
                if (rs.next()) {
                    String mid = Util.null2String(rs.getString("mid"));
                    // log.writeLog("mid------" + mid);
                    if (mid.length() > 0) {
                        // 表单建模数据权限重构
                        ModeRightInfo modeRightInfo = new ModeRightInfo();
                        modeRightInfo.editModeDataShare(1, 9, Integer.parseInt(mid));
                        modeRightInfo.editModeDataShareForModeField(1, 9, Integer.parseInt(mid));
                    } else {
                        log.writeLog("未找到匹配数据");
                    }
                }
            }
        }
    }

    String sql_mobile = " select operater,operate_date,operate_time from mobile_sign "
            + " where operate_date='" + attendDay + "' ";
    rs.executeSql(sql_mobile);
    while (rs.next()) {
        String empid = Util.null2String(rs.getString("operater"));
        String attendDate = Util.null2String(rs.getString("operate_date"));
        String attendTime = Util.null2String(rs.getString("operate_time"));
        String sql_emp = " select workcode from HrmResource where id= " + empid;
        res.executeSql(sql_emp);
        String workcode = "";
        if (res.next()) {
            workcode = Util.null2String(res.getString("workcode"));
        }

        Map<String, String> mapStr = new HashMap<String, String>();
        Map<String, String> whereMap = new HashMap<String, String>();
        mapStr.put("name", empid);
        mapStr.put("workcode", workcode);
        mapStr.put("attendDate", attendDate);
        mapStr.put("attendTime", attendTime);
        mapStr.put("type", "1");
        mapStr.put("valid", "0");
        mapStr.put("formmodeid", "9");
        mapStr.put("modedatacreater", "1");

        whereMap.put("name", empid);
        whereMap.put("workcode", workcode);
        whereMap.put("attendDate", attendDate);
        whereMap.put("attendTime", attendTime);
        flag = tmcUtil.saveOrUpdate("uf_AttendRecord", mapStr, whereMap);
        if (flag) {
            String sql = "select max(id) as mid from uf_AttendRecord where name =" + empid + " and "
                    + " workcode='" + workcode + "' and  attendDate='" + attendDate + "' and attendTime='" + attendTime + "' ";
            log.writeLog("SQL------" + sql);
            rs.executeSql(sql);
            if (rs.next()) {
                String mid = Util.null2String(rs.getString("mid"));
                // log.writeLog("mid------" + mid);
                if (mid.length() > 0) {
                    // 表单建模数据权限重构
                    ModeRightInfo modeRightInfo = new ModeRightInfo();
                    modeRightInfo.editModeDataShare(1, 9, Integer.parseInt(mid));
                    modeRightInfo.editModeDataShareForModeField(1, 9, Integer.parseInt(mid));
                } else {
                    log.writeLog("未找到匹配数据");
                }
            }
        }
        // out.print("flag=" + flag);
    }
%>

