<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
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
	int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	%>
<%

String workflowid = "" ;
String nodetype ="" ;
String fromdate ="" ;
String todate ="" ;
String creatertype ="" ;
String createrid ="" ;
String requestlevel ="" ;
String fromdate2 ="" ;
String todate2 ="" ;
String workcode ="" ;

// 
String request_id_tmp =  Util.null2String(request.getParameter("request_id_tmp"));;
String request_name_tmp  = Util.null2String(request.getParameter("request_name_tmp"));;

String querys=Util.null2String(request.getParameter("query"));
String fromself =Util.null2String(request.getParameter("fromself"));
String fromselfSql =Util.null2String(request.getParameter("fromselfSql"));
String isfirst =Util.null2String(request.getParameter("isfirst"));
String docids=Util.null2String(request.getParameter("docids"));
String flag=Util.null2String(request.getParameter("flag"));
int date2during=Util.getIntValue(Util.null2String(request.getParameter("date2during")),0);
int viewType=Util.getIntValue(Util.null2String(request.getParameter("viewType")),0);

String branchid="";
String cdepartmentid="";
//out.print(fromselfSql+"******");
try{
branchid=Util.null2String((String)session.getAttribute("branchid")); 
}
catch (Exception e)
{
branchid="";
}
int olddate2during = 0;
BaseBean baseBean = new BaseBean();
String date2durings = "";
try
{
	date2durings = Util.null2String(baseBean.getPropValue("wfdateduring", "wfdateduring"));
}
catch(Exception e)
{}
String[] date2duringTokens = Util.TokenizerString2(date2durings,",");
if(date2duringTokens.length>0)
{
	olddate2during = Util.getIntValue(date2duringTokens[0],0);
}
//add by xhheng @20050414 for TD 1545
int iswaitdo= Util.getIntValue(request.getParameter("iswaitdo"),0) ;
int isovertime= Util.getIntValue(request.getParameter("isovertime"),0) ;
if(fromself.equals("1")) {
  SearchClause.resetClause(); //added by xwj for td2045 on2005-05-26 
	workflowid = Util.null2String(request.getParameter("workflowid"));
	nodetype = Util.null2String(request.getParameter("nodetype"));
	fromdate = Util.null2String(request.getParameter("fromdate"));
	todate = Util.null2String(request.getParameter("todate"));
	creatertype = Util.null2String(request.getParameter("creatertype"));
	createrid = Util.null2String(request.getParameter("createrid"));
	requestlevel = Util.null2String(request.getParameter("requestlevel"));
	fromdate2 = Util.null2String(request.getParameter("fromdate2"));
	todate2 = Util.null2String(request.getParameter("todate2"));
    workcode = Util.null2String(request.getParameter("workcode"));
    cdepartmentid=Util.null2String(request.getParameter("cdepartmentid"));
}
else {

	workflowid = SearchClause.getWorkflowId();
	nodetype = SearchClause.getNodeType();
	fromdate = SearchClause.getFromDate();
	todate = SearchClause.getToDate();
	creatertype = SearchClause.getCreaterType();
	createrid = SearchClause.getCreaterId();
	requestlevel = SearchClause.getRequestLevel();
    fromdate2 = SearchClause.getFromDate2();
	todate2 = SearchClause.getToDate2();
    cdepartmentid=SearchClause.getDepartmentid();
}

String cdepartmentidspan = "";
ArrayList cdepartmentidArr = Util.TokenizerString(cdepartmentid,",");
for(int i=0;i<cdepartmentidArr.size();i++){
    String tempcdepartmentid = (String)cdepartmentidArr.get(i);
    if(cdepartmentidspan.equals("")) cdepartmentidspan += DepartmentComInfo.getDepartmentname(tempcdepartmentid);
    else cdepartmentidspan += ","+DepartmentComInfo.getDepartmentname(tempcdepartmentid);
}

String newsql="";

if(!workflowid.equals("") && !workflowid.equals("0"))
	newsql+=" and t1.workflowid in("+workflowid+")" ;
if(date2during>0&&date2during<37)
	newsql += WorkflowComInfo.getDateDuringSql(date2during);
