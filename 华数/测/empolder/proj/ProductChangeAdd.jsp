<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="weaver.general.Util, weaver.docs.docs.CustomFieldManager" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="CustomFieldTreeManager" class="weaver.hrm.resource.CustomFieldTreeManager" scope="page" />
<jsp:useBean id="EducationLevelComInfo" class="weaver.hrm.job.EducationLevelComInfo" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<html>


<%
FileUpload fu = new FileUpload(request);
String productVersionID = Util.null2String(fu.getParameter("productVersionID"));
String ProjID = Util.null2String(fu.getParameter("ProjID"));

// out.print(productVersionID+"&&&");
// out.print(ProjID);

%>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "产品目标及进度变更列表";
String needfav ="1";
String needhelp ="";
String needinputitems = "";
%>
<body>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doSubmit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:window.history.back(),_self}";
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr style="height:0px">
<td height="0" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">


<FORM name=weaver id=weaver action="?" method=post>

<table class=ViewForm >
  <colgroup>
  <col width="25%">
  <col width="25%">
  <col width="25%">
  <col width="25%"> 
  </colgroup>
  <tbody> 
  <tr>  
	<tH>
		产品目标及进度变更列表  
	</th>
  </tr>
  <TR class=spacing>
          <TD class=line1 colSpan=2></TD></TR>
  </tbody>
</table>
 
<input class=inputstyle type=hidden name=operation>
 <TABLE class=ViewForm>
	<TBODY>
    <TR>
      <TD vAlign=top>
   </tr>

<%
  String sql = "select * from Productchange where productVersionID = '"+productVersionID+"' and isShow = '0' order by id ";
  //out.println(sql);
  rs.executeSql(sql);
%>
	<TR>
      <TD vAlign=top>
        <TABLE width="100%" id="oTable" class=ListStyle >
          <COLGROUP>
   		    <COL width=10%>
		    <COL width=20%>
			<COL width=50%>
			<COL width=10%>
			<COL width=20%> 
	      <TBODY>
		  <input type=hidden name=rownum>
          <TR class=header>
          	
	       <TR>
      <TD colspan="5">
           <DIV>
            <a  style="cursor:pointer" onclick="addRow('oTable')"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></a>&nbsp; 
            <a  style="cursor:pointer" onclick="delRow('oTable')"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a>&nbsp;	
          </DIV>
      </TD>
  </TR> 
            <%-- <TD colspan="2" align="right">
				<div align="right">
					<span id="divAddAndDel">
						<a  style="cursor:pointer" onclick="addRow('oTable')"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></a>&nbsp;
						<a  style="cursor:pointer" onclick="delRow('oTable')"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a>&nbsp;  
					</span>
				<div>
			</TD>
          </TR> --%>
          <TR class=Spacing style="height:2px;display:none">
            <TD class=Line1 colSpan=5></TD>
          </TR>
		  <tr class=header>
            <td >选中</td>
		    <td >变更描述</td>
			<td >详细内容</td>
			<td >变更人</td>
			<td >变更时间</td>			 
		  </tr>

				<%
				  
				  int kkk = 0;
				  int rownum = 0;
				  while(rs.next()){
					
					String _id= Util.null2String(rs.getString("id"));
				    String description = Util.null2String(rs.getString("description"));
					String content = Util.null2String(rs.getString("content"));
					String changeUSER = Util.null2String(rs.getString("changeUSER"));
				    String changeData = Util.null2String(rs.getString("changeData"));
					
				%>
	       <tr id = "Row_<%= ++rownum %>"  class = 'opera' >
			   <td class=Field >
				 <input class='row_checkbox' type='checkbox'  name='check_node' value='Row_<%=rownum%>' ><span><%=rownum %></span>
			   </td>
			  <TD class=Field>
				<input class=inputstyle type='text' name='description' id='description_<%=rownum %>' value=<%=description %>></TD>
			  <TD class=Field>
				<input class=inputstyle type='text' name='content' id='content_<%=rownum %>' value=<%=content %>></TD>	
			  <TD class=Field>
			   <button type="button" class=Browser onClick=onShowResource('changeUSER_<%=rownum %>span','changeUSER_<%=rownum %>')></button> 
				   <span class=inputStyle name=changeUSER_<%=rownum %>span id=changeUSER_<%=rownum %>span><%=ResourceComInfo.getResourcename(changeUSER) %></span>
				 <input class=inputstyle type='hidden' name='changeUSER' id='changeUSER_<%=rownum %>' value=<%=changeUSER %>>
			  <TD class=Field>
				 <input class=inputstyle type='text' name='changeData' id='changeData_<%=rownum %>' value=<%=changeData %>>
				 <input class=inputstyle type='hidden' name='isDelete' value='0' id="isDelete">
				 <input class=inputstyle type='hidden' name='keyID' value='<%=_id%>' id="keyID">
				 <input class=inputstyle type='hidden' name='productVersionID' value='<%=productVersionID%>' id="productVersionID">
			  </TD>
			 </TR><tr  style="height: 1px"><td class=Line colspan=2></td></tr>						  
		<%
			
		  }
		%>
      </tbody>
       </table>
   </tr>
   </tbody>
