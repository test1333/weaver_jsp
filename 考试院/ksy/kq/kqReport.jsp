<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
int user_id = user.getUID();
String tmc_pageId = "s111111";
weaver.general.AccountType.langId.set(lg);
String year = Util.null2String(request.getParameter("year"));
String sopname_val = "";
int ksyue=Util.getIntValue(request.getParameter("ksyue"),0);
String department = Util.null2String(request.getParameter("department"));
String departmentStr = "";
if(!"".equals(department)){
    String sql1 = "select departmentname from HrmDepartment where id in ("+department+")";
	rs.executeSql(sql1);
	String text="";
	String flag="";
	while(rs.next()){
	       departmentStr =departmentStr+""+flag;
	       text = Util.null2String(rs.getString("departmentname"));
		  departmentStr +=text;
		  flag = ",";
	   }
}
String person = Util.null2String(request.getParameter("person"));
Calendar now = Calendar.getInstance();
	int now_year = now.get(Calendar.YEAR);
	int now_month = now.get(Calendar.MONTH) + 1;
	String begindate="";
	String enddate="";
	String beginmonth="";
  if(!year.equals("")&&ksyue !=0){
	    String time_month = ""+Integer.valueOf(ksyue);
		String end_month=""+(ksyue+1);
		  if(ksyue<10){
			   time_month ="0"+ksyue;
		  }
		  if(ksyue+1<10){
			   end_month ="0"+(ksyue+1);
		  }
	   beginmonth=year+"-"+time_month;
       begindate=year+"-"+time_month+"-01";
	   enddate=year+"-"+end_month+"-01";
   
  }else{
	  String time_month = ""+now_month;
		String end_month=""+(now_month+1);
		  if(now_month<10){
			   time_month ="0"+now_month;
		  }
		  if(now_month+1<10){
			   end_month ="0"+(now_month+1);
		  }
		   beginmonth=now_year+"-"+time_month;
		begindate=now_year+"-"+time_month+"-01";
	   enddate=now_year+"-"+end_month+"-01";
	   ksyue = now_month;
	   year = ""+now_year;
  }
String sql="";
int count=0;
String machine = "";
int nodecount=0;
sql="select to_char(last_day(to_date('"+begindate+"','yyyy-mm-dd')),'dd') as count from dual";
rs.executeSql(sql);
if(rs.next()){
nodecount = rs.getInt("count");
}
int nodecount_with=nodecount*2;
int with1=450+nodecount_with*50+550;
int with2=490+nodecount_with*50+550;


