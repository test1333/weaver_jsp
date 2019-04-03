	<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="tools" class="tool.tools" scope="page"/>
<script type="text/javascript" language="javascript" src="/js/jquery/jquery.js"></script>
<%
    String parentID= Util.null2String(request.getParameter("parentID"));
	String id= Util.null2String(request.getParameter("id"));
	
	
	
	String subjectid = "";//金蝶科目ID
	String subjcetcode = "";//关系科目编码
	String description = "";//说明
	String falg = "";//标记
	
	if(!"".equals(id)){
		String sql = "select * from relevance where id = '"+id+"'";
		rs.executeSql(sql);
		if(rs.next()){
			subjectid = rs.getString("subjectid");
			subjcetcode = rs.getString("subjcetcode");
			description = rs.getString("description");
			falg = rs.getString("isfalg");
			parentID = rs.getString("parentdepid");
		}
	}

%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "关联关系维护";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if(!"".equals(id)){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:doDelete(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/empolder/finance/relevanceList.jsp?parent="+parentID+",_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
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

<FORM style="MARGIN-TOP: 0px" name=right method=post action="relevanceOperation.jsp" >
  <input class=inputstyle type="hidden" name="id" value="<%=id%>">
  <input class=inputstyle type="hidden" name="parentID" value="<%=parentID %>"/>
  <input class=inputstyle type="hidden" name="operation"/>
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title>
      <TH colSpan=2>关联关系维护</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></td>
      <td class=Field> 
    
    		<brow:browser viewType="0"  name="subjectid" browserValue="<%=subjectid%>"
                browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.subjectDeatil"
              	hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
                 width="120px"
                linkUrl=""
                browserSpanValue="<%=tools.getSubjectName(subjectid) %>">
                </brow:browser>
    
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    <tr>
      <td>科目编码</td>
      <td class=Field>
      	<input class=inputstyle name="subjcetcode" size="30" value="<%=subjcetcode%>"/> 
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr>
      <td>是否有归属地</td>
      <td class=Field>
      	<select name="falg">
      		<option value="1" <%if("1".equals(falg)){ %> selected="selected" <%} %>>无</option>
      		<option value="0" <%if("0".equals(falg)){ %> selected="selected" <%} %>>有</option>
      	</select>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr>
    <td><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></td>
      <td class=Field> 
        <textarea class=inputstyle name="description" cols="60" rows=4><%=description %></textarea>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
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
<Script language=javascript>
function submitData(obj) {
        if(check_form(right,"name,depID")){
            right.submit();
            obj.disabled=true;
        }
}
function doDelete(obj){
	if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")) {
		right.operation.value="delete";
		right.submit();
    }
}
function onShowSubject() {
	var id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/empolder/finance/subjectBrowser.jsp");	
	   if (id1) {
				var ids = id1.id;
				var names = id1.name;
				if (ids.length > 0) {
					jQuery("#subjectid").val(ids);
					jQuery("#subjectidimage").html(names);
				} else {
					jQuery("#subjectid").val("");
					jQuery("#subjectidimage").html("");
				}
			}
	}
</script>

<script language=vbs>
sub onShowDepartment()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	departmentspan.innerHtml = id(1)
	right.depID.value=id(0)
	else
	departmentspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	right.depID.value=""
	end if
	end if
end sub
sub onShowBudgetfeeType()
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/BudgetfeeTypeBrowser.jsp")
    if (Not IsEmpty(id)) then
		if id(0)<> 0 then
            oasubjectidspan.innerHtml = id(1)
			right.oasubjectid.value=id(0)
			else
			oasubjectidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			right.oasubjectid.value=""
		end if
	end if
end sub
</script>

</BODY>
</HTML>