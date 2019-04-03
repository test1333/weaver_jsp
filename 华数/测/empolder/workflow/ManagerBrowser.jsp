<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page" />
<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DocSearchManage" class="weaver.docs.search.DocSearchManage" scope="page"/>
<jsp:useBean id="DocSearchComInfo" class="weaver.docs.search.DocSearchComInfo" scope="session"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />


<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</HEAD>


<%
String name = Util.null2String(request.getParameter("name"));

String sqlwhere = "" ;

//System.out.println("tempsqlwhere = " + tempsqlwhere);
int perpage = 10 ;
int pagenum = Util.getIntValue(request.getParameter("pagenum") , 1) ;
%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>


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


<FORM NAME=SearchForm STYLE="margin-bottom:0" action="ManagerBrowser.jsp" method=post>

<DIV align=right style="display:none">
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:SearchForm.submit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btnSearch accessKey=S type=submit><U>S</U>-<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:SearchForm.reset(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btnReset accessKey=T type=reset><U>T</U>-<%=SystemEnv.getHtmlLabelName(199,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:SearchForm.btnclose.click(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btn accessKey=1 id="btnclose" onclick="window.parent.close()"><U>1</U>-<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:btnclear_onclick(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btn accessKey=2 id=btnclear><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
</DIV>

<table width=100% class=ViewForm>
<TR class=Spacing><TD class=Line1 colspan=4></TD></TR>
<TR>
	<TD width=15%>Ãû³Æ</TD>
	<TD width=35% class=field><input class=InputStyle  name=name value="<%=name%>"></TD>	
</TR>
<tr><td class=Line colspan=4></td></tr>
<TR class=Spacing><TD class=Line1 colspan=4></TD></TR>
</table>
<TABLE ID=BrowseTable class=BroswerStyle cellspacing=1>
<TR class=DataHeader>
<TH width=0% style="display:none"></TH>
<TH width=40%>Ãû³Æ</TH>
<TH width=60%>ÃèÊö</TH>
</tr><TR class=Line><TH colSpan=5></TH></TR>
<%

//out.println(sqlwhere);    

int i=0;
String sql = "select resourceid,name,description from hrmManager ";
rs.executeSql(sql);

while(rs.next()) {
		if(i==0){
			i=1;
	%>
	<TR class=DataLight>
	<%
		}else{
			i=0;
	%>
	<TR class=DataDark>
		<%
		}
		%>
		<TD width=0% style="display:none"><A HREF=#><%=rs.getString("resourceid")%></A></TD>
		<TD><%=rs.getString("name")%></TD>
		<TD><%=rs.getString("description")%></TD>
	</TR>
	<%}%>
</TABLE>
<br>
<!-- <table width=100% class=Data> -->
<!-- <tr> -->
<%-- <td align=center><%=Util.makeNavbar2(pagenum, DocSearchManage.getRecordersize() , perpage, "DocBrowser.jsp?islink="+islink+"&searchid="+searchid+"&searchmainid="+searchmainid+"&searchsubject="+searchsubject+"&searchcreater="+searchcreater+"&searchdatefrom="+searchdatefrom+"&searchdateto="+searchdateto+"&sqlwhere="+sqlwhere1+"&initwhere="+initwhere+"&txtCrmId="+crmId)%></td> --%>
<!-- </tr> -->
</table>
<br>
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
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
</BODY></HTML>

<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT LANGUAGE=VBScript>
sub onShowCustomer(spName,inputename)
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
    if NOT isempty(id) then
        if id(0)<> "" then
        document.all(spName).innerHTML = id(1)
        document.all(inputename).value=id(0)
        else
        document.all(spName).innerHTML= ""
        document.all(inputename).value=""
        end if
    end if
end sub

sub onShowOwnerID(inputname,spanname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	spanname.innerHtml = "<A href='HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	inputname.value=id(0)
	else
	spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	inputname.value=""
	end if
	end if
end sub

Sub btnclear_onclick()
     window.parent.returnvalue = Array(0,"")
     window.parent.close
End Sub
Sub BrowseTable_onclick()
   Set e = window.event.srcElement
   If e.TagName = "TD" Then
     window.parent.returnvalue = Array(e.parentelement.cells(0).innerText,replaceToHtml(e.parentelement.cells(1).innerText))
    //  window.parent.returnvalue = e.parentelement.cells(0).innerText
      window.parent.Close
   ElseIf e.TagName = "A" Then
      window.parent.returnvalue = Array(e.parentelement.parentelement.cells(0).innerText,replaceToHtml(e.parentelement.parentelement.cells(1).innerText))
     // window.parent.returnvalue = e.parentelement.parentelement.cells(0).innerText
      window.parent.Close
   End If
End Sub
Sub BrowseTable_onmouseover()
   Set e = window.event.srcElement
   If e.TagName = "TD" Then
      e.parentelement.className = "Selected"
   ElseIf e.TagName = "A" Then
      e.parentelement.parentelement.className = "Selected"
   End If
End Sub
Sub BrowseTable_onmouseout()
   Set e = window.event.srcElement
   If e.TagName = "TD" Or e.TagName = "A" Then
      If e.TagName = "TD" Then
         Set p = e.parentelement
      Else
         Set p = e.parentelement.parentelement
      End If
      If p.RowIndex Mod 2 Then
         p.className = "DataDark"
      Else
         p.className = "DataLight"
      End If
   End If
End Sub
</SCRIPT>
<script type="text/javascript">
    function replaceToHtml(str){
	var re = str;
	var re1 = "<";
	var re2 = ">";
	do{
		re = re.replace(re1,"&lt;");
		re = re.replace(re2,"&gt;");
        re = re.replace(",","£¬");
	}while(re.indexOf("<")!=-1 || re.indexOf(">")!=-1)
	return re;
}
</script>