if(fromself.equals("1")) {

	if(!nodetype.equals(""))
		newsql += " and t1.currentnodetype='"+nodetype+"'";
	
	if(!fromdate.equals(""))
		newsql += " and t1.createdate>='"+fromdate+"'";

	if(!todate.equals(""))
		newsql += " and t1.createdate<='"+todate+"'";

	if(!fromdate2.equals(""))
		newsql += " and t2.receivedate>='"+fromdate2+"'";

	if(!todate2.equals(""))
		newsql += " and t2.receivedate<='"+todate2+"'";

    if(!workcode.equals(""))
		newsql += " and t1.creater in(select id from hrmresource where workcode like '%"+workcode+"%')";
    
    if(!createrid.equals("")){
		newsql += " and t1.creater='"+createrid+"'";
	}
    if(!cdepartmentid.equals("")){
        String tempWhere = "";
        ArrayList tempArr = Util.TokenizerString(cdepartmentid,",");
        for(int i=0;i<tempArr.size();i++){
            String tempcdepartmentid = (String)tempArr.get(i);
            if(tempWhere.equals("")) tempWhere += "departmentid="+tempcdepartmentid;
            else tempWhere += " or departmentid="+tempcdepartmentid;
        }
        if(!tempWhere.equals(""))
		newsql += " and exists(select 1 from hrmresource where t1.creater=id  and ("+tempWhere+"))";
	}

	if(!requestlevel.equals("")){
		newsql += " and t1.requestlevel="+requestlevel;
  }

 if(!querys.equals("1")) {
  if (!fromselfSql.equals(""))
   newsql += " and " + fromselfSql;
}
else
{
if (fromself.equals("1"))
newsql += " and  islasttimes=1 ";
}

}

String CurrentUser = Util.null2String((String)session.getAttribute("RequestViewResource")) ;

String userID = String.valueOf(user.getUID());
String logintype = ""+user.getLogintype();
int usertype = 0;
if(logintype.equals("2")) usertype= 1;
if(CurrentUser.equals("")) {
	CurrentUser = ""+user.getUID();
}
boolean superior = false;  //是否为被查看者上级或者本身
if(userID.equals(CurrentUser))
{
	superior = true;
}
else
{
	RecordSet.executeSql("SELECT * FROM HrmResource WHERE ID = " + CurrentUser + " AND managerStr LIKE '%" + userID + "%'");
	
	if(RecordSet.next())
	{
		superior = true;	
	}
}



String sqlwhere="";
if(isovertime==1){
    sqlwhere ="where (t1.deleted <> 1 or t1.deleted is null or t1.deleted='') and t1.requestid = t2.requestid and t2.id in (Select max(z1.id) from workflow_currentoperator z1 where exists(select 1 from SysPoppupRemindInfonew z2 where  z1.requestid=z2.requestid and z2.type=10 and z2.userid = "+user.getUID()+" and z2.usertype='"+(Util.getIntValue(logintype,1)-1)+"' and exists (select 1 from workflow_currentoperator z3 where z2.requestid=z3.requestid and ((z3.isremark='0' and (z3.isprocessed='2' or z3.isprocessed='3' or z3.isprocessed is null))  or z3.isremark='5') and z3.islasttimes=1)) group by z1.requestid)";
}
else{
	if(superior&&!flag.equals(""))
		CurrentUser = userID;
    sqlwhere="where (t1.deleted <> 1 or t1.deleted is null or t1.deleted='') and t1.requestid = t2.requestid and t2.userid = "+CurrentUser+" and t2.usertype=" + usertype;
    if(!Util.null2String(SearchClause.getWhereClause()).equals("")){
        sqlwhere += " and "+SearchClause.getWhereClause();
		//out.print("sql***********"+SearchClause.getWhereClause());
    }
}

if(RecordSet.getDBType().equals("oracle"))
{
	sqlwhere += " and (nvl(t1.currentstatus,-1) = -1 or (nvl(t1.currentstatus,-1)=0 and t1.creater="+user.getUID()+")) ";
}
else
{
	sqlwhere += " and (isnull(t1.currentstatus,-1) = -1 or (isnull(t1.currentstatus,-1)=0 and t1.creater="+user.getUID()+")) ";
}
String orderby = "";
//String orderby2 = "";

