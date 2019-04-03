<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.GCONST" %>
<%@ page import="weaver.general.IsGovProj" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubcompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>


<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>

<style>
.checkbox {
	display: none
}
</style>
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
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "搜索：项目任务文档信息查询";
String needfav ="1";
String needhelp ="";
String workflowids=""; String xmname=Util.null2String(request.getParameter("xmname"));
String taskname=Util.null2String(request.getParameter("taskname"));
String creaters=Util.null2String(request.getParameter("creaters")); 
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
String tmc_pageId = "lcrwwd001";
%>




<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>

	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:OnSearch(),_self}" ;
RCMenuHeight += RCMenuHeightStep ; 
RCMenu += "{新建任务文档,javascript:onNewTask(),_self}" ; 
RCMenuHeight += RCMenuHeightStep ; 
RCMenu += "{删除,javascript:OnDeleteTask(),_self}" ;
RCMenuHeight += RCMenuHeightStep ; 

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action="/project/Projtasklist.jsp"  method=post>
	<input name=creatertype type=hidden value="0">  
 <input name=deletetaskids type=hidden  >  
 <input name=taskid type=hidden  >  
 <input name=optype type=hidden  >  
 <input name=projid type=hidden value="<%=projid %>" >   
<input type=hidden name=isovertime value="<%=isovertime%>">
<input name=start type=hidden value="<%=start%>">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						
					<!--<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>-->
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
		</table>
					
		<% // 查询条件 %>
		 <div class="tab_box" style="visibility: visible;">
				<wea:layout type="4col">
				<wea:group context="搜索：项目任务文档信息查询">

				

				<wea:item>任务名称</wea:item>
				<wea:item>
				<input class="InputStyle" type="text"   name="taskname" id="taskname" value="<%=taskname%>">
				</wea:item>

				<wea:item>相关项目</wea:item>
				<wea:item>
				<%=xmname%>
				</wea:item>

               <wea:item>创建人</wea:item>
			   
				<wea:item>
				<brow:browser viewType="0"  name="creaters" browserValue="<%=creaters %>" 
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getMulResourcename(creaters),user.getLanguage())%>">
				</brow:browser>
				</wea:item>



				<wea:item>文档分类</wea:item>
				<wea:item>
					<select class="e8_btn_top middle" name="wdfl" id="wdfl"> 
                                 		    <option	value="-1"></option>
                                 			   <%  
						String wdflformid = Util.null2o(weaver.file.Prop.getPropValue("projconfig", "wdfl"));
						rs.executeSql(" select * from formtable_main_"+wdflformid+"_dt1 order by sx asc ");
                    while(rs.next()){ 
                %> 
                   <option value=<%=rs.getString("id") %> <%if(wdfl==rs.getInt("id")){ %>selected<%} %> ><%=rs.getString("flmc") %></option>
                <%}  %>  
                 </select>
				</wea:item>				

				</wea:group>		
				</wea:layout>
			</div>

	</FORM>
    
	<%
								
	String backfields = " t1.* "; 
	String fromSql  = " from wasu_projtask t1 "; 
  String sqlWhere = " where 1=1   "+sqlwhere;  
	String tableString = "";
  

//  右侧鼠标 放上可以点击
String  operateString= "";	
tableString =" <table  instanceid=\"workflowRequestListTable\" tabletype=\"checkbox\"  pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" >"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		 tableString+=" <col width=\"8%\"  text=\"创建人\" column=\"creater\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"    />";                      
      tableString+=" <col width=\"8%\"  text=\"创建日期\" column=\"createdate\"   orderkey=\"t1.createdate\"   />"; 
      tableString+=" <col width=\"10%\"  text=\"任务名称\" column=\"taskname\"  orderkey=\"t1.taskname\"   />";                       
      tableString+=" <col width=\"10%\"  text=\"文档分类\" column=\"tasklb\"  transmethod=\"weaver.general.ProjectTransMethod.getWDFLName\"  />";                      
      tableString+=" <col width=\"10%\"  text=\"相关项目\" column=\"projid\" transmethod=\"weaver.general.ProjectTransMethod.getProjName\"/>";  
      tableString+=" <col width=\"20%\"  text=\"相关附件情况\" column=\"id\" otherpara=\"column:tasklb\"  transmethod=\"weaver.general.ProjectTransMethod.getTaskFJInfo\"  />";  
      tableString+=" <col width=\"20%\"  text=\"各阶段时间\" column=\"id\"   transmethod=\"weaver.general.ProjectTransMethod.getProjTaskTimeButton\"  />";  
      tableString+="	</head>"+ 
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />

	<script type="text/javascript">
	
		function OnSearch() {
			report.submit();
		}
		function onNewTask(){
	window.location='/project/AddProjTask.jsp?projid=<%=projid%>';
}
function OnDeleteTask(){
	document.report.deletetaskids.value=_xtable_CheckedCheckboxId();
	document.report.submit();
}
function OnChangePage(start){
        document.report.start.value = start;
		document.report.submit();
}
function setbuttondate(typeid,dtaskid){ 
	if(confirm("确认审批？")){
		document.report.optype.value=typeid;
		document.report.taskid.value=dtaskid;
		document.report.submit();
		//window.location="/project/ViewCustomerBase.jsp?CustomerID=&curstatus="+curstatus;
	}
	 
}
function OnMultiSubmit(){ 

    document.report.multiSubIds.value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
    document.report.submit();
}

function OnMultiSubmitNew(obj){

    document.report.multiSubIds.value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
    document.report.submit();
	obj.disabled=true;
}

	</script>
	</script>
			<SCRIPT language="javascript" src="/js/datetime.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>
