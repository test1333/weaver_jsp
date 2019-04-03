<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
int user_id = user.getUID();
Calendar today = Calendar.getInstance() ; 
String currentyear = Util.add0(today.get(Calendar.YEAR),4) ;
String currentMonth = Util.add0(today.get(Calendar.MONTH)+1,2);
String currentdate = Util.add0(today.get(Calendar.YEAR),4) + "-" + Util.add0(today.get(Calendar.MONTH)+1,2) + "-" + Util.add0(today.get(Calendar.DAY_OF_MONTH),2);
//out.println(currentyear);
//out.println(currentMonth);
String tmc_pageId = "jbkb001";
weaver.general.AccountType.langId.set(lg);
String subid = Util.null2String(request.getParameter("subid"));
String searchyear = Util.null2String(request.getParameter("searchyear"));
String searchmonth = Util.null2String(request.getParameter("searchmonth"));
String xm = Util.null2String(request.getParameter("xm"));
String sql="";
	String department = Util.null2String(request.getParameter("department"));
	String departmentStr = "";
    String sql1 = "select departmentname from HrmDepartment where id in ("+department+")";
	rs.executeSql(sql1);
	String text="";
	String flag="";
	while(rs.next()){
	       departmentStr =departmentStr+""+flag;
	       text = Util.null2String(rs.getString("departmentname"));
		  departmentStr +=text;
		  flag = ",";
	   }
String searchTime="";
if("".equals(searchyear)||"".equals(searchmonth)){
	searchTime=currentyear+"-"+currentMonth;
}else{
	searchTime=searchyear+"-"+Util.add0(Integer.valueOf(searchmonth),2);
}

		


%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		
		
	</head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
  <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
  <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
	<BODY >
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
			RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/zj/report/jiaban-kanban.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="subid" id="subid" value="<%=subid%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				 <wea:item>年份</wea:item>
				<wea:item>
				  <select class="e8_btn_top middle" name="searchyear" id="searchyear">
				    <option value="" <%if("".equals(searchyear)){%> selected<%} %>>
                    <%=""%></option>
				  <%
						int length = Integer.parseInt(currentyear)-2017+10; 
						 	for(int i=0;i<length;i++){
							  String selectvalue=2017+i+"";
				  %>
					   <option value="<%=selectvalue%>" <%if(selectvalue.equals(searchyear)){%> selected<%} %>>
                    <%=selectvalue%></option>
				  <% }%>
		          </select>
				</wea:item>
				<wea:item>月份</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="searchmonth" id="searchmonth"> 
				<option value="" <%if("".equals(searchmonth)){%> selected<%} %>>
					<%=""%></option>
				<option value="1" <%if("1".equals(searchmonth)){%> selected<%} %>>
					<%="1"%></option>
				<option value="2" <%if("2".equals(searchmonth)){%> selected<%} %>>
					<%="2"%></option>
				<option value="3" <%if("3".equals(searchmonth)){%> selected<%} %>>
					<%="3"%></option>
				<option value="4" <%if("4".equals(searchmonth)){%> selected<%} %>>
					<%="4"%></option>
				<option value="5" <%if("5".equals(searchmonth)){%> selected<%} %>>
					<%="5"%></option>
				<option value="6" <%if("6".equals(searchmonth)){%> selected<%} %>>
					<%="6"%></option>
		    	<option value="7" <%if("7".equals(searchmonth)){%> selected<%} %>>
					<%="7"%></option>
				<option value="8" <%if("8".equals(searchmonth)){%> selected<%} %>>
					<%="8"%></option>
				<option value="9" <%if("9".equals(searchmonth)){%> selected<%} %>>
					<%="9"%></option>
				<option value="10" <%if("10".equals(searchmonth)){%> selected<%} %>>
					<%="10"%></option>
				<option value="11" <%if("11".equals(searchmonth)){%> selected<%} %>>
					<%="11"%></option>
				<option value="12" <%if("12".equals(searchmonth)){%> selected<%} %>>
					<%="12"%></option>
				</select>
				</wea:item>
				<wea:item>部门</wea:item>
                   <wea:item>
                    <brow:browser viewType="0" name="department" browserValue='<%=department %>'
                    browserurl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="
                    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                    completeUrl="/data.jsp?type=4"
                    browserSpanValue='<%=Util.toScreen(departmentStr,user.getLanguage())%>'></brow:browser>
                    </wea:item>
				<wea:item>姓名</wea:item>
                <wea:item>
                <brow:browser viewType="0"  name="xm" browserValue="<%=xm%>"
                browserOnClick=""
                browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                completeUrl="/data.jsp" width="165px"
                browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(xm),user.getLanguage())%>">
                </brow:browser>
                </wea:item>

				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		</FORM>
	
	
	<%
	//[dbo].[f_get_holiday_info](id,'19','"+searchyear+"') as jbxs
	String backfields="id,workcode,'"+searchTime+"' as year,[dbo].[f_get_jiaban_info](id,'"+searchTime+"') as hbxs ";
		String fromSql="  from hrmresource ";
		String sqlWhere=" where subcompanyid1='"+subid+"' and status in (0,1,2,3) ";
		String orderby = " id ";
		if(!"".equals(xm)){
			sqlWhere = sqlWhere +" and id='"+xm+"'";
		}
		if(!"".equals(department)){
			sqlWhere = sqlWhere +" and departmentid in ("+department+") ";
		}
	String tableString = "";
		String operateString= "";
		  tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
				tableString +="<col width=\"25%\" text=\"姓名\" column=\"id\" orderkey=\"id\" transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/>"+ 
						"<col width=\"25%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+
						"<col width=\"25%\" text=\"年月\" column=\"year\" orderkey=\"year\" />"+
                		"<col width=\"25%\" text=\"加班小时\" column=\"hbxs\" orderkey=\"hbxs\" />"+
                	"</head>"+
		 "</table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="false"/>
</div>
	<script type="text/javascript">
	
		function onBtnSearchClick() {
			report.submit();
		}
		function refersh() {
  			window.location.reload();
  		}
	

	</script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>