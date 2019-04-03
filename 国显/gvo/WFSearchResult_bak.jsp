<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%><!--added by xwj for td2023 on 2005-05-20-->
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<META HTTP-EQUIV="Cache-Control"CONTENT="no-cache">
<META HTTP-EQUIV="refresh" CONTENT="120"/> <!--设定自动刷新时间-->
<style type="text/css">
body
{
	margin: 0px; padding: 0px; border-style: none; border-bottom: 2px solid #e0e0e0;
}
table,div
{
	font-size:12px;
}
td {
	height:20px;
	line-height:20px;
	text-align:left;
}
.td_title
{
	background-color:#c8c8c8;
	border:1px solid #CFCFCF;
	border-left:0px;
	font-weight: bold;
}
.td_content
{
}
.bold_text
{
	font-weight:bold;
}
.normal_text
{
	font-weight:normal;
}
</style>
</head>

<script type="text/javascript" language="javascript">
function ch_color(obj)
{
	obj.style.color = 'red';
}

function ch_color_out(obj)
{
	obj.style.color = "";
}

function $( obj )
{
	return document.getElementById( obj );
}

function highlightrow( rowObj,check_id )
{
        var isCheckbox   = false;

	var oTable = $( "tab_list" );
	var isNew_val = rowObj.isNew ? rowObj.isNew : rowObj.getAttribute("isNew");

	if( isNew_val == '1' )
	{
		rowObj.className = "normal_text";	// for IE
		rowObj.setAttribute( "class", "normal_text" );

		rowObj.childNodes[0].firstChild.src = iconOldmail_src;
		rowObj.isNew = '';
	}

        return false;
}
</script>

<body>

<form id="listform" name="listform" method="post">
<div id="loginDIV"><img src="/images/loading2.gif" border="0">处理中...</div>
<div id="workflowDIV" style="display:none">
<table border="0" cellpadding="1" cellspacing="1" width="368px" id="tab_list" >
	<colgroup><col width="228px"></col><col width="width:55px"></col><col width="width:85px"></col></colgroup>
 
<thead>
	<!--
	<td class="td_title" style="width:75px">创建日期</td>
	<td class="td_title" style="width:130px">当前节点</td>
	<td class="td_title" style="width:45px">优先级</td> 
	
	<td class="td_title" style="width:238px">&nbsp;</td>
	<td class="td_title" style="width:55px">&nbsp;</td>
	<td class="td_title" style="width:75px">&nbsp;</td>-->
	<!-- <td class="td_title" style="width:90px">当前状况</td>
<!--
	<td style="width:10%" class="td_title">邮件大小</td>
-->
   </thead> 

<%
String imagefilename = "/images/hdDOC.gif";
String titlename = SystemEnv.getHtmlLabelName(197,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(648,user.getLanguage());
String needfav ="1";
String needhelp ="";
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

String fromself =Util.null2String(request.getParameter("fromself"));
String fromselfSql =Util.null2String(request.getParameter("fromselfSql"));
String isfirst =Util.null2String(request.getParameter("isfirst"));
String docids=Util.null2String(request.getParameter("docids"));
String complete=Util.null2String(request.getParameter("complete"));
if(complete.equals("")) complete = "0";

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
}

//START 判断帐号是否有主次帐号 by alan
String accounts = "";
String accountSql = "select id from hrmresource ";
	accountSql += "where id="+user.getUID(); 
	accountSql += " or id=(select belongto from hrmresource where id="+user.getUID()+") ";
	accountSql += " or (belongto="+user.getUID()+" and status in(0,1,2,3)) ";
	accountSql += " or (belongto=(select belongto from hrmresource where id="+user.getUID()+" and belongto>0) and status in(0,1,2,3))";
//	out.println(accountSql+"<br><br>");
RecordSet.executeSql(accountSql);
String appendStr = "";
while(RecordSet.next()) {
	accounts += appendStr+RecordSet.getString("id");
	appendStr = ",";
}
//END

String newsql="";


if(fromself.equals("1")) {
	if(!workflowid.equals("")) newsql+=" and t1.workflowid in("+workflowid+")" ;

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


	if(!createrid.equals("")){
		//newsql += " and t1.creater='"+createrid+"'";
		newsql += " and t1.creater in("+accounts+"')";
		newsql += " and t1.creatertype= '"+creatertype+"' ";
	}

	if(!requestlevel.equals("")){
		newsql += " and t1.requestlevel="+requestlevel;
  }
  
  newsql += " and " + fromselfSql;
}

String CurrentUser = Util.null2String((String)session.getAttribute("RequestViewResource")) ;
String logintype = ""+user.getLogintype();
int usertype = 0;

if(CurrentUser.equals("")) {
	CurrentUser = ""+user.getUID();
	if(logintype.equals("2")) usertype= 1;
}

