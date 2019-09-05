<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.hrm.attendance.domain.HrmLeaveTypeColor"%>
<%@page import="weaver.hrm.report.schedulediff.HrmScheduleDiffManager"%>
<%@ page import="weaver.general.Util,weaver.hrm.common.*,weaver.conn.*" %>
<%@ page import="weaver.file.*,net.sf.json.*,java.util.*,java.text.*,weaver.common.DataBook" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="strUtil" class="weaver.common.StringUtil" scope="page" />
<jsp:useBean id="dateUtil" class="weaver.common.DateUtil" scope="page" />
<jsp:useBean id="enumUtil" class="weaver.common.EnumUtil" scope="page" />
<jsp:useBean id="detachCommonInfo" class="weaver.hrm.moduledetach.ManageDetachComInfo" scope="page" />
<jsp:useBean id="HrmScheduleDiffUtil" class="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil" scope="page"/>
<jsp:useBean id="colorManager" class="weaver.hrm.attendance.manager.HrmLeaveTypeColorManager" scope="page" />
<jsp:useBean id="leaveTimeManager" class="weaver.hrm.attendance.manager.HrmPaidLeaveTimeManager" scope="page" />
<%!
	public String getTranStr(String data){
		String result = data;
		if("0".equals(data)){
			result = "";
		}else if("0.00".equals(data)){
			result = "";
		}
		return result;
	}

%>
<%
	Calendar today = Calendar.getInstance ();
	String currentDate = Util.add0(today.get(Calendar.YEAR), 4) + "-"
					   + Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-"
					   + Util.add0(today.get(Calendar.DAY_OF_MONTH), 2);

	String fromDate = strUtil.vString(request.getParameter("fromDate"));
	String toDate = strUtil.vString(request.getParameter("toDate"));
	int subCompanyId = strUtil.parseToInt(request.getParameter("subCompanyId"),0);
	int departmentId = strUtil.parseToInt(request.getParameter("departmentId"),0);
	String resourceId = strUtil.vString(request.getParameter("resourceId"));
	String fileName = fromDate+" "+SystemEnv.getHtmlLabelName(15322,user.getLanguage())+" "+toDate+" "+SystemEnv.getHtmlLabelName(20078,user.getLanguage()) ;
    List qList = colorManager.find("[map]subcompanyid:0;field003:1");
	int qSize = qList == null ? 0 : qList.size();
%>
<table  border=0 width="100%" >
	<tbody>
		<tr>
			<td align="center" ><font size=4><b><%=fileName%></b></font></td>
		</tr>
		<tr>
			<td align="right" ></td>
		</tr>
	</tbody>
</table>
<table  border=1  bordercolor=black style="border-collapse:collapse;" width="100%" >
	<COLGROUP>
		<COL width="9%">
		<COL width="9%">
		<COL width="6%">
		<COL width="6%">
		<COL width="6%">
		<COL width="6%">
		<COL width="6%">
		<COL width="6%">
		<COL width="6%">
		<COL width="6%">
		<COL width="6%">
		<COL width="6%">
		<COL width="6%">
	</COLGROUP>
	<tbody>
		<tr>
			<td rowspan=3 align="center"><%=SystemEnv.getHtmlLabelName(15390,user.getLanguage())%></td>
			<td rowspan=3 align="center"><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></td>
			<td colspan="11" align="center"><%=SystemEnv.getHtmlLabelName(20080,user.getLanguage())%></td>
		</tr>
		<tr>
			<td rowspan=2 align="center"><%=SystemEnv.getHtmlLabelName(34082,user.getLanguage())%></td>
			<td rowspan=2 align="center"><%=SystemEnv.getHtmlLabelNames("20081,81913,18929,81914",user.getLanguage())%></td>
			<td rowspan=2 align="center"><%=SystemEnv.getHtmlLabelNames("20082,81913,18929,81914",user.getLanguage())%></td>			
			<td colspan=4 align="center">请假（小时）</td> 			
			<td rowspan=2 align="center"><%=SystemEnv.getHtmlLabelNames("20084,81913,1925,81914",user.getLanguage())%></td>
			<td rowspan=2 align="center">外出（小时）</td>
			<td rowspan=2 align="center"><%=SystemEnv.getHtmlLabelNames("20085,81913,18929,81914",user.getLanguage())%></td>
			<td rowspan=2 align="center"><%=SystemEnv.getHtmlLabelNames("20086,81913,18929,81914",user.getLanguage())%></td>
		</tr> 
		
		<tr>
		<td align='center'>调休</td>
		<td align='center'>事假</td>
		<td align='center'>病假</td>
		<td align='center'>年假</td>
		</tr>
		<%
		String ycqts = "";
		String ycqsss = "";
		String sql = "select count(1) as ycqts, count(1) * 7.5 as ycqsss from (SELECT  TO_CHAR(TO_DATE('"+fromDate+"', 'YYYY-MM-DD') + ROWNUM - 1, 'YYYY-MM-DD') DAY_ID   FROM DUAL "+
                     " CONNECT BY ROWNUM <= TO_DATE('"+toDate+"', 'YYYY-MM-DD') - TO_DATE('"+fromDate+"', 'YYYY-MM-DD') + 1) where app_what_holiday(DAY_ID)=2";
		rs.execute(sql);
		if(rs.next()){
			ycqts = Util.null2String(rs.getString("ycqts"));
			ycqsss = Util.null2String(rs.getString("ycqsss"));
		}
		sql = "select a.id,a.departmentid,a.subcompanyid1,a.lastname,b.departmentname,c.subcompanyname,"+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'cdcs') as cdcs,"+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'ztcs') as ztcs,"+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'txts') as txts,"+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'sjts') as sjts,"+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'bjts') as bjts,"+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'njts') as njts,"+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'ccts') as ccts,"+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'gcts') as gcts,"+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'qqcs') as qqcs, "+
				"f_getData_type('"+fromDate+"','"+toDate+"',a.id,'lqcs') as lqcs "+
				"from hrmresource a, hrmdepartment b, hrmsubcompany c where a.departmentid=b.id and a.subcompanyid1=c.id and (a.id in(select distinct xm from uf_tsmygskqry) or a.id in(select distinct xm from uf_jtzbkqry))";
		if(!"".equals(resourceId)){
			sql = sql+" and a.id="+resourceId;
		}else if(departmentId !=0){
			sql = sql+" and a.departmentid="+departmentId;
		}else if(subCompanyId != 0){
			sql = sql+" and a.subcompanyid1="+subCompanyId;
		}else{
			sql = sql+" and 1=2";
		}
		rs.execute(sql);
		while(rs.next()){

	
		%>
		
		<tr>
			<td><%=Util.null2String(rs.getString("departmentname"))%></td>
			<td><%=Util.null2String(rs.getString("lastname"))%></td>
			<td align="center"><%=ycqts%></td>
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("cdcs")))%></td>
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("ztcs")))%></td>
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("txts")))%></td>
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("sjts")))%></td>
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("bjts")))%></td>
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("njts")))%></td>
			
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("ccts")))%></td>
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("gcts")))%></td>
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("qqcs")))%></td>
			<td align="center"><%=getTranStr(Util.null2String(rs.getString("lqcs")))%></td>
		</tr>
		<%
			}
		%>
	</tbody>
