<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ page import="weaver.mobile.sign.MobileSign"%>
<jsp:useBean id="signIn" class="weaver.hrm.mobile.signin.SignInManager" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>

<%!
    //设备考勤时间计算
	public String[] getEmpInfo(String emp_id){
	    RecordSet rs = new RecordSet();
	    BaseBean log = new BaseBean();
	    String[] arr = new String[8];//排班情况

	    String amBeginTime = "";
	    String amEndTime = "";
	    String pmBeginTime = "";
	    String pmEndTime = "";
	    String amAttendTime = "";
	    String pmAttendTime = "";
	    String latetime = "";
	    String earlyleavetime = "";

	    String sql = " select AmBeginTime,AmEndTime,PmBeginTime,PmEndTime "
	                +" from uf_Scheduling_table where isActive = 0 and EmployeeName =  "+emp_id;
	    rs.executeSql(sql);
	    //log.writeLog("sql___________" + sql);
	    if(rs.next()){
	        amBeginTime = Util.null2String(rs.getString("AmBeginTime"));
	        amEndTime = Util.null2String(rs.getString("AmEndTime"));
	        pmBeginTime = Util.null2String(rs.getString("PmBeginTime"));
	        pmEndTime = Util.null2String(rs.getString("PmEndTime"));

	    }

	    String sql_attend = " select * from dbo.sh_attend_count("+emp_id+",'"+amBeginTime+"','"+pmEndTime+"') ";
	    rs.executeSql(sql_attend);

	    if(rs.next()){
	        amAttendTime = Util.null2String(rs.getString("amattendtime"));
	        pmAttendTime = Util.null2String(rs.getString("pmattendtime"));
	        latetime = Util.null2String(rs.getString("latetime"));
	        earlyleavetime = Util.null2String(rs.getString("earlyleavetime"));

	    }
	        for(int i=0;i<arr.length;i++){
	            arr[0] = amBeginTime;//上午开始时间
	            arr[1] = amEndTime;//上午结束时间
	            arr[2] = pmBeginTime;//下午开始时间
	            arr[3] = pmEndTime;//下午结束时间
	            arr[4] = amAttendTime;//上班打卡时间
	            arr[5] = pmAttendTime;//下班打卡时间
	            arr[6] = latetime;//迟到
	            arr[7] = earlyleavetime;//早退
	        }

		return arr;
	}
%>

<%!
    //移动考勤时间计算
	public String[] getOutInfo(String emp_id,String out_date){
	    RecordSet rs = new RecordSet();
	    BaseBean log = new BaseBean();
	    String[] arr = new String[6];//排班情况

	    String amBeginTime = "";
	    String pmEndTime = "";
	    String amAttendTime = "";
	    String pmAttendTime = "";
	    String latetime = "";
	    String earlyleavetime = "";

	    String sql = " select min(ReplaceStartTime),max(ReplaceEndTime) from uf_Replace_table where EmployeeName =  "+emp_id+" "
	                +" and ReplaceStartDate = '"+out_date+"' ";
	    rs.executeSql(sql);
	    //log.writeLog("sql___________" + sql);
	    if(rs.next()){
	        amBeginTime = Util.null2String(rs.getString("ReplaceStartTime"));
	        pmEndTime = Util.null2String(rs.getString("ReplaceEndTime"));

	    }

	    String sql_attend = " select * from dbo.sh_out_attend_count("+emp_id+",'"+amBeginTime+"','"+pmEndTime+"') ";
	    rs.executeSql(sql_attend);

	    if(rs.next()){
	        amAttendTime = Util.null2String(rs.getString("amattendtime"));
	        pmAttendTime = Util.null2String(rs.getString("pmattendtime"));
	        latetime = Util.null2String(rs.getString("latetime"));
	        earlyleavetime = Util.null2String(rs.getString("earlyleavetime"));

	    }
	        for(int i=0;i<arr.length;i++){
	            arr[0] = amBeginTime;//外出开始时间
	            arr[1] = amAttendTime;//外出签到时间
	            arr[2] = pmEndTime;//外出结束时间
	            arr[3] = pmAttendTime;//外出签退时间
	            arr[4] = latetime;//迟到时间
	            arr[5] = earlyleavetime;//早退时间
	        }

		return arr;
	}
%>

<%!
    //String类型转int类型计算
	public String countTime(String latetime,String earlyleavetime){
	    
	    String sum = "";
	    //new BaseBean().writeLog("latetime=" + latetime +" earlyleavetime="+earlyleavetime);
	    if("".equals(latetime)) latetime = "0";
	    if("".equals(earlyleavetime)) earlyleavetime = "0";

	    int tmp_latetime = Integer.valueOf(latetime).intValue();
	    int tmp_earlyleavetime = Integer.valueOf(earlyleavetime).intValue();
	    int sumtime = tmp_latetime + tmp_earlyleavetime;
        if(sumtime>480){
            sumtime=480;
        }
	    sum = Integer.toString(sumtime);

		return sum;
	}