%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH:  <%=with1%>px;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 35px;
		}
		.table-head{padding-right:17px}
         .table-body{width:100%;overflow-y:auto;overflow-x: hidden}
		</style>
		
	</head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
  <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
  <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
	<BODY >
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
			RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/ksy/kq/kqReport.jsp" method=post>
			<input type="hidden" name="requestid" value="">
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
					<wea:item>年份</wea:item>
					<wea:item>
						<INPUT id="year" name="year" class='InputStyle' size="30" value="<%=year%>">年
			        </wea:item>
				<wea:item>月份</wea:item>
				<wea:item>
				<select id="ksyue" name="ksyue" style="width: 60px;">
					<option value="1" <%=(ksyue==1)?"selected":"" %>>1月</option>
					<option value="2" <%=(ksyue==2)?"selected":"" %>>2月</option>
					<option value="3" <%=(ksyue==3)?"selected":"" %>>3月</option>
					<option value="4" <%=(ksyue==4)?"selected":"" %>>4月</option>
					<option value="5" <%=(ksyue==5)?"selected":"" %>>5月</option>
					<option value="6" <%=(ksyue==6)?"selected":"" %>>6月</option>
					<option value="7" <%=(ksyue==7)?"selected":"" %>>7月</option>
					<option value="8" <%=(ksyue==8)?"selected":"" %>>8月</option>
					<option value="9" <%=(ksyue==9)?"selected":"" %>>9月</option>
					<option value="10" <%=(ksyue==10)?"selected":"" %>>10月</option>
					<option value="11" <%=(ksyue==11)?"selected":"" %>>11月</option>
					<option value="12" <%=(ksyue==12)?"selected":"" %>>12月</option>
				</select>	

					</wea:item>
					<wea:item>部门</wea:item>
					<wea:item>
					<brow:browser viewType="0" name="department" browserValue='<%=department %>' 
					browserurl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="
					hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
					completeUrl="/data.jsp?type=4"
					browserSpanValue='<%=Util.toScreen(departmentStr,user.getLanguage())%>'></brow:browser>
					</wea:item>
					<wea:item>人员</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="person" browserValue="<%=person %>" 
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(person),user.getLanguage())%>">
				</brow:browser>
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
	
		<div style="width:<%=with2%>px; ">	
	<div class="table-head" style="width:<%=with1%>px; ">
			<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup>  <col width="50px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px">
				         <%
						 for(int i=1; i<=nodecount;i++){
						 %>
							 <col width="50px">
							 <col width="50px">
						 <%
						 }
						 %>
						 <col width="50px"><col width="50px"><col width="50px"><col width="50px"><col width="50px">
						 <col width="50px"><col width="50px"><col width="50px"><col width="50px"><col width="50px">
						 <col width="50px">
				 </colgroup>
                <tbody>
					 <tr>
					    
	                    <td class="fname" align="center"></td>
						<td class="fname"  align="center"></td>
						<td class="fname"  align="center"></td>
						 <td class="fname" align="center"></td>
						  <td class="fname" align="center"></td>
						     <%
						 for(int i=1; i<=nodecount;i++){
							 String rqname="";
							 if(i<10){
								rqname=beginmonth+"-0"+i;
							 }else{
								rqname=beginmonth+"-"+i;
							 }
							 %>
							<td class="fname" colspan="2" align="center"><%=rqname%></td>
						 <%
						 }
						 %>
						 <td class="fname"  >正常</td>
						 <td class="fname"  >缺勤</td>
						 <td class="fname"  >迟到</td>
						 <td class="fname"  >早退</td>
						 <td class="fname"  >公务</td>
						 <td class="fname"  >事假</td>
						 <td class="fname"  >看病</td>
						 <td class="fname"  >病假</td>
						 <td class="fname"  >公休</td>
						 <td class="fname"  >例假</td>
						 <td class="fname"  >其他</td>
						
                       	
                 </tr>
				 <tr>
					  <td class="fname"  >序号</td>
						<td class="fname" >部门名称</td>
						<td class="fname" >部门序号</td>
						<td class="fname" >工号</td>
						<td class="fname">姓名</td>
					 <%
						 for(int i=1; i<=nodecount;i++){
						 %>
							 <td class="fname"  >上午</td>
							  <td class="fname"  >下午</td>
						 <%
						 }
						 %>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
						 <td class="fname"  >合计</td>
					 
				</tr>
				</tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
	</div>
	<div class="table-body" id="div22" style="width:<%=with2%>px; ">
	<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                 <colgroup>  
				 <col width="50px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px">
				         <%
						 for(int i=1; i<=nodecount;i++){
						 %>
							 <col width="50px">
							 <col width="50px">
						 <%
						 }
						 %>
						 <col width="50px"><col width="50px"><col width="50px"><col width="50px"><col width="50px">
						 <col width="50px"><col width="50px"><col width="50px"><col width="50px"><col width="50px">
						 <col width="50px">
				 </colgroup>
                <tbody>
					<%
					String num="";
					String departmentname="";
					String departmentcode="";
					String workcode="";
					String lastname="";
					String backfields="";
					String fromSql="";
					String sqlWhere="";
					String orderby = "";
					backfields=" rownum as num ,a.xm,a.workcode,a.departmentname,a.departmentcode,a.lastname,a.departmentid ";
					 for(int i=1; i<=nodecount;i++){
							 String atten_day="";
							 if(i<10){
								atten_day=beginmonth+"-0"+i;
							 }else{
								atten_day=beginmonth+"-"+i;
							 }
							backfields=backfields+" ,tmc_getStatus('"+atten_day+"',a.xm,'AM') as  a"+i+", tmc_getStatus('"+atten_day+"',a.xm,'PM') as  b"+i+"";
						 }
					for(int i=0; i<=10;i++){
							
							backfields=backfields+" ,kq_hj(a.xm,'"+i+"','"+begindate+"','"+enddate+"') as c"+i+"";
						 }
					fromSql=fromSql+" from (select distinct b.xm,c.workcode,c.lastname,c.departmentid,d.departmentname,d.departmentcode from formtable_main_82 a,formtable_main_82_dt1 b,hrmresource c,HrmDepartment d,workflow_requestbase e where a.id=b.mainid and b.xm=c.id and a.requestId=e.requestid and e.currentnodetype>=3 and c.departmentid=d.id  and a.sbzurq<'"+enddate+"' and a.sbzurq>to_char(to_date('"+begindate+"','yyyy-mm-dd')-7,'yyyy-mm-dd')) a  ";
					sqlWhere=" where 1=1  ";
					if(!"".equals(department)){
						sqlWhere=sqlWhere+" and departmentid in("+department+")";
					}
					if(!"".equals(person)){
						sqlWhere=sqlWhere+" and xm = '"+person+"'";
					}
					orderby=" num ";
					sql="select "+backfields+fromSql+sqlWhere+" order by num asc";
					//out.print(sql);
					 rs.executeSql(sql);
					 while(rs.next()){
						num = Util.null2String(rs.getString("num"));
						departmentname = Util.null2String(rs.getString("departmentname"));
						departmentcode = Util.null2String(rs.getString("departmentcode"));
						workcode = Util.null2String(rs.getString("workcode"));
						lastname = Util.null2String(rs.getString("lastname"));
					%>
					     <tr>
					     <td class="fvalue"><%=num%></td>
						 <td class="fvalue"><%=departmentname%></td>
						 <td class="fvalue"><%=departmentcode%></td>
						 <td class="fvalue"><%=workcode%></td>
						 <td class="fvalue"><%=lastname%></td>
						 
					 <%
						 for(int i=1; i<=nodecount;i++){
						 %>
							 <td class="fvalue"  ><%=Util.null2String(rs.getString("a"+i))%></td>
							  <td class="fvalue"  ><%=Util.null2String(rs.getString("b"+i))%></td>
						 <%
						 }
						 %>	 
						 <%
						 	for(int i=0; i<=10;i++){
							 %>
								  <td class="fvalue"  ><%=Util.null2String(rs.getString("c"+i))%></td>
							<%
							 }
%>
						
						 </tr>
					<%	 
					 }
					%>
                </tbody>
            </table>
			 </td>
        </tr>
    </tbody>
