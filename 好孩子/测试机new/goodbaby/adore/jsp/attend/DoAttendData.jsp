<%@page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="weaver.general.Util" %>
<%@page import="ks.util.TmcUtil" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="weaver.formmode.setup.ModeRightInfo" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>
<%!
    public static String getMDiff(String endDate, String nowDate) throws Exception {
        long nm = 1000 * 60;
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");//设置日期格式
        Date d1 = df.parse("2018-01-01 " + endDate);
        Date d2 = df.parse("2018-01-01 " + nowDate);
        // 获得两个时间的毫秒时间差异
        long diff = d1.getTime() - d2.getTime();
        // 计算差多少分钟
        long min = diff / nm;
        return min + "";
    }
%>
<%
    String attendDay = Util.null2String(request.getParameter("attendDay"));
    String sql_attend = " select name,workcode,attendDate,min(attendTime) attendTime1,max(attendTime) attendTime2 "
            + " from uf_AttendRecord where attendDate='" + attendDay + "' group by name,workcode,attendDate ";
    out.println("sql_attend=" + sql_attend);
    rs.executeSql(sql_attend);
    TmcUtil tmcUtil = new TmcUtil();
    boolean flag = false;
    while (rs.next()) {
        String empid = Util.null2String(rs.getString("name"));
        String workcode = Util.null2String(rs.getString("workcode"));
        String attendDate = Util.null2String(rs.getString("attendDate"));
        String attendTime1 = Util.null2String(rs.getString("attendTime1"));
        String attendTime2 = Util.null2String(rs.getString("attendTime2"));
        Map<String, String> mapStr = new HashMap<String, String>();
        Map<String, String> whereMap = new HashMap<String, String>();
        mapStr.put("name", empid);
        mapStr.put("workcode", workcode);
        mapStr.put("attendDate", attendDate);
        mapStr.put("valid", "0");
        mapStr.put("formmodeid", "12");
        mapStr.put("modedatacreater", "1");

        // 判断是否需要打卡
        boolean isNeed = false;
        // 判断是否动态打开
        boolean isDyna = false;
        // 判断直接是否为经理级9以上
        boolean isManager = false;
        String sql_isManager = " select joblevel from HrmResource where id= " + empid;
        res.executeSql(sql_isManager);
        if (res.next()) {
            int joblevel = res.getInt("joblevel");
            if (joblevel >= 9) {
                isManager = true;
            }
        }
        // 判断是否在排除表中
        String sql_noneed = " select count(id) isNeed from uf_NoNeedAttend where emp_id=" + empid + " and "
                + "start_date>='" + attendDay + "' ";
        res.executeSql(sql_noneed);
        if (res.next()) {
            int count = res.getInt("isNeed");
            if (count == 0) {
                isNeed = true;
            }
        }
        // true表示需要打卡
        if (isNeed) {
            // 先判断是否动态打卡
            String sql_dyna = " select count(id) isDyna from uf_DynamicAttend where (type=0 and name=" + empid + ") "
                    + " or( type=1 and dept=(select departmentid from HrmResource where id=" + empid + ")) ";
            res.executeSql(sql_dyna);
            if (res.next()) {
                int count = res.getInt("isDyna");
                if (count == 0) {
                    isDyna = true;
                }
            }

            // true表示未采用动态打卡，上下班时间为08:00~16:30
            if (isDyna) {
                mapStr.put("beginTime", "08:00");
                mapStr.put("beginCardTime", attendTime1);
                mapStr.put("endTime", "16:30");
                mapStr.put("endCardTime", attendTime2);
                mapStr.put("isDyna", "1");
                //判断是否经理级以上
                if (isManager) {
                    String lateTime = getMDiff(attendTime1, "08:30");
                    String earlyLeave = getMDiff("16:00", attendTime2);
                    if (Integer.valueOf(lateTime) <= 0) {
                        mapStr.put("lateTime", "0");
                        if (Integer.valueOf(earlyLeave) <= 0) {
                            mapStr.put("earlyLeaveTime", "0");
                            mapStr.put("normal", "0");
                        } else {
                            mapStr.put("earlyLeaveTime", earlyLeave);
                            mapStr.put("normal", "1");
                        }
                    } else {
                        mapStr.put("lateTime", lateTime);
                        if (Integer.valueOf(earlyLeave) <= 0) {
                            mapStr.put("earlyLeaveTime", "0");
                        } else {
                            mapStr.put("earlyLeaveTime", earlyLeave);
                        }
                        mapStr.put("normal", "1");
                    }
                } else {
                    // 经理级以下，没有缓冲
                    String lateTime = getMDiff(attendTime1, "08:00");
                    String earlyLeave = getMDiff("16:30", attendTime2);
                    if (Integer.valueOf(lateTime) <= 0) {
                        mapStr.put("lateTime", "0");
                        if (Integer.valueOf(earlyLeave) <= 0) {
                            mapStr.put("earlyLeaveTime", "0");
                            mapStr.put("normal", "0");
                        } else {
                            mapStr.put("earlyLeaveTime", earlyLeave);
                            mapStr.put("normal", "1");
                        }
                    } else {
                        mapStr.put("lateTime", lateTime);
                        if (Integer.valueOf(earlyLeave) <= 0) {
                            mapStr.put("earlyLeaveTime", "0");
                        } else {
                            mapStr.put("earlyLeaveTime", earlyLeave);
                        }
                        mapStr.put("normal", "1");
                    }
                }
            } else {
                // false 表示采用动态打卡
                mapStr.put("isDyna", "0");
                //判断是否经理级以上
                if (isManager) {
                    String lateTime1 = getMDiff(attendTime1, "08:30");
                    if (Integer.valueOf(lateTime1) <= 0) {
                        mapStr.put("beginTime", "08:00");
                        mapStr.put("beginCardTime", attendTime1);
                        mapStr.put("endTime", "16:30");
                        mapStr.put("endCardTime", attendTime2);
                        mapStr.put("lateTime", "0");
                        String earlyLeave = getMDiff("16:00", attendTime2);
                        if (Integer.valueOf(earlyLeave) <= 0) {
                            mapStr.put("earlyLeaveTime", "0");
                            mapStr.put("normal", "0");
                        } else {
                            mapStr.put("earlyLeaveTime", earlyLeave);
                            mapStr.put("normal", "1");
                        }
                    } else {
                        String lateTime2 = getMDiff(attendTime1, "09:30");
                        String earlyLeave = getMDiff("17:00", attendTime2);
                        if (Integer.valueOf(lateTime2) <= 0) {
                            mapStr.put("lateTime", "0");
                            mapStr.put("beginTime", "09:00");
                            mapStr.put("beginCardTime", attendTime1);
                            mapStr.put("endTime", "17:30");
                            mapStr.put("endCardTime", attendTime2);
                            if (Integer.valueOf(earlyLeave) <= 0) {
                                mapStr.put("earlyLeaveTime", "0");
                                mapStr.put("normal", "0");
                            } else {
                                mapStr.put("earlyLeaveTime", earlyLeave);
                                mapStr.put("normal", "1");
                            }
                        } else {
                            mapStr.put("beginTime", "08:00");
                            mapStr.put("beginCardTime", attendTime1);
                            mapStr.put("endTime", "16:30");
                            mapStr.put("endCardTime", attendTime2);
                            mapStr.put("lateTime", lateTime2);
                            if (Integer.valueOf(earlyLeave) <= 0) {
                                mapStr.put("earlyLeaveTime", "0");
                            } else {
                                mapStr.put("earlyLeaveTime", earlyLeave);
                            }
                            mapStr.put("normal", "1");
                        }
                    }
                } else {
                    String lateTime1 = getMDiff(attendTime1, "08:00");
                    if (Integer.valueOf(lateTime1) <= 0) {
                        mapStr.put("beginTime", "08:00");
                        mapStr.put("beginCardTime", attendTime1);
                        mapStr.put("endTime", "16:30");
                        mapStr.put("endCardTime", attendTime2);
                        mapStr.put("lateTime", "0");
                        String earlyLeave = getMDiff("16:30", attendTime2);
                        if (Integer.valueOf(earlyLeave) <= 0) {
                            mapStr.put("earlyLeaveTime", "0");
                            mapStr.put("normal", "0");
                        } else {
                            mapStr.put("earlyLeaveTime", earlyLeave);
                            mapStr.put("normal", "1");
                        }
                    } else {
                        String lateTime2 = getMDiff(attendTime1, "09:00");
                        String earlyLeave = getMDiff("17:30", attendTime2);
                        if (Integer.valueOf(lateTime2) <= 0) {
                            mapStr.put("beginTime", "09:00");
                            mapStr.put("beginCardTime", attendTime1);
                            mapStr.put("endTime", "17:30");
                            mapStr.put("endCardTime", attendTime2);
                            mapStr.put("lateTime", "0");
                            if (Integer.valueOf(earlyLeave) <= 0) {
                                mapStr.put("earlyLeaveTime", "0");
                                mapStr.put("normal", "0");
                            } else {
                                mapStr.put("earlyLeaveTime", earlyLeave);
                                mapStr.put("normal", "1");
                            }
                        } else {
                            mapStr.put("beginTime", "08:00");
                            mapStr.put("beginCardTime", attendTime1);
                            mapStr.put("endTime", "16:30");
                            mapStr.put("endCardTime", attendTime2);
                            mapStr.put("lateTime", lateTime2);
                            if (Integer.valueOf(earlyLeave) <= 0) {
                                mapStr.put("earlyLeaveTime", "0");
                            } else {
                                mapStr.put("earlyLeaveTime", earlyLeave);
                            }
                            mapStr.put("normal", "1");
                        }
                    }
                }
            }
            whereMap.put("name", empid);
            whereMap.put("workcode", workcode);
            whereMap.put("attendDate", attendDate);
            flag = tmcUtil.saveOrUpdate("uf_Attend", mapStr, whereMap);
            out.println("flag=" + flag);
            if (flag) {
                String sql = "select max(id) as mid from uf_Attend where name =" + empid + " and "
                        + " workcode='" + workcode + "' and  attendDate='" + attendDate + "' ";
                // log.writeLog("SQL------" + sql);
                res.executeSql(sql);
                if (res.next()) {
                    String mid = Util.null2String(res.getString("mid"));
                    // log.writeLog("mid------" + mid);
                    if (mid.length() > 0) {
                        // 表单建模数据权限重构
                        ModeRightInfo modeRightInfo = new ModeRightInfo();
                        modeRightInfo.editModeDataShare(1, 12, Integer.parseInt(mid));
                        modeRightInfo.editModeDataShareForModeField(1, 12, Integer.parseInt(mid));
                    } else {
                        log.writeLog("未找到匹配数据");
                    }
                }
            } else {
                out.println(mapStr.toString());
            }
        } else {
            // false 不需要打卡，循环继续
            continue;
        }
    }
%>

