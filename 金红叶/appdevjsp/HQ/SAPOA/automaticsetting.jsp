
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="weaver.hrm.User"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<% 
if(!HrmUserVarify.checkUserRight("OutDataInterface:Setting",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
%>
<html>
<head>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/dragBox/parentShowcol_wev8.js"></script>
<link rel="stylesheet" href="/css/ecology8/request/requestView_wev8.css" type="text/css" />

<%
String imagefilename = "/images/hdDOC_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(33720,user.getLanguage());
String needfav ="1";
String needhelp ="";
String zhongjian=Util.null2String(request.getParameter("zhongjian"));
String biaoji=Util.null2String(request.getParameter("biaoji"));
String typename = Util.null2String(request.getParameter("typename"));
String backto = Util.null2String(request.getParameter("backto"));
if(!"".equals(backto))
	typename = backto;
String deteteviewid = Util.null2String(request.getParameter("deteteviewid"));
List idlist = Util.TokenizerString(deteteviewid,",");
if(null!=idlist&&idlist.size()>0)
{
	for(int i = 0;i<idlist.size();i++)
	{
		String tempid = Util.null2String((String)idlist.get(i));
		if(!"".equals(tempid)&&"".equals(zhongjian))
		{
			RecordSet.executeSql("update  zoa_wfcode_mapping set IsActive=0   where id="+tempid);
    		//RecordSet.executeSql("delete from zoa_wfcode_mapping where mainid="+tempid);
		}else if(!"".equals(tempid)&&!"".equals(zhongjian)){
			RecordSet.executeSql("update  zoa_wfcode_mapping set IsActive=1   where id="+tempid);
		}
	}
}
String setname = Util.null2String(request.getParameter("setname"));
String namesimple = Util.null2String(request.getParameter("namesimple"));
String workflowname = Util.null2String(request.getParameter("workflowname"));
//String backfields=" a.id as aid,a.LC_TYPE ,b.workflowname " ;
String backfields=" a.* ,b.workflowname " ;
String urlType="10";
//String PageConstId = "AutomaticSetting_gxh";
String PageConstId = "DDDDDDDDDDD";
String fromSql=" zoa_wfcode_mapping a,workflow_base b "; 
String sqlwhere = "where a.WfId=b.id ";
if(biaoji.equals("1")){
	sqlwhere += " and IsActive=1 ";
}else{
	sqlwhere += " and IsActive=0 ";
}
//out.print ("select "+backfields+ " from "+fromSql+sqlwhere);
if(!"".equals(setname))
	sqlwhere += " and a.LC_TYPE like '%"+setname+"%'";
String tableString="";
if(!"".equals(workflowname))
{	
	sqlwhere+=" and b.workflowname like '%"+workflowname+"%'";
}

String orderby =" a.id  ";
//tableString =  " <table tabletype=\"checkbox\" pagesize=\""+PageIdConst.getPageSize(PageIdConst.WF_AUTOMATICWF_AUTOMATICSETTING,user.getUID())+"\" >";
tableString = " <table instanceid=\"ListTable\" tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageConstId,user.getUID())+"\" pageId=\""+PageConstId +"\">";
tableString += " <checkboxpopedom  id=\"checkbox\"   popedompara=\"column:a.id\" showmethod=\"weaver.general.SplitPageTransmethod.getCheckBox\" />"+

		 " <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlwhere)+"\"   sqlorderby=\""+orderby+"\"   sqlprimarykey=\"a.id\" sqlsortway=\"Desc\" sqlisdistinct=\"true\" />"+
         "       <head>"+
        // "           <col width=\"20%\"  text=\""+SystemEnv.getHtmlLabelName(195 ,user.getLanguage())+"\" column=\"LC_TYPE\" orderkey=\"LC_TYPE\" linkvaluecolumn=\"aid\"  linkkey=\"viewid\" href=\"/appdevjsp/HQ/SAPOA/showViewTab.jsp?isdialog=1&amp;_fromURL=2&amp;backto=&amp;typename=\" target=\"_blank\" />"+
	"  <col width=\"10%\"  text=\"ID\" column=\"id\" orderkey=\"a.id\"   />"+	 
	
 "  <col width=\"20%\"  text=\"SAP流程类型\" column=\"LC_TYPE\" orderkey=\"LC_TYPE\"   otherpara=\"column:id\"  transmethod=\"APPDEV.HQ.SAPOAInterface.tanchuang.getLinkType\" />"+
//<col width=\"40%\"  text=\""+SystemEnv.getHtmlLabelName(195,user.getLanguage())+"\" column=\"typename\" otherpara=\"column:id\" orderkey=\"typename\" transmethod=\"weaver.workflow.workflow.WorkTypeComInfo.getLinkType\"/>"+
		 
		 "           <col width=\"50%\"  text=\""+SystemEnv.getHtmlLabelName(2079 ,user.getLanguage())+"\" column=\"workflowname\" orderkey=\"workflowname\"  otherpara=\"column:id\"  transmethod=\"APPDEV.HQ.SAPOAInterface.tanchuang.getLinkType\"/>"+
         "       </head>"+
         "<operates width=\"20%\">";
		 
if(biaoji.equals("1")){
	tableString +=  
		 " <popedom transmethod=\"weaver.general.SplitPageTransmethod.getOpratePopedom\" otherpara=\"2\" ></popedom> "+
		 "     <operate href=\"javascript:doEditById()\"  linkkey=\"aid\" linkvaluecolumn=\"id\" text=\""+SystemEnv.getHtmlLabelName(93,user.getLanguage())+"\" target=\"_self\" index=\"0\"/>"+
		 "     <operate href=\"javascript:doDeleteById()\" linkkey=\"aid\" linkvaluecolumn=\"id\" text=\""+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"\" target=\"_fullwindow\" index=\"1\"/>"+       
		 "</operates>"+
         " </table>";
}else{
	tableString +=  
		 " <popedom transmethod=\"weaver.general.SplitPageTransmethod.getOpratePopedom\" otherpara=\"2\" ></popedom> "+
		// "     <operate href=\"javascript:doEditById()\"  linkkey=\"id\" linkvaluecolumn=\"id\" text=\""+SystemEnv.getHtmlLabelName(93,user.getLanguage())+"\" target=\"_self\" index=\"0\"/>"+
		 "     <operate href=\"javascript:recoveryById()\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\""+SystemEnv.getHtmlLabelName(16211,user.getLanguage())+"\" target=\"_fullwindow\" index=\"1\"/>"+       
		 "</operates>"+
         " </table>";
}
			
%>
<body>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
if(biaoji.equals("1")){
RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",javascript:add(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:del(),_self} " ;//---------------------暂未获得id
RCMenuHeight += RCMenuHeightStep ;}
else{
	RCMenu += "{"+SystemEnv.getHtmlLabelName(16211,user.getLanguage())+",javascript:recovery(),_self} " ;//-----------------还没写
RCMenuHeight += RCMenuHeightStep ;
	
}

%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form name="frmmain" method="post" action="automaticsetting.jsp">
<input type="hidden" id="deteteviewid" name="deteteviewid" value="">
<input type="hidden" id="zhongjian" name="zhongjian" value="">
<input name="typename" value="<%=typename %>" type="hidden" />
<input name="backto" value="<%=typename %>" type="hidden" />
<input type="hidden" id="biaoji" name="biaoji" value="1">
<!--<input type="hidden" name="pageId" id="pageId" value="<%=PageIdConst.WF_AUTOMATICWF_AUTOMATICSETTING%>"/>-->
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
		<td class="rightSearchSpan">
		<%if(biaoji.equals("1")){%>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(82,user.getLanguage()) %>" class="e8_btn_top" onclick="add()"/>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(91,user.getLanguage()) %>" class="e8_btn_top" onclick="del()"/>
		<%
			}else{//-------------------还未做	
		%>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(16211,user.getLanguage()) %>" class="e8_btn_top" onclick="recovery()"/>
			<%}%>
			<input type="text" class="searchInput" name="namesimple" value="<%=setname%>"/>
			&nbsp;&nbsp;&nbsp;
			<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage()) %></span>&nbsp;&nbsp;
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage()) %>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<div id="tabDiv" >
   <span style="font-size:14px;font-weight:bold;"><%=SystemEnv.getHtmlLabelName(32366,user.getLanguage()) %></span> <!-- 流程触发集成列表 -->
