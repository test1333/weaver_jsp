<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

String departmentid="";
String workcode="";
String subcompanyid1="";
String sql="";
int num_cc = 0;
int userid = user.getUID();

    String ids[] = request.getParameterValues("ids");
    for(int i=0;i<ids.length;i++){
        String empid = ids[i].toString();
        //out.println("empid="+empid);
        String amBeginTime_tmp = request.getParameter("amBeginTime"+empid);
        String amAttendTime_tmp = request.getParameter("amAttendTime"+empid);
        String amEndTimes_tmp = request.getParameter("amEndTime"+empid);
        String pmBeginTime_tmp = request.getParameter("pmBeginTime"+empid);
        String pmEndTime_tmp = request.getParameter("pmEndTime"+empid);
        String pmAttendTime_tmp = request.getParameter("pmAttendTime"+empid);
        if(!"".equals(amBeginTime_tmp)||!"".equals(amEndTimes_tmp)||!"".equals(pmBeginTime_tmp)||!"".equals(pmEndTime_tmp)||!"".equals(amAttendTime_tmp)||!"".equals(pmAttendTime_tmp)){
            String sql_hr = " select workcode,departmentid,subcompanyid1 from HrmResource where id= "+empid;
            res.executeSql(sql_hr);
            if(res.next()){
                workcode = Util.null2String(res.getString("workcode"));
                departmentid = Util.null2String(res.getString("departmentid"));
                subcompanyid1 = Util.null2String(res.getString("subcompanyid1"));
            }
            sql =" select count(*) as num_cc from sh_work_all_atten_info where isActive = 0 and EmployeeName = "+empid+" ";
            res.executeSql(sql);
            if(res.next()){
                num_cc = res.getInt("num_cc");
                out.println("num_cc="+num_cc);
            }
            if(num_cc < 1){
                    sql = " update uf_Scheduling_table set isActive =1,modedatacreatedate = CONVERT(varchar(10) ,GETDATE(), 23 ),"
                    +" modedatacreatetime = CONVERT(varchar(5) ,GETDATE(), 114 ),modedatacreater="+userid+" where EmployeeName= "+empid+" and isActive =0 ";
                rs.executeSql(sql);
                //out.println("sqlupdate___________="+sql);
                //new BaseBean().writeLog("sqlupdate___________"+sql);
                
                sql = " insert into uf_Scheduling_table(EmployeeName,AmBeginTime,AmEndTime,PmBeginTime,PmEndTime,EffectiveStartDate,EffectiveEndDate,formmodeid,Workcode,department,subcompany,modedatacreatedate,modedatacreatetime,isActive,modedatacreater) values ("+empid+",'"+amBeginTime_tmp+"','"+amEndTimes_tmp+"','"+pmBeginTime_tmp+"','"+pmEndTime_tmp+"','"+effeStartDate_tmp+"','"+effeEndDate_tmp+"',2,'"+workcode+"','"+departmentid+"','"+subcompanyid1+"',CONVERT(varchar(10) ,GETDATE(), 23 ),CONVERT(varchar(5) ,GETDATE(), 114 ),0,"+userid+") ";
            }

                res.executeSql(sql);
                //out.println("sql="+sql);
                //new BaseBean().writeLog("sqlinsert___________"+sql);
            //}
            sql = " select id from uf_Scheduling_table where EmployeeName ="+empid;
            rs.executeSql(sql);
            while(rs.next()){
                String sourceid = Util.null2String(rs.getString("id"));
                res.executeSql(" exec sh_scheduling_right @sourceid ="+sourceid);
            }
        }
    }
    response.sendRedirect("ScheduleManagementEdit.jsp");
%>


