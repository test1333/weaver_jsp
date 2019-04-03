<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<%
boolean canedit = true;
 
String stonedate=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String attentcontent="";
String attentreason="";
String attentorder=""; 
String stoneid=""; 
int maxorder=1;
String id=Util.null2String(request.getParameter("id"));
String isshowall=Util.null2String(request.getParameter("isshowall"));
String projid=Util.null2String(request.getParameter("projid")); 
if(!id.equals("")){
	RecordSet.executeSql(" select * from wasu_projAttention where projid="+projid+" and id="+id); 
	if(RecordSet.next()){
		attentorder=Util.null2String(RecordSet.getString("attentorder"));
		stoneid=Util.null2String(RecordSet.getString("stoneid"));
		attentcontent=Util.null2String(RecordSet.getString("attentcontent")); 
		attentreason=Util.null2String(RecordSet.getString("attentreason")); 
    }
}else{
	RecordSet.executeSql(" select max(attentorder) as maxorder from wasu_projAttention where projid="+projid+"  ");
	RecordSet.next();
	maxorder = Util.getIntValue(RecordSet.getString("maxorder"),0)+1;  
	attentorder=maxorder+""; 
}

//标示当前操作页面是修改页面还是添加页面
String isupdate=request.getParameter("isupdate");
if (isupdate == null || isupdate.length() < 0){
		isupdate = "no";
}
%>


