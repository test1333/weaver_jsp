<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%><!--added by xwj for td2023 on 2005-05-20-->
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.GCONST" %>
<%@ page import="weaver.general.IsGovProj" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ProjectTransMethod" class="weaver.general.ProjectTransMethod" scope="page" />
<jsp:useBean id="SubcompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type="text/css" rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>

</head>
<%
String multiSubIds=Util.null2String(request.getParameter("multiSubIds"));
if(!multiSubIds.equals("")){
   if(multiSubIds.startsWith(",")){
	   multiSubIds=multiSubIds.substring(1);
   }
   if(multiSubIds.endsWith(",")){
	   multiSubIds=multiSubIds.substring(0,multiSubIds.length()-1);
   } 
   boolean ok = rs.executeSql("delete from projmeeting where id in ("+multiSubIds+")");
   if(ok){
	   out.print("<script>alert('删除成功');</script>");
   }
}

%>
<%
int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
String imagefilename = "/images/hdDOC.gif";
String titlename = "搜索：会议纪要信息查询";   
String needfav ="1";
String needhelp ="";


String workflowids=""; 

%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %> 

<% 
 
String meetingname=Util.null2String(request.getParameter("meetingname"));
String sqrq1=Util.null2String(request.getParameter("sqrq1"));
String sqrq2=Util.null2String(request.getParameter("sqrq2")); 

int iswaitdo= Util.getIntValue(request.getParameter("iswaitdo"),0) ;
int isovertime= Util.getIntValue(request.getParameter("isovertime"),0) ;
 
String projid=Util.null2String(request.getParameter("projid")); 
String projname="";

String newsql=" ";
Calendar thedate = Calendar.getInstance(); 

if(!projid.equals("")&&!projid.equals("0")){
	if(rs.getDBType().equalsIgnoreCase("oracle")){
		newsql=" and (','||projids||',')  like '%,"+projid+",%'";
	}else{
		newsql=" and (','+ CONVERT(varchar(300),projids )+',')  like '%,"+projid+",%'";  
	}
	rs.executeSql(" select name from wasu_projectbase where id="+projid);
	if(rs.next()){
		projname = rs.getString("name");
	}
}

if(!meetingname.equals("")){ 
	newsql += "  and meetingname  like '%"+meetingname+"%' ";   
}

if(!sqrq1.equals("")){ 
	newsql += "  and meetingtime>='"+sqrq1+"' ";   
}
if(!sqrq2.equals("")){ 
	newsql += "  and meetingtime<='"+sqrq2+"' ";   
} 

String CurrentUser = Util.null2String((String)session.getAttribute("RequestViewResource")) ;

String userID = String.valueOf(user.getUID());
  
String sqlwhere="";
  
String orderby = "";  
sqlwhere +=" "+newsql ;
 orderby=" t1.id ";   
 
int start=Util.getIntValue(Util.null2String(request.getParameter("start")),1);
String sql="";
int totalcounts = Util.getIntValue(Util.null2String(request.getParameter("totalcounts")),0);

//add by xhheng @ 20050302 for TD 1545
String strworkflowid="";
int startIndex = 0;
  
int perpage=100;
 

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:OnSearch(),_self}" ;
RCMenuHeight += RCMenuHeightStep ; 

RCMenu += "{新建会议纪要,javascript:onnewMeeting(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;  
RCMenu += "{导出Excel,/weaver/weaver.file.ExcelOut,_self}" ;
RCMenuHeight += RCMenuHeightStep ; 
RCMenu += "{删除,javascript:onDeleteMeeting(),_self}" ; 
RCMenuHeight += RCMenuHeightStep ;  

%>

<FORM id=frmmain name=frmmain method=post action="Projmeetinglist.jsp">
<div id='divshowreceivied' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>  
 <input name=creatertype type=hidden value="0">  
 <input name=multiSubIds type=hidden  >  
 <input name=projid type=hidden value="<%=projid %>" >   
<input type=hidden name=isovertime value="<%=isovertime%>">
<table width=100% height=94% border="0" cellspacing="0" cellpadding="0">
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

