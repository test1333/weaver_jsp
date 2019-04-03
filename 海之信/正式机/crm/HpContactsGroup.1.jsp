
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
<script language=javascript >
	function openNewInfo1(id) {
		
		var title = "";
		var url = "/formmode/view/ViewMode.jsp?type=0&modeId=56&formId=-63&opentype=0&customid=37&viewfrom=fromsearchlist&billid="+id;
		
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1024;
		diag_vote.Height = 800;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
			
	}
</script>
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
	     
String customID = Util.null2String(request.getParameter("customID"));
if("".equals(customID)){
	customID = "-1";
}
%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
	<input type="hidden" name="customID" value="<%=customID%>">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type="button" value="新增" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="openDyInfo();"/>				
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">


	</div>
	
		<div>
		<table width="100%">
			<colgroup> <col width="10%" /><col/><col /></colgroup>
			<tr><td></td><td></td></tr><tr><td></td><td></td></tr>
		<tr><td></td><td>
		<table width="90%" align="center">
	  	  	<colgroup> <col width="35%" /><col width="10%" /><col /></colgroup> 
	  	       <tr> <td></td><td></td><td></td> </tr>
	  	       <tr> 
	  	       	<% 
					String sql = "select id,Name,tel,mobile,email,Address,Postcode from uf_Contacts where SuperID is null and dealStatus in(0,1) and GroupName="+customID;
	                RecordSet.executeSql(sql);
	            	int flag = 0;
	            	while(RecordSet.next()){  
	            		flag ++;
	            		String tmp_id = Util.null2String(RecordSet.getString("id"));
	            		String tmp_name = Util.null2String(RecordSet.getString("Name"));
	            		String tmp_mobile = Util.null2String(RecordSet.getString("mobile"));
	            		String tmp_tel = Util.null2String(RecordSet.getString("tel"));
	            		String tmp_email = Util.null2String(RecordSet.getString("email"));
	            		String tmp_Postcode = Util.null2String(RecordSet.getString("Postcode"));
	            		String tmp_Address = Util.null2String(RecordSet.getString("Address"));
	            		if(flag%2==0){
	            	%>
	            		<td></td>
	  	           <td>
	  	           		<table width="424" tabindex="-1" class="msoUcTable" style="width: 318pt; border-collapse: collapse; table-layout: fixed; -ms-word-wrap: break-word;" border="1" cellpadding="0">
						    <colgroup> <col width="43" style="width: 32pt;"></col> <col width="72" style="width: 54pt;"></col> <col width="93" style="width: 70pt;"></col> <col width="72" style="width: 54pt;"></col> <col width="72" style="width: 54pt;"></col> <col width="72" style="width: 54pt;"></col></colgroup>
						    <tbody>
						        <tr style="min-height: 14.25pt;">
						            <td valign="middle" style="border-width: 0.5pt; border-style: solid; border-color: windowtext black windowtext windowtext; font-size: 11pt;" bgcolor="#b6dde8" colspan="6"><a href="javascript:openNewInfo1(<%=tmp_id%>);"><font face="宋体"><%=tmp_name%></font></a></td>
						        </tr>
						        <tr style="min-height: 18.75pt;">
						            <td valign="bottom" style="border-width: 0.5pt medium medium 0.5pt; border-style: solid none none solid; border-color: windowtext currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="top" style="border-width: 0.5pt 0.5pt medium medium; border-style: solid solid none none; border-color: windowtext black currentColor currentColor; font-size: 14pt;" colspan="5"><a href="javascript:openNewInfo1(<%=tmp_id%>);"><font face="宋体"><strong><%=tmp_name%></strong></a></font></td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;"><font face="宋体"><strong>移动电话</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor black currentColor currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font face="Tahoma"><%=tmp_mobile%></font></div>
						            </td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;"><font face="宋体"><strong>电话</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor black currentColor currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font face="Tahoma"><%=tmp_tel%></font></div>
						            </td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;"><font face="宋体"><strong>邮箱</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor black currentColor currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font color="#0066cc" face="Tahoma"><a href="mailto:<%=tmp_email%>"><%=tmp_email%></a></font></div>
						            </td>
						        </tr>
						        <tr style="min-height: 2pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;">&nbsp;</td>
						            <td valign="middle" style="border: currentColor; font-size: 11pt;">
						            <div align="left">&nbsp;</div>
						            </td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;">&nbsp;</td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;">&nbsp;</td>
						            <td valign="bottom" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor windowtext currentColor currentColor; font-size: 11pt;"><font face="Tahoma">　</font></td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;"><font face="宋体"><strong>地址</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor black currentColor currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font face="宋体" style="color: black; font-size: 11pt;"> <%=tmp_Address%></font></div>
						            </td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium 0.5pt 0.5pt; border-style: none none solid solid; border-color: currentColor currentColor windowtext windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border-width: medium medium 0.5pt; border-style: none none solid; border-color: currentColor currentColor windowtext; font-size: 11pt;"><font face="宋体"><strong>邮编</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt 0.5pt medium; border-style: none solid solid none; border-color: currentColor black windowtext currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font face="Tahoma"><%=tmp_Postcode%></font></div>
						            </td>
						        </tr>
						    </tbody>
						</table>
						<br>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type=button class="e8_btn_top" onclick="dyMe(<%=tmp_id%>);" value="新建动态"></input>
		  	                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  	                    <input type=button class="e8_btn_top" onclick="foMe(<%=tmp_id%>);" value="加关注"></input>
		  	          </td> 
		  	            </tr>
	  	            	<%}else{%>
	  	           <td> 
	  	           	   
        		<table width="424" tabindex="-1" class="msoUcTable" style="width: 318pt; border-collapse: collapse; table-layout: fixed; -ms-word-wrap: break-word;" border="1" cellpadding="0">
						    <colgroup> <col width="43" style="width: 32pt;"></col> <col width="72" style="width: 54pt;"></col> <col width="93" style="width: 70pt;"></col> <col width="72" style="width: 54pt;"></col> <col width="72" style="width: 54pt;"></col> <col width="72" style="width: 54pt;"></col></colgroup>
						    <tbody>
						        <tr style="min-height: 14.25pt;">
						            <td valign="middle" style="border-width: 0.5pt; border-style: solid; border-color: windowtext black windowtext windowtext; font-size: 11pt;" bgcolor="#b6dde8" colspan="6"><a href="javascript:openNewInfo1(<%=tmp_id%>);"><font face="宋体"><%=tmp_name%></font></a></td>
						        </tr>
						        <tr style="min-height: 18.75pt;">
						            <td valign="bottom" style="border-width: 0.5pt medium medium 0.5pt; border-style: solid none none solid; border-color: windowtext currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="top" style="border-width: 0.5pt 0.5pt medium medium; border-style: solid solid none none; border-color: windowtext black currentColor currentColor; font-size: 14pt;" colspan="5"><a href="javascript:openNewInfo1(<%=tmp_id%>);"><font face="宋体"><strong><%=tmp_name%></strong></font></font></td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;"><font face="宋体"><strong>移动电话</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor black currentColor currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font face="Tahoma"><%=tmp_mobile%></font></div>
						            </td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;"><font face="宋体"><strong>电话</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor black currentColor currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font face="Tahoma"><%=tmp_tel%></font></div>
						            </td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;"><font face="宋体"><strong>邮箱</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor black currentColor currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font color="#0066cc" face="Tahoma"><a href="mailto:<%=tmp_email%>"><%=tmp_email%></a></font></div>
						            </td>
						        </tr>
						        <tr style="min-height: 2pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;">&nbsp;</td>
						            <td valign="middle" style="border: currentColor; font-size: 11pt;">
						            <div align="left">&nbsp;</div>
						            </td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;">&nbsp;</td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;">&nbsp;</td>
						            <td valign="bottom" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor windowtext currentColor currentColor; font-size: 11pt;"><font face="Tahoma">　</font></td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium medium 0.5pt; border-style: none none none solid; border-color: currentColor currentColor currentColor windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border: currentColor; font-size: 11pt;"><font face="宋体"><strong>地址</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt medium medium; border-style: none solid none none; border-color: currentColor black currentColor currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font face="宋体" style="color: black; font-size: 11pt;"> <%=tmp_Address%></font></div>
						            </td>
						        </tr>
						        <tr style="min-height: 14.25pt;">
						            <td valign="bottom" style="border-width: medium medium 0.5pt 0.5pt; border-style: none none solid solid; border-color: currentColor currentColor windowtext windowtext; font-size: 11pt;" bgcolor="#f2f2f2"><font face="Tahoma">　</font></td>
						            <td valign="bottom" style="border-width: medium medium 0.5pt; border-style: none none solid; border-color: currentColor currentColor windowtext; font-size: 11pt;"><font face="宋体"><strong>邮编</strong></font></td>
						            <td valign="middle" style="border-width: medium 0.5pt 0.5pt medium; border-style: none solid solid none; border-color: currentColor black windowtext currentColor; font-size: 11pt;" colspan="4">
						            <div align="left"><font face="Tahoma"><%=tmp_Postcode%></font></div>
						            </td>
						        </tr>
						    </tbody>
						</table>
					    <br>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type=button class="e8_btn_top" onclick="dyMe(<%=tmp_id%>);" value="新建动态"></input>
		  	                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  	                    <input type=button class="e8_btn_top" onclick="foMe(<%=tmp_id%>);" value="加关注"></input>
	  	           </td> 
	  	            	<%}
	  	            	}%>
			  	        <%if(flag%2 ==1) {%></tr> <%}%>
		  </table>
		</td></tr></table>

	</div>
	</FORM>

