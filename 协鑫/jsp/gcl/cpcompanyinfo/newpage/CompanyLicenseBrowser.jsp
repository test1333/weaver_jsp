<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ProjectStatusComInfo" class="weaver.proj.Maint.ProjectStatusComInfo" scope="page" />
<jsp:useBean id="ProjectTypeComInfo" class="weaver.proj.Maint.ProjectTypeComInfo" scope="page" />
<jsp:useBean id="WorkTypeComInfo" class="weaver.proj.Maint.WorkTypeComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>


<HTML><HEAD>

<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<%
String companyid =""+Util.getIntValue( Util.null2String(request.getParameter("companyid")),0);//带过来的公司id
String name = Util.null2String(request.getParameter("name"));//公司名称
String description = Util.null2String(request.getParameter("description"));
String prjtype = Util.null2String(request.getParameter("prjtype"));//登记机关
String worktype = Util.null2String(request.getParameter("worktype"));//注册号
String manager = Util.null2String(request.getParameter("manager"));//备注
String status = Util.null2String(request.getParameter("status"));//证照名称
String sqlwhere = Util.null2String(request.getParameter("sqlwhere"));
int ishead = 0;
if(!sqlwhere.equals("")) ishead = 1;
if(!worktype.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where t1.RECORDNUM like '%" + Util.fromScreen2(worktype,user.getLanguage()) +"%' ";
	}
	else
		sqlwhere += " and t1.RECORDNUM like '%" + Util.fromScreen2(worktype,user.getLanguage()) +"%' ";
}
if(!prjtype.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where t1.DEPARTINSSUE like '%" + Util.fromScreen2(prjtype,user.getLanguage()) +"%' ";
	}
	else
		sqlwhere += " and t1.DEPARTINSSUE like '%" + Util.fromScreen2(prjtype,user.getLanguage()) +"%' ";
}
if(!manager.equals("")){
	if(ishead==0){
		ishead = 1;
		sqlwhere += " where t1.memo like '%" + Util.fromScreen2(manager,user.getLanguage()) +"%' ";
	}
	else
		sqlwhere += " and t1.memo like '%" + Util.fromScreen2(manager,user.getLanguage()) +"%' ";
}


//String sqlstr = "select id,name,description,prjtype,worktype,manager,status from Prj_ProjectInfo " + sqlwhere;

int pagenum=Util.getIntValue(request.getParameter("pagenum"),1);
if(pagenum <= 0){
	pagenum = 1;
}
int perpage=10;
//*添加判断权限的内容--new--begin

String temptable = "CPLICENSE_TEMP"+ Util.getRandom() ;
String SearchSql = "";
String SqlWhere = "";

if(!sqlwhere.equals("")){
	SqlWhere = sqlwhere +" and t1.isdel='T' ";
//	SqlWhere += " and  not exists (select tt1.LICENSEAFFIXID from CPBUSINESSLICENSE tt1,CPLMLICENSEAFFIX tt2 where tt2.ismulti=1 and tt2.licenseaffixid=tt1.licenseaffixid and tt1.companyid="+companyid+" and tt1.companyid=t1.companyid ) ";
}else{
	SqlWhere = " where t1.isdel='T' ";
//    SqlWhere += " and not exists  (select tt1.LICENSEAFFIXID from CPBUSINESSLICENSE tt1,CPLMLICENSEAFFIX tt2 where tt2.ismulti=1 and tt2.licenseaffixid=tt1.licenseaffixid and tt1.companyid="+companyid+" and tt1.companyid=t1.companyid ) ";
}

	SearchSql = "create table "+temptable+"  as select * from (select distinct  t1.*,T2.COMPANYNAME,t3.licensename from CPBUSINESSLICENSE  t1  join CPCOMPANYINFO t2 on T1.COMPANYID=T2.COMPANYID "+(!"".equals(name)?" and t2.companyname like '%"+name+"%' ":"")+"  join CPLMLICENSEAFFIX t3 on t1.licenseaffixid=t3.licenseaffixid  "+(!"".equals(status)?" and t3.licensename like '%"+status+"%' ":"")+" "+ SqlWhere +" order by t1.companyid desc,t1.LICENSEID desc ) where rownum<"+ (pagenum*perpage+2);

    System.out.println("searchsql:"+SearchSql);
RecordSet.executeSql(SearchSql);

//添加判断权限的内容--new--end*/

RecordSet.executeSql("Select count(LICENSEID) RecordSetCounts from "+temptable);
boolean hasNextPage=false;
int RecordSetCounts = 0;
if(RecordSet.next()){
	RecordSetCounts = RecordSet.getInt("RecordSetCounts");
}
//    System.out.println("RecordSetCounts:"+RecordSetCounts);
if(RecordSetCounts>pagenum*perpage){
	hasNextPage=true;
}
	String sqltemp="";
	sqltemp="select * from (select * from  "+temptable+" order by companyid desc,LICENSEID desc) where rownum< "+(RecordSetCounts-(pagenum-1)*perpage+1);
RecordSet.executeSql(sqltemp);
//    System.out.println("sqltemp:"+sqltemp);
RecordSet.executeSql("drop table "+temptable);