<table class="viewform"  > 
  <colgroup>
  <col width="10%">
  <col width="20%">
  <col width="5">
  <col width="10%">
  <col width="20%">
  <col width="5%">
  <col width="10%">
  <col width="20%">
  <tbody>
    <tr>
    <td>会议名称</td>
    <td class=field> 
	      <input name=meetingname type=text class=inputStyle   value="<%=meetingname%>" >
    </td> 
    <td>&nbsp;</td>
    <td>相关项目</td> 
    <td class=field >
       <BUTTON class=browser id="selectProjids" onclick="onshowProject()"></BUTTON> 
				<SPAN id="meetingprojidSpan" name=meetingprojidSpan> <%=projname %> 
				</SPAN> 
				<INPUT type="hidden" name="meetingprojid"  value="<%=projid%>"> 
    </td> 
    <td>&nbsp;</td>
    <td>会议时间</td> 
    <td class=field >
          <BUTTON class="Calendar" id="selectBeginDate" onclick="onshowPlanDate(sqrq1, selectBeginDateSpan)"></BUTTON> 
				<SPAN id="selectBeginDateSpan"><%=sqrq1%></SPAN> 
				<INPUT type="hidden" name="sqrq1" value="<%=sqrq1%>">  
				- 
			<BUTTON class="Calendar" id="selectendDate" onclick="onshowPlanDate(sqrq2, selectendDateSpan)"></BUTTON> 
				<SPAN id="selectendDateSpan"><%=sqrq2%></SPAN> 
				<INPUT type="hidden" name="sqrq2" value="<%=sqrq2%>">
    </td> 
  </tr>
  <TR><TD class=Line colSpan=8></TD></TR> 
   
  <TR><TD class=Line colSpan=8></TD></TR> 
  </tbody>
</table>

<input name=start type=hidden value="<%=start%>">
</form>
 
 <TABLE width="100%">
    <tr>
      <td valign="top">                                                                                    
     <%
      String tableString = "";
      if(perpage <2) perpage=10;                                  
                        
      String backfields =" t1.* "; 
      String fromSql  = " from projmeeting t1 ";  
      String sqlWhere = " where 1=1   "+sqlwhere;  
      // new weaver.general.BaseBean().writeLog("------->select "+backfields+fromSql+sqlWhere); 
      //System.out.println("select "+backfields+fromSql+sqlWhere);
      tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"checkbox\" pagesize=\""+perpage+"\" >"+
                   " <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
                   " <head>";   
      tableString+=" <col width=\"20%\"  text=\"会议名称\" column=\"meetingname\"   orderkey=\"t1.meetingname\" linkvaluecolumn=\"id\"  linkkey=\"id\" href=\"/project/editProjMeeting.jsp?1=1\" target=\"_self\"  />";                      
      tableString+=" <col width=\"20%\"  text=\"会议日期\" column=\"meetingtime\"   orderkey=\"t1.meetingtime\"   />"; 
      tableString+=" <col width=\"30%\"  text=\"相关项目\" column=\"projids\"   transmethod=\"weaver.general.ProjectTransMethod.getProjLinkNames\"  />";                       
      tableString+=" <col width=\"30%\"  text=\"相关附件情况\" column=\"fjids\"  transmethod=\"weaver.general.ProjectTransMethod.getFjNames\"  />";  
      tableString+="	</head>"+      	 		
        "</table>";    
    %>
 <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run"  showExpExcel="true"  />
          </td>
        </tr>
 </TABLE>

<!--   added by xwj for td2023 on 2005-05-20  end  -->
     
