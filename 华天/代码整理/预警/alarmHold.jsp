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


String alarmid = Util.null2String(request.getParameter("alarmid"));
String gxbh = Util.null2String(request.getParameter("gxbh"));
String pc = Util.null2String(request.getParameter("pc"));
String lh = Util.null2String(request.getParameter("lh"));

 int userid  = user.getUID();
String tmc_pageId = "alarm111";
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
RCMenu += "{不处理,javascript:undo(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=/htkj/alarm/alarmHold.jsp method=post>
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
                <wea:item>预警ID</wea:item>
				<wea:item>
				 <input name="alarmid" id="alarmid" class="InputStyle" type="text" value="<%=alarmid%>"/>
				</wea:item>
				<wea:item>工序编号</wea:item>
				<wea:item>
				 <input name="gxbh" id="gxbh" class="InputStyle" type="text" value="<%=gxbh%>"/>
				</wea:item>
				<wea:item>批次</wea:item>
				<wea:item>
				 <input name="pc" id="pc" class="InputStyle" type="text" value="<%=pc%>"/>
				</wea:item>
				<wea:item>料号</wea:item>
				<wea:item>
				 <input name="lh" id="lh" class="InputStyle" type="text" value="<%=lh%>"/>
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
	if(userid == 1){
     backfields = " a.id,wheresystem,aramid,remark,a.gxbh,pc,lh,sbbh,ygxm,decode(status,'0','正常','1','处理中','2','结束','正常') as status "; 
	 fromSql  = " from uf_alarm_info a ";
	 sqlWhere = " where 1=1 and status = '0' ";
	}else{
	 backfields = " a.id,wheresystem,aramid,remark,a.gxbh,pc,lh,sbbh,ygxm,decode(status,'0','正常','1','处理中','2','结束','正常') as status "; 
	 fromSql  = " from uf_alarm_info a ,uf_alarm_hold b";
	 sqlWhere = " where 1=1 and status = '0' and ','||b.gxbh||',' like '%,'||a.gxbh||',%' and a.wheresystem = b.sjkly and b.gsry='"+userid+"'";
	}
	if(!"".equals(alarmid)){
		sqlWhere +=" and a.aramid like '%"+alarmid+"%'";
	}
	if(!"".equals(gxbh)){
		sqlWhere +=" and a.gxbh like '%"+gxbh+"%'";
	}
	
	if(!"".equals(pc)){
		sqlWhere +=" and a.pc like '%"+pc+"%'";
	}
	if(!"".equals(lh)){
		sqlWhere +=" and a.lh like '%"+lh+"%'";
	}

	//out.print("select "+backfields+fromSql+sqlWhere);
	String orderby = " id " ;
	String tableString = "";
	

   


//  右侧鼠标 放上可以点击
String  operateString= "";
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		" <checkboxpopedom  id=\"checkbox\" popedompara=\"column:id\" showmethod=\"htkj.alarm.AlarmUtil.getCanCheck\" />"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"10%\"  text=\"来源\" column=\"wheresystem\" orderkey=\"wheresystem\"/>"+
		"<col width=\"10%\"  text=\"预警ID\" column=\"aramid\" orderkey=\"aramid\"/>"+
		"<col width=\"10%\"  text=\"预警信息\" column=\"remark\" orderkey=\"remark\"/>"+
		"<col width=\"20%\"  text=\"工序编号\" column=\"gxbh\" orderkey=\"gxbh\"/>"+
		"<col width=\"10%\"  text=\"批次\" column=\"pc\" orderkey=\"pc\"/>"+
		"<col width=\"10%\"  text=\"料号\" column=\"lh\" orderkey=\"lh\"/>"+
		"<col width=\"10%\"  text=\"设备编号\" column=\"sbbh\" orderkey=\"sbbh\"/>"+
		"<col width=\"10%\"  text=\"员工\" column=\"ygxm\" orderkey=\"ygxm\"/>"+
		"<col width=\"10%\"  text=\"状态\" column=\"status\" orderkey=\"status\"/>"+
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
					xhr.open("GET","/htkj/alarm/createRequest.jsp?id="+ids+"&sqr="+sqr, false);
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

		function undo(){
			var ids = _xtable_CheckedCheckboxId();
			//alert(sqr);
            if(ids!=null && ids!=""){
			  //alert(ids);
			  	var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/htkj/alarm/undo.jsp?id="+ids, false);
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