</div>

<div class="cornerMenuDiv"></div>
<div class="advancedSearchDiv" id="advancedSearchDiv">
<wea:layout type="4col">
	<wea:group context='<%= SystemEnv.getHtmlLabelName(20331,user.getLanguage())%>'>
	  <wea:item>SAP流程类型</wea:item>
	  <wea:item><input  type="text" name="setname" value='<%=setname%>'></wea:item>
	  <wea:item><%=SystemEnv.getHtmlLabelName(2079,user.getLanguage())%></wea:item>
	  <wea:item><input   type="text" name="workflowname" value='<%=workflowname%>'></wea:item>
    </wea:group>
	<wea:group context="" attributes="{'groupDisplay':'none'}">
		<wea:item type="toolbar">
		
		<%if(biaoji.equals("1")){%>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(197 ,user.getLanguage()) %>" class="zd_btn_submit" onclick="zd_btn_submit(1)" />
		<%
			}else{
			
		%>	
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(197 ,user.getLanguage()) %>" class="zd_btn_submit" onclick="zd_btn_submit(2)" />	
			
		<%}%>	
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(2022 ,user.getLanguage()) %>" class="e8_btn_cancel" onclick="resetCondtion();"/>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(201 ,user.getLanguage()) %>" class="zd_btn_cancle" id="cancel"/>
		</wea:item>
	</wea:group>
