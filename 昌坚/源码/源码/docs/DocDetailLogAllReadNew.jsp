<%@ page import="weaver.general.Util" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<HTML><HEAD>
<%
	int id = Util.getIntValue(request.getParameter("id"),0);
 %>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript">
var dialog = null;
try{
	dialog = parent.parent.getDialog(parent); 
}catch(e){}

jQuery(document).ready(function(){
	jQuery("#topTitle").topMenuTitle();
	jQuery("#hoverBtnSpan").hoverBtn();
});
</script>
</head>
<%
String imagefilename = "/images/hdMaintenance_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(21990,user.getLanguage());
String needfav ="1";
String needhelp ="";
String isDialog = Util.null2String(request.getParameter("isdialog"));
String creater = Util.null2String(request.getParameter("creater")) ;
String fromdate = Util.null2String(request.getParameter("fromdate")) ;
String todate = Util.null2String(request.getParameter("todate")) ;
String creatername = "";
if(!creater.equals("")){
	String[] tmpArr = creater.split(",");
	for(int i=0;i<tmpArr.length;i++){
		if(creatername.equals("")){
			creatername = Util.toScreen(ResourceComInfo.getLastname(tmpArr[i]),user.getLanguage());
		}else{
			creatername = creatername+","+Util.toScreen(ResourceComInfo.getLastname(tmpArr[i]),user.getLanguage());
		}
	}
}
%>
<BODY>
<%if("1".equals(isDialog)){ %>
<div class="zDialog_div_content">
<%} %>
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;" >
	<FORM id=searchfrm name=searchfrm method=post>
		<wea:layout type="4col">
			<wea:group context='<%=SystemEnv.getHtmlLabelName(20331,user.getLanguage())%>'>
			    <wea:item><%=SystemEnv.getHtmlLabelName(17482,user.getLanguage())%></wea:item>
			    <wea:item>
			    <brow:browser viewType="0" name="creater" browserValue='<%= ""+creater %>' 
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MultiResourceBrowser.jsp?resourceids="
						hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
						completeUrl="/data.jsp" 
						browserSpanValue='<%=creatername%>'>
				</brow:browser>
			    </wea:item>
			    <wea:item><%=SystemEnv.getHtmlLabelName(21663,user.getLanguage())%></wea:item>
			    <wea:item>
			    	<span class="wuiDateSpan">
					    <input class=wuiDateSel type="hidden" name="fromdate" value="<%=fromdate%>">
					    <input class=wuiDateSel  type="hidden" name="todate" value="<%=todate%>">
					</span>
			    </wea:item>
		    </wea:group>
		     <wea:group context="" attributes="{'groupDisplay':'none'}">
				<wea:item type="toolbar">
					<input type="submit" value="<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%>" class="e8_btn_submit""/>
					<input type="button" value="<%=SystemEnv.getHtmlLabelName(2022,user.getLanguage())%>" class="e8_btn_cancel" onclick="resetCondtion();"/>
					<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
			</wea:group>
	    </wea:layout>
	</FORM>
</div>


			<%
				//设置好搜索条件				
				String docid = Util.null2String(request.getParameter("id"));
				
				
				String tableString=""+
					   "<table datasource=\"weaver.docs.docs.DocDataSource.getAllReadLog\" sourceparams=\"id:"+docid+"+operateuserid:"+creater+"+fromdate:"+fromdate+"+todate:"+todate+"\" pagesize=\""+PageIdConst.getPageSize(PageIdConst.DOC_ALLREADDOCLOG,user.getUID(),PageIdConst.DOC)+"\" tabletype=\"none\">"+
					   "<sql backfields=\"*\"  sqlform=\"temp\" sqlorderby=\"id\"  sqlprimarykey=\"id\" sqlsortway=\"desc\"  />"+
					   "<head>";
					   		tableString+=	 "<col width=\"20%\"  text=\""+SystemEnv.getHtmlLabelName(97,user.getLanguage())+"\" column=\"operatedate\" orderkey=\"operatedate\" />";
					   		tableString += "<col width=\"15%\"  text=\""+SystemEnv.getHtmlLabelName(99,user.getLanguage())+"\" column=\"operateuserid\" orderkey=\"operateuserid\"/>";
							tableString += "<col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(63,user.getLanguage())+"\" column=\"operatetype\" orderkey=\"operatetype\"/>";
							tableString +=	 "<col width=\"15%\"  text=\""+SystemEnv.getHtmlLabelName(84,user.getLanguage())+"\" column=\"tag\"  orderkey=\"tag\" />";
							tableString += "<col width=\"25%\"  text=\""+SystemEnv.getHtmlLabelName(229,user.getLanguage())+"\" column=\"subject\" orderkey=\"subject\"/>";
							tableString +=	 "<col width=\"15%\"  text=\""+SystemEnv.getHtmlLabelName(108,user.getLanguage())+SystemEnv.getHtmlLabelName(110,user.getLanguage())+"\" column=\"clientaddress\"  orderkey=\"clientaddress\" />"+
					   "</head>"+
					   "</table>";      
			  %>
			  <input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.DOC_ALLREADDOCLOG %>"/>
							<wea:SplitPageTag  tableString='<%=tableString%>' isShowTopInfo="false"  mode="run"/> 
 <%if("1".equals(isDialog)){ %>
	</div>
	<div id="zDialog_div_bottom" class="zDialog_div_bottom">
		<wea:layout needImportDefaultJsAndCss="false">
			<wea:group context=""  attributes="{\"groupDisplay\":\"none\"}">
				<wea:item type="toolbar">
					<input type="button" value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>" id="zd_btn_cancle"  class="zd_btn_cancle" onclick="dialog.closeByHand();">
				</wea:item>
			</wea:group>
		</wea:layout>
</div>
	<script type="text/javascript">
		jQuery(document).ready(function(){
			resizeDialog(document);
		});
	</script>
<%} %>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
 </BODY></HTML>