<script type="text/javascript">
   
   function openDyInfo() {
		var title = "";
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=ctgnew,<%=customID%>";
		// var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=custom,,";

		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1024;
		diag_vote.Height = 800;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show();
		

	}
	
	// 加关注
	function foMe(id) {

			var title = "";
			var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward_1.jsp?typex=foMe,0,"+id;

			var diag_vote = new window.top.Dialog();
			diag_vote.currentWindow = window;
			diag_vote.Width = 600;
			diag_vote.Height = 400;
			diag_vote.Modal = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.isIframe=false;
			diag_vote.show();	
	}
               // 动态
	
		function dyMe(id) {
			var title = "";
			var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward_1.jsp?typex=dyMe,0,"+id;

			var diag_vote = new window.top.Dialog();
			diag_vote.currentWindow = window;
			diag_vote.Width = 600;
			diag_vote.Height = 400;
			diag_vote.Modal = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.isIframe=false;
			diag_vote.show();	
		}	
	
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
	}	
	
	function onCheckup(){
		var ids = _xtable_CheckedCheckboxId();
		if(ids != ""){
	//		alert("ids = " + ids);
			document.report.multiIds.value = ids;
			document.report.action = "/seahonor/crm/NpForCustomContactsOper.jsp";
		//	obj.disabled = true;
			document.report.submit();
		}else{
        	top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
    	}
	}
		
	function onShowSubcompanyid1(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#subcompanyid1span").html(data.name);
				jQuery("#subcompanyid1").val(data.id);
				makechecked();
			}else{
				jQuery("#subcompanyid1span").html("");
				jQuery("#subcompanyid1").val("");
			}
		}
	}
	
	function onShowDepartmentid(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#departmentidspan").html(data.name);
				jQuery("#departmentid").val(data.id);
				makechecked();
			}else{
				jQuery("#departmentidspan").html("");
				jQuery("#departmentid").val("");
			}
		}
	}
	
		function makechecked() {
			if ($GetEle("subcompanyid1").value != "") {
				$($GetEle("chkSubCompany")).css("display", "");
				$($GetEle("lblSubCompany")).css("display", "");
			} else {
				$($GetEle("chkSubCompany")).css("display", "none");
				$($GetEle("chkSubCompany")).attr("checked", "");
				$($GetEle("lblSubCompany")).css("display", "none");
			}
			jQuery("body").jNice();
		}
		function onBtnSearchClick() {
			report.submit();
		}
		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}
	</script>
</BODY>
</HTML>
