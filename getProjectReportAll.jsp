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
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String prjstatus_name ="";
	String prjstatus_x = Util.null2String(request.getParameter("prjstatus"));
	if("".equals(prjstatus_x)){
	prjstatus_x="'9','10','19'";
	}
	String sql1 = "select description from Prj_ProjectStatus where id in("+prjstatus_x+")";
	rs.executeSql(sql1);
	String flag=",";
	String description="";
	while(rs.next()){
	       description = Util.null2String(rs.getString("description"));
		   prjstatus_name +=description;
		   prjstatus_name =prjstatus_name+""+flag;
	   }
	Calendar now = Calendar.getInstance();
	int now_year = now.get(Calendar.YEAR);
	int now_month = now.get(Calendar.MONTH) + 1;
	String year = Util.null2String(request.getParameter("year"));
	String month = Util.null2String(request.getParameter("month"));
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	
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
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/CRM/report/getProjectReportAll.jsp" method=post>
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
				<option value="" <%if("".equals(year)){%> selected<%} %>>
					<%=""%></option>
				<option value="2013" <%if("2013".equals(year)){%> selected<%} %>>
					<%="2013"%></option>
				<option value="2014" <%if("2014".equals(year)){%> selected<%} %>>
					<%="2014"%></option>
				<option value="2015" <%if("2015".equals(year)){%> selected<%} %>>
					<%="2015"%></option>
				<option value="2016" <%if("2016".equals(year)){%> selected<%} %>>
					<%="2016"%></option>
				<option value="2017" <%if("2017".equals(year)){%> selected<%} %>>
					<%="2017"%></option>
				<option value="2018" <%if("2018".equals(year)){%> selected<%} %>>
					<%="2018"%></option>
		    	<option value="2019" <%if("2019".equals(year)){%> selected<%} %>>
					<%="2019"%></option>
				<option value="2020" <%if("2020".equals(year)){%> selected<%} %>>
					<%="2020"%></option>
				<option value="2021" <%if("2021".equals(year)){%> selected<%} %>>
					<%="2021"%></option>
				<option value="2022" <%if("2022".equals(year)){%> selected<%} %>>
					<%="2022"%></option>
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
				<wea:item>項目狀態</wea:item>				
				
                <wea:item>
				<brow:browser viewType="0"  name="prjstatus" browserValue="<%=prjstatus_x %>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/MultiCommonBrowser.jsp?type=browser.projectstatus"
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=prjstatus_name %>">
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
		<%
		 
		String backfields = "d.description status,"+
		                    " case when LEFT(SUBSTRING(b.takeordermonth,6,2),1)='0' then SUBSTRING(b.takeordermonth,7,1) else SUBSTRING(b.takeordermonth,6,2) end +'月' takeordermonth,c.name cusumer,a.name,b.quity,"+
							" CONVERT(VARCHAR(15),CAST(CONVERT(DECIMAL(12,2),LTRIM(b.singleprice)) AS MONEY),1) as singleprice, CONVERT(VARCHAR(15),CAST(CONVERT(DECIMAL(12,2),LTRIM(b.itembuget)) AS MONEY),1) as itembuget,b.pcentchange ,"+
							" CONVERT(VARCHAR(15),CAST(CONVERT(DECIMAL(12,2),LTRIM(b.pertotalmoney)) AS MONEY),1) as pertotalmoney,"+
							" LEFT(b.peroutmonth,7) peroutmonth, "+
							" LEFT(b.persalemonth,7)  persalemonth, "+
							" LEFT(b.peracceptancemonth,7) peracceptancemonth,"+
							"  CONVERT(VARCHAR(15),CAST(CONVERT(DECIMAL(12,2),LTRIM(b.peroutmoney)) AS MONEY),1) as peroutmoney ";
														
		String fromSql  = " Prj_ProjectInfo a join cus_fielddata b on a.id=b.id left join CRM_CustomerInfo c on b.cusumer = c.id join Prj_ProjectStatus d on a.status=d.id";
		String sqlWhere = " where 1=1 and a.prjtype = 29 and b.scopeid = 29 ";
		String orderby = " b.takeordermonth desc ";
		String tableString = "";
	    if(!year.equals("")&&!month.equals("")){
		  String time_month = ""+Integer.valueOf(month);
		  if(Integer.valueOf(month)<10){
			   time_month ="0"+Integer.valueOf(month);
		  }
		String time="'"+Integer.valueOf(year)+"-"+time_month+"'";
		 sqlWhere+= " and LEFT(b.takeordermonth,7) in("+time+")";
		}

		if(!"".equals(prjstatus_x)){
		sqlWhere+= " and a.status in ("+prjstatus_x+")";
		}
		
		%>
		