</table>
           
</div>
</div>	
<div style="display:none">
	<%
	String tableString="";
	String  operateString= "";
	//out.print(sql);
	fromSql=fromSql.replaceAll(">", "&gt;").replaceAll("<", "&lt;");
tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" >"+	
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"xm\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"50px\"  text=\"序号\" column=\"num\" orderkey=\"num\" hide=\"true\"/>"+
		"<col width=\"100px\"  text=\"部门名称\" column=\"departmentname\" orderkey=\"departmentname\" hide=\"true\"/>"+
		"<col width=\"100px\"  text=\"部门序号\" column=\"departmentcode\" orderkey=\"departmentcode\" hide=\"true\"/>"+
		"<col width=\"100px\"  text=\"工号\" column=\"workcode\" orderkey=\"workcode\" hide=\"true\"/>"+
		"<col width=\"100px\"  text=\"姓名\" column=\"lastname\" orderkey=\"lastname\" hide=\"true\"/>";
		 for(int i=1; i<=nodecount;i++){
		 String rqname="";
		 if(i<10){
			rqname=beginmonth+"-0"+i;
		 }else{
			rqname=beginmonth+"-"+i;
	    	}
			tableString+="<col width=\"100px\"  text=\""+rqname+"(上午)\" column=\"a"+i+"\" orderkey=\"a"+i+"\" hide=\"true\"/>"+	
				"<col width=\"100px\"  text=\""+rqname+"(下午)\" column=\"b"+i+"\" orderkey=\"b"+i+"\" hide=\"true\"/>";
						
		}
		tableString+="<col width=\"100px\"  text=\"正常\" column=\"c0\" orderkey=\"c0\" hide=\"true\"/>"+
		"<col width=\"100px\"  text=\"缺勤\" column=\"c1\" orderkey=\"c1\" hide=\"true\"/>"+
		"<col width=\"100px\"  text=\"迟到\" column=\"c2\" orderkey=\"c2\" hide=\"true\"/>"+
		"<col width=\"100px\"  text=\"早退\" column=\"c3\" orderkey=\"c3\" hide=\"true\"/>"+	 
		"<col width=\"100px\"  text=\"公务\" column=\"c4\" orderkey=\"c4\" hide=\"true\"/>"+	 
		"<col width=\"100px\"  text=\"事假\" column=\"c5\" orderkey=\"c5\" hide=\"true\"/>"+	 		
		"<col width=\"100px\"  text=\"看病\" column=\"c6\" orderkey=\"c6\" hide=\"true\"/>"+ 
		"<col width=\"100px\"  text=\"病假\" column=\"c7\" orderkey=\"c7\" hide=\"true\"/>"+	 
		"<col width=\"100px\"  text=\"公休\" column=\"c8\" orderkey=\"c8\" hide=\"true\"/>"+
		"<col width=\"100px\"  text=\"例假\" column=\"c9\" orderkey=\"c9\" hide=\"true\"/>"+ 
		"<col width=\"100px\"  text=\"其他\" column=\"c10\" orderkey=\"c10\" hide=\"true\"/>";	 
      

	tableString +="			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true"/>
</div>
	<script type="text/javascript">
	window.onload=function(){
		var clienthei= document.body.clientHeight;
		var height1=Number(clienthei)-100;
		height1=height1+'px';
		document.getElementById('div22').style.height=height1;
	}
	  
		var parentWin;
		try{
		parentWin = parent.getParentWindow(window);
		}catch(e){}
		function onBtnSearchClick() {
			report.submit();
		}
        	var parentWin="";
		function refersh() {
  			window.location.reload();
  		}
		  function onBtnSaveClick() {	
			$('#report1').submit();	
			window.close();
		}
	   

	</script>
</BODY>
</HTML>