//out.print(sqlwhere);

sqlwhere +=" "+newsql ;
//orderby=" t1.createdate,t1.createtime,t1.requestlevel";
orderby=SearchClause.getOrderClause();
if(orderby.equals("")){
    orderby="t2.receivedate desc ,t2.receivetime desc";
}
//orderby2=" order by t1.createdate,t1.createtime,t1.requestlevel";

//String tablename = "wrktablename"+ Util.getRandom() ;

int start=Util.getIntValue(Util.null2String(request.getParameter("start")),1);
String sql="";
int totalcounts = Util.getIntValue(Util.null2String(request.getParameter("totalcounts")),0);

//add by xhheng @ 20050302 for TD 1545
String strworkflowid="";
int startIndex = 0;

String fromhp = Util.null2String(request.getParameter("fromhp"));
if(fromhp.equals("1")){
	String eid = Util.null2String(request.getParameter("eid"));
	String tabid = Util.null2String(request.getParameter("tabid"));
	RecordSet.execute("select count(content) as count from workflowcentersettingdetail where  type = 'flowid' and eid="+eid+"and tabId = '"+tabid+"'");
	if(RecordSet.next()){
		if(RecordSet.getInt("count")>0){
			strworkflowid = " in (select content from workflowcentersettingdetail where  type = 'flowid' and eid="+eid+"and tabId = '"+tabid+"' )";
		}
	}
}else{
	
	if(!Util.null2String(SearchClause.getWhereClause()).equals(""))
	{
	  String tempstr=SearchClause.getWhereClause();
	  if(tempstr.indexOf("t1.workflowid")!=-1){
	    startIndex = tempstr.indexOf("t1.workflowid")+13;//added by xwj for td2045 on 2005-05-26
	    if(tempstr.indexOf("and")!=-1) {
			if(tempstr.indexOf("(t1.deleted=0")!=-1){
				int startIndex1 = tempstr.indexOf("and");
				int startIndex2 = tempstr.indexOf("and", startIndex1+1);
				strworkflowid=tempstr.substring(startIndex,startIndex2);
			}else{
		    	strworkflowid=tempstr.substring(startIndex,tempstr.indexOf("and"));
			}
	    	if(strworkflowid.indexOf("(")!=-1 && strworkflowid.indexOf(")")==-1) strworkflowid+=")";
	    }
	    else
	        strworkflowid=tempstr.substring(startIndex,tempstr.indexOf(")")+1);
	    	if(strworkflowid.indexOf("(")!=-1 && strworkflowid.indexOf(")")==-1) strworkflowid+=")";
	  }
	  //System.out.println("strworkflowid1 = " + strworkflowid);
	}
	else{
	  if(!workflowid.equals(""))
	  strworkflowid=" in ("+ workflowid +")";
	}
}

//System.out.println("strworkflowid2 = " + strworkflowid);

// 全部批量打开，不需要判断
/*
if(strworkflowid.equals("")){
  RecordSet.executeSql("select count(id) as mtcount from workflow_base where multiSubmit=1");
}else {
  RecordSet.executeSql("select count(id) as mtcount from workflow_base where id "+strworkflowid+" and multiSubmit=1");
}
boolean isMultiSubmit=false;
if(RecordSet.next()){
  if(RecordSet.getInt("mtcount")>0){
    isMultiSubmit=true;
  }
} */

