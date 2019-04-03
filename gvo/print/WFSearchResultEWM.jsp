<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%><!--added by xwj for td2023 on 2005-05-20-->
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.GCONST" %>
<%@ page import="weaver.general.IsGovProj" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type="text/css" rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>

</head>
<%
int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(197,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(648,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>

<FORM id=weaver name=frmmain method=post action="#">

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
String querys=Util.null2String(request.getParameter("query"));
String fromself =Util.null2String(request.getParameter("fromself"));
String fromselfSql =Util.null2String(request.getParameter("fromselfSql"));
String isfirst =Util.null2String(request.getParameter("isfirst"));
String docids=Util.null2String(request.getParameter("docids"));
String flag=Util.null2String(request.getParameter("flag"));
int date2during=Util.getIntValue(Util.null2String(request.getParameter("date2during")),0);
int viewType=Util.getIntValue(Util.null2String(request.getParameter("viewType")),0);
String  requestidstemp = Util.null2String(request.getParameter("requestidstemp"));
String  requestids = Util.null2String(request.getParameter("requestids"));
if(requestids.equalsIgnoreCase("x")||requestids.equalsIgnoreCase("c")){
	requestidstemp = "";
}else{
	if(requestids.length() > 2){
		if(requestidstemp.length() < 2){
			requestidstemp = requestids;
		}else{
			requestidstemp = requestidstemp + "," + requestids;
		}
	}
}
 //out.print("requestids = " + requestids + "<br>");
 //out.print("requestidstemp = " + requestidstemp + "<br>");

requestids = "";

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
if("".equals(requestidstemp))
{
	newsql += " and 1=2 ";
}
	//out.println(fromself);
if(fromself.equals("1")) {
  
//	if(!requestidstemp.equals("")){
//		newsql += " and t1.requestid in ("+requestidstemp+")";
// 	} 
  	
  	if(!requestidstemp.equals("")){
  		String remarkArr[] = requestidstemp.split(",");
		StringBuffer buff = new StringBuffer();
		String s_flag = "";
		for(int index = 0;index < remarkArr.length;index++){
			buff.append(s_flag);
			buff.append("'");
			buff.append(remarkArr[index]);
			buff.append("'");
			
			s_flag = ",";
		}
		
		newsql += " and t1.requestmark in ("+buff.toString()+")";
  	} 

	if(!querys.equals("1")) {
	if (!fromselfSql.equals(""))
		newsql += " and " + fromselfSql;
	}else{
		if (fromself.equals("1"))
		newsql += " and  islasttimes=1 ";
	}

}
//out.println("----"+newsql);
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
    orderby="t2.receivedate ,t2.receivetime";
}
//orderby2=" order by t1.createdate,t1.createtime,t1.requestlevel";

//String tablename = "wrktablename"+ Util.getRandom() ;

int start=Util.getIntValue(Util.null2String(request.getParameter("start")),1);
String sql="";
int totalcounts = Util.getIntValue(Util.null2String(request.getParameter("totalcounts")),0);

//add by xhheng @ 20050302 for TD 1545
String strworkflowid="";
int startIndex = 0;

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

//System.out.println("strworkflowid2 = " + strworkflowid);
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
}

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



RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:OnSearch(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{重置,javascript:doreset(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;

if(isMultiSubmit && iswaitdo==1){
  RCMenu += "{"+SystemEnv.getHtmlLabelName(17598,user.getLanguage())+",javascript:OnMultiSubmitNew(this),_self}" ;
  RCMenuHeight += RCMenuHeightStep ;
}
%>

<div id='divshowreceivied' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>
<input type=hidden name=fromself value="1">
<input type=hidden name=isfirst value="<%=isfirst%>">
<input type=hidden name=fromselfSql value="<%if(!"1".equals(isfirst)){%><%=SearchClause.getWhereClause()%><%}else{%><%=fromselfSql%><%}%>">
<input name=iswaitdo type=hidden value="<%=iswaitdo%>">
<input name=query type=hidden value="<%=querys%>">
<input type=hidden name=docids value="<%=docids%>">
<input type=hidden name=isovertime value="<%=isovertime%>">
<input type=hidden name=viewType value="<%=viewType%>">

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

<table class="viewform" width="100%">
  <colgroup>
  <col width="30%">
  <col width="70%"> 
  <tbody>
     <tr>
	     <td >编码</td>
	     <td><input type="text" id="requestids" name="requestids" size="100"   /> 
			<input type="hidden" size="100" id="requestidstemp" name="requestidstemp" class=inputstyle value="<%=requestidstemp%>"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<!--	<input type="hidden" value="重置" class="e8_btn_top_first" onclick="doreset()" /> -->
		 </td>
		
		 
	 </tr>
     <TR style="height:1px;"><TD class=Line colSpan=2></TD></TR>
  </tbody>
</table>

<input name=start type=hidden value="<%=start%>">
</form>



<!--   added by xwj for td2023 on 2005-05-20  begin  -->
<FORM id=weaver1 name=frmmain1 method=post action="#">
<input type=hidden name=multiSubIds value="">
</form>

 <TABLE width="100%">
 
                 
                   
                    <tr>
                     
                      <td valign="top">                                                                                    
                          <%
                           String tableString = "";
                          
                            if(perpage <2) perpage=10;                                 
                        
                            String backfields = " t1.requestid, t1.createdate, t1.createtime,t1.creater, t1.creatertype, t1.workflowid, t1.requestname, t1.status,t1.requestlevel,t1.currentnodeid,t2.viewtype,t2.receivedate,t2.receivetime,t2.isremark,t2.nodeid,t2.agentorbyagentid,t2.agenttype,t2.isprocessed ";
                            String fromSql  = " from workflow_requestbase t1,workflow_currentoperator t2 ";
                            String sqlWhere = sqlwhere;
                            if(sqlWhere.indexOf("in (select id from workflow_base where isvalid=") < 0){
	                            sqlWhere += " and t1.workflowid in (select id from workflow_base where isvalid='1' )";
                            }
                            String para2="column:requestid+column:workflowid+column:viewtype+"+isovertime+"+"+user.getLanguage()+"+column:nodeid+column:isremark+"+userID+"+column:agentorbyagentid+column:agenttype+column:isprocessed";
                            String para4=user.getLanguage()+"+"+user.getUID();
							if(!docids.equals("")){
                                fromSql  = fromSql+",workflow_form t4 ";
                                sqlWhere = sqlWhere+" and t1.requestid=t4.requestid ";
                            }
                            
                            
                            if(!superior)
                        	{
                            	sqlWhere += " AND EXISTS (SELECT 1 FROM workFlow_CurrentOperator workFlowCurrentOperator WHERE t2.workflowid = workFlowCurrentOperator.workflowid AND t2.requestid = workFlowCurrentOperator.requestid AND workFlowCurrentOperator.userid=" + userID + " and workFlowCurrentOperator.usertype = " + usertype +") ";
                        	}
                            
                           if (!branchid.equals(""))
						   {
						   sqlWhere += " AND t1.creater in (select id from hrmresource where subcompanyid1="+branchid+")  ";
						   }
                    	  //out.println("select " + backfields + fromSql + sqlWhere);
                          if(isMultiSubmit && iswaitdo==1){
                          tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"checkbox\" pagesize=\""+perpage+"\" >"+ 
                                       " <checkboxpopedom    popedompara=\"column:workflowid+column:isremark+column:requestid\" showmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCheckBox\" />"+ 
                                                "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.requestid\" sqlsortway=\"Desc\" sqlisdistinct=\"true\" />"+
                                                  "			<head>";
                          if(hascreatetime)
                                    tableString+="				<col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(722,user.getLanguage())+"\" column=\"createdate\" orderkey=\"t1.createdate,t1.createtime\" otherpara=\"column:createtime\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCreateTime\" />";
                          if(hascreater)
                                    tableString+="				<col width=\"6%\"  text=\""+SystemEnv.getHtmlLabelName(882,user.getLanguage())+"\" column=\"creater\" orderkey=\"t1.creater\"  otherpara=\"column:creatertype\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\" />";
                          if(hasworkflowname)
                                    tableString+="				<col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(259,user.getLanguage())+"\" column=\"workflowid\" orderkey=\"t1.workflowid\" transmethod=\"weaver.workflow.workflow.WorkflowComInfo.getWorkflowname\" />";
                          if(hasrequestlevel)
                                    tableString+="				<col width=\"8%\"   text=\""+SystemEnv.getHtmlLabelName(15534,user.getLanguage())+"\" column=\"requestlevel\"  orderkey=\"t1.requestlevel\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultUrgencyDegree\" otherpara=\""+user.getLanguage()+"\"/>";
                          if(hasrequestname) {
	                          tableString+="				<col width=\"19%\"  text=\""+SystemEnv.getHtmlLabelName(1334,user.getLanguage())+"\" column=\"requestname\" orderkey=\"t1.requestname\"  linkkey=\"requestid\" linkvaluecolumn=\"requestid\" target=\"_fullwindow\" transmethod=\"weaver.general.WorkFlowTransMethod.getWfNewLinkWithTitle\"  otherpara=\""+para2+"\"/>";
                          }
                          if(hascurrentnode)
                                    tableString+="				<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(524,user.getLanguage())+SystemEnv.getHtmlLabelName(15586,user.getLanguage())+"\" column=\"currentnodeid\" transmethod=\"weaver.general.WorkFlowTransMethod.getCurrentNode\"/>";
                          if(hasreceivetime)
                                    tableString+="			    <col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(17994,user.getLanguage())+"\" column=\"receivedate\" orderkey=\"t2.receivedate,t2.receivetime\" otherpara=\"column:receivetime\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCreateTime\" />";
                          if(hasstatus)
                                    tableString+="			    <col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(1335,user.getLanguage())+"\" column=\"status\" orderkey=\"t1.status\" />";
                          if(hasreceivedpersons)
                                    tableString+="			    <col width=\"15%\"  text=\""+SystemEnv.getHtmlLabelName(16354,user.getLanguage())+"\" column=\"requestid\" otherpara=\""+para4+"\" transmethod=\"weaver.general.WorkFlowTransMethod.getUnOperators\"/>";
                          if(hasSubWorkflow)
                                    tableString+="				<col width=\"6%\"  text=\""+SystemEnv.getHtmlLabelName(19363,user.getLanguage())+"\" column=\"requestid\" orderkey=\"t1.requestid\"  linkkey=\"requestid\" linkvaluecolumn=\"requestid\" target=\"_self\" transmethod=\"weaver.general.WorkFlowTransMethod.getSubWFLink\"  otherpara=\""+user.getLanguage()+"\"/>";

                                    tableString+="			</head>"+   			
                                                 "</table>";
                         }
                         else{                         
                         tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                                                 "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.requestid\" sqlsortway=\"Desc\" sqlisdistinct=\"true\" />"+
                                                 "			<head>";
                          if(hascreatetime)
                                    tableString+="				<col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(722,user.getLanguage())+"\" column=\"createdate\" orderkey=\"t1.createdate,t1.createtime\" otherpara=\"column:createtime\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCreateTime\" />";
                          if(hascreater)
                                    tableString+="				<col width=\"6%\"  text=\""+SystemEnv.getHtmlLabelName(882,user.getLanguage())+"\" column=\"creater\" orderkey=\"t1.creater\"  otherpara=\"column:creatertype\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\" />";
                          if(hasworkflowname)
                                    tableString+="				<col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(259,user.getLanguage())+"\" column=\"workflowid\" orderkey=\"t1.workflowid\" transmethod=\"weaver.workflow.workflow.WorkflowComInfo.getWorkflowname\" />";
                          if(hasrequestlevel)
                                    tableString+="				<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(15534,user.getLanguage())+"\" column=\"requestlevel\"  orderkey=\"t1.requestlevel\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultUrgencyDegree\" otherpara=\""+user.getLanguage()+"\"/>";
                          if(hasrequestname) {
                              tableString+="				<col width=\"19%\"  text=\""+SystemEnv.getHtmlLabelName(1334,user.getLanguage())+"\" column=\"requestname\" orderkey=\"t1.requestname\"  linkkey=\"requestid\" linkvaluecolumn=\"requestid\" target=\"_fullwindow\" transmethod=\"weaver.general.WorkFlowTransMethod.getWfNewLinkWithTitle\"  otherpara=\""+para2+"\"/>";
                          }
                          if(hascurrentnode)
                                    tableString+="				<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(524,user.getLanguage())+SystemEnv.getHtmlLabelName(15586,user.getLanguage())+"\" column=\"currentnodeid\" transmethod=\"weaver.general.WorkFlowTransMethod.getCurrentNode\"/>";
                          if(hasreceivetime)
                                    tableString+="			    <col width=\"10%\"  text=\""+SystemEnv.getHtmlLabelName(17994,user.getLanguage())+"\" column=\"receivedate\" orderkey=\"t2.receivedate,t2.receivetime\" otherpara=\"column:receivetime\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCreateTime\" />";
                          if(hasstatus)
                                    tableString+="			    <col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(1335,user.getLanguage())+"\" column=\"status\" orderkey=\"t1.status\" />";
                          if(hasreceivedpersons)
                                    tableString+="			    <col width=\"15%\"  text=\""+SystemEnv.getHtmlLabelName(16354,user.getLanguage())+"\" column=\"requestid\"  otherpara=\""+para4+"\" transmethod=\"weaver.general.WorkFlowTransMethod.getUnOperators\"/>";
                          if(hasSubWorkflow)
                                    tableString+="				<col width=\"6%\"  text=\""+SystemEnv.getHtmlLabelName(19363,user.getLanguage())+"\" column=\"requestid\" orderkey=\"t1.requestid\"  linkkey=\"requestid\" linkvaluecolumn=\"requestid\" target=\"_self\" transmethod=\"weaver.general.WorkFlowTransMethod.getSubWFLink\"  otherpara=\""+user.getLanguage()+"\"/>";

                                    tableString+="			</head>"+   			
                                                 "</table>"; 
                        
                          }


                          %>
                          
                          <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" />
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



<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
</body>

<script type="text/javascript">
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

function doreset(){
	//jQuery("#requestidstemp").val('');
//	window.open("WFSearchResultEWM.jsp","");
//	window.close();	
	window.location.href='WFSearchResultEWM.jsp';
}
function OnChangePage(start){
        $GetEle("start").value = start;
  //      $GetEle("frmmain").submit();
}

function OnSearch(){
	$GetEle("fromself").value="1";
	$GetEle("isfirst").value="1";
//	$GetEle("frmmain").submit();
}

function OnMultiSubmit(){

	$GetEle("multiSubIds").value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
  //  $GetEle("frmmain1").submit();
}

function OnMultiSubmitNew(obj){

	$GetEle("multiSubIds").value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
  //  $GetEle("frmmain1").submit();
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
	jQuery(document).ready(function(){
		jQuery("#requestids").focus();
		
//		jQuery("#requestids").bind('keydown',function(event){
//		    if(event.keyCode == "13") {
		    //	alert("111");
//		        jQuery("#requestids").focus();
//				OnSearch();
	//    }
//		}); 
		
		jQuery("#requestids").bind('input propertychange',function(event){
		//	alert("222");
			var ss = jQuery("#requestids").val();
	//	    jQuery("#requestids").focus();
			if(ss != ''){
		   	 openNewInfo(ss);
		 	}
	//		OnSearch();
			jQuery("#requestids").val("");
		}); 
		
//		jQuery("#requestids").bind("blur",function(){
//		jQuery("#requestids").blur(function(){
		
			//var temprequestid =  this.value;
			
	//		jQuery("#requestidstemp").val(temprequestid);
			
//			jQuery("#requestids").focus();
//			OnSearch();
//		});
	});


	
	function openNewInfo(id) {
		var title = "";
		var url = "hsReq.jsp?requestids="+id;

		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Height = 700;
		diag_vote.Width = 1200;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();	
	}
</script>

<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</html>