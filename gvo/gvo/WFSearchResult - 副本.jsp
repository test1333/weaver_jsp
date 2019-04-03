<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%><!--added by xwj for td2023 on 2005-05-20-->
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<html>
<head>
 <%
     String ranTs = String.valueOf(new Date().getTime());
  %>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<META HTTP-EQUIV="Cache-Control"CONTENT="no-cache">
<!--<META HTTP-EQUIV="refresh" CONTENT="120"/> 设定自动刷新时间-->
<meta http-equiv="refresh" content="45;url=/gvo/WFSearchResult.jsp?ranTs=<%=ranTs%>">
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
<table border="0" cellpadding="1" cellspacing="1" width="318px" id="tab_list" >
	<colgroup><col width="158px"></col><!--<col width="width:55px"></col><col width="width:85px"></col>--></colgroup>


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

String CurrentUser = Util.null2String((String)session.getAttribute("RequestViewResource")) ;
String logintype = ""+user.getLogintype();
int usertype = 0;

if(CurrentUser.equals("")) {
	CurrentUser = ""+user.getUID();
	if(logintype.equals("2")) usertype= 1;
}

String sqlwhere="";
String orderby = "";
//String orderby2 = "";



sqlwhere +=" "+newsql ;

//if(orderby.equals("")){
	//and t2.isremark in('0','1','5','8','9')
    orderby=" order by t2.receivedate desc,t2.receivetime desc";
//}
//orderby2=" order by t1.createdate,t1.createtime,t1.requestlevel";

//String tablename = "wrktablename"+ Util.getRandom() ;

int start=Util.getIntValue(Util.null2String(request.getParameter("start")),1);
String sql="";
int totalcounts = Util.getIntValue(Util.null2String(request.getParameter("totalcounts")),0);

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
		String tmp_uid = Util.null2String(RecordSet.getString("userid"));
		String tmp_num = Util.null2String(RecordSet.getString("c_num"));
		
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
		if(!"0".equals(tmp_num)) {
		
			// buff.append("<font size=\"3px\">");
			buff.append("<span>");
			//buff.append(tmp_name);buff.append("</font>[<font color=\"#660000\">");buff.append(tmp_z_type);buff.append("</font>]&nbsp;");
			buff.append(tmp_name);buff.append("[");buff.append(tmp_z_type);buff.append("]");
			//buff.append("<font color=\"#dd0000\" size=\"3px\">");buff.append(tmp_num);
			buff.append("(<font color=\"#dd0000\" >");buff.append(tmp_num);
			//buff.append("</font>) &nbsp;&nbsp;");
			buff.append("</font>) &nbsp;</span>");
			// buff.append(ranTs);
		}
		
	}

	out.println(buff.toString() + " <a href=\"/gvo/WFSearchResult.jsp?ranTs="+ranTs+"\"><img src=\"shuaxi.png\" width=\"13\" height=\"13\"></a>");


//RecordSet.executeSql(sqltemp);
//RecordSet.executeSql("drop table "+tablename);

String tableString = "";

if(perpage <2) perpage=10;                                 

String backfields = " t1.requestid, t1.createdate, t1.createtime,t1.creater, t1.creatertype, t1.workflowid, t1.requestname, t1.status,t1.requestlevel,t1.currentnodeid,t2.viewtype,t2.receivedate,t2.receivetime,t2.userid ";
String fromSql  = " from workflow_requestbase t1,workflow_currentoperator t2 ";
String sqlWhere = "";

sqlWhere =" where t1.requestid = t2.requestid and t2.userid in("+accounts+") and t2.isremark in(0,1) ";

sqlWhere +=" and t2.userid in("+accounts+")";

sqlWhere +=" and t1.currentnodetype!=3 and  t1.workflowid in (select id from workflow_base where isvalid in('1','3')) and t2.isremark in(0,1)  ";
sqlWhere += " and t1.workflowid !=1 ";

if(!docids.equals("")){
    fromSql  = fromSql+",workflow_form t4 ";
    sqlWhere = sqlWhere+" and t1.requestid=t4.requestid ";
}
String strSqlStart = "select x.requestid, x.createdate, x.createtime,x.creater, x.creatertype, x.workflowid, x.requestname, x.status,"
       +"x.requestlevel,x.currentnodeid,x.viewtype,x.receivedate,x.receivetime,x.userid from (select ";
String strSqlEnd = ") x group by x.requestid, x.createdate, x.createtime,x.creater, x.creatertype, x.workflowid, x.requestname, x.status,"
       +"x.requestlevel,x.currentnodeid,x.viewtype,x.receivedate,x.receivetime,x.userid  order by x.receivedate desc,x.receivetime desc";
RecordSet.executeSql(strSqlStart + backfields + fromSql + sqlWhere + orderby + strSqlEnd);
// out.println(strSqlStart + backfields + fromSql + sqlWhere + orderby + strSqlEnd);
int i = 0;
while(RecordSet.next()) {
	i++;
%>

<tr style="cursor:pointer;" onClick="winopen('<%=RecordSet.getString("requestid")%>','<%=RecordSet.getString("userid")%>');" bgColor='<%if((i%2)!=0){%>#f6f8f7<%}else{%>#FFFFFF<%}%>' onMouseOver="ch_color(this);" onMouseOut="ch_color_out(this);" bordercolorlight="#ffffff" bordercolordark="#ffffff" class='normal_text' id="content_line_0">
<%
	String rname = Util.null2String(RecordSet.getString("requestname"));
	//out.print(rname);	
%>

<td  class='td_content'><span style="border:0px solid #000000;width:190px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;" title="<%=rname%>"><%=rname%></span></td>
<!--<td  class='td_content'><span style="border:0px solid #000000;width:50px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;"><%=ResourceComInfo.getResourcename(RecordSet.getString("creater"))%></span></td>-->
	<%
	String nodename = "";
	String nid = RecordSet.getString("currentnodeid");
	rs.executeSql("select nodename from workflow_nodebase where id="+nid);
	if(rs.next()) nodename = rs.getString("nodename");	
%>
<!--<td  class='td_content'><span style="border:0px solid #000000;width:130px;text-overflow:ellipsis; white-space:nowrap;overflow:hidden;"><%=nodename%></span></td>
<td  class='td_content'><%=RecordSet.getString("receivedate")%></td>-->
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