%>
<%!
//获取当前日期
public String getNowDate(){   
    String temp_str="";   
    Date dt = new Date();   
    //最后的aa表示“上午”或“下午”    HH表示24小时制    如果换成hh表示12小时制   
    //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss aa");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");     
    temp_str=sdf.format(dt);
    //temp_str = "2015-12-08";  
    return temp_str;   
} 
%>

<%
//if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
   // response.sendRedirect("/notice/noright.jsp");
    //return;
//}
String departmentid="";
String workcode="";
String subcompanyid1="";

int userid = user.getUID();
String isActive = Util.null2String(request.getParameter("isActive"));

String sql="";
String id = "";

String deptid = Util.null2String(request.getParameter("deptid"));
String subcomid = Util.null2String(request.getParameter("subcomid"));

sql=" select * from HrmResource where id not in(select EmployeeName from uf_Exclude_table) and status <5 ";

if(!"".equals(deptid)){
	sql = sql + " and departmentid  = "+deptid+" ";
}

if(!"".equals(subcomid)){
	sql = sql + " and subcompanyid1 = "+subcomid+" ";
}

    Boolean isAdmin=false;
    String sql_1="";
    sql_1=" select count(id) as num_admin from HrmRoleMembers where roleid=36 and resourceid="+userid;
    rs.executeSql(sql_1);
    if(rs.next()){
        int num_admin=rs.getInt("num_admin");
        if(num_admin>0){
            isAdmin=true;
        }
    }
    
    if(!isAdmin){
        response.sendRedirect("/notice/noright.jsp");
        return;
    }
%>

