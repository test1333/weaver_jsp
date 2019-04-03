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
	            arr[0] = amBeginTime;
	            arr[1] = amEndTime;
	            arr[2] = pmBeginTime;
	            arr[3] = pmEndTime;
	            arr[4] = amAttendTime;
	            arr[5] = pmAttendTime;
	            arr[6] = latetime;
	            arr[7] = earlyleavetime;
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

	    String sql = " select ReplaceStartTime,ReplaceEndTime from uf_Replace_table where EmployeeName =  "+emp_id+" "
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
	            arr[0] = amBeginTime;
	            arr[1] = amAttendTime;
	            arr[2] = pmEndTime;
	            arr[3] = pmAttendTime;
	            arr[4] = latetime;
	            arr[5] = earlyleavetime;
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
	    sum = Integer.toString(sumtime);

		return sum;
	}
%>
<%!
    //String类型转int类型计算
	public String minusTime(String beginTime,String endTime){
	    
	    String sum = "";
	    //new BaseBean().writeLog("latetime=" + latetime +" earlyleavetime="+earlyleavetime);
	    if("".equals(beginTime)) beginTime = "0";
	    if("".equals(endTime)) endTime = "0";

	    int tmp_beginTime = Integer.valueOf(beginTime).intValue();
	    int tmp_endTime = Integer.valueOf(endTime).intValue();
	    int sumtime = tmp_endTime - tmp_beginTime;
	    if(sumtime<0) sumtime = 0;
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
    temp_str = "2015-10-30";  
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

String isActive = Util.null2String(request.getParameter("isActive"));

String sql="";
String id = "";

String deptid = Util.null2String(request.getParameter("deptid"));
String subcomid = Util.null2String(request.getParameter("subcomid"));

sql=" select * from HrmResource where id not in(select EmployeeName from uf_Exclude_table) ";

if(!"".equals(deptid)){
	sql = sql + " and departmentid  = "+deptid+" ";
}

if(!"".equals(subcomid)){
	sql = sql + " and subcompanyid1 = "+subcomid+" ";
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
<script type="text/javascript"> 
function fixupFirstRow(tab) { 
var div=tab.parentNode; 
if(div.className.toLowerCase()=="TimeDate"){ 
tab.rows[0].style.zIndex="1"; 
tab.rows[0].style.position="relative"; 
div.onscroll = function(){ 
var tr = tab.rows[0]; 
tr.style.top = this.scrollTop-(this.scrollTop==0?1:2); 
tr.style.left=-1; 
} 
} 
} 

window.onload = function(){ 
var tab=document.getElementById("testtable"); 
if(tab){ 
fixupFirstRow(tab); 
} 
} 
</script> 
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
			<wea:layout type="table" attributes="{'cols':'18','cws':'5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%,5%'}">
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
			        /*String amBeginTime = Util.null2String(request.getParameter("amBeginTime")); 
                    String amAttendTime = Util.null2String(request.getParameter("amAttendTime")); 
                    String amEndTime = Util.null2String(request.getParameter("amEndTime")); 
                    String pmBeginTime = Util.null2String(request.getParameter("pmBeginTime")); 
                    String pmEndTime = Util.null2String(request.getParameter("pmEndTime"));
                    String pmAttendTime = Util.null2String(request.getParameter("pmAttendTime"));  
                    String latetime = Util.null2String(request.getParameter("latetime"));
                    String earlyleavetime = Util.null2String(request.getParameter("earlyleavetime")); 


			        String amOutTime = Util.null2String(request.getParameter("amOutTime"));
                    String amOutAttendTime = Util.null2String(request.getParameter("amOutAttendTime"));
                    String pmOutTime = Util.null2String(request.getParameter("pmOutTime"));  
                    String pmOutAttendTime = Util.null2String(request.getParameter("pmOutAttendTime"));   
                    String outlatetime = Util.null2String(request.getParameter("outlatetime"));
                    String outearlyleavetime = Util.null2String(request.getParameter("outearlyleavetime")); 
                    String outsumtime = Util.null2String(request.getParameter("outsumtime"));*/

                    String amBeginTime = Util.null2String(request.getParameter("amBeginTime")); 
                    String amLateTime = Util.null2String(request.getParameter("amLateTime")); 
                    String amEndTime = Util.null2String(request.getParameter("amEndTime")); 
                    String amEarlyleavetime = Util.null2String(request.getParameter("amEarlyleavetime")); 
                    String pmBeginTime = Util.null2String(request.getParameter("pmBeginTime")); 
                    String pmLateTime = Util.null2String(request.getParameter("pmLateTime")); 
                    String pmEndTime = Util.null2String(request.getParameter("pmEndTime")); 
                    String pmEarlyleavetime = Util.null2String(request.getParameter("pmEarlyleavetime")); 
                    String sumTime = Util.null2String(request.getParameter("sumTime")); 


			        String amOutBeginTime = Util.null2String(request.getParameter("amOutBeginTime")); 
                    String amOutLateTime = Util.null2String(request.getParameter("amOutLateTime")); 
                    String amOutEndTime = Util.null2String(request.getParameter("amOutEndTime")); 
                    String amOutEarlyleavetime = Util.null2String(request.getParameter("amOutEarlyleavetime")); 
                    String pmOutBeginTime = Util.null2String(request.getParameter("pmOutBeginTime")); 
                    String pmOutLateTime = Util.null2String(request.getParameter("pmOutLateTime")); 
                    String pmOutEndTime = Util.null2String(request.getParameter("pmOutEndTime")); 
                    String pmOutEarlyleavetime = Util.null2String(request.getParameter("pmOutEarlyleavetime")); 
			      
                    //是否外出
			   	    String sql_chk = " select count(*) as num_out from uf_Replace_table where EmployeeName = "+id+" and ReplaceStartDate = '"+getNowDate()+"' ";
			   	    int num_out = 0;
			   	    rs.executeSql(sql_chk);
			   	    if(rs.next()){
			   	       num_out = rs.getInt("num_out");
			   	       //new BaseBean().writeLog("num_out=" + num_out+" empid="+id);
			   	    }
                    //外出
                    if(num_out > 0){
                        String sql_standard = " select AttendanceStandard from uf_Replace_table where EmployeeName = "+id+" and ReplaceStartDate = '"+getNowDate()+"' ";
                        int standard = 0;
                        res.executeSql(sql_standard);
                        if(res.next()){
                            standard = res.getInt("AttendanceStandard");
                            //new BaseBean().writeLog("standard=" + standard+" empid="+id);
                        }
                    //上班不参与设备考勤  
                    if(standard == 0){
                       String[] str = getEmpInfo(id);
			               String pmBeginTime1 = str[2];
			               String pmEndTime1 = str[3];
			               pmBeginTime = str[5];
			               pmEarlyleavetime = minusTime(pmBeginTime1,pmBeginTime);
			               earlyleavetime = str[7];
			           
			        String[] str_out = getOutInfo(id,getNowDate());
			               amOutTime = str_out[0];
			               amOutAttendTime = str_out[1];
			               outlatetime = str_out[4];
			               outsumtime = countTime(outlatetime,earlyleavetime);

			               if("0".equals(outlatetime)) outlatetime = "";
	                       if("0".equals(earlyleavetime)) earlyleavetime = "";
	                       if("0".equals(outsumtime)) outsumtime = "";
                    }
                    //下班不参与设备考勤
                    else if(standard == 1){
                       String[] str = getEmpInfo(id);
			               amBeginTime = str[0];
			               amEndTime = str[1];
			               amAttendTime = str[4];
			               latetime = str[6];
			           
			        String[] str_out = getOutInfo(id,getNowDate());
			           pmOutTime = str_out[2];
			           pmOutAttendTime = str_out[3];
			           outearlyleavetime = str_out[5];
                       outsumtime = countTime(latetime,outearlyleavetime);
                       if("0".equals(latetime)) latetime = "";
	                   if("0".equals(outearlyleavetime)) outearlyleavetime = "";
	                   if("0".equals(outsumtime)) outsumtime = "";

                    }else{
                    	//全天不参与设备考勤
                       String[] str_out = getOutInfo(id,getNowDate());
			               amOutTime = str_out[0];
			               amOutAttendTime = str_out[1];
			               pmOutTime = str_out[2];
			               pmOutAttendTime = str_out[3];
			               outlatetime = str_out[4];
			               outearlyleavetime = str_out[5];
                           outsumtime = countTime(outlatetime,outearlyleavetime);
                           if("0".equals(outlatetime)) outlatetime = "";
	                       if("0".equals(outearlyleavetime)) outearlyleavetime = "";
	                       if("0".equals(outsumtime)) outsumtime = "";
                    }
                }else{
                	//未外出
                    String[] str = getEmpInfo(id);
			           amBeginTime = str[0];
			           amEndTime = str[1];
			           pmBeginTime = str[2];
			           pmEndTime = str[3];
			           amAttendTime = str[4];
			           pmAttendTime = str[5];
			           latetime = str[6];
			           earlyleavetime = str[7];
                       outsumtime = countTime(latetime,earlyleavetime);
                       if("0".equals(latetime)) latetime = "";
	                   if("0".equals(earlyleavetime)) earlyleavetime = "";
	                   if("0".equals(outsumtime)) outsumtime = "";
                   
                }
                   
			  %>
			     <wea:item><a href=javascript:this.openFullWindowForXtable('/hrm/resource/HrmResource.jsp?id=<%=id%>')><%=lastname%></a>
			     <INPUT type="hidden" name="workcode" value="<%=workcode%>">
			     <INPUT type="hidden" name="departmentid" value="<%=departmentid%>">
			     <INPUT type="hidden" name="subcompanyid" value="<%=subcompanyid1%>">
			     <INPUT type="hidden"  name="ids" value="<%=id%>">
			     </wea:item>
			     <wea:item><%=amBeginTime%></wea:item>
			     <wea:item><%=amLateTime%></wea:item>
			     <wea:item><%=amEndTime%></wea:item>
			     <wea:item><%=amEarlyleavetime%></wea:item>
			     <wea:item><%=pmBeginTime%></wea:item>
			     <wea:item><%=pmLateTime%></wea:item>
			     <wea:item><%=pmEarlyleavetime%></wea:item>
			     <wea:item><%=sumTime%></wea:item>
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
function onSave(){
    frmmain.submit();
}

function firm(){

    if(confirm("是否确认同步？"))
    {
        sycal();
    }
    else
    {

    }
}

function BatchProcess(){
    document.frmmain.operation.value="batchprocess";
    frmmain.submit();
}
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
<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
<SCRIPT language="javascript" src="/seahonor/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/seahonor/attend/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</HTML>
