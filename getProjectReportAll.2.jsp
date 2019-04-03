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
		                    " case when LEFT(SUBSTRING(b.takeordermonth,6,2),1)='0' then SUBSTRING(b.takeordermonth,7,1) else SUBSTRING(b.takeordermonth,6,2) end +'月' takeordermonth,c.name cusumer,a.name,b.quity,b.singleprice,b.itembuget,b.pcentchange ,b.pertotalmoney, "+
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
														
		String fromSql  = " Prj_ProjectInfo a join cus_fielddata b on a.id=b.id join CRM_CustomerInfo c on b.cusumer = c.id join Prj_ProjectStatus d on a.status=d.id";
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
		if(!"".equals(prjstatus_x)){
		sqlWhere+= " and a.status in ("+prjstatus_x+")";
		}
		
		%>
		
<wea:layout attributes="{'expandAllGroup':'true'}">
	<div id="TimeDate">
		<wea:item attributes="{'isTableList':'true'}">
		    <wea:layout type="table" attributes="{'cols':'48','cws':'100px,200px,200px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px,150px'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
				<wea:item type="thead">接單月份</wea:item>
			    <wea:item type="thead">客戶</wea:item>
			    <wea:item type="thead">設備名稱</wea:item>
				<wea:item type="thead">項目狀態</wea:item>
			    <wea:item type="thead">台數</wea:item>
				<wea:item type="thead">單價</wea:item>
			    <wea:item type="thead">總價</wea:item>
			    <wea:item type="thead">成交機會</wea:item>
				<wea:item type="thead">成交淨額</wea:item>
			    <wea:item type="thead">預計出貨月份</wea:item>
			    <wea:item type="thead">預計銷貨月份</wea:item>
				<wea:item type="thead">預計驗收月份</wea:item>
				
			    <%
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
			  String colname1= mon+"月 預計出貨金額";
			  String colname2= mon+"月 預計銷貨金額";
			  String colname3= mon+"月 預計結案驗收金額";
				%>
				<wea:item type="thead"><%=colname1%></wea:item>
			     <wea:item type="thead"><%=colname2%></wea:item>
				<wea:item type="thead"><%=colname3%></wea:item>
			<%}%>	
		<% String sql="select "+backfields +" from "+fromSql+" "+sqlWhere+" order by "+orderby;
		 out.print(sql);
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
		   String[] str = new String[36];
		   int yue1;
				if(!month.equals("")){
				yue1=Integer.valueOf(month);
				}else{
				yue1=now_month;
				}
				for(int i=0;i<=11;i++){
					int mon=(yue1+i)%12;
					if (mon == 0){
							mon=12;
					}
		      String name1="sale"+mon+"1";
			   String name2="sale"+mon+"2";
			    String name3="sale"+mon+"3";
				str[i*3]=name1;
				str[i*3+1]=name2;
				str[i*3+2]=name3;
				}
		   String value1="";
		   String value2="";
		   String value3="";
		   String value4="";
		   String value5="";
		   String value6="";
		   String value7="";
		   String value8="";
		   String value9="";
		   String value10="";
		   String value11="";
		   String value12="";
		   String value13="";
		   String value14="";
		   String value15="";
		   String value16="";
		   String value17="";
		   String value18="";
		   String value19="";
		   String value20="";
		   String value21="";
		   String value22="";
		   String value23="";
		   String value24="";
		   String value25="";
		   String value26="";
		   String value27="";
		   String value28="";
		   String value29="";
		   String value30="";
		   String value31="";
		   String value32="";
		   String value33="";
		   String value34="";
		   String value35="";
		   String value36="";
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
			value1=Util.null2String(rs1.getString(str[0]));
			value2=Util.null2String(rs1.getString(str[1]));
			value3=Util.null2String(rs1.getString(str[2]));
			value4=Util.null2String(rs1.getString(str[3]));
			value5=Util.null2String(rs1.getString(str[4]));
			value6=Util.null2String(rs1.getString(str[5]));
			value7=Util.null2String(rs1.getString(str[6]));
			value8=Util.null2String(rs1.getString(str[7]));
			value9=Util.null2String(rs1.getString(str[8]));
			value10=Util.null2String(rs1.getString(str[9]));
			value11=Util.null2String(rs1.getString(str[10]));
			value12=Util.null2String(rs1.getString(str[11]));
			value13=Util.null2String(rs1.getString(str[12]));
			value14=Util.null2String(rs1.getString(str[13]));
			value15=Util.null2String(rs1.getString(str[14]));
			value16=Util.null2String(rs1.getString(str[15]));
			value17=Util.null2String(rs1.getString(str[16]));
			value18=Util.null2String(rs1.getString(str[17]));
			value19=Util.null2String(rs1.getString(str[18]));
			value20=Util.null2String(rs1.getString(str[19]));
			value21=Util.null2String(rs1.getString(str[20]));
			value22=Util.null2String(rs1.getString(str[21]));
			value23=Util.null2String(rs1.getString(str[22]));
			value24=Util.null2String(rs1.getString(str[23]));
			value25=Util.null2String(rs1.getString(str[24]));
			value26=Util.null2String(rs1.getString(str[25]));
			value27=Util.null2String(rs1.getString(str[26]));
			value28=Util.null2String(rs1.getString(str[27]));
			value29=Util.null2String(rs1.getString(str[28]));
			value30=Util.null2String(rs1.getString(str[29]));
			value31=Util.null2String(rs1.getString(str[30]));
			value32=Util.null2String(rs1.getString(str[31]));
			value33=Util.null2String(rs1.getString(str[32]));
			value34=Util.null2String(rs1.getString(str[33]));
			value35=Util.null2String(rs1.getString(str[34]));
			value36=Util.null2String(rs1.getString(str[35]));
			  
			  %>
			  <wea:item><%=takeordermonth%></wea:item>
			     <wea:item><%=cusumer%></wea:item>
			     <wea:item><%=name%></wea:item>
				 <wea:item><%=prjstatus%></wea:item>
			     <wea:item><%=quity%></wea:item>
			     <wea:item><%=singleprice%></wea:item>
			     <wea:item><%=itembuget%></wea:item>
			     <wea:item><%=pcentchange%></wea:item>
			     <wea:item><%=pertotalmoney%></wea:item>
				 <wea:item><%=peroutmonth%></wea:item>
			     <wea:item><%=persalemonth%></wea:item>
			     <wea:item><%=peracceptancemonth%></wea:item>
				 
				 <wea:item><%=value1%></wea:item>
			     <wea:item><%=value2%></wea:item>
			     <wea:item><%=value3%></wea:item>
			     <wea:item><%=value4%></wea:item>
			     <wea:item><%=value5%></wea:item>
			     <wea:item><%=value6%></wea:item>
			     <wea:item><%=value7%></wea:item>
			     <wea:item><%=value8%></wea:item>
				 <wea:item><%=value9%></wea:item>
				 <wea:item><%=value10%></wea:item>
			     <wea:item><%=value11%></wea:item>
			     <wea:item><%=value12%></wea:item>
			     <wea:item><%=value13%></wea:item>
			     <wea:item><%=value14%></wea:item>
			     <wea:item><%=value15%></wea:item>
			     <wea:item><%=value16%></wea:item>
			     <wea:item><%=value17%></wea:item>
				 <wea:item><%=value18%></wea:item>
				 <wea:item><%=value19%></wea:item>
			     <wea:item><%=value20%></wea:item>
			     <wea:item><%=value21%></wea:item>
			     <wea:item><%=value22%></wea:item>
			     <wea:item><%=value23%></wea:item>
			     <wea:item><%=value24%></wea:item>
			     <wea:item><%=value25%></wea:item>
			     <wea:item><%=value26%></wea:item>
				 <wea:item><%=value27%></wea:item>
				  <wea:item><%=value28%></wea:item>
			     <wea:item><%=value29%></wea:item>
			     <wea:item><%=value30%></wea:item>
			     <wea:item><%=value31%></wea:item>
			     <wea:item><%=value32%></wea:item>
			     <wea:item><%=value33%></wea:item>
			     <wea:item><%=value34%></wea:item>
			     <wea:item><%=value35%></wea:item>
				 <wea:item><%=value36%></wea:item>
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