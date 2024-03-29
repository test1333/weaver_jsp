<%@ page import="weaver.general.Util" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>

<%

if(!HrmUserVarify.checkUserRight("CptCapital:Return", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
String capitalid = request.getParameter("capitalid");
String stateid = request.getParameter("stateid");

%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
</head>
<%
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename = Util.toScreen(CapitalComInfo.getCapitalname(capitalid),user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<FORM id=weaver name=frmain method=post onSubmit="onSubmit()">
<DIV class=HdrProps></DIV>
<BUTTON type='button' class=btnSave accessKey=S onclick="onSubmit()"><U>S</U>-<%=SystemEnv.getHtmlLabelName(1384,user.getLanguage())%></BUTTON>
<BUTTON type='button' class=btn accessKey=B onclick='window.history.back(-1)'><U>B</U>-<%=SystemEnv.getHtmlLabelName(1390,user.getLanguage())%></BUTTON>
  <TABLE class=form>
    <COLGROUP> <COL width="15%"> <COL width="85%"> <TBODY> 
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(1413,user.getLanguage())%></td>
      <td class=Field><BUTTON type='button' class=Calendar id=selectreturndate onClick="getreturnDate()"></button> 
        <span id=returndatespan ><IMG src="/images/BacoError_wev8.gif" align=absMiddle></span> 
        <input type="hidden" name="returndate">
      </td>
    </tr>
	<%if (!stateid.equals("4")) {%>
	<%if (stateid.equals("3")) {%>	
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(1414,user.getLanguage())%></td>
      <td class=Field>
	  <select class=saveHistory id=afterstateid name=afterstateid>
	  <option value="1" selected><%=SystemEnv.getHtmlLabelName(747,user.getLanguage())%></option>
	  <option value="2"><%=SystemEnv.getHtmlLabelName(160,user.getLanguage())%></option>
	  </select>
      </td>
    </tr>
	<%}%>
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></td>
      <td class=Field><BUTTON type='button' class=Browser id=SelectDeparment onClick="onShowDepartment()"></button> 
        <span class=saveHistory id=departmentspan><img src="/images/BacoError_wev8.gif" 
            align=absMiddle></span> 
        <input id=departmentid type=hidden name=departmentid>
      </td>
    </tr>
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(425,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(426,user.getLanguage())%></td>
      <td class=Field><BUTTON type='button' class=Browser id=SelectCostCenter onClick="onShowCostCenter()"></button> 
        <span class=saveHistory id=costcenterspan><img src="/images/BacoError_wev8.gif" 
            align=absMiddle></span> 
        <input id=costcenterid type=hidden name=costcenterid>
      </td>
    </tr>
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></td>
      <td class=Field><BUTTON type='button' class=Browser id=SelectResourceID onClick="onShowResourceID()"></button> 
        <span 
            id=resourceidspan></span> 
        <input class=saveHistory id=resourceid type=hidden name=resourceid>
      </td>
    </tr>
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(259,user.getLanguage())%></td>
      <td class=Field><BUTTON type='button' class=Browser id=SelectUseRequest onClick="onShowUseRequest()"></button> 
        <span 
            id=userequestspan></span> 
        <input class=saveHistory id=userequest type=hidden name=userequest>
      </td>
    </tr>
	<%}
	if(stateid.equals("4")) {%>
	<tr>
      <td><%=SystemEnv.getHtmlLabelName(1393,user.getLanguage())%></td>
      <td class=Field> 
        <input type=text size=15 maxlength=13 name="fee"  onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("fee")'>
     </td>
    </tr>
	<%}
	if(!stateid.equals("4")){%>
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(1387,user.getLanguage())%></td>
      <td class=Field> 
        <input type=text size=60 maxlength=100 name="location" onChange='checkinput("location","locationimage")'>
        <span id=locationimage><img src="/images/BacoError_wev8.gif" align=absMiddle></span></td>
    </tr>
	<%}%>
    <tr> 
      <td><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></td>
      <td class=Field colspan=2> 
        <textarea class="saveHistory"  style="width:100%" name=remark rows="6"></textarea>
      </td>
    </tr>
    <input type="hidden" name=capitalid value=<%=capitalid%>>
    <input type="hidden" name=stateid value=<%=stateid%>>
    </TBODY> 
  </TABLE>
 </form>
 <script language=vbs>
 sub onShowDepartment()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&frmain.departmentid.value)
	issame = false 
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	if id(0) = frmain.departmentid.value then
		issame = true 
	end if
	departmentspan.innerHtml = id(1)
	frmain.departmentid.value=id(0)
	else
	departmentspan.innerHtml = "<IMG src='/images/BacoError_wev8.gif' align=absMiddle>"
	frmain.departmentid.value=""
	end if
	if issame = false then
			costcenterspan.innerHtml = "<IMG src='/images/BacoError_wev8.gif' align=absMiddle>"
			frmain.costcenterid.value=""
	end if
	end if
end sub

sub onShowCostCenter()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/CostcenterBrowser.jsp?sqlwhere= where departmentid="&frmain.departmentid.value)
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	costcenterspan.innerHtml = id(1)
	frmain.costcenterid.value=id(0)
	else 
	costcenterspan.innerHtml = "<IMG src='/images/BacoError_wev8.gif' align=absMiddle>"
	frmain.costcenterid.value=""
	end if
	end if
end sub

sub onShowUseRequest()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/request/RequestBrowser.jsp?isrequest=1")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	userequestspan.innerHtml = id(1)
	frmain.userequest.value=id(0)
	else 
	userequestspan.innerHtml = ""
	frmain.userequest.value=""
	end if
	end if
end sub

sub onShowResourceID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	resourceidspan.innerHtml = "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	frmain.resourceid.value=id(0)
	else 
	resourceidspan.innerHtml = ""
	frmain.resourceid.value=""
	end if
	end if
end sub
</script>
 <script language="javascript">
 function onSubmit(){
 	if(check_form(document.frmain,'<%if(!stateid.equals("4")) {%>location,departmentid,costcenterid<%}%>returndate')){
		document.frmain.action="CapitalReturnOperation.jsp"
		document.frmain.submit();
	}
 }
 </script>
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</HTML>