int perpage=10;
boolean hascreatetime =true;
boolean hascreater =true;
boolean hasworkflowname =true;
boolean hasrequestlevel =true;
boolean hasrequestname =true;
boolean hasreceivetime =true;
boolean hasstatus =true;
boolean hasreceivedpersons =true;
boolean hascurrentnode =true;
RecordSet.executeProc("workflow_RUserDefault_Select",""+user.getUID());
if(RecordSet.next()){
    if(!Util.null2String(RecordSet.getString("hascreatetime")).equals("1")) hascreatetime=false;
    if(!Util.null2String(RecordSet.getString("hascreater")).equals("1")) hascreater=false;
    if(!Util.null2String(RecordSet.getString("hasworkflowname")).equals("1")) hasworkflowname=false;
    if(!Util.null2String(RecordSet.getString("hasrequestlevel")).equals("1")) hasrequestlevel=false;
    if(!Util.null2String(RecordSet.getString("hasrequestname")).equals("1")) hasrequestname=false;
    if(!Util.null2String(RecordSet.getString("hasreceivetime")).equals("1")) hasreceivetime=false;
    if(!Util.null2String(RecordSet.getString("hasstatus")).equals("1")) hasstatus=false;
    if(!Util.null2String(RecordSet.getString("hasreceivedpersons")).equals("1")) hasreceivedpersons=false;
    if(!Util.null2String(RecordSet.getString("hascurrentnode")).equals("1")) hascurrentnode=false;
    perpage= RecordSet.getInt("numperpage");
}else{
    RecordSet.executeProc("workflow_RUserDefault_Select","1");
    if(RecordSet.next()){
        if(!Util.null2String(RecordSet.getString("hascreatetime")).equals("1")) hascreatetime=false;
        if(!Util.null2String(RecordSet.getString("hascreater")).equals("1")) hascreater=false;
        if(!Util.null2String(RecordSet.getString("hasworkflowname")).equals("1")) hasworkflowname=false;
        if(!Util.null2String(RecordSet.getString("hasrequestlevel")).equals("1")) hasrequestlevel=false;
        if(!Util.null2String(RecordSet.getString("hasrequestname")).equals("1")) hasrequestname=false;
        if(!Util.null2String(RecordSet.getString("hasreceivetime")).equals("1")) hasreceivetime=false;
        if(!Util.null2String(RecordSet.getString("hasstatus")).equals("1")) hasstatus=false;
        if(!Util.null2String(RecordSet.getString("hasreceivedpersons")).equals("1")) hasreceivedpersons=false;
        if(!Util.null2String(RecordSet.getString("hascurrentnode")).equals("1")) hascurrentnode=false;
        perpage= RecordSet.getInt("numperpage");
    }
}

/*如果所有的列都不显示，那么就显示所有的，避免页面出错*/
if(!hascreatetime&&!hascreater&&!hasworkflowname&&!hasrequestlevel&&!hasrequestname&&!hasreceivetime&&!hasstatus&&!hasreceivedpersons&&!hascurrentnode){
	hascreatetime =true;
	hascreater =true;
	hasworkflowname =true;
	hasrequestlevel =true;
	hasrequestname =true;
	hasreceivetime =true;
	hasstatus =true;
	hasreceivedpersons =true;
	hascurrentnode =true;			
}

//update by fanggsh 20060711 for TD4532 begin
boolean hasSubWorkflow =false;

if(workflowid!=null&&!workflowid.equals("")&&workflowid.indexOf(",")==-1){
	RecordSet.executeSql("select id from Workflow_SubWfSet where mainWorkflowId="+workflowid);
	if(RecordSet.next()){
		hasSubWorkflow=true;
	}

	RecordSet.executeSql("select id from Workflow_TriDiffWfDiffField where mainWorkflowId="+workflowid);
	if(RecordSet.next()){
		hasSubWorkflow=true;
	}
}

//update by fanggsh 20060711 for TD4532 end


//RecordSet.executeSql(sqltemp);
//RecordSet.executeSql("drop table "+tablename);

