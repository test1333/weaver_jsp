
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
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
String beginDate = Util.null2String(request.getParameter("beginDate"));
String endDate = Util.null2String(request.getParameter("endDate"));
String beginDate2 = Util.null2String(request.getParameter("beginDate2"));
String endDate2 = Util.null2String(request.getParameter("endDate2"));
String memberIDs = Util.null2String(request.getParameter("memberIDs"));
String tmpaccepterids="";
String tmpaccepterNames="";
ArrayList accepterids1=Util.TokenizerString(memberIDs,",");
if(accepterids1.size()!=0){
	for(int m=0; m < accepterids1.size(); m++){
		String tmpaccepterid=(String) accepterids1.get(m);
		tmpaccepterids+=","+tmpaccepterid;
		//tmpaccepterNames+="<a href='/hrm/resource/HrmResource.jsp?id="+tmpaccepterid+"' target='_blank'>"+Util.toScreen(ResourceComInfo.getResourcename(tmpaccepterid),user.getLanguage())+"</a> &nbsp;";
		tmpaccepterNames+=Util.toScreen(ResourceComInfo.getResourcename(tmpaccepterid),user.getLanguage())+",";
	}
}
String bh = Util.null2String(request.getParameter("bh"));

String tmc_pageId = "tmcCus0011";
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
	RCMenu += "{"+"提交"+",javascript:goodCommit(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type="button" value="提交" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="goodCommit();"/>
						<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
	
		<wea:item>申请人</wea:item>
		<wea:item>
			<brow:browser viewType="0" name="memberIDs" browserValue='<%=tmpaccepterids %>' temptitle='<%=SystemEnv.getHtmlLabelName(15525,user.getLanguage())%>' 
				browserOnClick="" browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=" 
				hasInput="true"  isSingle="false" hasBrowser = "true" isMustInput='1'  width="300px" 
				completeUrl="/data.jsp" linkUrl="javascript:openhrm($id$)" 
				browserSpanValue='<%=tmpaccepterNames%>'></brow:browser>
		</wea:item>
		<wea:item>编号</wea:item>
		<wea:item>
				 <input name="bh" id="bh" class="InputStyle" type="text" value="<%=bh%>"/>
		</wea:item>
	  <wea:item>填表日期</wea:item>
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
			<input class="e8_btn_submit" type="submit" name="submit_1" onClick="OnSearch()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>		
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
		</wea:item>
	</wea:group>
	
</wea:layout>

</div>
	</FORM>
	<%


							
	String backfields = "a.requestid,b.id,a.id as mainid ,a.sqr,a.tbrq,a.tbrq2,a.bh,b.xqsl,b.hpmc,(select name from cptcapital where id=b.hpmc) as name,b.ggxh,b.dw ,(select unitname from LgcAssetUnit where id= b.dw) as dwname,b.sgsl,b.dj,b.je "; 
	String fromSql  = " from formtable_main_28 a join formtable_main_28_dt1 b on a.id=b.mainid join workflow_requestbase c on a.requestid = c.requestid  ";
	String sqlWhere = " where c.currentnodetype>=3 and b.id not in (select cptid from uf_cptLog) ";
	String orderby = " c.requestid desc " ;
	String tableString = "";
    if(!"".equals(beginDate)){
		sqlWhere +=  " and a.tbrq2 >='"+beginDate+"'";
	}
	if(!"".equals(endDate)){
		sqlWhere +=  " and a.tbrq2 <='"+endDate+"'";
	}
	
	if(!"".equals(memberIDs)){
		sqlWhere +=  " and a.sqr in ("+memberIDs+")";
	}
	if(!"".equals(bh)){
		sqlWhere +=  " and a.bh = '"+bh+"'";
	}

	

//out.print("select "+backfields+fromSql+sqlWhere);

//  右侧鼠标 放上可以点击
String  operateString= "";

tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"b.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                  
		tableString+="<col width=\"10%\"  text=\"编号\" column=\"bh\" orderkey=\"bh\" />"+
		"<col width=\"10%\"  text=\"货品名称\" column=\"name\" orderkey=\"name\" />"+
		 "				<col width=\"10%\"  text=\"规格型号\" column=\"ggxh\" orderkey=\"ggxh\" />"+
	 "				<col width=\"10%\"  text=\"单位\" column=\"dwname\" orderkey=\"dwname\" />"+
	  "				<col width=\"10%\"  text=\"需求数量\" column=\"xqsl\" orderkey=\"xqsl\"  />"+
	  "				<col width=\"10%\"  text=\"申请人\" column=\"sqr\" orderkey=\"sqr\"   transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
	  "				<col width=\"12%\"  text=\"填表日期\" column=\"tbrq2\" orderkey=\"tbrq2\"  />"+
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

	<script type="text/javascript">
	
		function onBtnSearchClick() {
			report.submit();
		}
		function goodCommit(){
			var multirequestid = _xtable_CheckedCheckboxId()+'0';
			if(multirequestid == '0'){
				alert("请先选择采购记录");
				return;
			}
	    var title = "填写入库单";
	
		
		var url = "/ksy/CptInstock.jsp?cptids="+multirequestid;
		
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1000;
		diag_vote.Height = 600;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show();

		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