<table align=right>
   <tr>
   <td>&nbsp;</td>
   <td>
   <%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(18363,user.getLanguage())+",javascript:_table.firstPage(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1258,user.getLanguage())+",javascript:_table.prePage(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1259,user.getLanguage())+",javascript:_table.nextPage(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(18362,user.getLanguage())+",javascript:_table.lastPage(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
   %>
 <td>&nbsp;</td>
   </tr>
	  </TABLE>
	  
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
<% sql = "SELECT " + backfields + " " + fromSql + " " + sqlWhere + " ORDER BY " + " t1.id desc ";
RecordSet.executeSql(sql); 
ExcelFile.init();
ExcelSheet es = new ExcelSheet();
ExcelStyle excelStyle = ExcelFile.newExcelStyle("Border");
excelStyle.setCellBorder(ExcelStyle.WeaverBorderThin);
ExcelStyle excelStyle1 = ExcelFile.newExcelStyle("Header");
excelStyle1.setGroundcolor(ExcelStyle.WeaverHeaderGroundcolor);
excelStyle1.setFontcolor(ExcelStyle.WeaverHeaderFontcolor);
excelStyle1.setFontbold(ExcelStyle.WeaverHeaderFontbold);
excelStyle1.setAlign(ExcelStyle.WeaverHeaderAlign);
excelStyle1.setCellBorder(ExcelStyle.WeaverBorderThin);
ExcelRow er = es.newExcelRow();

er.addStringValue("会议名称", "Header"); 
er.addStringValue("会议日期", "Header"); 
er.addStringValue("相关项目", "Header"); 
er.addStringValue("相关附件情况", "Header"); 
 
while(RecordSet.next()){
	er = es.newExcelRow();
	 
	er.addStringValue(Util.null2String(RecordSet.getString("meetingname")), "Border");
	er.addStringValue(Util.null2String(RecordSet.getString("meetingtime")), "Border");
	er.addStringValue(ProjectTransMethod.getProjLinkNamesNoHref(Util.null2String(RecordSet.getString("projids"))), "Border");
	er.addStringValue(ProjectTransMethod.getFjNamesNoHref(Util.null2String(RecordSet.getString("fjids"))), "Border"); 
	 
}
ExcelFile.setFilename("会议列表导出"); 
ExcelFile.addSheet("会议列表", es);
%>


<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
</body>
<script language=vbs>
sub onShowResource()
	tmpval = document.all("creatertype").value
	if tmpval = "0" then
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	else
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
	end if
	if NOT isempty(id) then
	        if id(0)<> "" and id(0)<> "0" then
		resourcespan.innerHtml = id(1)
		frmmain.createrid.value=id(0)
		else
		resourcespan.innerHtml = ""
		frmmain.createrid.value=""
		end if
	end if
end sub

sub onShowMutiResource(inputename,spanname)  
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&document.all(inputename).value)
	if NOT isempty(id) then
	        if id(0)<> "" and id(0)<> "0" then
		document.all(spanname).innerHtml = id(1)
		document.all(inputename).value=id(0)
		else
		document.all(spanname).innerHtml = ""
		document.all(inputename).value=""
		end if
	end if

end sub


sub onshowProject()
   id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.xgxm&sqlwhere=") 	
	 if (Not IsEmpty(id)) then
	 if id(0)<> "" then
         document.all("meetingprojidSpan").innerHtml= "<A href='/project/ViewCustomer.jsp?CustomerID="&id(0)&"'>"&id(1)&"</A>"
         document.all("meetingprojid").value=id(0)
   else
   	document.all("meetingprojidSpan").innerHTML = ""
   	document.all("meetingprojid").value = ""
   end if
	 end if
end sub

sub onShowDepartment(tdname,inputename)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="&document.all(inputename).value)
	if NOT isempty(id) then
	        if id(0)<> "" and id(0)<> "0" then
		document.all(tdname).innerHtml = mid(id(1),2,len(id(1)))
		document.all(inputename).value=mid(id(0),2,len(id(0)))
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

<SCRIPT language="javascript">

function OnChangePage(start){
        document.frmmain.start.value = start;
		document.frmmain.submit();
}

function OnSearch(){
        
		document.frmmain.submit();
}

function onnewMeeting(){
	window.location='/project/addProjMeeting.jsp';
}

function OnMultiSubmit(){ 

    document.frmmain.multiSubIds.value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
    document.frmmain.submit();
}

