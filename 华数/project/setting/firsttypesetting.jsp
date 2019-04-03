<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CategoryMethod" class="weaver.general.CategoryMethod" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
</HEAD>
<%
    String imagefilename = "/images/hdMaintenance.gif";
    String titlename = "一级类型维护设置"; 
    String needfav ="1";
    String needhelp ="";
    
    String documentid = request.getParameter("documentid");

    if(HrmUserVarify.checkUserRight("ProjectStone:Look", user)){
       /*  response.sendRedirect("/notice/noright.jsp"); 
        return ; */
    }
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{保存,javascript:doSave(),_top} ";
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{返回,javascript:history.go(-1),_top} ";
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<form id=weaver name=frmmain action="SettingOperation.jsp" method=post >
<input type=hidden name=method value="firsttypesetting"/>
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
		<table class=ViewForm>
             <tbody>                                
                 <TR class=Title> 
                     <TH>一级类型维护</TH>
                     <TH width="100" align="right"><a href="javascript:addRow()">[添加]</a>&nbsp;&nbsp;<a href="javascript:delRow()">[删除]</a></TH>
                 </TR>
                 <TR class=Spacing>
                     <TD class=Line1 colSpan=2></TD>
                 </TR>
             </tbody>
         </table>
         <table class=ViewForm id="catalogTable">
             <tbody>
             <tr>
				<td width="30">
				</td>
				<td  width="50%">
				一级类型名称
				</td>  
				<!-- <td width="30%">
					显示名称
				</td>-->
				<td width="30%">
					 顺序
				</td> 
			</tr>
			<TR class=Spacing> 
				<TD class=Line2 colSpan=3></TD>
			</TR>
             <%
             int i = -1; 
             rs.executeSql("Select * From firsttype  order by dsporder asc ");
             while(rs.next()) {  
            	 i++;
            	 String id = rs.getString("id"); 
            	 String typename = rs.getString("typename");  
            	 String typevalue = rs.getString("typevalue");  
            	 String dsporder = rs.getString("dsporder");  
             %>
             <tr>
				<td width="10">
					<INPUT class="inputStyle" type="checkbox" value="">
					<INPUT class="inputStyle" type="hidden"  name=id value="<%=id%>"> 
				</td>
				<td width="30%"> 
					  <INPUT class="inputStyle" id="typevalue<%=i%>" type="text" name=typevalue value="<%=typevalue %>" >
				</td>   
				<td width="30%">
					<INPUT class="inputStyle" id="dsporder<%=i%>" type="text" name=dsporder value="<%=dsporder %>">
				</td> 
			</tr>
			<TR class=Spacing>
				<TD class=Line2 colSpan=3></TD>
			</TR>
             <%
             }
             %>
             </tbody>
         </table>
         </td></tr></table>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>
</form>
</body>
</html>

<div id="btnDIV" style="display:none">
<tr>
	<td width="30">
		<INPUT class="inputStyle" type="checkbox" value="">
	</td>
	<td width="50%"> 
		<INPUT class="inputStyle" id="typevalue##row##" type="text"  name=typevalue >
	</td>  
	<td width="30%">
			<INPUT class="inputStyle" id="dsporder##row##" type="text"  name=dsporder >
	</td> 
</tr>
<TR class=Spacing>
	<TD class=Line2 colSpan=2></TD>
</TR>
</div>

<script type="text/javascript">
function onSelectCategory(inputname, spanname) {
    var result = showModalDialog("/systeminfo/BrowserMain.jsp?url=/docs/category/MutilCategoryBrowser.jsp");
   alert(result);
    if (result != null) {
	    if (result[0] > 0)  {
	    	jQuery("#"+spanname).html(result[2]);
	    	jQuery("#"+inputname).val(result[1]);
    	}
	    else {
	    	jQuery("#"+spanname).html("");
	    	jQuery("#"+inputname).val("");
	    }
	}
}

var rows = <%=i%>;
function addRow() {
	rows++;
	jQuery("#catalogTable").append(jQuery("#btnDIV").html().replace(/##row##/g, rows));
}

function delRow() {
	jQuery(":checkbox").each(function () {
		var cobj = jQuery(this);
		if(cobj.attr("checked")==true) {
			cobj.closest("tr").next("tr").remove(); 
			cobj.closest("tr").remove(); 
		}
	});
}

function checkshowsub(obj,index){
	if(obj.checked){
		document.getElementById("showsub_"+index).value="1";
	}else{
		document.getElementById("showsub_"+index).value="0";
	}
}

function doSave() {
	weaver.submit();
}

 
/* function onShowDepartment(spanname,inputname) {
    var result = showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids=");
    if (result != null) { 
	    if (result[0] > 0)  {
	    	jQuery("#"+spanname).html(result[2]);
	    	jQuery("#"+inputname).val(result[1]);
    	}
	    else {
	    	jQuery("#"+spanname).html("");
	    	jQuery("#"+inputname).val("");
	    }
	}
} */
</script>

<script LANGUAGE="VBS">
sub onShowBrowser3(inputname,spanname)

    url="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.doccategory"
    id1 = window.showModalDialog(url)
	
	name = id1(1)
	 
	document.all(inputname).value=id1(0) 
	document.all(spanname).innerHtml =name

end sub

sub onShowMutiCategory(inputname,spanname)

    url="/systeminfo/BrowserMain.jsp?url=/docs/category/MutilCategoryBrowser.jsp"
    id1 = window.showModalDialog(url)
	
	name = id1(1)
	 
	document.all(inputname).value=id1(0) 
	document.all(spanname).innerHtml =name

end sub

sub onShowDepartment(tdname,inputename)
    linkurl="/hrm/company/HrmSubCompanyDsp.jsp?id="
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&document.all(inputename).value)
    if NOT isempty(id) then
        if id(0)<> "" then        
        	resourceids = id(0)
       		resourcename = id(1)
        	sHtml = ""
        	 
       		document.all(inputename).value = resourceids
        	while InStr(resourceids,",") <> 0
            	curid = Mid(resourceids,1,InStr(resourceids,",")-1)
            	curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            	resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
            	resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            	sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
       		wend
        	sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
       		document.all(tdname).innerHtml = sHtml
        else
					document.all(tdname).innerHtml = ""
        	document.all(inputename).value=""
        end if
    end if
end sub

sub onShowSubcompany(tdname,inputename)
    linkurl="/hrm/company/HrmSubCompanyDsp.jsp?id="
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SingleSubcompanyBrowser.jsp?selectedids="&document.all(inputename).value)
    if NOT isempty(id) then
        if id(0)<> "" then        
        	resourceids = id(0)
       		resourcename = id(1)
        	sHtml = ""
        	 
       		document.all(inputename).value = resourceids
        	while InStr(resourceids,",") <> 0
            	curid = Mid(resourceids,1,InStr(resourceids,",")-1)
            	curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            	resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
            	resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            	sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
       		wend
        	sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
       		document.all(tdname).innerHtml = sHtml
        else
					document.all(tdname).innerHtml = ""
        	document.all(inputename).value=""
        end if
    end if
end sub
</script>