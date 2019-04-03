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
		String backfields = " case when LEFT(SUBSTRING(b.takeordermonth,6,2),1)='0' then SUBSTRING(b.takeordermonth,7,1) else SUBSTRING(b.takeordermonth,6,2) end +'月' takeordermonth,c.name cusumer,a.name,b.quity,b.singleprice,b.itembuget,b.pcentchange ,b.pertotalmoney, "+
							" case when b.peroutmonth='' then '' when LEFT(SUBSTRING(b.peroutmonth,6,2),1)='0' then SUBSTRING(b.peroutmonth,7,1) +'月' else SUBSTRING(b.peroutmonth,6,2) +'月' end  peroutmonth, "+
							" case when b.persalemonth = '' then ''when LEFT(SUBSTRING(b.persalemonth,6,2),1)='0' then SUBSTRING(b.persalemonth,7,1) +'月' else SUBSTRING(b.persalemonth,6,2) +'月' end  persalemonth, "+
							" case when b.peracceptancemonth = '' then '' when LEFT(SUBSTRING(b.peracceptancemonth,6,2),1)='0' then SUBSTRING(b.peracceptancemonth,7,1) +'月' else SUBSTRING(b.peracceptancemonth,6,2) +'月' end  peracceptancemonth, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='01' then b.peroutmoney else 0 end sale11, case when SUBSTRING(b.persalemonth,6,2)='01' then b.persalemoney else 0 end sale12,case when SUBSTRING(b.peracceptancemonth,6,2)='01' then b.peracceptancemoney else 0 end sale13, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='02' then b.peroutmoney else 0 end sale21, case when SUBSTRING(b.persalemonth,6,2)='02' then b.persalemoney else 0 end sale22,case when SUBSTRING(b.peracceptancemonth,6,2)='02' then b.peracceptancemoney else 0 end sale23, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='03' then b.peroutmoney else 0 end sale31, case when SUBSTRING(b.persalemonth,6,2)='03' then b.persalemoney else 0 end sale32,case when SUBSTRING(b.peracceptancemonth,6,2)='03' then b.peracceptancemoney else 0 end sale33, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='04' then b.peroutmoney else 0 end sale41, case when SUBSTRING(b.persalemonth,6,2)='04' then b.persalemoney else 0 end sale42,case when SUBSTRING(b.peracceptancemonth,6,2)='04' then b.peracceptancemoney else 0 end sale43, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='05' then b.peroutmoney else 0 end sale51, case when SUBSTRING(b.persalemonth,6,2)='05' then b.persalemoney else 0 end sale52,case when SUBSTRING(b.peracceptancemonth,6,2)='05' then b.peracceptancemoney else 0 end sale53, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='06' then b.peroutmoney else 0 end sale61, case when SUBSTRING(b.persalemonth,6,2)='06' then b.persalemoney else 0 end sale62,case when SUBSTRING(b.peracceptancemonth,6,2)='06' then b.peracceptancemoney else 0 end sale63, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='07' then b.peroutmoney else 0 end sale71, case when SUBSTRING(b.persalemonth,6,2)='07' then b.persalemoney else 0 end sale72,case when SUBSTRING(b.peracceptancemonth,6,2)='07' then b.peracceptancemoney else 0 end sale73, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='08' then b.peroutmoney else 0 end sale81, case when SUBSTRING(b.persalemonth,6,2)='08' then b.persalemoney else 0 end sale82,case when SUBSTRING(b.peracceptancemonth,6,2)='08' then b.peracceptancemoney else 0 end sale83, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='09' then b.peroutmoney else 0 end sale91, case when SUBSTRING(b.persalemonth,6,2)='09' then b.persalemoney else 0 end sale92,case when SUBSTRING(b.peracceptancemonth,6,2)='09' then b.peracceptancemoney else 0 end sale93, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='10' then b.peroutmoney else 0 end sale101, case when SUBSTRING(b.persalemonth,6,2)='10' then b.persalemoney else 0 end sale102,case when SUBSTRING(b.peracceptancemonth,6,2)='10' then b.peracceptancemoney else 0 end sale103, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='11' then b.peroutmoney else 0 end sale111, case when SUBSTRING(b.persalemonth,6,2)='11' then b.persalemoney else 0 end sale112,case when SUBSTRING(b.peracceptancemonth,6,2)='11' then b.peracceptancemoney else 0 end sale113, "+
							" case when SUBSTRING(b.peroutmonth,6,2)='21' then b.peroutmoney else 0 end sale121, case when SUBSTRING(b.persalemonth,6,2)='12' then b.persalemoney else 0 end sale122,case when SUBSTRING(b.peracceptancemonth,6,2)='12' then b.peracceptancemoney else 0 end sale123 ";
														
		String fromSql  = " Prj_ProjectInfo a join cus_fielddata b on a.id=b.id join CRM_CustomerInfo c on b.cusumer = c.id ";
		String sqlWhere = " where 1=1";
		String orderby = " b.takeordermonth asc ";
		String tableString = "";
		String tiaojian=" and LEFT(b.takeordermonth,7) in( ";
		String tiaojian2=" and LEFT(b.takeordermonth,7) in( ";
        for(int i=0;i<=11;i++){
		String aa="";
		int bb;
			if(now_month+i>12){		
			  bb=(now_month+i)%12;
			   if (bb == 0){
				    bb=12;
				   }
				if(bb < 10){
				  
					aa="0"+bb;
				}
			  if(i==11){
			  tiaojian +="'"+(now_year+1)+"-"+aa+"'";
			  }else{
			   tiaojian +="'"+(now_year+1)+"-"+aa+"',";
			  }
		      
		    }else{
			  if(now_month+i< 10){
			     aa="0"+(now_month+i);
			  }
			   if(i==11){
			    tiaojian +="'"+now_year+"-"+aa+"'";
			   }else{
			   tiaojian +="'"+now_year+"-"+aa+"',";
			   }
			}
		}
		tiaojian +=" )";
		if(!year.equals("")&&!month.equals("")){
		for(int i=0;i<=11;i++){
		String aa="";
		int bb;
			if(Integer.valueOf(month)+i>12){		
			  bb=(Integer.valueOf(month)+i)%12;
			  if (bb == 0){
				    bb=12;
				   }
				if(bb < 10){
				   
					aa="0"+bb;
				}
			  if(i==11){
			  tiaojian2 +="'"+(Integer.valueOf(year)+1)+"-"+aa+"'";
			  }else{
		      tiaojian2 +="'"+(Integer.valueOf(year)+1)+"-"+aa+"',";
			  }
		    }else{
			  if(Integer.valueOf(month)+i<10){
			     aa="0"+(Integer.valueOf(month)+i);
			  }
			  if(i==11){
			  tiaojian2 +="'"+Integer.valueOf(year)+"-"+aa+"'";
			  }else{
			   tiaojian2 +="'"+Integer.valueOf(year)+"-"+aa+"',";
			  }
			}
		}
		}
		tiaojian2 +=" )";
		if(!year.equals("")&&!month.equals("")){
			sqlWhere+=tiaojian2;
		}else{
		sqlWhere+=tiaojian;
		}
		String tableString1 = "";
		int yue;
		if(!month.equals("")){
		  yue=Integer.valueOf(month);
		}else{
		  yue=now_month;
		}
		 for(int i=0;i<=11;i++){
		      int mon=(yue+i)%12;
			   if (mon == 0){
				    mon=12;
				   }
		      String name1="sale"+mon+"1";
			   String name2="sale"+mon+"2";
			    String name3="sale"+mon+"3";
			  String colname1= mon+"月 預計出貨金額";
			  String colname2= mon+"月 預計銷貨金額";
			  String colname3= mon+"月 預計結案驗收金額";
		      tableString1+=" <col width=\"2%\" text=\""+colname1+"\" column=\""+name1+"\" orderkey=\""+name1+"\"/>"+
			                "  <col width=\"2%\" text=\""+colname1+"\" column=\""+name2+"\" orderkey=\""+name2+"\"/>"+
							"  <col width=\"2%\" text=\""+colname1+"\" column=\""+name3+"\" orderkey=\""+name3+"\"/>";
			                
		   }
		
		String  operateString= "";
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"A.Name\" sqlsortway=\"Desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"2%\" text=\"接單月份\" column=\"takeordermonth\" orderkey=\"takeordermonth\"/>"+
			"               <col width=\"5%\" text=\"客戶\" column=\"cusumer\" orderkey=\"cusumer\"/>"+
			"               <col width=\"5%\" text=\"設備名稱\" column=\"name\" orderkey=\"name\"/>"+
			"               <col width=\"2%\" text=\"台數\" column=\"quity\" orderkey=\"quity\"/>"+
			"               <col width=\"2%\" text=\"單價\" column=\"singleprice\" orderkey=\"singleprice\"/>"+
			"               <col width=\"2%\" text=\"總價\" column=\"itembuget\" orderkey=\"itembuget\"/>"+	
			"               <col width=\"2%\" text=\"成交機會\" column=\"pcentchange\" orderkey=\"pcentchange\"/>"+
			"               <col width=\"2%\" text=\"成交淨額\" column=\"pertotalmoney\" orderkey=\"pertotalmoney\"/>"+
			"               <col width=\"2%\" text=\"預計出貨月份\" column=\"peroutmonth\" orderkey=\"peroutmonth\"/>"+
			"               <col width=\"2%\" text=\"預計銷貨月份\" column=\"persalemonth\" orderkey=\"persalemonth\"/>"+
			"               <col width=\"2%\" text=\"預計驗收月份\" column=\"peracceptancemonth\" orderkey=\"peracceptancemonth\"/>"+
			tableString1+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true" />
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