%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
			RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:OnSearch(),_self}" ;
			RCMenuHeight += RCMenuHeightStep ;
			RCMenu += "{"+SystemEnv.getHtmlLabelName(364,user.getLanguage())+",WFSearch.jsp?iswaitdo="+iswaitdo+"&date2during="+olddate2during+",_self}" ;
			RCMenuHeight += RCMenuHeightStep ;

			RCMenu += "{批量打开,javascript:OnMultiSubmitNew(),_self}" ;
			RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
		<input type=hidden name=fromself value="<%=fromself%>">
		<input type=hidden name=isfirst value="<%=isfirst%>">
		<input type=hidden name=fromselfSql value="<%if(!"1".equals(isfirst)){%><%=SearchClause.getWhereClause()%><%}else{%><%=fromselfSql%><%}%>">
		<input name=iswaitdo type=hidden value="<%=iswaitdo%>">
		<input name=query type=hidden value="<%=querys%>">
		<input type=hidden name=docids value="<%=docids%>">
		<input type=hidden name=isovertime value="<%=isovertime%>">
		<input type=hidden name=viewType value="<%=viewType%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">

				<wea:item>类型</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="workflowid" browserValue="<%=workflowid%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowBrowser.jsp"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="120px"
			    linkUrl=""
			    browserSpanValue="<%=workflowid%>">
				</brow:browser>
				</wea:item>

				<wea:item>节点类型</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="nodetype" id="nodetype"> 
     			<option value="">&nbsp;</option>
     			<option value="0" <% if(nodetype.equals("0")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(125,user.getLanguage())%></option>
     			<option value="1" <% if(nodetype.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(142,user.getLanguage())%></option>
     			<option value="2" <% if(nodetype.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(725,user.getLanguage())%></option>
     			<option value="3" <% if(nodetype.equals("3")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(251,user.getLanguage())%></option>
				</select>
				</wea:item>

				<wea:item>等级</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="requestlevel" id="requestlevel"> 
	  			<option value=""> </option>
	  			<option value="0" <% if(requestlevel.equals("0")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%></option>
	  			<option value="1" <% if(requestlevel.equals("1")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%></option>
	  			<option value="2" <% if(requestlevel.equals("2")) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%></option>
				</select>
				</wea:item>

				<wea:item>创建日期</wea:item>
				<wea:item>
			    <button type="button" class=Calendar id="SelectDate" onclick="gettheDate(fromdate,fromdatespan)"></BUTTON> 
            	<SPAN id=fromdatespan><%=fromdate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" name="fromdate" value="<%=fromdate%>"> 

			    <button type="button" class=Calendar id="SelectDate2" onclick="gettheDate(todate,todatespan)"></BUTTON> 
            	 <SPAN id=todatespan><%=todate%></SPAN> 
            	 <INPUT type="hidden" name="todate" value="<%=todate%>">
			     </wea:item>

			    <wea:item>创建人</wea:item>
				<wea:item>
				<brow:browser viewType="0"  id ="createrid" name="createrid" browserValue="<%=ResourceComInfo.getResourcename(createrid)%>" 
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="120px"
			    browserSpanValue="<%=ResourceComInfo.getResourcename(createrid)%>">
				</brow:browser>
				</wea:item>

				<wea:item>接收日期</wea:item>
				<wea:item>
			    <button type="button" class=Calendar id="SelectDate3" onclick="gettheDate(fromdate2,fromdatespan2)"></BUTTON> 
            	<SPAN id=fromdatespan2><%=fromdate2%></SPAN> 
            	<INPUT class=inputstyle type="hidden" name="fromdate2" value="<%=fromdate2%>"> 

			    <button type="button" class=Calendar id="SelectDate4" onclick="gettheDate(todate2,todatespan2)"></BUTTON> 
            	 <SPAN id=todatespan2><%=todate2%></SPAN> 
            	 <INPUT type="hidden" name="todate2" value="<%=todate2%>">
			     </wea:item>

			    <wea:item>创建人编号</wea:item>
			    <wea:item>
				<INPUT  maxLength=50 size=45 name="workcode" style="width: 120px;" id = "name"
						value="<%=workcode%>">
				</wea:item>

				<wea:item>创建人部门</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="cdepartmentid" browserValue="<%=cdepartmentid%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="120px"
			    linkUrl=""
			    browserSpanValue="<%=cdepartmentid%>">
				</brow:browser>
				</wea:item>

				<wea:item>接受期间</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="date2during" id="requestlevel"> 
	     		<option value="">&nbsp;</option>
	     	<%
	     	for(int i=0;i<date2duringTokens.length;i++)
	     	{
	     		int tempdate2during = Util.getIntValue(date2duringTokens[i],0);
	     		if(tempdate2during>36||tempdate2during<1)
	      		{
	      			continue;
	      		}
	     	%>
	     	<!-- 最近个月 -->
	     	<option value="<%=tempdate2during %>" <%if (date2during==tempdate2during) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(24515,user.getLanguage())%><%=tempdate2during %><%=SystemEnv.getHtmlLabelName(26301,user.getLanguage())%></option>
	     	<%
	     	} 
	     	%>
	     	<!-- 全部 -->
	     	<option value="38" <%if (date2during==38) {%>selected<%}%>><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></option>
				</select>
				</wea:item>

				<wea:item>流程编号</wea:item>
				<wea:item>
				<INPUT  maxLength=50 size=45 name="request_id_tmp" style="width: 120px;" id = "name"
						value="<%=request_id_tmp%>">
				</wea:item>

				<wea:item>请求标题</wea:item>
				<wea:item>
				<INPUT  maxLength=50 size=45 name="request_name_tmp" style="width: 120px;" id = "name"
						value="<%=request_name_tmp%>">
				</wea:item>

				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		</FORM>
            <%
                           String tableString = "";
                          
                            if(perpage <2) perpage=10;                                 
                        
                            String backfields = " t1.requestid, t1.createdate, t1.createtime,t1.creater, t1.creatertype, t1.workflowid, t1.requestname, t1.status,t1.requestlevel,t1.currentnodeid,t2.viewtype,t2.receivedate,t2.receivetime,t2.isremark,t2.nodeid,t2.agentorbyagentid,t2.agenttype,t2.isprocessed,t1.requestmark ";
                            String fromSql  = " from workflow_requestbase t1,workflow_currentoperator t2 ";
                            String sqlWhere = sqlwhere;
                            if(sqlWhere.indexOf("in (select id from workflow_base where isvalid=") < 0){
	                            sqlWhere += " and t1.workflowid in (select id from workflow_base where isvalid='1' )";
                            }
                            sqlWhere += " and t2.isremark in(0,1) ";
                           // sqlWhere += " and t1.requestid not in (select requestid from workflow_requestbase wr where wr.requestname like '会议%' and wr.workflowid=1) "
                            sqlWhere += " and t1.workflowid !=1 ";
                            
                            String para2="column:requestid+column:workflowid+column:viewtype+"+isovertime+"+"+user.getLanguage()+"+column:nodeid+column:isremark+"+userID+"+column:agentorbyagentid+column:agenttype+column:isprocessed";
                            String para4=user.getLanguage()+"+"+user.getUID();
							if(!docids.equals("")){
                                fromSql  = fromSql+",workflow_form t4 ";
                                sqlWhere = sqlWhere+" and t1.requestid=t4.requestid ";
                            }
                            // String request_id_tmp = "";
         					// String request_name_tmp = ""; 
                            
							if(!request_id_tmp.equals("")){
                                sqlWhere = sqlWhere+" and t1.requestmark like '%" + request_id_tmp +"%' ";
                            }
                            
							if(!request_name_tmp.equals("")){
                                sqlWhere = sqlWhere+" and t1.requestname like '%"+ request_name_tmp+"%' ";
                            }
                            
                            if(!superior)
                        	{
                            	sqlWhere += " AND EXISTS (SELECT 1 FROM workFlow_CurrentOperator workFlowCurrentOperator WHERE t2.workflowid = workFlowCurrentOperator.workflowid AND t2.requestid = workFlowCurrentOperator.requestid AND workFlowCurrentOperator.userid=" + userID + " and workFlowCurrentOperator.usertype = " + usertype +") ";
                        	}
                            
                           if (!branchid.equals(""))
						   {
						   sqlWhere += " AND t1.creater in (select id from hrmresource where subcompanyid1="+branchid+")  ";
						   }
                          //out.println("select "+backfields+fromSql+sqlWhere);
                          tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"checkbox\" pagesize=\""+perpage+"\" >"+ 
                                                "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.requestid\" sqlsortway=\"Desc\" sqlisdistinct=\"true\" />"+
                                                 "			<head>";
                          if(hascreatetime)
                                    tableString+="				<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(19502,user.getLanguage())+"\" column=\"requestmark\" orderkey=\"requestmark\" />";
	                      if(hascreatetime)
                                    tableString+="				<col width=\"9%\"  text=\""+SystemEnv.getHtmlLabelName(722,user.getLanguage())+"\" column=\"createdate\" orderkey=\"t1.createdate,t1.createtime\" otherpara=\"column:createtime\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCreateTime\" />";
                          if(hascreater)
                                    tableString+="				<col width=\"5%\"  text=\""+SystemEnv.getHtmlLabelName(882,user.getLanguage())+"\" column=\"creater\" orderkey=\"t1.creater\"  otherpara=\"column:creatertype\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\" />";
                          if(hasworkflowname)
                                    tableString+="				<col width=\"11%\"  text=\""+SystemEnv.getHtmlLabelName(259,user.getLanguage())+"\" column=\"workflowid\" orderkey=\"t1.workflowid\" transmethod=\"weaver.workflow.workflow.WorkflowComInfo.getWorkflowname\" />";
                          if(hasrequestlevel)
                                    tableString+="				<col width=\"4%\"   text=\""+SystemEnv.getHtmlLabelName(15534,user.getLanguage())+"\" column=\"requestlevel\"  orderkey=\"t1.requestlevel\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultUrgencyDegree\" otherpara=\""+user.getLanguage()+"\"/>";
                          if(hasrequestname) {
	                          tableString+="				<col width=\"22%\"  text=\""+SystemEnv.getHtmlLabelName(1334,user.getLanguage())+"\" column=\"requestname\" orderkey=\"t1.requestname\"  linkkey=\"requestid\" linkvaluecolumn=\"requestid\" target=\"_fullwindow\" transmethod=\"weaver.general.WorkFlowTransMethod.getWfNewLinkWithTitle\"  otherpara=\""+para2+"\"/>";
                          }
                          if(hascurrentnode)
                                    tableString+="				<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(524,user.getLanguage())+SystemEnv.getHtmlLabelName(15586,user.getLanguage())+"\" column=\"currentnodeid\" transmethod=\"weaver.general.WorkFlowTransMethod.getCurrentNode\"/>";
                          if(hasreceivetime)
                                    tableString+="			    <col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(17994,user.getLanguage())+"\" column=\"receivedate\" orderkey=\"t2.receivedate,t2.receivetime\" otherpara=\"column:receivetime\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCreateTime\" />";
                          if(hasstatus)
                                    tableString+="			    <col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(1335,user.getLanguage())+"\" column=\"status\" orderkey=\"t1.status\" />";
                     //     if(hasreceivedpersons)
                          //          tableString+="			    <col width=\"15%\"  text=\""+SystemEnv.getHtmlLabelName(16354,user.getLanguage())+"\" column=\"requestid\" otherpara=\""+para4+"\" transmethod=\"weaver.general.WorkFlowTransMethod.getUnOperators\"/>";
                          if(hasSubWorkflow)
                                    tableString+="				<col width=\"6%\"  text=\""+SystemEnv.getHtmlLabelName(19363,user.getLanguage())+"\" column=\"requestid\" orderkey=\"t1.requestid\"  linkkey=\"requestid\" linkvaluecolumn=\"requestid\" target=\"_self\" transmethod=\"weaver.general.WorkFlowTransMethod.getSubWFLink\"  otherpara=\""+user.getLanguage()+"\"/>";

                                    tableString+="			</head>"+   			
                                                 "</table>";

                          %>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
	function onBtnSearchClick() {
			$GetEle("fromself").value="1";
			$GetEle("isfirst").value="1";
			//$GetEle("frmmain").submit();
			report.submit();
		}

	function onShowResource() {
	var tmpval = $GetEle("creatertype").value;
	var id = null;
	if (tmpval == "0") {
		id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp", "", "dialogWidth:550px;dialogHeight:550px;");
	}else {
		id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp", "", "dialogWidth:550px;dialogHeight:550px;");
	}
	if (id != null) {
        if (wuiUtil.getJsonValueByIndex(id, 0) != "" && wuiUtil.getJsonValueByIndex(id, 0) != "0") {
			resourcespan.innerHTML = wuiUtil.getJsonValueByIndex(id, 1);
			$GetEle("createrid").value=wuiUtil.getJsonValueByIndex(id, 0);
        } else {
			resourcespan.innerHTML = "";
			$GetEle("createrid").value="";
        }
	}

}
function onShowDepartment(tdname,inputename) {
	var id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids=" + $GetEle(inputename).value, "", "dialogWidth:550px;dialogHeight:550px;")
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "" && wuiUtil.getJsonValueByIndex(id, 0) != "0") {
			$GetEle(tdname).innerHTML = wuiUtil.getJsonValueByIndex(id, 1).substr(1);
			$GetEle(inputename).value= wuiUtil.getJsonValueByIndex(id, 0).substr(1);
		} else {
			$GetEle(tdname).innerHTML = "";
			$GetEle(inputename).value="";
		}
	}
}
</script>

<SCRIPT language="javascript">

function OnChangePage(start){
        $GetEle("start").value = start;
        $GetEle("frmmain").submit();
}

function OnSearch(){
	$GetEle("fromself").value="1";
	$GetEle("isfirst").value="1";
	$GetEle("frmmain").submit();
}

function OnMultiSubmitNew2(){
	OnMultiSubmitNew1();
	OnMultiSubmitNew1();
}

function OnMultiSubmit1(){

	$GetEle("multiSubIds").value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
    $GetEle("frmmain1").submit();
}
<!--
function OnMultiSubmitNew(){
	var uid = <%=userID%>
//	alert("批量打开，打开请求为 "+_xtable_CheckedCheckboxId());
	
	var all_reqs = _xtable_CheckedCheckboxId().split(",");
	var div_str = "";
	var ids = new Array();
	
	for(var i=0;i<all_reqs.length-1;i++){
		var tmp_id = "gvo_op_"+i;
		ids[i] = tmp_id;
		
	//	div_str = "http://222.92.108.195:8082/workflow/request/ViewRequest.jsp?requestid="+all_reqs[i];
//		div_str = div_str + " <a id=\""+tmp_id+"\" href=\"/workflow/request/ViewRequest.jsp?requestid="+all_reqs[i]+"&isrequest=0\" target=\"_fullwindow\"></a>";
		var wopener = null;
		wopener = window.open('/sso/SSOForward.jsp?fromUserId='+uid+'&type=WFL&requestid='+all_reqs[i],'newwin'+all_reqs[i]);
	}
	window.location.reload();
//	jQuery("#ccccxx").html(div_str);
//	for(var i=0;i<all_reqs.length-1;i++){
		
//		document.getElementById(ids[i]).click();
//	}
}
//--->


function openMore(i){
	if(i==1 || i=='1'){
		openMore1();
	}else{
		openMore2();
	}
}

function openMore1(){
	alert("openMore1 ");
	document.getElementById("gvo_op_0").click();
}
function openMore2(){
	alert("openMore2 ");
	document.getElementById("gvo_op_1").click();
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


var showTableDiv  = $GetEle('divshowreceivied');
var oIframe = document.createElement('iframe');
function showreceiviedPopup(content){
    showTableDiv.style.display='';
    var message_Div = document.createElement("div");
     message_Div.id="message_Div";
     message_Div.className="xTable_message";
     showTableDiv.appendChild(message_Div);
     var message_Div1  = $GetEle("message_Div");
     message_Div1.style.display="inline";
     message_Div1.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_Div1.style.position="absolute"
     message_Div1.style.top=pTop;
     message_Div1.style.left=pLeft;

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
	             $GetEle(returntdid).innerHTML = ajax.responseText;
	             $GetEle(returntdid).parentElement.title = ajax.responseText.replace(/[\r\n]/gm, "");
            }catch(e){}
	            showTableDiv.style.display='none';
	            oIframe.style.display='none';
        } 
    } 
}

function onShowWorkFlow(inputname, spanname) {
	onShowWorkFlowBase(inputname, spanname, false);
}

function onShowWorkFlowNeeded(inputname, spanname) {
	onShowWorkFlowBase(inputname, spanname, true);
}

function onShowWorkFlowBase(inputname, spanname, needed) {
	var retValue = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowBrowser.jsp", "", "dialogWidth:550px;dialogHeight:550px;");
	if (retValue != null) {
		if (wuiUtil.getJsonValueByIndex(retValue, 0) != "" ) {
			$GetEle(spanname).innerHTML = wuiUtil.getJsonValueByIndex(retValue, 1);
			$GetEle(inputname).value = wuiUtil.getJsonValueByIndex(retValue, 0);
		} else { 
			$GetEle(inputname).value = "";
			if (needed) {
				$GetEle(spanname).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			} else {
				$GetEle(spanname).innerHTML = "";
			}
		}
	}
}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>