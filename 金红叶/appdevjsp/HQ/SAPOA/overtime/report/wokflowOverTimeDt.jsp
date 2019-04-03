<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="xssUtil" class="weaver.filter.XssUtil"/>
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String pageId="JG2018070401";
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	int curr_user = user.getUID();

	String subcompany1 = Util.null2String(request.getParameter("subcompany1"));
	String name = Util.null2String(request.getParameter("name"));
	if(name.length() < 1&&subcompany1.length()<1) {
		name = "" + curr_user;
	}

	String hrmname = "";
	String names[] = name.split(",");
	for(String tName : names){
		hrmname = hrmname + ResourceComInfo.getLastname(tName)+",";
	}

	int typeid=Util.getIntValue(request.getParameter("typeid"),0);
	int wfname = Util.getIntValue(Util.null2String(request.getParameter("wfname")),0);
	String foDate = Util.null2String(request.getParameter("foDate"));
	String toDate = Util.null2String(request.getParameter("toDate"));
	String lz = Util.null2String(request.getParameter("lz"));

	Calendar calendar = Calendar.getInstance();
	calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - 30);
	Date lastmhday = calendar.getTime();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	String result = format.format(lastmhday);

	Calendar calendar2 = Calendar.getInstance();
	Date today = calendar2.getTime();
	String result2 = format.format(today);

	if(foDate.length() != 10){
		foDate = result;
	}

	if(toDate.length() != 10){
		toDate = result2;
	}
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
	<input type="hidden" name="pageId" id="pageId" value="<%=pageId%>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action="" method=post>
		<input type="hidden" name="company" id="company" value="<%=subcompany1%>"/>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>
		<% // 查询条件 %>
		<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
		<wea:layout type="4col">
		<wea:group context="查询条件">

		<wea:item>到达日期</wea:item>
		<wea:item>
				<BUTTON type=button class=calendar id=SelectDate onclick=onShowDate(foDateSpan,foDate)></BUTTON>&nbsp;
				<SPAN id=foDateSpan ><%=foDate%></SPAN>
				<input class="inputstyle" type="hidden" id="foDate" name="foDate" value="<%=foDate%>">&nbsp;&nbsp;
				<button type="button" class="Calendar" id="SelectDate2" onclick="gettheDate(toDate,toDateSpan)"></BUTTON> 
            	<SPAN id="toDateSpan"><%=toDate%></SPAN> 
            	<INPUT type="hidden" name="toDate" value="<%=toDate%>">
		</wea:item>

		<wea:item><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></wea:item>
    	<wea:item>
    	   	<brow:browser viewType="0" name="subcompany1" browserValue='<%=subcompany1 %>' 
           browserUrl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/SubcompanyBrowser3.jsp?selectedids="
           hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
           completeUrl="/data.jsp?type=164"
           browserSpanValue='<%=subcompany1.length()>0?Util.toScreen(SubCompanyComInfo.getSubcompanynames(subcompany1+""),user.getLanguage()):""%>'>
   		   </brow:browser>
    	   <input type='hidden' name='shareid' value='0'>
    	   <span id="showrelatedsharename" class='showrelatedsharename'  name='showrelatedsharename'></span>
  	    </wea:item>
		
		<wea:item>姓名</wea:item>
		<wea:item>
			<brow:browser viewType="0" name="name" browserValue='<%=name %>' 
					browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="
					hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
					completeUrl="/data.jsp?type=1" width="328px" browserSpanValue='<%=hrmname %>' >
			</brow:browser>
		</wea:item>
			
		<wea:item>流程类型</wea:item>
		<wea:item>
			<brow:browser viewType="0" name="typeid"
					browserValue='<%=typeid+"" %>'
					browserUrl="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkTypeBrowser.jsp"
					_callback="" width="328px"
					hasInput="true" isSingle="true" hasBrowser="true"
					isMustInput="1" completeUrl="/data.jsp"
					browserDialogWidth="600px"
					browserSpanValue='<%=WorkTypeComInfo.getWorkTypename(typeid+"")%>'>
				</brow:browser>
			
		</wea:item>	
		
		<wea:item>流程名</wea:item>
		<wea:item>
			<brow:browser viewType="0" name="wfname" browserValue='<%=wfname==0?"":(String.valueOf(wfname))%>' 
			 	browserUrl='<%="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowBrowser.jsp?sqlwhere="+xssUtil.put("where isbill=1 and formid<0") %>'
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput="1"
				completeUrl="/data.jsp" linkUrl=""  width="328px" onPropertyChange="updateBrowserSpan()"
				browserDialogWidth="600px"
				browserSpanValue='<%=WorkflowComInfo.getWorkflowname(String.valueOf(wfname))%>'>
			</brow:browser>
		</wea:item>

		<wea:item>是否自动流转</wea:item>
			<wea:item>
				<select class="e8_btn_top middle" name="lz" id="lz"> 
     			<option value="Y" <% if(lz.equals("Y")) {%>selected<%}%>>Y</option>
     			<option value="N" <% if(lz.equals("N")) {%>selected<%}%>>N</option>
				</select>
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
		String backfields = " id,workcode,lastname,department,jobtitle,userid,requestid,requestnamenew,creater,tDateTime,adt,opDateTime,adds,isprocessed,currentuserid,workflowid,nodeid ";
		String fromSql  = " from WorkflowMattersView ";
		String sqlWhere = " where (getEmpISLook("+curr_user+",userid,1346) > 0 or userid = "+curr_user+") ";
		String orderby = "id ";
		String tableString = "";
		String operateString= "";

		//out.println("name="+name);
		if(!"".equals(name)){sqlWhere = sqlWhere + " and userid in (select id from hrmresource where workcode in (select workcode from hrmresource where id in ("+name+"))) ";}
		if(typeid > 0){sqlWhere = sqlWhere + " and workflowid in (select id from workflow_base where workflowtype = '"+typeid+"') ";}
		if(wfname > 0){sqlWhere = sqlWhere + " and workflowid = '"+wfname+"' ";}
		if(!"".equals(foDate)){sqlWhere = sqlWhere + " and receivedate &gt;= '"+foDate+"' ";}
		if(!"".equals(toDate)){sqlWhere = sqlWhere + " and receivedate &lt;= '"+toDate+"' ";}
		if(!"".equals(subcompany1)){sqlWhere = sqlWhere + " and userid in (select id from hrmresource where subcompanyid1 in ("+subcompany1+")) ";}
		if(!"".equals(lz)){sqlWhere = sqlWhere + " and isprocessed = '"+lz+"' ";}

		//out.println("select "+backfields+fromSql+sqlWhere);

	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+PageIdConst.getPageSize(pageId,user.getUID(),pageId)+"\" pageId=\""+pageId+"\">"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
			operateString+
			"			<head>";
			tableString+="  <col width=\"7%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+
						" <col width=\"7%\" text=\"姓名\" column=\"lastname\" orderkey=\"lastname\" />	"+
						" <col width=\"7%\" text=\"部门\" column=\"department\" orderkey=\"department\" />	"+
						" <col width=\"7%\" text=\"职务\" column=\"jobtitle\" orderkey=\"jobtitle\" />	"+
						" <col width=\"7%\" text=\"流程号\" column=\"requestid\" orderkey=\"requestid\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"  href=\"/workflow/request/ViewRequest.jsp\"/>	"+
						" <col width=\"11%\" text=\"流程名称\" column=\"requestnamenew\" orderkey=\"requestnamenew\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"  href=\"/workflow/request/ViewRequest.jsp\"/>	"+
						" <col width=\"6%\" text=\"创建人\" column=\"creater\" orderkey=\"creater\" />	"+
						" <col width=\"6%\" text=\"到达日期\" column=\"tDateTime\" orderkey=\"tDateTime\" />	"+
						" <col width=\"6%\" text=\"超时时间\" column=\"adt\" orderkey=\"adt\" />	"+
						" <col width=\"6%\" text=\"操作时间\" column=\"opDateTime\" orderkey=\"opDateTime\" />	"+
						" <col width=\"6%\" text=\"剩余时间\" column=\"adds\" orderkey=\"adds\" />	"+
						" <col width=\"6%\" text=\"自动流转标识\" column=\"isprocessed\" orderkey=\"isprocessed\" />	"+
						" <col width=\"6%\" text=\"当前处理人\" column=\"currentuserid\" orderkey=\"currentuserid\" />	"+
						" <col width=\"6%\" text=\"WorkflowID\" column=\"workflowid\" orderkey=\"workflowid\" />	"+
						" <col width=\"6%\" text=\"节点ID\" column=\"nodeid\" orderkey=\"nodeid\" />	"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true"/>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}
		function refersh() {
  			window.location.reload();
  		}
	</script>
</BODY>
</HTML>