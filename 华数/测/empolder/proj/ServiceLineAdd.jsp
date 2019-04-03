<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%

	String id= Util.null2String(request.getParameter("id"));
	
	String name = "";
	String description = "";
	String order_o = "";
	String personnel_1 = "";
	
	if(!"".equals(id)){
		String sql = "select * from serviceline where id = '"+id+"'";
		rs.executeSql(sql);
		if(rs.next()){
			name = rs.getString("name");
			order_o = rs.getString("order_o");
			description =  rs.getString("description");
			personnel_1 = rs.getString("personnel_1");
		}
	}
	
	boolean delete_1 = true;
	boolean delete_2 = true;
	boolean delete_3 = true;
	String sql_s = "";
	sql_s = "select * from productProject where forServerLine = '"+id+"' and isshow = '0'";
	rs.executeSql(sql_s);
	if(rs.next()){
		if(rs.getCounts() > 0){
			delete_1 = false;
		}
	}
	sql_s = "select * from projectInfo where forLine = '"+id+"' and isshow = '0'";
	rs.executeSql(sql_s);
	if(rs.next()){
		if(rs.getCounts() > 0){
			delete_2 = false;
		}
	}
	
	sql_s = "select * from ProductDictionary where forServerLine = '"+id+"' and isshow = '0'";
	rs.executeSql(sql_s);
	if(rs.next()){
		if(rs.getCounts() > 0){
			delete_3 = false;
		}
	}
	
	

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "业务线维护";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if(!"".equals(id) && delete_1 && delete_2 && delete_3){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:doDelete(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:window.history.back(),_self}";
RCMenuHeight += RCMenuHeightStep;
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

<FORM style="MARGIN-TOP: 0px" name=right method=post action="ServiceLineOperation.jsp" >
  <input class=inputstyle type="hidden" name="id" value="<%=id%>">
  <input class=inputstyle type="hidden" name="operation" />
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title>
      <TH colSpan=2>业务线维护</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <Tr>
    <td>业务线名称</td>
  <td class=field> 
  <input type=text name="name" id="name" value="<%=name%>" onchange=checkinput("name","nameSpan")><span id="nameSpan"><%if("".equals(name)){ %><IMG src="/images/BacoError.gif" align=absMiddle><%} %></SPAN></td>
  </Tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    <tr> 
      <td>业务线描述</td>
      <td class=Field> 
		<input type=text name="description" size="50" value="<%=description%>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td>排序</td>
      <td class=Field>
		<input type=text name="order_o" size="5" value="<%=order_o%>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td>负责人</td>
      <td class=Field>
      <BUTTON class=Browser onClick="onShowResourceMutil('personnelspan','personnel')"></BUTTON> 
      <span id="personnelspan"><%if(!"".equals(personnel_1)){ %><%=ResourceComInfo.getMulResourcename(personnel_1)%><%}else{ %><IMG src="/images/BacoError.gif" align=absMiddle><%} %></span>
		<input type=hidden name="personnel" id="personnel" value="<%=personnel_1%>">
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
        if(check_form(right,"name")){
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
function onShowResourceMutil(spanname, inputname) {
    tmpids = document.all(inputname).value;
    if(tmpids!="-1"){ 
     url="/hrm/resource/MutiResourceBrowser.jsp?resourceids="+tmpids;
    }else{
     url="/hrm/resource/MutiResourceBrowser.jsp";
    }
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+url);
    try {
        jsid = new VBArray(id).toArray();
    } catch(e) {
        return;
    }
    if (jsid != null) {
        if (jsid[0] != "0" && jsid[1]!="") {
            document.all(spanname).innerHTML = jsid[1].substring(1);
            document.all(inputname).value = jsid[0].substring(1);
        } else {
            document.all(spanname).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
            document.all(inputname).value = "";
        }
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
		Managerspan.innerHtml = ""
		right.Manager.value=""
		end if
	end if

end sub
</script>

</BODY>
</HTML>