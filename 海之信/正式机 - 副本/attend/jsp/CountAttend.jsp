<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%!
//获取当前日期
public String getNowDate(){   
    String temp_str="";   
    Date dt = new Date();   
    //最后的aa表示“上午”或“下午”    HH表示24小时制    如果换成hh表示12小时制   
    //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss aa");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");     
    temp_str=sdf.format(dt);
    //temp_str = "2015-11-10";  
    return temp_str;   
} 
%>
<%
    String sql = "";
    String dateToday = getNowDate();
    out.print("dateToday="+dateToday);
    if(!"".equals(dateToday)){
        sql = " exec sh_atten_info_clear_up @atten_day1 ='"+dateToday+"' ";
        rs.executeSql(sql);
        //out.println("sql="+sql);
    }
    response.sendRedirect("/seahonor/attend/jsp/SH_attend_all_info.jsp");
%>


