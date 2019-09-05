<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.hrm.attendance.domain.HrmPubHoliday"%>
<%@page import="weaver.hrm.attendance.domain.HrmScheduleDiffMonthAtt"%>
<!-- Added by wcd 2015-05-14 [月考勤日历报表] -->
<%@ page import="weaver.general.Util,weaver.hrm.common.*,weaver.conn.*" %>
<%@ page import="weaver.file.*,net.sf.json.*,java.util.*,java.text.*,weaver.common.DataBook" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="strUtil" class="weaver.common.StringUtil" scope="page" />
<jsp:useBean id="dateUtil" class="weaver.common.DateUtil" scope="page" />
<jsp:useBean id="enumUtil" class="weaver.common.EnumUtil" scope="page" />
<jsp:useBean id="detachCommonInfo" class="weaver.hrm.moduledetach.ManageDetachComInfo" scope="page" />
<jsp:useBean id="resourceInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="holidayManager" class="weaver.hrm.attendance.manager.HrmPubHolidayManager" scope="page" />
<jsp:useBean id="monthAttManager" class="weaver.hrm.attendance.manager.HrmScheduleDiffMonthAttManager" scope="page" />
<%
	String currentdate = strUtil.vString(request.getParameter("currentdate"), dateUtil.getCurrentDate());
	Date CURRENT_DATE = dateUtil.parseToDate(currentdate);
	Calendar cal = dateUtil.getCalendar(CURRENT_DATE);
	Calendar ____Fday = dateUtil.getCalendar(dateUtil.getFirstDayOfMonth(CURRENT_DATE));
	Calendar ____Lday = dateUtil.getCalendar(dateUtil.getLastDayOfMonth(CURRENT_DATE));
	int subCompanyId = strUtil.parseToInt(request.getParameter("subCompanyId"),0);
	int departmentId = strUtil.parseToInt(request.getParameter("departmentId"),0);
	String resourceId = strUtil.vString(request.getParameter("resourceId"));
	if(resourceId.length() > 0) {
		if(subCompanyId <= 0) subCompanyId = strUtil.parseToInt(resourceInfo.getSubCompanyID(resourceId), 0);
		if(departmentId <= 0) departmentId = strUtil.parseToInt(resourceInfo.getDepartmentID(resourceId), 0);
	}
	if(departmentId > 0) {
		if(subCompanyId <= 0) subCompanyId = strUtil.parseToInt(departmentComInfo.getSubcompanyid1(String.valueOf(departmentId)), 0);
	}
	int __year = cal.get(Calendar.YEAR), __month = cal.get(Calendar.MONTH), fDay = ____Fday.get(Calendar.DATE), lDay = ____Lday.get(Calendar.DATE);
	boolean isAfter = __month >= strUtil.parseToInt(dateUtil.getMonth(), 0) && __year >= strUtil.parseToInt(dateUtil.getYear(), 0);
%>
<table id="monthAttData" class="altrowstable" border=1 cellspacing=0 cellpadding=0 style="width:99.7%;margin-left: 0.2%;margin-top: -1px">
	<tr style="height:2px;background-color: #f7f7f7;">
		<td style="width:3%;text-align:center;"><%=strUtil.addWords(SystemEnv.getHtmlLabelName(413,user.getLanguage()), "<br>")%></td>
		<td style="width:3%;text-align:center;"><%=strUtil.addWords(SystemEnv.getHtmlLabelName(124,user.getLanguage()), "<br>")%></td>
		<%for(int __date=fDay; __date<=lDay; __date++) out.println("<td height=\"20px\" width=\"3%\" ALIGN=CENTER>"+__date+"</td>");%>
	</tr>
	<%
	List hList = holidayManager.find("[map]countryid:1;sql_holidaydate:and t.holidaydate like '"+__year+"%'");
	int hSize = hList == null ? 0 : hList.size();
	HrmPubHoliday hBean = null;
	Calendar tempday = Calendar.getInstance();
	Map colorMap = new HashMap();
	int curDay = 0;
	String bgColor = "", curDate = "";
	for(int __date=fDay; __date<=lDay; __date++){
		tempday.clear();
		tempday.set(__year, __month, __date);
		curDay = tempday.getTime().getDay();
		bgColor = curDay == 0 || curDay == 6 ? "#f7f7f7" : "";
		curDate = dateUtil.getDate(tempday.getTime());
		for(int j=0; j<hSize; j++) {
			hBean = (HrmPubHoliday)hList.get(j);
			if(curDate.equals(hBean.getHolidaydate())){
				switch(hBean.getChangetype()) {
				case 1 :
					bgColor = "RED";
					break ;
				case 2 :
					bgColor = "GREEN";
					break ;
				case 3 :
					bgColor = "MEDIUMBLUE";
					break ;
				}
				break;
			}
		}
		colorMap.put(curDate, bgColor);
	}
	monthAttManager.setUser(user);
	String sql_dt = "";
	String sql = "select a.id,a.lastname,b.departmentname  from hrmresource a, hrmdepartment b, hrmsubcompany c where a.departmentid=b.id and a.subcompanyid1=c.id and (a.id in(select distinct xm from uf_tsmygskqry) or a.id in(select distinct xm from uf_jtzbkqry))";
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
		out.println("<tr>");
		out.println("<td style=\"border-color:#E6E6E6;text-align:center;\" title=\""+Util.null2String(rs.getString("lastname"))+"\">"+strUtil.addWords(Util.null2String(rs.getString("lastname")), "<br>", 10)+"</td>");
		out.println("<td style=\"border-color:#E6E6E6;text-align:center;\" title=\""+Util.null2String(rs.getString("departmentname"))+"\">"+strUtil.addWords(Util.null2String(rs.getString("departmentname")), "<br>", 10)+"</td>");
		String innertext="";
		

		//封装数据开始
		for(int __date=fDay; __date<=lDay; __date++){
			tempday.clear();
			tempday.set(__year, __month, __date);
			curDate = dateUtil.getDate(tempday.getTime());
			String curValue = "";
			String cursor = "";
			if(!isAfter){
				sql_dt = "select getEmpStatus("+Util.null2String(rs.getString("id"))+",'"+curDate+"') as status from dual";
				rs_dt.execute(sql_dt);
				if(rs_dt.next()){
					curValue = Util.null2String(rs_dt.getString("status"));
				}
				if(curValue.length() > 0 && !curValue.equals("Y") && !curValue.equals("N")) {
					curValue = "<a href=\"javascript:void(0);\" onclick=\"showWindow('"+Util.null2String(rs.getString("id"))+"','"+curDate+"');\">"+curValue+"</a>";
					cursor = "cursor:pointer";
				}
			}
			if(curValue.equals("Y")){
				curValue = "√";
			}else if(curValue.equals("N")){
				curValue = "";
			}
			%>
			<td height="20px" align="center" style="background-color:<%=strUtil.vString(colorMap.get(curDate))%>;border-color: #E6E6E6;<%=cursor%>" title="<%=innertext%>"><%=curValue%></td>
			<%
		}
		//封装数据结束
		


		out.println("</tr>");
	}
	%>
</table>