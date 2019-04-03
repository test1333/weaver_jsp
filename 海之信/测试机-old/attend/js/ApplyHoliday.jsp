<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
    StringBuffer json = new StringBuffer();
    String empid = request.getParameter("sqr");//申请人
    String holiday = request.getParameter("holiday");//申请假期
    String name="";

    String sql = "";
    if (!"".equals(empid)) {
        sql=" select lastname from HrmResource where id= "+empid;
        rs.executeSql(sql);
        //log.writeLog("log.sql---------" + sql);
        if(rs.next()) {
            name = Util.null2String(rs.getString("lastname"));
        }
        
        sql=" select count(*) as num_cc from uf_apply_holiday where  applyholiday="+holiday+" and applyuser="+empid+" ";
        rs.executeSql(sql);
        if(rs.next()) {
            int num_cc = rs.getInt("num_cc");
            if (num_cc>0){
                
                sql = " select (select holiname from uf_holiday_table where id="+holiday+") as applyholi,"
                    +" startdate,enddate from uf_apply_holiday where applyuser="+empid+" and applyholiday="+holiday+" ";
                res.executeSql(sql);
                //log.writeLog("log.sql---------" + sql);
                while(res.next()) {
                    json.append("<span >");
                    json.append("[");
                    json.append(name).append("]").append("已经申请了");
                    String startdate = Util.null2String(res.getString("startdate"));
                    String enddate = Util.null2String(res.getString("enddate"));
                    String applyholi = Util.null2String(res.getString("applyholi"));
                    json.append(startdate).append("至").append(enddate).append("的").append("[").append(applyholi).append("]").append("</span><br/>");
                }    
            }
        }
    }
        out.println(json.toString());
%>