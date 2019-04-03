<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="tools" class="tool.tools" scope="page" />
<%@ page import="java.sql.Timestamp" %>
<%

	String id= Util.null2String(request.getParameter("id"));
	
	String name = "";
	String description = "";
	String o_order = "";
	String forServerLine = "";
	String createPerson = "";
	String dutyNameID = "";
	
	boolean isTrue = true;
	
	if(!"".equals(id)){
		String sql = "select * from ProductDictionary where id = '"+id+"'";
		rs.executeSql(sql);
		if(rs.next()){
			name = rs.getString("name");
			description =  rs.getString("description");
			o_order =  rs.getString("o_order");
			forServerLine = rs.getString("forServerLine");
			createPerson = rs.getString("createPerson");
			dutyNameID = rs.getString("dutyNameID");
		}
		sql = "select * from projectinfo where name = '"+id+"' and isshow = '0'";
		rs.executeSql(sql);
		if(rs.next()){
			isTrue = false;
		}
		
	}

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "产品线维护";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if(!"".equals(id) && isTrue){
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

<FORM style="MARGIN-TOP: 0px" name=right method=post action="ProductLineOperation.jsp" >
  <input class=inputstyle type="hidden" name="id" value="<%=id%>">
  <input class=inputstyle type="hidden" name="operation" />
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title>
      <TH colSpan=2>产品线维护</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <Tr>
    <td>产品线名称</td>
  <td class=field> 
  <input type=text name="name" id="name" value="<%=name%>" onchange=checkinput("name","nameSpan")><span id="nameSpan"><%if("".equals(name)){ %><IMG src="/images/BacoError.gif" align=absMiddle><%} %></SPAN></td>
  </Tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    <tr> 
      <td>产品线描述</td>
      <td class=Field> 
		<input type=text name="description" size="50" value="<%=description%>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td>所属业务线</td>
      <td class=field>
      <BUTTON class=Browser id=ServiceLineBrowser onClick="onServiceLineBrowser()"></BUTTON> 
      <span id=forServerLinespan><%if("".equals(forServerLine)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%}else{ %><%=tools.getServiceLineName(forServerLine)%><%} %></span> 
              <INPUT class=inputstyle type=hidden name="forServerLine" id="forServerLine" value="<%=forServerLine%>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    <tr> 
      <td>创建人</td>
      <td class=Field> 
      <%if("".equals(id)){ %>
		<span><%=ResourceComInfo.getResourcename(String.valueOf(user.getUID())) %></span> 
              <INPUT class=inputstyle type=hidden name="createPerson" value="<%=user.getUID()%>">
      <%}else{%>
      	<span><%=ResourceComInfo.getResourcename(createPerson) %></span> 
              <INPUT class=inputstyle type=hidden name="createPerson" value="<%=createPerson%>">
      <%} %>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td>负责人</td>
      <td class=Field> 
		      <BUTTON class=Browser id=ServiceLineBrowser onClick="onShowResource()"></BUTTON> 
		      <span id=dutyNamespan><%if("".equals(dutyNameID)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%}else{ %><%=ResourceComInfo.getResourcename(dutyNameID)%><%} %></span> 
              <INPUT class=inputstyle type=hidden name="dutyName" id="dutyName" value="<%=dutyNameID%>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR> 
    <tr> 
      <td>位置</td>
      <td class=Field> 
		<input type=text name="o_order" value="<%=o_order%>">
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
function onServiceLineBrowser() {
	var id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/empolder/proj/ServiceLineBrowser.jsp");
	                     if (id1) {
				var ids = id1.id;
				var names = id1.name;
				if (ids.length > 0) {
					jQuery("#forServerLine").val(ids);
					jQuery("#forServerLinespan").html(names);
				} else {
					jQuery("#forServerLine").val("");
					jQuery("#forServerLinespan").html("");
				}
			}
	}
</script>

<script language=vbs>
sub onShowResource()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if NOT isempty(id) then
	        if id(0)<> "" then
		dutyNamespan.innerHtml = id(1)
		right.dutyName.value=id(0)
		else
		dutyNamespan.innerHtml = ""
		right.dutyName.value=""
		end if
	end if

end sub

</script>

</BODY>
</HTML>