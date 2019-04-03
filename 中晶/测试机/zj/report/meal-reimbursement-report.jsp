<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

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
		<script type='text/javascript' src='/js/jquery-autocomplete/lib/jquery.bgiframe.min_wev8.js'></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/jquery.autocomplete_wev8.js'></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
		<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/jquery.autocomplete_wev8.css" />
		<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/browser_wev8.css" />
		<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
		<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "cfbxr01";
	 String departmentid = (String)session.getAttribute("departmentid");
	 //out.print("departmentid"+departmentid);
	 String departmentids="";
	 String flag="";
	 String sql="WITH allsub(id,departmentname) as (SELECT id,departmentname FROM HrmDepartment where id=31 UNION ALL SELECT a.id,a.departmentname FROM HrmDepartment a,allsub b where a.supdepid = b.id) select id from allsub";
	 rs.executeSql(sql);
	 while(rs.next()){
		 departmentids = departmentids+flag+Util.null2String(rs.getString("id"));
		 flag=",";
	 }
	//out.println("departmentids"+departmentids);
	int now_year = now.get(Calendar.YEAR);
	int now_month = now.get(Calendar.MONTH) + 1; 
	String start_month = "";
	String end_month="";
	String end_year="";
	start_month= now_month+"";
	end_month = now_month+1+"";
	end_year = now_year+"";
	if(now_month < 10){
		start_month = "0"+now_month;
		end_month=now_month+1+"";
		if(now_month+1<10){
			end_month = "0"+(now_month+1);
		}
	}
	if(now_month==12){
		start_month = now_month+"";
		end_month="01";
		end_year = now_year+1+"";
	}
    String startday = "";
	String endday = "";

	String yg = Util.null2String(request.getParameter("yg"));
	String workcode = Util.null2String(request.getParameter("workcode"));
	String department = Util.null2String(request.getParameter("department"));
	String departmentStr = "";
    String sql1 = "select departmentname from HrmDepartment where id in ("+department+")";
	rs.executeSql(sql1);
	String text="";
    flag="";
	while(rs.next()){
	    departmentStr =departmentStr+""+flag;
	    text = Util.null2String(rs.getString("departmentname"));
		departmentStr +=text;
		flag = ",";
	}
    String year = Util.null2String(request.getParameter("year"));
	String month = Util.null2String(request.getParameter("month"));
	if("".equals(year)||"".equals(month)){
	   startday = now_year+"-"+start_month+"-"+"01";
	   endday = end_year+"-"+end_month+"-"+"01";
	
	}else{
		int selectyear=Util.getIntValue(year);
		int selectmonth=Util.getIntValue(month);
		start_month= selectmonth+"";
		end_month = selectmonth+1+"";
		end_year = selectyear+"";
		if(selectmonth < 10){
			start_month = "0"+selectmonth;
			end_month=selectmonth+1+"";
			if(selectmonth+1<10){
				end_month = "0"+(selectmonth+1);
			}
		}
		if(selectmonth==12){
			start_month = selectmonth+"";
			end_month="01";
			end_year = selectyear+1+"";
		}
		startday = selectyear+"-"+start_month+"-"+"01";
		endday = end_year+"-"+end_month+"-"+"01";
	}
	
	int kqts=0;
	sql="select COUNT(1) as count from (select convert(varchar(10),dateadd(dd,number,'"+startday+"'),120) as day from master..spt_values where type='P' and dateadd(dd,number,'"+startday+"')<=dateadd(dd,-1,'"+endday+"')) a where dbo.sh_what_holiday(day)=2";
	//out.println(sql);
	rs.executeSql(sql);
	if(rs.next()){
		kqts = rs.getInt("count");
	}
	
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
	    <input type="hidden" name="pageId" id="pageId" value="<%=out_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
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
				<select class="e8_btn_top middle" name="year" id="year"> 
					<option value="" <%if("".equals(year)){%> selected<%} %>><%=""%></option>
					<% for(int i=0;i<10;i++){
					String xzyear = now_year-i+"";	
					%>
					
					<option value="<%=xzyear%>" <%if(xzyear.equals(year)){%> selected<%} %>>
						<%=xzyear%></option>
					<%}%>
					
				</select>
				</wea:item>

				<wea:item>月份</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="month" id="month"> 
				<option value="" <%if("".equals(month)){%> selected<%} %>>
					<%=""%></option>
				<option value="1" <%if("1".equals(month)){%> selected<%} %>>
					<%="1"%></option>
				<option value="2" <%if("2".equals(month)){%> selected<%} %>>
					<%="2"%></option>
				<option value="3" <%if("3".equals(month)){%> selected<%} %>>
					<%="3"%></option>
				<option value="4" <%if("4".equals(month)){%> selected<%} %>>
					<%="4"%></option>
				<option value="5" <%if("5".equals(month)){%> selected<%} %>>
					<%="5"%></option>
				<option value="6" <%if("6".equals(month)){%> selected<%} %>>
					<%="6"%></option>
		    	<option value="7" <%if("7".equals(month)){%> selected<%} %>>
					<%="7"%></option>
				<option value="8" <%if("8".equals(month)){%> selected<%} %>>
					<%="8"%></option>
				<option value="9" <%if("9".equals(month)){%> selected<%} %>>
					<%="9"%></option>
				<option value="10" <%if("10".equals(month)){%> selected<%} %>>
					<%="10"%></option>
				<option value="11" <%if("11".equals(month)){%> selected<%} %>>
					<%="11"%></option>
				<option value="12" <%if("12".equals(month)){%> selected<%} %>>
					<%="12"%></option>
				</select>
				</wea:item>
					<wea:item>员工</wea:item>
					<wea:item>
						<brow:browser viewType="0"  name="yg" browserValue="<%=yg %>"
						browserOnClick=""
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
						hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
						completeUrl="/data.jsp" width="165px"
						browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(yg),user.getLanguage())%>">
						</brow:browser>
					</wea:item>
					<wea:item>工号</wea:item>
					<wea:item>
					<input name="workcode" id="workcode" class="InputStyle" type="text" value="<%=workcode%>"/>
					</wea:item>

					<wea:item>部门</wea:item>
					<wea:item>
                    <brow:browser viewType="0" name="department" browserValue='<%=department %>'
                    browserurl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="
                    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                    completeUrl="/data.jsp?type=4"
                    browserSpanValue='<%=Util.toScreen(departmentStr,user.getLanguage())%>'></brow:browser>
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
		String backfields = "id,departmentid,lastname,workcode,'"+kqts+"' as kqts,dbo.get_cf_days(id,'1','"+startday+"','"+endday+"') as qjts,dbo.get_cf_days(id,'2','"+startday+"','"+endday+"') as wcts,dbo.get_cf_days(id,'3','"+startday+"','"+endday+"') as jbts ,"+kqts+"*10-dbo.get_cf_days(id,'1','"+startday+"','"+endday+"')*10+dbo.get_cf_days(id,'2','"+startday+"','"+endday+"')*5+dbo.get_cf_days(id,'3','"+startday+"','"+endday+"')*15 as cfje ";
							
		String fromSql  = " hrmresource ";
		String sqlWhere = " where 1=1 and status in(0,1,2,3) and departmentid in ("+departmentids+") ";
		String orderby = " departmentid,id";
		String tableString = "";

		if(!"".equals(yg)){
			sqlWhere +=" and id='"+yg+"'";
		}

		if(!"".equals(workcode)){
			sqlWhere +=" and workcode='"+workcode+"'";
		}

		if(!"".equals(department)){
			sqlWhere+=" and departmentid in("+department+") ";
		}
	 
		//out.print("select "+backfields+" from "+fromSql+sqlWhere);
		String  operateString= "";
				 		
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"15%\" text=\"部门名称\" column=\"departmentid\" orderkey=\"departmentid\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
			"               <col width=\"15%\" text=\"姓名\" column=\"lastname\" orderkey=\"lastname\" />"+
			"               <col width=\"10%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+
			"               <col width=\"10%\" text=\"考勤天数\" column=\"kqts\" orderkey=\"kqts\" />"+
			"               <col width=\"10%\" text=\"请假天数\" column=\"qjts\" orderkey=\"qjts\" />"+
			"               <col width=\"10%\" text=\"外出天数\" column=\"wcts\" orderkey=\"wcts\" />"+
			"               <col width=\"10%\" text=\"加班天数\" column=\"jbts\" orderkey=\"jbts\"/>"+
			"               <col width=\"10%\" text=\"餐费金额\" column=\"cfje\" orderkey=\"cfje\"  />"+		
			
		"			</head>"+
	" </table>";
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="false" />
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
	
	   function doservice(){
		   	var ids = _xtable_CheckedCheckboxId();
          //alert(ids);
		  if(ids!=null && ids!=""){
			//  alert(ids);
			  	var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/appdevjsp/HQ/SAPOA/Exception/doException.jsp?requestids="+ids, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
								//alert(text);
								
							}	
						}
					}
				xhr.send(null);			
				}
				window.location.reload();
			}else{
				alert("请先选择需要处理的内容");
			}
	   }
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>