<wea:layout attributes="{'expandAllGroup':'true'}">
	<div id="TimeDate">
		<wea:item attributes="{'isTableList':'true'}">
		    <wea:layout type="table" attributes="{'cols':'11','cws':'120px,200px,200px,100px,100px,100px,100px,100px,100px,100px,100px'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
				

				<wea:item type="thead">項目狀態</wea:item>
				<wea:item type="thead">客戶</wea:item>
			    <wea:item type="thead">設備名稱</wea:item>
				<wea:item type="thead">單價</wea:item>
				<wea:item type="thead">台數</wea:item>
				 <wea:item type="thead">總價</wea:item>
				 <wea:item type="thead">接單月份</wea:item>
				 <wea:item type="thead">預計出貨月份</wea:item>
				 <wea:item type="thead">預計出貨金額</wea:item>
				  <wea:item type="thead">成交機會</wea:item>
				  <wea:item type="thead">成交淨額</wea:item>
				
		
		<% String sql="select "+backfields +" from "+fromSql+" "+sqlWhere+" order by "+orderby;
		 RecordSet rs1 = new RecordSet();
		   rs1.executeSql(sql);
		   String takeordermonth="";
		   String cusumer="";
		   String name="";
		   String quity="";
		   String singleprice="";
		   String itembuget="";
		   String pcentchange="";
		   String pertotalmoney="";
		   String peroutmonth="";
		   String persalemonth="";
		   String peracceptancemonth="";
		   String prjstatus="";
		   String peroutmoney="";
		  while(rs1.next()){
	        takeordermonth = Util.null2String(rs1.getString("takeordermonth"));
	        cusumer = Util.null2String(rs1.getString("cusumer"));
	        quity = Util.null2String(rs1.getString("quity"));
	        singleprice = Util.null2String(rs1.getString("singleprice"));
			 itembuget = Util.null2String(rs1.getString("itembuget"));
	        pcentchange = Util.null2String(rs1.getString("pcentchange"));
	        pertotalmoney = Util.null2String(rs1.getString("pertotalmoney"));
	        peroutmonth = Util.null2String(rs1.getString("peroutmonth"));
			 persalemonth = Util.null2String(rs1.getString("persalemonth"));
	        name = Util.null2String(rs1.getString("name"));
	        peracceptancemonth = Util.null2String(rs1.getString("peracceptancemonth"));
			prjstatus=Util.null2String(rs1.getString("status"));
			peroutmoney=Util.null2String(rs1.getString("peroutmoney"));
			  %>
			   <wea:item><%=prjstatus%></wea:item>			
			   <wea:item><%=cusumer%></wea:item>
			   <wea:item><%=name%></wea:item>			    
			   <wea:item><%=singleprice%></wea:item>
			   <wea:item><%=quity%></wea:item>
			   <wea:item><%=itembuget%></wea:item>
			   <wea:item><%=takeordermonth%></wea:item>
			   <wea:item><%=peroutmonth%></wea:item>
			   <wea:item><%=peroutmoney%></wea:item>
			   <wea:item><%=pcentchange%></wea:item>
			   <wea:item><%=pertotalmoney%></wea:item>
				
				
				 
	    <% } %>
		   </wea:group>
			</wea:layout>
		</wea:item>

	</div>
</wea:layout>

	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}

	</script>
</BODY>
</HTML>