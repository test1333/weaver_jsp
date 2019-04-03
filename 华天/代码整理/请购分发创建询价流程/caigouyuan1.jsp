<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

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


String qgdbh = Util.null2String(request.getParameter("qgdbh"));
String lh = Util.null2String(request.getParameter("lh"));
String qgr = Util.null2String(request.getParameter("qgr"));

 int userid  = user.getUID();
String tmc_pageId = "qg111";
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
RCMenu += "{创建流程,javascript:createRequest(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=/htkj/caigou/caigouyuan1.jsp  method=post>
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
                <wea:item>请购单编号</wea:item>
				<wea:item>
				 <input name="qgdbh" id="qgdbh" class="InputStyle" type="text" value="<%=qgdbh%>"/>
				</wea:item>
				<wea:item>料号</wea:item>
				<wea:item>
				 <input name="lh" id="lh" class="InputStyle" type="text" value="<%=lh%>"/>
				</wea:item>
				<wea:item>请购人</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="qgr" browserValue="<%=qgr %>" 
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(qgr),user.getLanguage())%>">
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
    String backfields="";
	String fromSql ="";
	String sqlWhere = "";

     backfields = "id,qgdbh,case when bsfs='1' then '保税' else '非保税' end as bsfs,lh,wlmc,xh,gg,th,dwzw,sl,yt,qgr,status"; 
	 fromSql  = " from uf_data_qinggou  ";
	 sqlWhere = " where 1=1 and status ='2' ";
	
	if(!"".equals(qgdbh)){
		sqlWhere +=" and Upper(qgdbh) like Upper('%"+qgdbh+"%') ";
	}
	if(!"".equals(lh)){
		sqlWhere +=" and Upper(lh) like Upper('%"+lh+"%') ";
	}
	
	if(!"".equals(qgr)){
		sqlWhere +=" and qgr='"+qgr+"'";
	}
	if(userid != 1){
		sqlWhere +=" and cgy='"+userid+"'";
	}
	

	//out.print("select "+backfields+fromSql+sqlWhere);
	String orderby = " id " ;
	String tableString = "";
	

   


//  右侧鼠标 放上可以点击
String  operateString= "";
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+

		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"10%\"  text=\"请购单编号\" column=\"qgdbh\" orderkey=\"qgdbh\"/>"+
		"<col width=\"6%\"  text=\"保税方式\" column=\"bsfs\" orderkey=\"bsfs\"/>"+
		"<col width=\"10%\"  text=\"料号\" column=\"lh\" orderkey=\"lh\"/>"+
		"<col width=\"10%\"  text=\"物料名称\" column=\"wlmc\" orderkey=\"wlmc\"/>"+
		"<col width=\"10%\"  text=\"型号\" column=\"xh\" orderkey=\"xh\"/>"+
		"<col width=\"10%\"  text=\"规格\" column=\"gg\" orderkey=\"gg\"/>"+
		//"<col width=\"10%\"  text=\"图号\" column=\"th\" orderkey=\"th\"/>"+
		"<col width=\"6%\"  text=\"单位\" column=\"dwzw\" orderkey=\"dwzw\"/>"+
		"<col width=\"6%\"  text=\"数量\" column=\"sl\" orderkey=\"sl\"/>"+
		"<col width=\"10%\"  text=\"用途\" column=\"yt\" orderkey=\"yt\"/>"+
		"<col width=\"8%\"  text=\"请购人\" column=\"qgr\" orderkey=\"qgr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
		//"<col width=\"4%\"  text=\"状态\" column=\"status\" orderkey=\"status\"/>"+
	"			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
        function onBtnSearchClick() {
			report.submit();
		 }


		function createRequest(){
			var ids = _xtable_CheckedCheckboxId();
			var sqr=<%=userid%>;
			//alert(sqr);
            if(ids!=null && ids!=""){
			//  alert(ids);
			  	var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/htkj/caigou/createRequest.jsp?id="+ids+"&sqr="+sqr, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
								//alert(text);
								
							}	
						}
					}
				xhr.send(null);			
				}
				window.location.reload();
			}
		}
	</script>
	
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