String sqlwhere="";
if(isovertime==1){
    sqlwhere="where t1.requestid = t2.requestid ";
    int perpage=10;
    RecordSet.executeProc("workflow_RUserDefault_Select",""+user.getUID());
    if(RecordSet.next()){
       perpage= RecordSet.getInt("numperpage");
    }
    if(perpage <2) perpage=10;
    String requestids="0";
    RecordSet.executeSql("select requestids from SysPoppupRemindInfo where type=10 and userid in( "+accounts+")");
    if(RecordSet.next()){
        requestids=RecordSet.getString("requestids");
    }
    if(requestids.length()>1){
        requestids=requestids.substring(0,requestids.length()-1);
      	sqlwhere +=" and t2.id in (Select top "+perpage+" max(id) from workflow_currentoperator where requestid in ( "+requestids+") group by requestid order by requestid)";
    }

}
else{
    sqlwhere="where t1.requestid = t2.requestid and t2.userid in("+accounts+") and t2.isremark in(0,1) ";
    if(!Util.null2String(SearchClause.getWhereClause()).equals("")){
        sqlwhere += " and "+SearchClause.getWhereClause()+"";
    }
}
String orderby = "";
//String orderby2 = "";



sqlwhere +=" "+newsql ;

//orderby=" t1.createdate,t1.createtime,t1.requestlevel";
orderby=SearchClause.getOrderClause();
//if(orderby.equals("")){
	//and t2.isremark in('0','1','5','8','9')
    orderby=" order by t2.receivedate desc,t2.receivetime desc";
//}
//orderby2=" order by t1.createdate,t1.createtime,t1.requestlevel";

//String tablename = "wrktablename"+ Util.getRandom() ;

int start=Util.getIntValue(Util.null2String(request.getParameter("start")),1);
String sql="";
int totalcounts = Util.getIntValue(Util.null2String(request.getParameter("totalcounts")),0);

