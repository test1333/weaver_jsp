<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
	<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%
	String id= Util.null2String(request.getParameter("id"));
	
	String manager = "";
	String code = "";
	String description = "";
	String resourceID = "";
	
	if(!"".equals(id)){
		String sql = "select * from hrmManager where id = '"+id+"'";
		rs.executeSql(sql);
		if(rs.next()){
			manager = rs.getString("name");
			code = rs.getString("code");
			description =  rs.getString("description");
			resourceID =  rs.getString("resourceID");
		}
	}

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "拓展经理维护";
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

<FORM style="MARGIN-TOP: 0px" name=right method=post action="ManagerOperation.jsp" >
  <input class=inputstyle type="hidden" name="id" value="<%=id%>">
  <input class=inputstyle type="hidden" name="operation" />
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title>
      <TH colSpan=2>拓展经理维护</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <Tr>
    <td>名称</td>
  <td class=field> 
  <input type=text name="Manager" id="Manager" value="<%=manager%>" onchange="checkinput('Manager','MSpan')">
  <span id="MSpan"><%if("".equals(manager)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%} %></span>
  </td>
  </Tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    <tr> 
      <td>区域编码</td>
      <td class=Field> 
<%--         <textarea class=inputstyle name="code" cols="60" rows=4><%=describe %></textarea> --%>
		<input type=text name="code" value="<%=code%>" onchange="checkinput('code','codeSpan')">
		<span id="codeSpan"><%if("".equals(code)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%} %></span>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td>所属OA人员</td>
      <td class=Field>
              <brow:browser viewType="0"  name="resourceID" browserValue='<%=resourceID %>'
                        browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?selectedids="
                        hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1' linkUrl="javascript:openhrm($id$)"
                        completeUrl="/data.jsp" width="80%"
                        browserSpanValue='<%=Util.toScreen(ResourceComInfo.getResourcename(resourceID),user.getLanguage())%>'></brow:browser>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td>描述</td>
      <td class=Field> 
        <textarea class=inputstyle name="description" cols="60" rows=4 onchange="checkinput('description','descriptionSpan')"><%=description %></textarea>
        <span id="descriptionSpan"><%if("".equals(description)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%} %></span>
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
        if(check_form(right,"Manager,code,resourceID,description")){
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
</script>

<script language=vbs>
sub onShowResource()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if NOT isempty(id) then
	        if id(0)<> "" then
		Managerspan.innerHtml = id(1)
		right.resourceID.value=id(0)
		else
		Managerspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
		right.resourceID.value=""
		end if
	end if

end sub
</script>

</BODY>
</HTML>