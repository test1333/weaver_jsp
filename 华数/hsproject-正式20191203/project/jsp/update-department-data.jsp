<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />

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
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String ybm = Util.null2String(request.getParameter("ybm"));
	String xbm = Util.null2String(request.getParameter("xbm"));
	String multiIds = Util.null2String(request.getParameter("multiIds"));
	String needfav ="1";
	String needhelp ="";
	
	
	//判断操作
	 
	 
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
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/hsproject/project/jsp/update-department-data.jsp" method=post>
			
		<input type="hidden" name="multiIds" value="-1">
			
		<%
			BaseBean log = new BaseBean();
			if("1".equals(multiIds)){
				String sql = "update hs_projectinfo set belongdepart='"+xbm+"' where belongdepart='"+ybm+"'";
				log.writeLog("更新部门数据 sql:"+sql);
				rs.executeSql(sql);
				out.println("<font size=\"5px\" color=\"red\">执行完成，更新成功!</font>");
			}
		%>
		<div >
				<wea:layout type="2col">
				<wea:group context="更新项目部门">
				<wea:item>原部门</wea:item>
				<wea:item>
                        <brow:browser name='ybm'
                                    viewType='0'
                                    browserValue='<%=ybm%>'
                                    isMustInput='1'
                                    browserSpanValue='<%=Util.toScreen(DepartmentComInfo.getDepartmentname(ybm),user.getLanguage())%>'
                                    hasInput='true'
                                    linkUrl='/hrm/company/HrmDepartmentDsp.jsp?id='
                                    completeUrl='/data.jsp?type=4'
                                    width='60%'
                                    isSingle='true'
                                    hasAdd='false'
                                    browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
                        </brow:browser>
                    </wea:item>


				

				<wea:item>新部门</wea:item>
				<wea:item>
                        <brow:browser name='xbm'
                                    viewType='0'
                                    browserValue='<%=xbm%>'
                                    isMustInput='1'
                                    browserSpanValue='<%=Util.toScreen(DepartmentComInfo.getDepartmentname(xbm),user.getLanguage())%>'
                                    hasInput='true'
                                    linkUrl='/hrm/company/HrmDepartmentDsp.jsp?id='
                                    completeUrl='/data.jsp?type=4'
                                    width='60%'
                                    isSingle='true'
                                    hasAdd='false'
                                    browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
                        </brow:browser>
                    </wea:item>
				

				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="更新" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				</wea:item>
				</wea:group>
				</wea:layout>
		<div>
		</FORM>
	<script type="text/javascript">
    function onBtnSearchClick() {
		var ybm  = document.getElementById('ybm').value;
		var xbm  = document.getElementById('xbm').value;
		if(ybm == ""||xbm == ""){
			alert("信息填写不完整，请填写完整后，再处理");
			return;
		}
		if(confirm("是否确定要更新数据")){
			document.report.multiIds.value = "1";
			document.report.submit();
		}else{
			return false;
		}
	 
}
	   function refersh() {
		   document.report.multiIds.value = "-1";
		    document.report.ybm.value = "";
			 document.report.xbm.value = "";
  			document.report.submit();
  		}
 
	</script>
</BODY>
</HTML>