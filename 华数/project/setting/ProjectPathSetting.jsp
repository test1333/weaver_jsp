<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<%
boolean canedit=false;

String name="";
String approver="";
String desc="";
String category = "";
String categorypath = "";
String id="1";
if(!id.equals("")){ 
	RecordSet.executeSql(" select * from wasu_projpath where typeid=1");
	if(RecordSet.next()){
     category = Util.null2String(RecordSet.getString("prjpath")); 
     if(!category.equals("")){ 
         String[] categoryArr = Util.TokenizerString2(category,",");
         categorypath += "/"+MainCategoryComInfo.getMainCategoryname(categoryArr[0]);
         categorypath += "/"+SubCategoryComInfo.getSubCategoryname(categoryArr[1]);
         categorypath += "/"+SecCategoryComInfo.getSecCategoryname(categoryArr[2]);
     }
    }
}
 
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
<SCRIPT language="javascript" src="../../js/jquery/jquery.js"></script>
</HEAD>


<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "项目文档存放路径维护";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="10" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
 
<FORM id=weaverA name=weaverA action="SettingOperation.jsp" method=post  >
	<input class=inputstyle type="hidden" name="method" value="edit">
	<input class=inputstyle type="hidden" name="id" value="<%=id%>">
<TABLE class=Viewform>
  <COLGROUP>
  <COL width="15%">
  <COL width=85%>
  <TBODY>
  <TR class=Spacing>
          <TD class=Sep1 colSpan=4></TD></TR>

          
        <TR><TD class=Line colSpan=2></TD></TR>
       
       <tr>
	            <td><%=SystemEnv.getHtmlLabelName(17616,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(92,user.getLanguage())%></td>
	            <td class=field>
	                <BUTTON class=Browser onClick="onShowCatalog(catalogpathspan)" name=selectCategory></BUTTON>
	                <span id="catalogpathspan" name="catalogpathspan"><%=categorypath %></span>
	                <input type=hidden id='catalogpath' name='catalogpath' value="<%=category %>">
	            </td>
	        </tr>
          <TR><TD class=Line colspan=2></TD></TR> 
  </TBODY>
</TABLE>
</FORM>
 
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
<script language=javascript>
	
function submitData() {
		 weaverA.submit(); 
}
 

function onShowCatalog(spanName) {
    var result = showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/CategoryBrowser.jsp");
    if (result != null) {
        if (result[0] > 0){
          spanName.innerHTML=result[2];
          document.all("catalogpath").value=result[3]+","+result[4]+","+result[1];
        }else{
          spanName.innerHTML="";
          document.all("catalogpath").value="";
        }
    }
}
</script>
<script language=vbs>

sub onShowHrm(spanname,inputename,needinput)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	document.all(spanname).innerHtml= "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	document.all(inputename).value=id(0)
	else
	if needinput = "1" then
	document.all(spanname).innerHtml= "<IMG src='/images/BacoError.gif' align=absMiddle>"
	else
	document.all(spanname).innerHtml= ""
	end if
	document.all(inputename).value=""
	end if
	end if
end sub
sub adfonShowSubcompany()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser4.jsp?rightStr=MeetingType:Maintenance")
	issame = false
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	if id(0) = weaverA.subcompanyid.value then
		issame = true
	end if
	subcompanyspan.innerHtml = id(1)
	weaverA.subcompanyid.value=id(0)
	else
	subcompanyspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaverA.subcompanyid.value=""
	end if
	end if
end sub

</script>
<script language="vbs">
	sub onShowWorkflow()
		id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowBrowser.jsp?sqlwhere= where isbill=1 and formid=85")
		if NOT isempty(id) then
				if id(0)<> 0 then
			approvewfspan.innerHtml = id(1)
			weaverA.approver.value=id(0)
			else
			approvewfspan.innerHtml = ""
			weaverA.approver.value = ""
			end if
		end if
	end sub
</script> 