<%    
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(21590,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<link rel="stylesheet" href="/appres/hrm/css/signin_wev8.css" type="text/css" />
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
//RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="">
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<%if(HrmUserVarify.checkUserRight("AnnualLeave:All", user)){ %>
				<input type=button class="e8_btn_top" onclick="onSave();" value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%>"></input>
				<input type=button class="e8_btn_top" onclick="BatchProcess();" value="<%=SystemEnv.getHtmlLabelName(21611,user.getLanguage())%>"></input>
			<%} %>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>

<wea:layout attributes="{'expandAllGroup':'true'}">
	<div id="TimeDate">
	<wea:group context="今日考勤情况">
		<wea:item attributes="{'isTableList':'true'}">
		    <wea:layout type="table" attributes="{'cols':'18','cws':'5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
				<wea:item type="thead"></wea:item>
			    <wea:item type="thead">设备</wea:item>
			    <wea:item type="thead">考勤</wea:item>
			    <wea:item type="thead"></wea:item>
				<wea:item type="thead"></wea:item>
			    <wea:item type="thead"></wea:item>
			    <wea:item type="thead"></wea:item>
				<wea:item type="thead"></wea:item>
			    <wea:item type="thead"></wea:item>
			    <wea:item type="thead">移动</wea:item>
				<wea:item type="thead">考勤</wea:item>
			    <wea:item type="thead"></wea:item>
			    <wea:item type="thead"></wea:item>
			    <wea:item type="thead"></wea:item>
				<wea:item type="thead"></wea:item>
				<wea:item type="thead"></wea:item>
			    <wea:item type="thead"></wea:item>
				<wea:item type="thead"></wea:item>
				</wea:group>
			</wea:layout>
			<wea:layout type="table" attributes="{'cols':'11','cws':'5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
				<wea:item type="thead">姓名</wea:item>
			    <wea:item type="thead">上午上班时间</wea:item>
			    <wea:item type="thead">迟到</wea:item>
			    <wea:item type="thead">上午下班时间</wea:item>
				<wea:item type="thead">早退</wea:item>
			    <wea:item type="thead">下午上班时间</wea:item>
			    <wea:item type="thead">迟到</wea:item>
			    <wea:item type="thead">下午下班时间</wea:item>
			    <wea:item type="thead">早退</wea:item>
			    <wea:item type="thead">上午上班时间</wea:item>
			    <wea:item type="thead">迟到</wea:item>
			    <wea:item type="thead">上午下班时间</wea:item>
				<wea:item type="thead">早退</wea:item>
			    <wea:item type="thead">下午上班时间</wea:item>
			    <wea:item type="thead">迟到</wea:item>
			    <wea:item type="thead">下午下班时间</wea:item>
			    <wea:item type="thead">早退</wea:item>
			    <wea:item type="thead">合计</wea:item>
					<%
			    RecordSet.executeSql(sql);
			    while(RecordSet.next()){
			        id = Util.null2String(RecordSet.getString("id"));
			        String lastname = Util.null2String(RecordSet.getString("lastname"));
			        departmentid = Util.null2String(RecordSet.getString("departmentid"));
			        subcompanyid1 = Util.null2String(RecordSet.getString("subcompanyid1"));
			        workcode = Util.null2String(RecordSet.getString("workcode"));
                    
                    //数据在循环内声明或者循环结束后清空
                    
                    String amBeginTime1 = "";
                    String amBeginTime = ""; 
                    String amLateTime = ""; 
                    String amEndTime = ""; 
                    String amEarlyleavetime = ""; 
                    String pmBeginTime = ""; 
                    String pmLateTime = ""; 
                    String pmEndTime = ""; 
                    String pmEarlyleavetime = ""; 
                    String sumTime = ""; 
                    /*
                    String amBeginTime = Util.null2String(request.getParameter("amBeginTime")); 
                    String amLateTime = Util.null2String(request.getParameter("amLateTime")); 
                    String amEndTime = Util.null2String(request.getParameter("amEndTime")); 
                    String amEarlyleavetime = Util.null2String(request.getParameter("amEarlyleavetime")); 
                    String pmBeginTime = Util.null2String(request.getParameter("pmBeginTime")); 
                    String pmLateTime = Util.null2String(request.getParameter("pmLateTime")); 
                    String pmEndTime = Util.null2String(request.getParameter("pmEndTime")); 
                    String pmEarlyleavetime = Util.null2String(request.getParameter("pmEarlyleavetime")); 
                    String sumTime = Util.null2String(request.getParameter("sumTime")); */


			        String amOutBeginTime = ""; 
                    String amOutLateTime = ""; 
                    String amOutEndTime = ""; 
                    String amOutEarlyleavetime = ""; 
                    String pmOutBeginTime = ""; 
                    String pmOutLateTime = ""; 
                    String pmOutEndTime = ""; 
                    String pmOutEarlyleavetime = ""; 
			        String sumOutTime = ""; 
                    
                    /*
                    String amOutBeginTime = Util.null2String(request.getParameter("amOutBeginTime")); 
                    String amOutLateTime = Util.null2String(request.getParameter("amOutLateTime")); 
                    String amOutEndTime = Util.null2String(request.getParameter("amOutEndTime")); 
                    String amOutEarlyleavetime = Util.null2String(request.getParameter("amOutEarlyleavetime")); 
                    String pmOutBeginTime = Util.null2String(request.getParameter("pmOutBeginTime")); 
                    String pmOutLateTime = Util.null2String(request.getParameter("pmOutLateTime")); 
                    String pmOutEndTime = Util.null2String(request.getParameter("pmOutEndTime")); 
                    String pmOutEarlyleavetime = Util.null2String(request.getParameter("pmOutEarlyleavetime")); 
			        String sumOutTime = Util.null2String(request.getParameter("sumOutTime")); 
                    
                    */
			      
                    //是否外出
			   	    String sql_chk = " select count(*) as num_out from uf_Replace_table where EmployeeName = "+id+" and ReplaceStartDate = '"+getNowDate()+"' ";
			   	    int num_out = 0;
			   	    rs.executeSql(sql_chk);
                    out.print("sql_chk="+sql_chk);
			   	    if(rs.next()){
			   	       num_out = rs.getInt("num_out");
			   	       //new BaseBean().writeLog("num_out=" + num_out+" empid="+id);
			   	    }
                    //外出
                    if(num_out > 0){
                        String sql_standard = " select AttendanceStandard from uf_Replace_table where EmployeeName = "+id+" and ReplaceStartDate = '"+getNowDate()+"' ";
                        int standard = 0;
                        res.executeSql(sql_standard);
                        out.print("sql_standard="+sql_standard);
                        if(res.next()){
                            standard = res.getInt("AttendanceStandard");
                            //new BaseBean().writeLog("standard=" + standard+" empid="+id);
                        }
                    //上班不参与设备考勤  
                    if(standard == 0){
                       String[] str = getEmpInfo(id);
			               pmEndTime = str[5];
                           String pmEndTime1 = str[3];
                           pmEarlyleavetime = str[7];
			           
			        String[] str_out = getOutInfo(id,getNowDate());
			               amOutBeginTime = str_out[1];
			               amOutLateTime = str_out[4];
			               sumTime = countTime(amOutLateTime,pmEarlyleavetime);

			               if("0".equals(amOutLateTime)) amOutLateTime = "";
	                       if("0".equals(pmEarlyleavetime)) pmEarlyleavetime = "";
	                       if("0".equals(sumTime)) sumTime = "";
                    }
                    //下班不参与设备考勤
                    else if(standard == 1){
                       String[] str = getEmpInfo(id);
			               amBeginTime = str[4];
                           amLateTime = str[6];
                           amEarlyleavetime = "";
			           
			        String[] str_out = getOutInfo(id,getNowDate());
			           pmOutEndTime = str_out[3];
			           pmOutEarlyleavetime = str_out[5];
                       sumTime = countTime(amLateTime,pmOutEarlyleavetime);
                       if("0".equals(amLateTime)) amLateTime = "";
	                   if("0".equals(pmOutEarlyleavetime)) pmOutEarlyleavetime = "";
	                   if("0".equals(sumTime)) sumTime = "";

                    }else{
                    	//全天不参与设备考勤
                       String[] str_out = getOutInfo(id,getNowDate());
			               String amOutBeginTime1 = str_out[0];
			               amOutBeginTime = str_out[1];
			               amOutLateTime = str_out[4];
			               pmOutEndTime = str_out[3];
			               String pmOutEndTime1 = str_out[2];
			               pmOutEarlyleavetime = str_out[5];
                           sumTime = countTime(amOutLateTime,pmOutEarlyleavetime);
                          
	                       if("0".equals(amOutLateTime)) amOutLateTime = "";
                           if("0".equals(pmOutEarlyleavetime)) pmOutEarlyleavetime = "";
                           if("0".equals(sumTime)) sumTime = "";
                    }
                }else{
                	//未外出
                    String[] str = getEmpInfo(id);
			           amBeginTime1 = str[0];
			           amBeginTime = str[4];
                       amLateTime = str[6];
                       amEarlyleavetime = "";
			           pmEndTime = str[5];
                       String pmEndTime1 = str[3];
                       pmEarlyleavetime = str[7];
                       sumTime = countTime(amLateTime,pmEarlyleavetime);
			           
	                   if("0".equals(sumTime)) sumTime = "";
                       if("0".equals(amLateTime)) amLateTime = "";
                       if("0".equals(pmEarlyleavetime)) pmEarlyleavetime = "";
                   
                }
                   
			  %>
			     <wea:item><a href=javascript:this.openFullWindowForXtable('/hrm/resource/HrmResource.jsp?id=<%=id%>')><%=lastname%></a>
			     </wea:item>
			     <wea:item><%=amBeginTime%></wea:item>
			     <wea:item><%=amLateTime%></wea:item>
			     <wea:item><%=amEndTime%></wea:item>
			     <wea:item><%=amEarlyleavetime%></wea:item>
			     <wea:item><%=pmBeginTime%></wea:item>
			     <wea:item><%=pmLateTime%></wea:item>
			     <wea:item><%=pmEndTime%></wea:item>
			     <wea:item><%=pmEarlyleavetime%></wea:item>
			     <wea:item>
			     <!--地图超连接-->
            	 <a href="javascript:void(0);" onclick="showMap('sign9', '<%=id%>', '<%=getNowDate()%>')"><%=amOutBeginTime%></a>
			     </wea:item>
			     <wea:item><%=amOutLateTime%></wea:item>
			     <wea:item><%=amOutEndTime%></wea:item>
			     <wea:item>
			     <!--地图超连接-->
              	 <a href="javascript:void(0);" onclick="showMap('sign9', '<%=id%>', '<%=getNowDate()%>')"><%=amOutEarlyleavetime%></a>
			     </wea:item>
			     <wea:item><%=pmOutBeginTime%></wea:item>
			     <wea:item><%=pmOutLateTime%></wea:item>
			     <wea:item><%=pmOutEndTime%></wea:item>
			     <wea:item><%=pmOutEarlyleavetime%></wea:item>
			     <wea:item><%=sumTime%></wea:item>
			     
			  <%
			    }
			  %>
				</wea:group>
			</wea:layout>
		</wea:item>
	</wea:group>
	</div>
</wea:layout>
</form>
<script language=javascript>
//查看地图
/*function showMap(id, uid, thisDate){
	parent.parent.location.href = "/hrm/HrmTab.jsp?_fromURL=mobileSignIn&showMap=true&id="+id+"&uid="+uid+"&thisDate="+thisDate;
}
*/
function showMap(id, uid, thisDate){
	var title = "";
	var url = "";
	title = "<%=SystemEnv.getHtmlLabelNames("82634",user.getLanguage())%>";
	url="/hrm/mobile/signin/mapView.jsp?id="+id+"&uid="+uid+"&thisDate="+thisDate;

	diag_vote = new window.top.Dialog();
	diag_vote.currentWindow = window;
	diag_vote.Width = 600;
	diag_vote.Height = 400;
	diag_vote.maxiumnable = true;
	diag_vote.Modal = true;
	diag_vote.Title = title;
	diag_vote.URL = url;
	diag_vote.show();
}

</script>
</BODY>
</HTML>