</table>
<%
	String otherParam = "fromDate="+fromDate+"&toDate="+toDate+"&subCompanyId="+subCompanyId+"&departmentId="+departmentId+"&resourceId="+resourceId;
%>
<table border=0 width="100%">
	<tbody>
		<tr>
			<td align="right" ><%=SystemEnv.getHtmlLabelName(20087,user.getLanguage())+"："+currentDate%></td>
		</tr>
		<tr>
			<td align="center" >
				<a href="javascript:void(0);" onclick="todo('/hrm/HrmDialogTab.jsp?_fromURL=hrmReport&cmd=schedulediff&method=HrmScheduleDiffSignInDetail&<%=otherParam%>','<%=SystemEnv.getHtmlLabelName(20241,user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelName(20241,user.getLanguage())%></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="todo('/hrm/HrmDialogTab.jsp?_fromURL=hrmReport&cmd=schedulediff&method=HrmScheduleDiffSignOutDetail&<%=otherParam%>','<%=SystemEnv.getHtmlLabelName(20242,user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelName(20242,user.getLanguage())%></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<!--<a href="javascript:void(0);" onclick="todo('/hrm/HrmDialogTab.jsp?_fromURL=hrmReport&cmd=schedulediff&method=HrmScheduleDiffBeLateDetail&<%=otherParam%>','<%=SystemEnv.getHtmlLabelName(20088,user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelName(20088,user.getLanguage())%></a>&nbsp;&nbsp;|&nbsp;&nbsp;-->
				<a href="javascript:void(0);" onclick="todo('/TaiSon/kq/detail/BeLateDetailUrl.jsp?<%=otherParam%>','<%=SystemEnv.getHtmlLabelName(20088,user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelName(20088,user.getLanguage())%></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="todo('/TaiSon/kq/detail/ZtDetailUrl.jsp?<%=otherParam%>','<%=SystemEnv.getHtmlLabelName(20089,user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelName(20089,user.getLanguage())%></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="todo('/TaiSon/kq/detail/QqDetailUrl.jsp?<%=otherParam%>','缺勤明细')" href="#">缺勤明细</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="todo('/TaiSon/kq/detail/LqDetailUrl.jsp?<%=otherParam%>','<%=SystemEnv.getHtmlLabelName(20091,user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelName(20091,user.getLanguage())%></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="todo('/hrm/HrmDialogTab.jsp?_fromURL=hrmReport&cmd=schedulediff&method=HrmScheduleDiffLeaveDetail&<%=otherParam%>','<%=SystemEnv.getHtmlLabelName(20092,user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelName(20092,user.getLanguage())%></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="todo('/hrm/HrmDialogTab.jsp?_fromURL=hrmReport&cmd=schedulediff&method=HrmScheduleDiffEvectionDetail&<%=otherParam%>','<%=SystemEnv.getHtmlLabelName(20093,user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelName(20093,user.getLanguage())%></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="todo('/hrm/HrmDialogTab.jsp?_fromURL=hrmReport&cmd=schedulediff&method=HrmScheduleDiffOutDetail&<%=otherParam%>','外出明细')" href="#">外出明细</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<!--<a href="javascript:void(0);" onclick="todo('/hrm/report/tab.jsp?topage=hrmReport&name=HrmScheduleOvertimeWorkDetail&<%=otherParam%>','<%=SystemEnv.getHtmlLabelName(33501,user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelName(33501,user.getLanguage())%></a>&nbsp;&nbsp;|&nbsp;&nbsp;-->
				<a href="javascript:void(0);" onclick="todo('/hrm/HrmDialogTab.jsp?_fromURL=hrmReport&cmd=schedulediff&method=HrmScheduleDiffOtherDetail&<%=otherParam%>','<%=SystemEnv.getHtmlLabelNames("127655,17463",user.getLanguage())%>')" href="#"><%=SystemEnv.getHtmlLabelNames("127655,17463",user.getLanguage())%></a>
			</td>
		</tr>
	</tbody>
</table>