</table>

<br>
 
</form>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr  style="height:0px">
	<td height="0" colspan="3"></td>
</tr>
</table>

<script language=javascript>
function doSubmit(){
	weaver.action="ProductChangeOption.jsp";
	weaver.submit();
}

function select(){
	weaver.submit();
}

var rownum = <%=rownum+1 %>;

var productVersionID_1 = <%=productVersionID%>;

//添加一行记录
function addRow(obj){
	var row_n = jQuery("#rowCount").val();
	//alert("---" + row_n);
	var trStr = "";
	var classStr = "";
	if(rownum % 2 == 0){
		classStr = "datalight";
	}else{
		classStr = "datadark";
	}
	
	if(obj=='oTable'){
		trStr += "<TR id='Row_"+rownum+"' class='"+classStr+"'>";
		trStr += "	<TD width=10%><INPUT class='row_checkbox' value='Row_"+rownum+"' type=checkbox name=check_node><span>"+rownum+"</span></TD>"; 
		trStr += "  <TD width=20%><INPUT class=inputstyle id='description_"+rownum+"' type=text name='description'>";
		trStr += "	</TD><TD width=50%>";
		trStr += "  <INPUT class=inputstyle id='content_"+rownum+"' type=text size='50' name='content'>";
		trStr += "	</TD><TD width=10%>";
		trStr += "	<button class=Browser onClick=\"onShowResource('changeUSER_"+rownum+"span','changeUSER_"+rownum+"')\"></button>";
		trStr += "  <span  id='changeUSER_"+rownum+"span' name='changeUSER_"+rownum+"span' STYLE=\"width:39%\"></span>";
		trStr += "  <INPUT class=inputstyle id='changeUSER_"+rownum+"' type=hidden name='changeUSER'>";
		trStr += "	</TD><TD width=10%>";
		trStr += "  <input class=inputstyle type='text' name='changeData' id='changeData_"+rownum+"'>";
	    trStr += "  <input type='hidden' name='isDelete' value='0' id='isDelete' />";
	    trStr += "  <input type='hidden' name='keyID' value='-1' id='keyID' />";
	    trStr += "  <input type='hidden' name='productVersionID' value='"+productVersionID_1+"' id='productVersionID' />";
		trStr += "	</TD>";
		trStr += "	</TR>";

		jQuery("#rowCount").val(row_n);
		//alert(row_n);
	}
	jQuery('#'+obj).append(trStr);
	rownum++;
}

//删除选中行记录
function delRow(tableObj) {
	var row_n = jQuery("#rowCount").val();
	if(confirm("<%=SystemEnv.getHtmlLabelName(17048,user.getLanguage())%>?")){
	jQuery('#'+tableObj).find('.row_checkbox').each(function(){
// 	alert(jQuery(this).attr("checked"));
		if(jQuery(this).attr("checked")==true) {
			jQuery('#'+jQuery(this).val()).hide();
			jQuery('#'+jQuery(this).val()).find('#isDelete').first().val("1");
		}
	});
	}
}

// function onShowResource(tdname,inputename){
// 	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
// 	if (data!=null){
// 	    if (data.id != "" && data.id != "0"){
// 	    	alert(data.id);
// 	    	alert(data.name);
// 			jQuery("#"+tdname).html(data.name);
// 			jQuery("input[name="+inputename+"]").val(data.id);
// 		}else{
// 			jQuery("#"+tdname).html("<IMG src='/images/BacoError.gif' align=absMiddle>");
// 			jQuery("input[name="+inputename+"]").val("");
// 		}
// 	}
// }

