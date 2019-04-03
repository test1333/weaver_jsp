<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%><!--added by xwj for td2023 on 2005-05-20-->
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.GCONST" %>
<%@ page import="weaver.general.IsGovProj" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubcompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type="text/css" rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>

</head>
<%
String multiSubIds=Util.null2String(request.getParameter("deletetaskids"));
if(!multiSubIds.equals("")){
   if(multiSubIds.startsWith(",")){
	   multiSubIds=multiSubIds.substring(1);
   }
   if(multiSubIds.endsWith(",")){
	   multiSubIds=multiSubIds.substring(0,multiSubIds.length()-1);
   } 
   boolean ok = rs.executeSql("delete from wasu_projtask where id in ("+multiSubIds+")");
   if(ok){
	   out.print("<script>alert('删除成功');</script>"); 
   }
}
//审批时间
String optype=Util.null2String(request.getParameter("optype"));
String taskid=Util.null2String(request.getParameter("taskid"));
if(!optype.equals("")&&!taskid.equals("")){ 
	Date newdate = new Date() ;
	long datetime = newdate.getTime() ;
	java.sql.Timestamp timestamp = new java.sql.Timestamp(datetime) ;
	String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
	String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);
    String updatesql="";  
	boolean ok = rs.executeSql("update wasu_projtask set "+optype+"date='"+CurrentDate+"' where id="+taskid);  
}
%>
<%
int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
String imagefilename = "/images/hdDOC.gif";
String titlename = "搜索：项目任务文档信息查询";   
String needfav ="1";
String needhelp ="";


String workflowids=""; 

%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %> 

<% 
 
String xmname=Util.null2String(request.getParameter("xmname"));
String taskname=Util.null2String(request.getParameter("taskname"));
String creaters=Util.null2String(request.getParameter("xmjl")); 
int wdfl=Util.getIntValue(request.getParameter("wdfl"),-1);
String sqrq1=Util.null2String(request.getParameter("sqrq1"));
String sqrq2=Util.null2String(request.getParameter("sqrq2")); 

int iswaitdo= Util.getIntValue(request.getParameter("iswaitdo"),0) ;
int isovertime= Util.getIntValue(request.getParameter("isovertime"),0) ;
 
String projid=Util.null2String(request.getParameter("projid"));

String newsql=" ";
Calendar thedate = Calendar.getInstance();

if(!projid.equals("")){
	newsql=" and projid="+projid; 
	rs.executeSql(" select name from wasu_projectbase where id="+projid);
	rs.next();
	xmname=rs.getString("name");
}

if(!sqrq1.equals("")){ 
	newsql += "  and sqrq>='"+sqrq1+"' ";   
}
if(!sqrq2.equals("")){ 
	newsql += "  and sqrq<='"+sqrq2+"' ";   
}
if(!taskname.equals("")){ 
	newsql += "  and taskname like '%"+taskname+"%' ";    
}   
if(wdfl>-1){ 
	newsql += "  and tasklb="+wdfl+" ";    
} 
  

