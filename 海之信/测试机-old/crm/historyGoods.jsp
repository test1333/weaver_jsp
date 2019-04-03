<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

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

 String customID = (String)session.getAttribute("customID");
if("".equals(customID)){
	customID = "-1";
}
String spmc = Util.null2String(request.getParameter("spmc"));
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));


String tmc_pageId = "tmcgys111";
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
	<%
RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
//RCMenu += "{新增客户动态,javascript:openDyInfo(),_blank} " ;
//RCMenuHeight += RCMenuHeightStep ;
%>
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
				<wea:item>商品名称</wea:item>
				<wea:item>
				 <input name="spmc" id="spmc" class="InputStyle" type="text" value="<%=spmc%>"/>
				</wea:item>
                
				<wea:item>创建日期</wea:item>
				<wea:item>
					<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON> 
						<SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN> 
						<INPUT type="hidden" name="beginDate" value="<%=beginDate%>">  
					&nbsp;-&nbsp;
					<button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON> 
						<SPAN id=endDateSpan><%=endDate%></SPAN> 
						<INPUT type="hidden" name="endDate" value="<%=endDate%>">  
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
								
	String backfields = " c.id,a.requestid,a.requestname,a.workflowid,(select goodsname from  uf_goodsinfo where id=c.goodsname) as name ,c.unit,c.vendor,c.purchaseprice,c.purchasenum,c.purchasepricex ,a.createdate  "; 
	String fromSql  = " from workflow_requestbase a join formtable_main_74 b on a.requestid=b.requestId join formtable_main_74_dt1  c  on b.id=c.mainid ";
	String sqlWhere = " where a.currentnodetype>=3 and vendor = '"+customID+"'";
	
	String orderby = " c.id asc " ;
	String tableString = "";
	if(!"".equals(spmc)){
		sqlWhere +=  " and (select goodsname from  uf_goodsinfo where id=c.goodsname) like '%"+spmc+"%' ";
	}
	
	if(!"".equals(beginDate)){
		sqlWhere +=  " and createdate >='"+beginDate+"'";
	}
	if(!"".equals(endDate)){
		sqlWhere +=  " and createdate <='"+endDate+"'";
	}

   


//  右侧鼠标 放上可以点击
String  operateString= "";
String para1="column:requestid+column:workflowid+column:viewtype+0+"+user.getLanguage();
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"c.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"15%\"  text=\"商品名称\" column=\"name\" orderkey=\"name\"/>"+
		"<col width=\"15%\"  text=\"单位\" column=\"unit\" orderkey=\"unit\"/>"+
		"<col width=\"15%\"  text=\"入库单价\" column=\"purchaseprice\" orderkey=\"purchaseprice\"/>"+
	  "				<col width=\"15%\"  text=\"入库数量\" column=\"purchasenum\" orderkey=\"purchasenum\"  />"+
	  "				<col width=\"15%\"  text=\"入库金额\" column=\"purchasepricex\" orderkey=\"purchasepricex\"  />"+     
	  "				<col width=\"15%\"  text=\"入库时间\" column=\"createdate\" orderkey=\"createdate\"  />"+
	"			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
        function onBtnSearchClick() {
			report.submit();
		 }
	</script>
	
			<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
