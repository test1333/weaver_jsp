<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />

<%
	int user_id = user.getUID();
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

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
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";

int subjectType = Util.getIntValue(request.getParameter("subjectType"), 1);
String subjectId = Util.null2String(request.getParameter("subjectId")).trim();
StringBuffer shownameSubject = new StringBuffer();
String sql="";
if(!"".equals(subjectId)){
	sql = "select a.id, a.name from FnaBudgetfeeType a where a.id in ("+subjectId+") ORDER BY a.codename, a.name, a.id ";
	subjectId = "";
	rs.executeSql(sql);
	while(rs.next()){
		if(shownameSubject.length() > 0){
			shownameSubject.append(",");
			subjectId+=",";
		}
		shownameSubject.append(Util.null2String(rs.getString("name")).trim());
		subjectId+=Util.null2String(rs.getString("id")).trim();
	}
}

String tmc_pageId = "fna001";
%>





<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>

	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
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

				<wea:item><%=SystemEnv.getHtmlLabelNames("1462",user.getLanguage())%></wea:item><!-- 预算科目 -->
		    <wea:item>
				<select id="subjectType" name="subjectType" onchange="subjectType_onchange();" style="width: 80px;float: left;">
					<option value="1" <%=(subjectType==1)?"selected":"" %>><%=SystemEnv.getHtmlLabelNames("19398,585", user.getLanguage()) %></option><!-- 月度科目 -->
					<option value="2" <%=(subjectType==2)?"selected":"" %>><%=SystemEnv.getHtmlLabelNames("17495,585", user.getLanguage()) %></option><!-- 季度科目 -->
					<option value="3" <%=(subjectType==3)?"selected":"" %>><%=SystemEnv.getHtmlLabelNames("19483,585", user.getLanguage()) %></option><!-- 半年度科目 -->
					<option value="4" <%=(subjectType==4)?"selected":"" %>><%=SystemEnv.getHtmlLabelNames("17138,585", user.getLanguage()) %></option><!-- 年度科目 -->
				
				</select>
		        <brow:browser viewType="0" name="subjectId" browserValue='<%=subjectId %>' 
		                getBrowserUrlFn="getSubjectId_browserUrl"
		                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput="1"
		                completeUrl="javascript:getSubjectId_completeUrl()" 
		                temptitle='<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())+SystemEnv.getHtmlLabelName(1462,user.getLanguage()) %>'
		                browserSpanValue='<%=shownameSubject.toString() %>' width="60%" >
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
								
	String backfields = " * "; 
	String fromSql  = " from uf_custom_dynamic ";
	String sqlWhere = " where 1=1";
	
	String orderby = "id " ;
	String tableString = "";
   


//  右侧鼠标 放上可以点击
String  operateString= "";

tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"20%\" labelid=\"-9403\" text=\"标题\" column=\"bt\" orderkey=\"bt\"/>"+
		"<col width=\"35%\" labelid=\"-9403\" text=\"动态内容\" column=\"content\" orderkey=\"content\"/>"+
		"<col width=\"15%\" text=\"关键字\" column=\"gjz\" orderkey=\"gjz\"/>"+
	  "				<col width=\"15%\" labelid=\"882\" text=\"发布人\" column=\"creater\" orderkey=\"creater\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"  />"+
	  "				<col width=\"15%\" labelid=\"1339\" text=\"发布时间\" column=\"createTime\" orderkey=\"createTime\"  />"+
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

<script>
function getSubjectId_completeUrl(){
	var subjectType = jQuery("#subjectType").val();
	return "/data.jsp?type=FnaBudgetfeeTypeMultiByGroupCtrl&feeperiod="+subjectType;
}
function getSubjectId_browserUrl(){
	var subjectType = jQuery("#subjectType").val();
	var selectids = jQuery("#subjectId").val();
	return "/systeminfo/BrowserMain.jsp?url=/fna/browser/feeTypeByGroupCtrl/FnaBudgetfeeTypeByGroupCtrlBrowserMulti.jsp%3Fselectids="+selectids+"%26feeperiod="+subjectType;
}
</script>

			<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
