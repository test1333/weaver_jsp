<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="hsproject.dao.*" %>
<%@ page import="hsproject.bean.*" %>
<%@ page import="hsproject.util.*" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@page import="weaver.cpt.util.html.HtmlElement"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="org.json.JSONObject"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/lib/jquery.bgiframe.min_wev8.js'></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/jquery.autocomplete_wev8.js'></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
		<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/jquery.autocomplete_wev8.css" />
		<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/browser_wev8.css" />
		<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
		<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String prjtype = Util.null2String(request.getParameter("prjtype"));
	ProjectGroupDao pgd = new ProjectGroupDao();
	ValueTransMethod vtm = new ValueTransMethod();
	List<ProjectGroupBean> pgblist = pgd.getGroupData();
	EditTransMethod etm = new EditTransMethod();
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		//RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/hsproject/project/list/hs-add-project.jsp" method=post enctype="multipart/form-data">
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="prjtype" id="prjtype" value="<%=prjtype%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			<!-- 系统布局组件 wea:layout wea:group wea:item -->   
			<wea:layout type="2col">
			<wea:group context="项目">
			<wea:item>多人力资源必填</wea:item>
			<wea:item>
			 <brow:browser name='hrmids02'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/hrm/resource/HrmResource.jsp?id=' 
				completeUrl='/data.jsp?type=17'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=#id#'>
                </brow:browser>
			</wea:item>	
			<wea:item>多人力资源可编辑</wea:item>
			<wea:item>
			 <brow:browser name='hrmids02'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/hrm/resource/HrmResource.jsp?id=' 
				completeUrl='/data.jsp?type=17'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=#id#'>
                </brow:browser>
			</wea:item>
			<wea:item>单人力资源必填</wea:item>
			<wea:item>
				<brow:browser name='manager'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/hrm/resource/HrmResource.jsp?id=' 
				completeUrl='/data.jsp'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?resourceid=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>单人力资源可编辑</wea:item>
			<wea:item>
				<brow:browser name='manager'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/hrm/resource/HrmResource.jsp?id=' 
				completeUrl='/data.jsp'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?resourceid=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>文档必填</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>
			<wea:item>文档编辑</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>文档只读</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='0'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>多文档必填</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>多文档编辑</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>
			<wea:item>多部门必填</wea:item>
			<wea:item>
			<brow:browser name='department'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='/hrm/company/MutiDepartmentBrowser.jsp?id=' 
				completeUrl='/data.jsp?type=4'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?resourceids=#id#'>
				</brow:browser>
			</wea:item>

			<wea:item>多部门编辑</wea:item>
			<wea:item>
			<brow:browser name='department'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='/hrm/company/MutiDepartmentBrowser.jsp?id=' 
				completeUrl='/data.jsp?type=4'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?resourceids=#id#'>
				</brow:browser>
			</wea:item>
			
			<wea:item>部门必填</wea:item>
			<wea:item>
			<brow:browser name='department'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='/hrm/company/DepartmentBrowser.jsp?id=' 
				completeUrl='/data.jsp?type=4'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
				</brow:browser>
			</wea:item>

			<wea:item>部门编辑</wea:item>
			<wea:item>
			<brow:browser name='department'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='/hrm/company/DepartmentBrowser.jsp?id=' 
				completeUrl='/data.jsp?type=4'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
				</brow:browser>
			</wea:item>
			<wea:item>多分部编辑</wea:item>
			<wea:item> 
			<brow:browser name='subcompany1'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='' 
				completeUrl='/data.jsp?type=164'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?resourceids=#id#'>
				</brow:browser>
            </wea:item>
			<wea:item>多分部必填</wea:item>
			<wea:item> 
			<brow:browser name='subcompany1'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='' 
				completeUrl='/data.jsp?type=164'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?resourceids=#id#'>
				</brow:browser>
            </wea:item>
			<wea:item>分部编辑</wea:item>
			<wea:item> 
			<brow:browser name='subcompany1'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='' 
				completeUrl='/data.jsp?type=164'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp?resourceids=#id#'>
				</brow:browser>
            </wea:item>
			<wea:item>分部必填</wea:item>
			<wea:item> 
			<brow:browser name='subcompany1'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='' 
				completeUrl='/data.jsp?type=164'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp?resourceids=#id#'>
				</brow:browser>
            </wea:item>
			<wea:item>日期必填</wea:item>
			<wea:item>
			 <button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON>
              <SPAN id=selectBeginDateSpan ></SPAN>
              <INPUT type="hidden" name="beginDate" id="beginDate" value="">
		
			</wea:item>
			<wea:item>日期必填</wea:item>
			<wea:item>
			 <button type="button" class=Clock id="selectamEndTime" onclick="onShowTime(amendTimeSpan,amEndTime)"></BUTTON>
                  <SPAN id="amendTimeSpan"></SPAN>
                  <INPUT class=inputstyle type=hidden id="SHamEndTimeAll" name="amEndTime" value=">

		
			</wea:item>				
		</wea:group>
	</wea:layout>
</FORM>
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