/* function onShowResource(tdname,inputename){
// 	alert(tdname);	
	var data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp");
	if (data!=null){
	    if (data.id != ""){
	    	alert(data.id);
	    	alert(data.name);
			jQuery("#"+tdname).html(data.name);
			jQuery("input[name="+inputename+"]").val(data.id);
		}else{
			jQuery("#"+tdname).html("<IMG src='/images/BacoError.gif' align=absMiddle>");
			jQuery("input[name="+inputename+"]").val("");
		}
	}
} */

function onShowMHrm1(spanname,inputename){
	tmpids = document.getElementById(inputename).value;
	alert(tmpids)
	datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="+tmpids);
    alert(datas)
	if(datas){
        if (datas.id&&datas.name.length > 2000){ //500为表结构文档字段的长度
	         	alert("<%=SystemEnv.getHtmlLabelName(24476,user.getLanguage())%>",48,"<%=SystemEnv.getHtmlLabelName(18739,user.getLanguage())%>");
				return;
		 }else if(datas.id){
			resourceids = datas.id;
			resourcename =datas.name;
			alert(resourcename)
				alert(resourceids)
			sHtml = "";
			resourceids =resourceids.split(",");
			document.getElementById(inputename).value= resourceids.indexOf(",")==0?resourceids.substr("1"):resourceids;
			resourcename =resourcename.split(",");
			for(var i=0;i<resourceids.length;i++){
				if(resourceids[i]&&resourcename[i]){
					sHtml = sHtml+"<a href=/hrm/resource/HrmResource.jsp?id="+resourceids[i]+"  target=_blank>"+resourcename[i]+"</a>&nbsp"
				}
			}
			//alert(spanname)
			//$("#"+spanname).innerHTML(sHtml);
			//document.all(spanname).innerHtml = sHtml;
			alert(sHtml);
			document.getElementById(spanname).innerHTML = sHtml;
			//$($GetEle(spanname)).innerhtml(sHtml);
        }else{
			document.getElementById(inputename).value="";
			//$($GetEle(spanname)).innerHTML("");
			document.getElementById(spanname).innerHTML = "";
        }
    }
 }
 
</script>
<script language=vbs>
sub onShowResource(tdname,inputename)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if NOT isempty(id) then
	        if id(0)<> "" then
		document.all(tdname).innerHtml = id(1)
		document.all(inputename).value=id(0)
		else
		document.all(tdname).innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
		document.all(inputename).value=""
		end if
	end if
end sub

sub onShowMHrm(spanname,inputename)
		tmpids = document.all(inputename).value
		id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&tmpids)
		    if (Not IsEmpty(id1)) then
				if id1(0)<> "" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all(inputename).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&curid&">"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&resourceids&">"&resourcename&"</a>&nbsp"
					document.all(spanname).innerHtml = sHtml
					
				else
					document.all(spanname).innerHtml =""
					document.all(inputename).value=""
				end if
			end if
end sub

sub onShowCompany()
	Dim id 
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp")
	if (Not IsEmpty(id)) then
		if id(0)<> 0 then
			companyspan.innerHtml = id(1)
			weaver.company.value=id(0)
		else 
			companyspan.innerHtml = ""
			weaver.company.value=""
		end if
	end if
end sub


sub onShowSubCompany(spanname,inputename)
		tmpids = document.all(inputename).value
		id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiSubcompanyBrowser.jsp?resourceids="&tmpids)
		    if (Not IsEmpty(id1)) then
				if id1(0)<> "" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all(inputename).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href=/hrm/company/HrmSubCompany.jsp?id="&curid&">"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href=/hrm/company/HrmSubCompany.jsp?id="&resourceids&">"&resourcename&"</a>&nbsp"
					document.all(spanname).innerHtml = sHtml
					
				else
					document.all(spanname).innerHtml =""
					document.all(inputename).value=""
				end if
			end if
end sub

 
sub onShowManagerID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	manageridspan.innerHtml = "<A href='HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	resourcepersonalinfo.managerid.value=id(0)
	else
	manageridspan.innerHtml = ""
	resourcepersonalinfo.managerid.value=""
	end if
	end if
end sub

</script>
 
</body>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<script type="text/javascript" src="/js/selectDateTime.js"></script>
</html>