<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
<SCRIPT language="javascript" src="../../js/jquery/jquery.js"></script>
</HEAD>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "里程碑维护";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
if(canedit){
    if(id.equals("")){
RCMenu += "{"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;}else{
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
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

<%if(canedit){%>
<FORM id=weaverA name=weaverA action="ProjAttentionOperation.jsp" method=post  >
<%if(id.equals("")){%>
	<input class=inputstyle type="hidden" name="method" value="add">
	<input class=inputstyle type="hidden" name="projid" value="<%=projid%>">
<%}else{%>
	<input class=inputstyle type="hidden" name="method" value="edit">
	<input class=inputstyle type="hidden" name="id" value="<%=id%>">
	<input class=inputstyle type="hidden" name="projid" value="<%=projid%>">
<%}%>
<TABLE class=Viewform>
  <COLGROUP>
  <COL width="15%">
  <COL width=85%>
  <TBODY>
  <TR class=Sapcing>
          <TD class=Sep1 colSpan=4></TD></TR>
          <TD>关注点序号</TD> 
          <TD class=Field>
              <input class=inputstyle id=attentorder name=attentorder  style="width=20%" onblur="onblurCheckName()" onchange='checkinput("attentorder","stoneorderimage")' value="<%if(!attentorder.equals("")){%><%=attentorder%><%}%>"><SPAN id=stoneorderimage><%if(attentorder.equals("")){%><IMG src="/images/BacoError.gif" align=absMiddle><%}%></SPAN><SPAN id=checknameinfo style='color:red;'>&nbsp;</SPAN>
		  </TD>
        </TR>
     <TR><TD class=Line colSpan=2></TD></TR>
    
        <tr>
            <td>相关里程碑</td>
            <td class=field >
                 		<select name=stoneid>
                 		<% rs.executeSql(" select id,stonename  from wasu_projstone where projid="+projid+" and  (stonestatus is null or stonestatus=0)  ");
                 		   while(rs.next()){ 
                 		%> 
                			<option value="<%=rs.getString("id")%>" <%if(stoneid.equals(rs.getString("id"))){ %> selected <% }%> ><%=rs.getString("stonename")%></option>
                 		<%} %>
                 		</select>
            </td>
        </tr>
        <tr class="Spacing"><td colspan=2 class="Line"></td></tr>
           <TR>
          <TD>关注内容</TD>
          <TD class=Field>
			   <textarea name=attentcontent rows=5 cols=50 value=<%=attentcontent %> ><%=attentcontent %></textarea>   
		  </TD>
        </TR>
        <TR><TD class=Line colSpan=2></TD></TR>
        <tr class="Spacing"><td colspan=2 class="Line"></td></tr>
           <TR>
          <TD>关注原因</TD>
          <TD class=Field>
			   <input type=text class=inputStyle name=attentreason value="<%=attentreason %>"/>
		  </TD>
        </TR>
        <TR><TD class=Line colSpan=2></TD></TR>
           
  </TBODY>
</TABLE>
</FORM>

<FORM id=weaverD action="ProjAttentionOperation.jsp" method=post>
<input class=inputstyle type="hidden" name="method" value="delete"> 
<input class=inputstyle type="hidden" name="projid" value="<%=projid%>"> 
<TABLE class=form>
  <COLGROUP>
  <COL width="20%">
  <COL width=80%>
  <TBODY>
  <TR class=separator>
          <TD class=Sep1 colSpan=2></TD></TR>
           <TR>
          <TD colSpan=2> 
		  <BUTTON class=btnDelete accessKey=D type=submit onclick="return isdel()"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
		  </TD>
        </TR>
  </TBODY>
</TABLE>
<%}%>
	  <TABLE class=ListStyle cellspacing=1 >
        <TBODY>
	    <TR class=Header>
			<th width=10>&nbsp;</th>
			<th>关注点序号</th>
            <th>里程碑名称</th>
			<th>关注点内容</th> 
			<th>关注点原因</th> 
	    </TR>
        <TR class=Line><TD colspan="5" ></TD></TR> 
<%
 
    RecordSet.executeSql("select t1.*,t2.stonename from wasu_projAttention t1,wasu_projstone t2 where t1.stoneid=t2.id and t1.projid="+projid+"  order by t1.attentorder asc ");
 
boolean isLight = false;
while(RecordSet.next())
{
	 
		if(isLight)
		{%>
	<TR CLASS=DataDark  >
<%		}else{%>
	<TR CLASS=DataLight  > 
<%		}%>

			<th width=10><%if(canedit){%><input class=inputstyle type=checkbox name=attentionids value="<%=RecordSet.getString("id")%>"><%}%></th>
			<td>
			<a href="ProjAttentionlist.jsp?id=<%=RecordSet.getString("id")%>&isupdate=yes&projid=<%=projid%>"><%=Util.forHtml(RecordSet.getString("attentorder"))%></A>
			</td> 
            <td>
			<a href="ProjAttentionlist.jsp?id=<%=RecordSet.getString("id")%>&isupdate=yes&projid=<%=projid%>"><%=Util.forHtml(RecordSet.getString("stonename"))%></A>
			</td>
			<td><%=Util.forHtml(RecordSet.getString("attentcontent"))%></td>
			<td><%=Util.forHtml(RecordSet.getString("attentreason"))%></td>
    </tr>
<%
	isLight = !isLight;
}%>
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

$(document).ready(function(){
	//alert("hide");
	$("#checknameinfo").hide();	
});


function submitData() {
		var roomname = $("#stoneorder").val();		
		var isupdate = '<%=isupdate%>';
		if (isupdate == "no"){ 
				//$.post("/meeting/Maint/MeetingRoomCheck.jsp",{roomname:encodeURIComponent($("#roomname").val())},function(datas){ 							 
				//		 $("#checknameinfo").hide();
				//		 if(datas.indexOf("unfind") > 0 && check_form(weaverA,"name")){
								weaverA.submit();
				//		 } else if (datas.indexOf("exist") > 0){				 	  
				//		 	  alert("<%=SystemEnv.getHtmlLabelName(780,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%> [ "+roomname+" ] <%=SystemEnv.getHtmlLabelName(24943,user.getLanguage())%>");
				//		 }
				//});
		} else if (isupdate == "yes"){
			 
				//$.post("/meeting/Maint/MeetingRoomCheck.jsp",{roomname:encodeURIComponent($("#roomname").val()),id:'<%=id%>'},function(datas){ 	
						 //alert(datas+"==");   
				//		 $("#checknameinfo").hide();
				//		 if(datas.indexOf("unfind") > 0 && check_form(weaverA,"name")){
								weaverA.submit();
				//		 } else if (datas.indexOf("exist") > 0){				 	  
				//		 	  alert("<%=SystemEnv.getHtmlLabelName(780,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%> [ "+roomname+" ] <%=SystemEnv.getHtmlLabelName(24943,user.getLanguage())%>");
				//		 }
				//}); 	
			
	  } else if (check_form(weaverA,"name")){
				weaverA.submit();
	 } 
}

function onblurCheckName() {
		var roomname = $("#roomname").val();		
		var isupdate = '<%=isupdate%>';
		var name = '<%=id%>';
		if (isupdate == "no"){
				$.post("/meeting/Maint/MeetingRoomCheck.jsp",{roomname:encodeURIComponent($("#roomname").val())},function(datas){ 							 
						 if (datas.indexOf("exist") > 0){
						 	  $("#checknameinfo").show();						 	
						 	  $("#checknameinfo").text(" <%=SystemEnv.getHtmlLabelName(780,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%> [ "+roomname+" ] <%=SystemEnv.getHtmlLabelName(24943,user.getLanguage())%>");
						 } else { 
						 		$("#checknameinfo").hide();
						 }
				});
		} else if (isupdate == "yes"){			
				$.post("/meeting/Maint/MeetingRoomCheck.jsp",{roomname:encodeURIComponent($("#roomname").val()),id:'<%=id%>'},function(datas){ 	
						 if (datas.indexOf("exist") > 0){				 	  
						 	  $("#checknameinfo").show();						 	
						 	  $("#checknameinfo").text(" <%=SystemEnv.getHtmlLabelName(780,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%> [ "+roomname+" ] <%=SystemEnv.getHtmlLabelName(24943,user.getLanguage())%>");
						 }
				});				
	  }
}
</script>
<script language=vbs>
sub onShowHrmID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	hrmidspan.innerHtml = "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	weaverA.hrmid.value=id(0)
	else
    hrmidspan.innerHtml = ""
	weaverA.hrmid.value=""
	end if
	end if
end sub
sub adfonShowSubcompany()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser4.jsp?rightStr=MeetingRoomAdd:Add")
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
</body>
</html>