</wea:layout>
</div>

<TABLE width="100%">
    <tr>
        <td valign="top">  
        	
           	<wea:SplitPageTag  tableString='<%=tableString%>'  mode="run" />
        </td>
    </tr>
</TABLE>
</form>
</body>
</html>
<script language="javascript" src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
<script language="javascript" src="/wui/theme/ecology8/jquery/js/zDrag_wev8.js"></script>
<script language="javascript">
jQuery(document).ready(function () {
	$("#topTitle").topMenuTitle({searchFn:doRefresh});
	$(".topMenuTitle td:eq(0)").html($("#tabDiv").html());
	$("#tabDiv").remove();
	$("#advancedSearch").bind("click", function(){
	  $(".searchInput").val('');
	});
});
var dialog = null;
function closeDialog(){
	if(dialog){
		dialog.close();
	}
}

function openDialog(url,title){
	dialog = new window.top.Dialog();
	dialog.currentWindow = window;
	var url = url;
	dialog.Title = title;
	dialog.Width = 1200;
	dialog.Height = 600;
	dialog.Drag = true;
	dialog.URL = url;
	dialog.maxiumnable=true;//允许最大化
	dialog.show();
}
function showVi(vid){
	if(vid=="") return ;
	var url = "/appdevjsp/HQ/SAPOA/showViewTab.jsp?isdialog=1&_fromURL=2&biaoji=<%=biaoji%>&backto=<%=typename%>&typename=<%=typename%>&viewid="+vid;
	var title = "基本信息查看";
	openDialog(url,title);	
}
function recoveryById(aid){
	var asd="2";
	if(aid=="") return ;
	top.Dialog.confirm("确定要恢复吗？", function (){
		document.frmmain.action = "/appdevjsp/HQ/SAPOA/automaticsetting.jsp";
		document.frmmain.deteteviewid.value = aid;
		document.frmmain.zhongjian.value = asd;
		document.frmmain.biaoji.value = asd;
		var fan=true;
		var  xhr = null;  
		if (window.ActiveXObject) { //IE浏览器 
			
		    xhr = new ActiveXObject("Microsoft.XMLHTTP"); 
		} else if (window.XMLHttpRequest) { 
			xhr = new XMLHttpRequest(); 
		  } 
		if (null != xhr) { 
			
		    xhr.open("GET", "/appdevjsp/HQ/SAPOA/yanzheng.jsp?yanbiao=er&viewid="+aid, false);
		              
		    xhr.onreadystatechange = function () { 
		        if (xhr.readyState == 4) { 
		            if (xhr.status == 200) { 
		                var text = xhr.responseText; 
		                text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						if(text!='1'){
						fan=false;	
						top.Dialog.alert(text);//			
						}
		           } 
		        }  
		   } 
		xhr.send(null); 
	    } 
		if(!fan){	
			return fan;
		} 
		
		document.frmmain.submit();
	}, function () {}, 320, 90,true);	 
	
}
function zd_btn_submit(aa){
	var bb=aa;
	if(bb=='1'){
		document.frmmain.biaoji.value = bb;
		document.frmmain.submit();
		
	}else if(bb=='2'){
		document.frmmain.biaoji.value = "2";
		document.frmmain.submit();
	}else{
		document.frmmain.biaoji.value = "1";
		document.frmmain.submit();
	}
}