function onDeleteMeeting(){
	 document.frmmain.multiSubIds.value = _xtable_CheckedCheckboxId();
	    if(document.frmmain.multiSubIds.value==''){
		   alert("未选择任何会议纪要！"); 
		   return;
	    }else{
	    	document.frmmain.submit();
	    }
}

function OnMultiSubmitNew(obj){

    document.frmmain1.multiSubIds.value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
    document.frmmain1.submit();
	obj.disabled=true;
}
function CheckAll(haschecked) {

    len = document.weaver1.elements.length;
    var i=0;
    for( i=0; i<len; i++) {
        if (document.weaver1.elements[i].name.substring(0,13)=='multi_submit_') {
            document.weaver1.elements[i].checked=(haschecked==true?true:false);
        }
    }


}


var showTableDiv  = document.getElementById('divshowreceivied');
var oIframe = document.createElement('iframe');
function showreceiviedPopup(content){
    showTableDiv.style.display='';
    var message_Div = document.createElement("<div>");
     message_Div.id="message_Div";
     message_Div.className="xTable_message";
     showTableDiv.appendChild(message_Div);
     var message_Div1  = document.getElementById("message_Div");
     message_Div1.style.display="inline";
     message_Div1.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_Div1.style.position="absolute"
     message_Div1.style.posTop=pTop;
     message_Div1.style.posLeft=pLeft;

     message_Div1.style.zIndex=1002;

     oIframe.id = 'HelpFrame';
     showTableDiv.appendChild(oIframe);
     oIframe.frameborder = 0;
     oIframe.style.position = 'absolute';
     oIframe.style.top = pTop;
     oIframe.style.left = pLeft;
     oIframe.style.zIndex = message_Div1.style.zIndex - 1;
     oIframe.style.width = parseInt(message_Div1.offsetWidth);
     oIframe.style.height = parseInt(message_Div1.offsetHeight);
     oIframe.style.display = 'block';
}
function displaydiv_1()
{
	if(WorkFlowDiv.style.display == ""){
		WorkFlowDiv.style.display = "none";
		//WorkFlowspan.innerHTML = "<a href='javascript:void(0);' onClick=displaydiv_1() target=_self><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></a>";
		WorkFlowspan.innerHTML = "<span style='cursor:hand;color: blue; text-decoration: underline' onClick='displaydiv_1()' ><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></span>";
	}
	else{
		WorkFlowDiv.style.display = "";
		//WorkFlowspan.innerHTML = "<a href='javascript:void(0);' onClick=displaydiv_1() target=_self><%=SystemEnv.getHtmlLabelName(15154,user.getLanguage())%></a>";
		WorkFlowspan.innerHTML = "<span style='cursor:hand;color: blue; text-decoration: underline' onClick='displaydiv_1()' ><%=SystemEnv.getHtmlLabelName(15154,user.getLanguage())%></span>";

	}
}

function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    ajax = new XMLHttpRequest();
    }
    return ajax;
}
function showallreceived(requestid,returntdid){
    showreceiviedPopup("<%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>");
    var ajax=ajaxinit();
	
    ajax.open("POST", "WorkflowUnoperatorPersons.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("requestid="+requestid+"&returntdid="+returntdid);
    //获取执行状态
    //alert(ajax.readyState);
	//alert(ajax.status);
    ajax.onreadystatechange = function() {
        //如果执行状态成功，那么就把返回信息写到指定的层里
        if (ajax.readyState==4&&ajax.status == 200) {
            try{
            document.all(returntdid).innerHTML = ajax.responseText;
            }catch(e){}
            showTableDiv.style.display='none';
            oIframe.style.display='none';
        } 
    } 
}
//?rnd="+Math.random()+" 
</script>
 
<SCRIPT language="javascript" defer="defer" src='/js/datetime.js?rnd="+Math.random()+"'></script>
<SCRIPT language="javascript" defer="defer" src='/js/JSDateTime/WdatePicker.js?rnd="+Math.random()+"'></script>
<SCRIPT language="javascript"  src='/js/selectDateTime.js?rnd="+Math.random()+"'></script>
</html>
 