//add by xhheng @ 20050302 for TD 1545
/*
String strworkflowid="";
int startIndex = 0;
if(!Util.null2String(SearchClause.getWhereClause()).equals(""))
{
  String tempstr=SearchClause.getWhereClause();
  if(tempstr.indexOf("t1.workflowid")!=-1){
    startIndex = tempstr.indexOf("t1.workflowid")+13;//added by xwj for td2045 on 2005-05-26
    if(tempstr.indexOf("and")!=-1)
        strworkflowid=tempstr.substring(startIndex,tempstr.indexOf("and"));
    else
        strworkflowid=tempstr.substring(startIndex,tempstr.indexOf(")")+1);
  }
}
else{
  strworkflowid=" in("+ workflowid +")";
}
if(strworkflowid.equals(""))
  RecordSet.executeSql("select count(id) as mtcount from workflow_base where multiSubmit=1");
else
  RecordSet.executeSql("select count(id) as mtcount from workflow_base where id "+strworkflowid+" and multiSubmit=1");
*/
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
if(user.getUID() > 1){
	String tmp_sql = "select x.userid,count(*) as c_num from (select t2.userid,t1.requestid from workflow_requestbase t1,workflow_currentoperator t2 "
			+" where t1.requestid = t2.requestid and t2.userid in("+accounts+")  and t2.isremark in(0,1) "
			+" and t1.currentnodetype!=3 and  t1.workflowid in (select id from workflow_base where isvalid='1') "
		    +" and t1.workflowid !=1 group by t2.userid,t1.requestid  ) x "
	        +" group by x.userid ";
	RecordSet.executeSql(tmp_sql);
	StringBuffer buff = new StringBuffer();
	Map<String,String> user_map = new HashMap<String,String>();
	while(RecordSet.next()){
		String tmp_uid = RecordSet.getString("userid");
		String tmp_num = RecordSet.getString("c_num");
		user_map.put(tmp_uid,tmp_num);
	}
	tmp_sql = "select id,lastname,belongto,decode(trim(belongto),null,'主账号','0','主账号','-1','主账号','次账号') as z_type from hrmresource where id in("+accounts+") order by id";
	RecordSet.executeSql(tmp_sql);
	while(RecordSet.next()){
		String tmp_uid = RecordSet.getString("id");
		String tmp_z_type = RecordSet.getString("z_type");
		String tmp_name = RecordSet.getString("lastname");
		String tmp_num = Util.null2String(user_map.get(tmp_uid));
		if("".equals(tmp_num)) tmp_num = "0";
		buff.append("<font size=\"3px\">");
		buff.append(tmp_name);buff.append("</font>[<font color=\"#660000\">");buff.append(tmp_z_type);buff.append("</font>]&nbsp;");
		buff.append("<font color=\"#dd0000\" size=\"3px\">(");buff.append(tmp_num);buff.append(")</font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	}

	out.println(buff.toString());


//RecordSet.executeSql(sqltemp);
//RecordSet.executeSql("drop table "+tablename);

String tableString = "";

if(perpage <2) perpage=10;                                 

String backfields = " t1.requestid, t1.createdate, t1.createtime,t1.creater, t1.creatertype, t1.workflowid, t1.requestname, t1.status,t1.requestlevel,t1.currentnodeid,t2.viewtype,t2.receivedate,t2.receivetime,t2.userid ";
String fromSql  = " from workflow_requestbase t1,workflow_currentoperator t2 ";
String sqlWhere = sqlwhere;

sqlWhere +=" and t1.currentnodetype!=3 and  t1.workflowid in (select id from workflow_base where isvalid='1') and t2.isremark in(0,1)  ";
sqlWhere += " and t1.workflowid !=1 ";
String para2="column:requestid+column:viewtype+"+isovertime;
if(!docids.equals("")){
    fromSql  = fromSql+",workflow_form t4 ";
    sqlWhere = sqlWhere+" and t1.requestid=t4.requestid ";
}
String strSqlStart = "select x.requestid, x.createdate, x.createtime,x.creater, x.creatertype, x.workflowid, x.requestname, x.status,"
       +"x.requestlevel,x.currentnodeid,x.viewtype,x.receivedate,x.receivetime,x.userid from (select ";
String strSqlEnd = ") x group by x.requestid, x.createdate, x.createtime,x.creater, x.creatertype, x.workflowid, x.requestname, x.status,"
       +"x.requestlevel,x.currentnodeid,x.viewtype,x.receivedate,x.receivetime,x.userid  order by x.receivedate desc,x.receivetime desc";
RecordSet.executeSql(strSqlStart + backfields + fromSql + sqlWhere + orderby + strSqlEnd);
//out.println(strSqlStart + backfields + fromSql + sqlWhere + orderby + strSqlEnd);
int i = 0;
while(RecordSet.next()) {
	i++;
%>
<tr style="cursor:pointer;" onclick="winopen('<%=RecordSet.getString("requestid")%>','<%=RecordSet.getString("userid")%>');" bgColor='<%if((i%2)!=0){%>#f6f8f7<%}else{%>#FFFFFF<%}%>' onmouseover="ch_color(this);" onmouseout="ch_color_out(this);" bordercolorlight="#ffffff" bordercolordark="#ffffff" class='normal_text' id="content_line_0">
<!--<td  class='td_content'><%=RecordSet.getString("createdate")%></td>-->

<!--<td  class='td_content'><%
	String lv = RecordSet.getString("requestlevel");
	if(lv!=null && lv.equals("0")) {
		out.print("正常");
	}
	else if(lv!=null && lv.equals("1")) {
		out.print("重要");
	}
	else if(lv!=null && lv.equals("2")) {
		out.print("紧急");
	}
	%></td>-->
<%
	String rname = Util.null2String(RecordSet.getString("requestname"));
	//out.print(rname);	
%>
<td  class='td_content'><span style="border:0px solid #000000;width:215px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;" title="<%=rname%>"><%=rname%></span></td>
<td  class='td_content'><span style="border:0px solid #000000;width:50px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;"><%=ResourceComInfo.getResourcename(RecordSet.getString("creater"))%></span></td>
	<%
	String nodename = "";
	String nid = RecordSet.getString("currentnodeid");
	rs.executeSql("select nodename from workflow_nodebase where id="+nid);
	if(rs.next()) nodename = rs.getString("nodename");	
%>
<!--<td  class='td_content'><span style="border:0px solid #000000;width:130px;text-overflow:ellipsis; white-space:nowrap;overflow:hidden;"><%=nodename%></span></td>-->
<td  class='td_content'><%=RecordSet.getString("receivedate")%></td>
<!--
<td  class='td_content'><span style="border:0px solid #000000;width:80px;text-overflow:ellipsis; white-space:nowrap;overflow:hidden;"><%=RecordSet.getString("status")%></span></td>
-->
</tr>
<%
}
}
%>
</table>
</div>
</form>
</body>
</html>
<script>
var wopener = null;
function winopen(rid,uid) {
	wopener = window.open('/sso/SSOForward.jsp?fromUserId='+uid+'&type=WFL&requestid='+rid,'newwin'+rid);
	checkOpener();
}
function checkOpener() {
<%if(complete.equals("0")){%>
	if(wopener!=null) {
		if(wopener.closed==true) {
			wopener = null;
			//alert('刷新');
			document.getElementById('workflowDIV').style.display = 'none';
			document.getElementById('loginDIV').style.display = '';
			window.location.reload();
		}
		else {
			var turl = wopener.location+'';
			setTimeout('checkOpener()', 1000);
			if(turl.indexOf('RequestView.jsp')!=-1) {
				//alert('关闭');
				wopener.close();
			}
		}
	}
<%}%>
}
document.getElementById('loginDIV').style.display = 'none';
document.getElementById('workflowDIV').style.display = '';
</script>