function doRefresh()
{
	//document.frmmain.action = "/workflow/automaticwf/automaticsetting.jsp?backto=<%=typename%>&typename=<%=typename%>";
	//document.frmmain.submit();
	var setname=$("input[name='namesimple']",parent.document).val();
	$("input[name='setname']").val(setname);
	window.location="/appdevjsp/HQ/SAPOA/automaticsetting.jsp?backto=<%=typename%>&typename=<%=typename%>&setname="+setname+"&biaoji=<%=biaoji%>";
}
function setdetail()
{
	document.location = "/appdevjsp/HQ/SAPOA/automaticperiodsetting.jsp";
}
function add()
{
	var url = "/appdevjsp/HQ/SAPOA/automaticsettingTab.jsp?isdialog=1&_fromURL=1&backto=<%=typename%>&typename=<%=typename%>";
	var title = "<%=SystemEnv.getHtmlLabelNames("365,33720",user.getLanguage())%>";
	openDialog(url,title);
}
function doEditById(aid)
{	
	if(aid=="") return ;
	var url = "/appdevjsp/HQ/SAPOA/automaticsettingTab.jsp?isdialog=1&_fromURL=2&backto=<%=typename%>&typename=<%=typename%>&viewid="+aid;
	var title = "<%=SystemEnv.getHtmlLabelNames("93,33720",user.getLanguage())%>";
	openDialog(url,title);
}
function doEditDetailById(id,tabid)
{
	if(id=="") return ;
	var url = "/appdevjsp/HQ/SAPOA/showViewTab.jsp?isdialog=1&_fromURL=2&backto=<%=typename%>&typename=<%=typename%>&viewid="+id+"&tabid="+tabid;
	var title = "<%=SystemEnv.getHtmlLabelNames("93,33720",user.getLanguage())%>";
	openDialog(url,title);
}
function resetCondtion()
{
	frmmain.setname.value = "";
	frmmain.workflowname.value = "";
	frmmain.namesimple.value = "";
}

function doDeleteById(aid)
{
	if(aid=="") return ;
	top.Dialog.confirm("<%=SystemEnv.getHtmlLabelName(15097,user.getLanguage())%>", function (){
		document.frmmain.action = "/appdevjsp/HQ/SAPOA/automaticsetting.jsp";
		document.frmmain.deteteviewid.value = aid;
		document.frmmain.submit();
	}, function () {}, 320, 90,true);	
}
function del()
{
	var ids = _xtable_CheckedCheckboxId();
	//alert("ids1 : "+ids);
	if(ids.match(/,$/)){
		ids = ids.substring(0,ids.length-1);
	}
	//alert("ids : "+ids);
	if(ids==""||typeof(ids) == "undefined")
   	{
   		top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage()) %>");
		return ;
   	}
	top.Dialog.confirm("<%=SystemEnv.getHtmlLabelName(15097,user.getLanguage())%>", function (){
		document.frmmain.action = "/appdevjsp/HQ/SAPOA/automaticsetting.jsp";
		document.frmmain.deteteviewid.value = ids;
		document.frmmain.submit();
	}, function () {}, 320, 90,true);		
}


function recovery()
{
	var ids = "";
	if(!ids){
		ids = _xtable_CheckedCheckboxId();
	}
	if(ids.match(/,$/)){
		ids = ids.substring(0,ids.length-1);
	}
	//alert("ids : "+ids);
	if(ids=="")
   	{
   		top.Dialog.alert("<%=SystemEnv.getHtmlLabelNames("18214,126261,16211,18946,563",user.getLanguage()) %>");
		return ;
   	}
	top.Dialog.confirm("确定要恢复吗？", function (){
		var asd="2";
		document.frmmain.action = "/appdevjsp/HQ/SAPOA/automaticsetting.jsp";
		document.frmmain.deteteviewid.value = ids;
		document.frmmain.zhongjian.value = asd;
		document.frmmain.biaoji.value = asd;
		document.frmmain.submit();
	}, function () {}, 320, 90,true);		
}









</script>
