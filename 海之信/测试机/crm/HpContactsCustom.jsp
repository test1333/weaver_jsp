
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
<jsp:useBean id="RecordSet_dt" class="weaver.conn.RecordSet" scope="page" />
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
		diag_vote.Width = 1200;
		diag_vote.Height = 800;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
			
	}
	function changeImage(id1,id2,index){
		var imgs = [id1,id2];
		var url="";
		var currentimage=jQuery('#imagetext'+index).val();
		if(currentimage =='0'){
	      url= "/weaver/weaver.file.FileDownload?fileid="+imgs[1];
		  currentimage = '1';
	    }else{
		 url= "/weaver/weaver.file.FileDownload?fileid="+imgs[0];
		 currentimage = '0';
		}
		var imag1 = document.getElementById('imag'+index);
		imag1.src = url;
		jQuery('#imagetext'+index).val(currentimage);
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
			<tr><td></td>
			 <td>
		      <table width="90%" align="center">
	  	  	    <colgroup> <col width="35%" /><col width="10%" /><col width="35%" /><col width="10%" /></colgroup> 
	  	         <tr></tr>
				 <% 
					String tmp_id = "";
	            	String tmp_name = "";
	            	String picHead =  "";
	            	String picend = "";
					String tmp_zm="";
					String tmp_fm="";
					String sql = "select id,Name,picHead,picend from uf_Contacts where SuperID is null and dealStatus in(0,1) and (status is null or status=0 or status='') and customName="+customID;
	                String sql1="";
					RecordSet.executeSql(sql);
	            	int flag = 0;
	            	while(RecordSet.next()){  
	            		flag ++;
	            		tmp_id = Util.null2String(RecordSet.getString("id"));
	            		tmp_name = Util.null2String(RecordSet.getString("Name"));
	            		picHead = Util.null2String(RecordSet.getString("picHead"));
	            		picend = Util.null2String(RecordSet.getString("picend"));
						tmp_zm="-1";
						tmp_fm="-1";
	            		if(!"".equals(picHead)){
                            sql1="select MIN(imagefileid) as tmp_zm from DocImageFile where docid in("+picHead+") ";
							//out.print(sql1);
							RecordSet_dt.executeSql(sql1);
							if(RecordSet_dt.next()){
								tmp_zm = Util.null2String(RecordSet_dt.getString("tmp_zm"));
							}
						}
						if(!"".equals(picend)){
                            sql1="select MIN(imagefileid) as tmp_fm from DocImageFile where docid in("+picend+") ";
							//out.print(sql1);
							RecordSet_dt.executeSql(sql1);
							if(RecordSet_dt.next()){
								tmp_fm = Util.null2String(RecordSet_dt.getString("tmp_fm"));
							}
						}
						//out.print("tmp_name"+tmp_name+"tmp_zm"+tmp_zm+"tmp_fm"+tmp_fm+"flag"+flag);
	            		
	            	%>
					<tr>
				  <td>
					 <table align="center" style="border:1px solid #000000;" cellpadding="0"cellspacing="1">
						 <tr><td valign="middle" style="border-width: 0.5pt; border-style: solid; border-color: windowtext black windowtext windowtext; font-size: 13pt;" bgcolor="rgb(231, 243, 252)" colspan="3"><a href="javascript:openNewInfo1(<%=tmp_id%>);"><font face="宋体">&nbsp;&nbsp;<%=tmp_name%></font></a></td></tr>
						 <tr><td><img height="150px" id="imag<%=flag%>" width="400px"  id=resourceimage  src="/weaver/weaver.file.FileDownload?fileid=<%=tmp_zm%>"></td></tr>
						 <tr>
							 <td style="text-align:right;font-size: 13pt;" >								
								<font face="宋体">&nbsp;&nbsp;正面</font>
							</td>
					    </tr>
					 </table>
					 <br/>
				  </td>
				  <td></td>
				  <td>
					 <table align="center" style="border:1px solid #000000;" cellpadding="0"cellspacing="1">
						 <tr><td valign="middle" style="border-width: 0.5pt; border-style: solid; border-color: windowtext black windowtext windowtext; font-size: 13pt;" bgcolor="rgb(231, 243, 252)" colspan="3"><a href="javascript:openNewInfo1(<%=tmp_id%>);"><font face="宋体">&nbsp;&nbsp;<%=tmp_name%></font></a></td></tr>
						 <tr><td><img height="150px" id="imag<%=flag%>" width="400px"  id=resourceimage  src="/weaver/weaver.file.FileDownload?fileid=<%=tmp_fm%>"></td></tr>
						 <tr>
							  <td style="text-align:right;font-size: 13pt;" >								
								<font face="宋体">&nbsp;&nbsp;反面</font>
							</td>
					    </tr>
					 </table>
					  <br/>
				  </td> 
				  <td></td>
	  	    </tr> 
			   <%}%>
		      </table>	
		 </td>
		</tr>
		</table>

	</div>
	</FORM>

<script type="text/javascript">
   
   function openDyInfo() {
		var title = "";
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=ctnew,<%=customID%>";
		// var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=custom,,";

		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1024;
		diag_vote.Height = 800;
		diag_vote.maxiumnable=true;
		diag_vote.DefaultMax=true;
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