if(!creaters.equals("") ){
	if(creaters.startsWith(",")){
		creaters = creaters.substring(1,creaters.length());
	}  
	newsql += " and t1.creater  in("+creaters+")"; 
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
RCMenu += "{新建任务文档,javascript:onNewTask(),_self}" ; 
RCMenuHeight += RCMenuHeightStep ; 
RCMenu += "{删除,javascript:OnDeleteTask(),_self}" ;
RCMenuHeight += RCMenuHeightStep ; 

%>

<FORM id=frmmain name=frmmain method=post action="Projtasklist.jsp">
<div id='divshowreceivied' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>  
 <input name=creatertype type=hidden value="0">  
 <input name=deletetaskids type=hidden  >  
 <input name=taskid type=hidden  >  
 <input name=optype type=hidden  >  
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

<table class="viewform">
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
    <td>任务名称</td>
    <td class=field> 
	      <input name=taskname type=text class=inputStyle   value="<%=taskname%>" >
    </td> 
    <td>&nbsp;</td>
    <td>相关项目</td> 
    <td class=field >
       <%=xmname%>
    </td> 
    <td>&nbsp;</td>
    <td>创建人</td> 
    <td class=field >
          <button class=browser onClick="onShowMutiResource('xmjl','resourcesspan')"></button>
			<span id=resourcesspan><%=ResourceComInfo.getMulResourcename(creaters) %></span>
		   <input name=xmjl type=hidden  value="<%=creaters %>"> 
    </td> 
  </tr>
  <TR><TD class=Line colSpan=8></TD></TR> 
  <tr>
   <td>文档分类</td>
   <td class=field>
       <select name="wdfl">
       <option	value=-1></option>
        <%  
        String wdflformid = Util.null2o(weaver.file.Prop.getPropValue("projconfig", "wdfl"));
        rs.executeSql(" select * from formtable_main_"+wdflformid+"_dt1 order by sx asc ");
                    while(rs.next()){ 
                %> 
                   <option value=<%=rs.getString("id") %> <%if(wdfl==rs.getInt("id")){ %>selected<%} %> ><%=rs.getString("flmc") %></option>
                <%}  %>  
       </select>
  </td>
  <td>&nbsp;</td>
 <td > </td>
	<td class=field> 
    </td>
  <td>&nbsp;</td>
 
  <td > </td>
	<td class=field> 
              </select>
    </td> 
  
  </tr>
  <TR><TD class=Line colSpan=8></TD></TR> 
   
   
  <TR><TD class=Line colSpan=8></TD></TR> 
  </tbody>
</table>

<input name=start type=hidden value="<%=start%>">

 
 <TABLE width="100%">
    <tr>
      <td valign="top">                                                                                    
     <%
      String tableString = "";
      if(perpage <2) perpage=10;                                  
                        
      String backfields =" t1.* "; 
      String fromSql  = " from wasu_projtask t1 "; 
      String sqlWhere = " where 1=1   "+sqlwhere;  
      // new weaver.general.BaseBean().writeLog("------->select "+backfields+fromSql+sqlWhere); 
      System.out.println("select "+backfields+fromSql+sqlWhere);
      tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"checkbox\" pagesize=\""+perpage+"\" >"+
                   " <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
                   " <head>";   
      tableString+=" <col width=\"8%\"  text=\"创建人\" column=\"creater\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"    />";                      
      tableString+=" <col width=\"8%\"  text=\"创建日期\" column=\"createdate\"   orderkey=\"t1.createdate\"   />"; 
      tableString+=" <col width=\"10%\"  text=\"任务名称\" column=\"taskname\"  orderkey=\"t1.taskname\"   />";                       
      tableString+=" <col width=\"10%\"  text=\"文档分类\" column=\"tasklb\"  transmethod=\"weaver.general.ProjectTransMethod.getWDFLName\"  />";                      
      tableString+=" <col width=\"10%\"  text=\"相关项目\" column=\"projid\" transmethod=\"weaver.general.ProjectTransMethod.getProjName\"/>";  
      tableString+=" <col width=\"20%\"  text=\"相关附件情况\" column=\"id\" otherpara=\"column:tasklb\"  transmethod=\"weaver.general.ProjectTransMethod.getTaskFJInfo\"  />";  
      tableString+=" <col width=\"20%\"  text=\"各阶段时间\" column=\"id\"   transmethod=\"weaver.general.ProjectTransMethod.getProjTaskTimeButton\"  />";  
      tableString+="	</head>"+      	 		
        "</table>";    
    %>
 <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run"  showExpExcel="true"  />
          </td>
        </tr>
 </TABLE>
</form>
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

function OnDeleteTask(){
	document.frmmain.deletetaskids.value=_xtable_CheckedCheckboxId();
	document.frmmain.submit();
}

function onNewTask(){
	window.location='/project/AddProjTask.jsp?projid=<%=projid%>';
}

function OnMultiSubmit(){ 

    document.frmmain.multiSubIds.value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
    document.frmmain.submit();
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

function setbuttondate(typeid,dtaskid){ 
	if(confirm("确认审批？")){
		document.frmmain.optype.value=typeid;
		document.frmmain.taskid.value=dtaskid;
		document.frmmain.submit();
		//window.location="/project/ViewCustomerBase.jsp?CustomerID=&curstatus="+curstatus;
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
<SCRIPT language="javascript" defer="defer" src='/js/project/WdatePicker.js?rnd="+Math.random()+"'></script>
<SCRIPT language="javascript"  src='/js/selectDateTime.js?rnd="+Math.random()+"'></script>
</html>
 