%>
<BODY  scroll="auto">
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%
RCMenuHeight += RCMenuHeightStep ; //取消右键按钮 看不到按钮，只能查看3个！

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:submitData(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:document.SearchForm.reset(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.close(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:submitClear(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;

if(pagenum>1){ RCMenu += "{"+SystemEnv.getHtmlLabelName(1258,user.getLanguage())+",javascript:perPage(),_self} " ;
RCMenuHeight += RCMenuHeightStep; };
if(hasNextPage) { RCMenu += "{"+SystemEnv.getHtmlLabelName(1259,user.getLanguage())+",javascript:nextPage(),_self} " ;
RCMenuHeight += RCMenuHeightStep;} ;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<jsp:useBean id="xss" class="weaver.filter.XssUtil" scope="page" />
<FORM NAME=SearchForm STYLE="margin-bottom:0" action="CompanyLicenseBrowser.jsp" method=post>
  <input type="hidden" name="sqlwhere" value='<%=xss.put(Util.null2String(request.getParameter("sqlwhere")))%>'>
  <input type="hidden" id="pagenum" name="pagenum" value="<%=pagenum%>">
  <input type="hidden" id="companyid" name="companyid" value="<%=companyid %>">


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



<table width=100% class=viewform>
<TR>
    <TD width=15%>公司名称</TD>
    <TD width=35% class=field>
        <input name=name value="<%=name %>" class="InputStyle">
    </TD>
    <TD width=15%>证照名称</TD>
    <TD width=35% class=field>
      <input name=status value="<%=status %>" class="InputStyle">
    </TD>
</TR>
<TR style="height:1px;"><TD class=Line colSpan=4></TD></TR>
<TR>
    <TD width=15%>登记机关</TD>
    <TD width=35% class=field>
        <input name=prjtype value="<%=prjtype %>" class="InputStyle">
    </TD>
    <TD width=15%>注册号</TD>
    <TD width=35% class=field>
      <input name=worktype value="<%=worktype %>" class="InputStyle">
    </TD>
</TR>
<TR style="height:1px;"><TD class=Line colSpan=4></TD></TR>
<TR>
    <TD width=15%>备注</TD>
    <TD width=35% class=field colspan="3">
        <input name=manager value="<%=manager %>" class="InputStyle">
    </TD>

</TR>
<TR style="height:1px;"><TD class=Line colSpan=4></TD></TR>


</table>
<TABLE ID=BrowseTable class="BroswerStyle" cellspacing="1"  width="100%">

<TR class=DataHeader>
<TH width=0% style="display:none"><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TH>      
      <TH >公司名称</TH>
	  <TH >证照名称</TH>
      <TH >登记机关</TH>
      <TH >注册号</TH>
      <TH >备注</TH></tr>
	  <TR class=Line style="height:1px;"><Th colspan="5" ></Th></TR> 
<%
int i=0;
int totalline=1;
if(RecordSet.last()){
	do{
	String ids = RecordSet.getString("LICENSEID");
	String names = Util.toScreen(RecordSet.getString("companyname"),user.getLanguage());
	String prjtypes =Util.toScreen(RecordSet.getString("licensename"),user.getLanguage());
	String worktypes =Util.toScreen(RecordSet.getString("DEPARTINSSUE"),user.getLanguage());
	String managers =Util.toScreen(RecordSet.getString("RECORDNUM"),user.getLanguage());
	String statuss = Util.toScreen(RecordSet.getString("memo"),user.getLanguage());
	if(i==0){
		i=1;
%>
<TR class=DataLight>
<%
	}else{
		i=0;
%>
<TR class=DataDark>
<%
}
%>
	<TD style="display:none"><A HREF=#><%=ids%></A></TD>
	<td> <%=names %></TD>
	<TD><%=prjtypes %> </TD>
	<TD><%=worktypes %></TD>
	<TD><%=managers %></TD>
	<TD><%=statuss %></TD>
</TR>
<%
	if(hasNextPage){
		totalline+=1;
		if(totalline>perpage)	break;
	}
}while(RecordSet.previous());
}
%>
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

</FORM>
</BODY></HTML>


<script language="javascript">
function btnclear_onclick(){
	window.parent.returnValue = {id:"",name:""};
	window.parent.close();
	}
function submitData()
{
	if (check_form(SearchForm,'')){
		document.getElementById("pagenum").value = "1";
		SearchForm.submit();
	}
}

function submitClear()
{
	btnclear_onclick();
}

function nextPage(){
	document.getElementById("pagenum").value=parseInt(document.getElementById("pagenum").value)+1 ;
	SearchForm.submit();	
}

function perPage(){
	document.getElementById("pagenum").value=parseInt(document.getElementById("pagenum").value)-1 ;
	SearchForm.submit();
}



function BrowseTable_onmouseover(e){
	e=e||event;
   var target=e.srcElement||e.target;
   if("TD"==target.nodeName){
		jQuery(target).parents("tr")[0].className = "Selected";
   }else if("A"==target.nodeName){
		jQuery(target).parents("tr")[0].className = "Selected";
   }
}
function BrowseTable_onmouseout(e){
	var e=e||event;
   var target=e.srcElement||e.target;
   var p;
	if(target.nodeName == "TD" || target.nodeName == "A" ){
      p=jQuery(target).parents("tr")[0];
      if( p.rowIndex % 2 ==0){
         p.className = "DataDark"
      }else{
         p.className = "DataLight"
      }
   }
}
jQuery(document).ready(function(){
	jQuery("#BrowseTable").bind("click",BrowseTable_onclick);
	jQuery("#BrowseTable").bind("mouseover",BrowseTable_onmouseover);
	jQuery("#BrowseTable").bind("mouseout",BrowseTable_onmouseout);
})
function BrowseTable_onclick(e){
   var e=e||event;
   var target=e.srcElement||e.target;

   if( target.nodeName =="TD"||target.nodeName =="A"  ){
     window.parent.parent.returnValue = {id:jQuery(jQuery(target).parents("tr")[0].cells[0]).text(),name:jQuery(jQuery(target).parents("tr")[0].cells[1]).text()};
	 window.parent.parent.close();
	}
}
</script>
<%

%>