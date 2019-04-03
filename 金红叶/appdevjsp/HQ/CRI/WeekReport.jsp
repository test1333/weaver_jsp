<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.file.ExcelStyle" %>
<%@ page import="weaver.file.ExcelSheet" %>
<%@ page import="weaver.file.ExcelRow" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.hrm.resource.ResourceComInfo" %>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="resourc" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page" />
<html>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<style type="text/css">
.rowcss:hover{
  background:#e0e0e0;
}
table{
	width:100%;
}
.td1{
	width:50px;
	text-align:center;
	padding:5px!important;
}
.td2{
	width:20px;
	text-align:center;
	font-weight:bold;
	background-color:#d2d2d2;
	padding:5px!important;
}
.reportshow{
	margin-top:10px;
	margin-left:5px;
}

.td2{border:solid #000000; border-width:0px 1px 1px 0px; padding-left:10px;}
.td1{border:solid #000000; border-width:0px 1px 1px 0px; padding-left:10px;}
TABLE.Shadow td{
  padding: 3px;
}
.buttons{
	font-weight:bold;
	padding:3px;
	border:2px solid rgb(158,177,178);
	FONT-SIZE:8pt;
	COLOR:#000000;
	BACKGROUND-REPEAT: no-repeat;
	BACKGROUND-COLOR: white;
	TEXT-ALIGN: center;
	width:60px; 
	height:30px;
	border-radius: 5px; 
	background:#eb2744; 
	line-height:30px; 
}
</style>
<body>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{导出excel,/weaver/weaver.file.ExcelOut,_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<%
String durrdate = TimeUtil.getCurrentDateString();
String year = durrdate.split("-")[0];
String startdate = Util.null2String(request.getParameter("begindate"));
String enddate = Util.null2String(request.getParameter("enddate"));

String sqlwhere = "";
String ZS = Util.null2String(request.getParameter("ajzs"));
if(!"".equals(ZS)){
	if("1".equals(ZS)){
		sqlwhere += " and (ajsyzs >= 6 and ajsyzs <= 7 and fzcd = '0') ";
	}else if("0".equals(ZS)){
		sqlwhere += " and ((ajsyzs >= 8 and fzcd = '0') or (ajsyzs > 1 and fzcd = '1')) ";
	} else if("2".equals(ZS)) {
		sqlwhere += " and ((ajsyzs < 6 and fzcd = '0') or (ajsyzs <= 1 and fzcd = '1'))";
	} 
}
String hrmids = Util.null2String(request.getParameter("hrmids"));
if(!"".equals(hrmids)){
	sqlwhere += " and ','||dcy||',' like '%,"+hrmids+",%' ";
}
%>
<form id="formid"  name="myform" method = 'post'  action = 'WeekReportOpertion.jsp' >
<div class="reportshow">
<TABLE class=Shadow>
<tr height=10>
	<table width="100%">
		
		<tbody>
		<tr>		    
			<td align="center" colspan="3">
				<div style="font-size:16px;font-weight:900;"><%=SystemEnv.getHtmlLabelName(-12351,user.getLanguage())%></div>
			<td>
			<td align="center" >
				<div><input type="button" class="middle e8_btn_top_first" value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%>" title="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%>" onclick="this.form.submit()" style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;float:left;" /></div>
			<td>
		</tr>
		<tr>
		    <td align="center">
				<div style="font-weight:bold;font-size:16px;"><%=SystemEnv.getHtmlLabelName(-11563,user.getLanguage())%>:</div>
			</td>
			<td>
				 <brow:browser viewType="0" name="hrmids" id="hrmids" browserValue="<%=hrmids%>" browserOnClick="" browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp" hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1' completeUrl="/data.jsp" width="100%" browserSpanValue="<%=resourc.getLastname(hrmids)%>"> </brow:browser>
			</td>
			<td align="center">
				<div style="font-weight:bold;font-size:16px;"><%=SystemEnv.getHtmlLabelName(-12352,user.getLanguage())%>:</div>
			</td>
			<td>
				<select name="type" id="ajzs">
				    <%
					if("7".equals(""+user.getLanguage())){
					%>
					<option value = ""></option>
					<option value = "0" <%if("0".equals(ZS)){%> selected <%}%>>标红案件</option>
					<option value = "1" <%if("1".equals(ZS)){%> selected <%}%>>标黄案件</option>
					<option value = "2" <%if("2".equals(ZS)){%> selected <%}%>>尚未预警</option>
					<%} else {%>
					<option value = ""></option>
					<option value = "0" <%if("0".equals(ZS)){%> selected <%}%>>Standard red case</option>
					<option value = "1" <%if("1".equals(ZS)){%> selected <%}%>>Standard yellow case</option>
					<option value = "2" <%if("2".equals(ZS)){%> selected <%}%>>Not yet warning</option>
					<%}%>
				</select>
			</td>			
		</tr>
		</tbody>
	</table>
</tr>
<tr>
	<td valign="top">
	<%
	
	Calendar c = Calendar.getInstance();   //获得一个日历的实例   
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
	Date date = null;   
	try{   
		date = sdf.parse(durrdate);   //初始日期   
	}catch(Exception e){  
	}   
	c.setTime(date);//设置日历时间   
	date  = c.getTime();
	int re = TimeUtil.getWeekOfYear(date);
	String newweek1 = year+String.valueOf(re-1);
	String newweek2 = year+String.valueOf(re);
	String newweek3 = year+String.valueOf(re+1);
	ExcelFile.init();
	String fileName = SystemEnv.getHtmlLabelName(-12351,user.getLanguage());
	ExcelFile.setFilename(fileName) ;
	ExcelStyle excelStyle = ExcelFile.newExcelStyle("Header");
	excelStyle.setFontcolor(ExcelStyle.WeaverHeaderFontcolor);
	excelStyle.setFontbold(ExcelStyle.WeaverHeaderFontbold);
	excelStyle.setAlign(ExcelStyle.WeaverHeaderAlign);
	ExcelSheet es = ExcelFile.newExcelSheet(fileName);
	ExcelRow er = es.newExcelRow() ;
	er = es.newExcelRow() ;
	er.addStringValue(SystemEnv.getHtmlLabelName(-11840,user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11568,user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11756,user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11564,user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11911,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11912,user.getLanguage()), "Header");	
	er.addStringValue(SystemEnv.getHtmlLabelName(-11640,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11829,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11789,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11654,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11654,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11637,user.getLanguage()), "Header");
	er.addStringValue(year+"第"+(re-1)+"周(上一周)(本周完成)", "Header");
	er.addStringValue(year+"第"+(re-1)+"周(上一周)(下周计划)", "Header");
	er.addStringValue(year+"第"+re+"周(上一周)(本周完成)", "Header");
	er.addStringValue(year+"第"+re+"周(上一周)(下周计划)", "Header");
	er.addStringValue(year+"第"+(re+1)+"周(上一周)(本周完成)", "Header");
	er.addStringValue(year+"第"+(re+1)+"周(上一周)(下周计划)", "Header");
		
	%>
	  <table width="2000" border="1px solid" bordercolor="#000000" cellspacing="0px" style="table-layout:fixed;word-break:break-all;margin-top:10px;">
			<colgroup>
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="270" />
				<col width="190" />
				<col width="190" />
				<col width="190" />
				<col width="190" />
				<col width="190" />
				<col width="190" />
			</colgroup>
			<tbody>
		    <tr>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11840,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11568,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11756,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11564,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11911,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11912,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11640,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11829,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11789,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11654,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11654,user.getLanguage())%></td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11637,user.getLanguage())%></td>
				
				<%
				if("7".equals(""+user.getLanguage())){
				%>
				<td colspan="2" class="td2" align="center" style="font-weight:bold;" name="week1"><%=year%>第<%=re-1%>周(上一周)</td>
				<td colspan="2" class="td2" align="center" style="font-weight:bold;" name="week2"><%=year%>第<%=re%>周(本周)</td>
				<td colspan="2" class="td2" align="center" style="font-weight:bold;" name="week3"><%=year%>第<%=re+1%>周(下一周)</td>
				<%} else {%>
				<td colspan="2" class="td2" align="center" style="font-weight:bold;" name="week1"><%=year%>No.<%=re-1%>Week(Last week)</td>
				<td colspan="2" class="td2" align="center" style="font-weight:bold;" name="week2"><%=year%>No.<%=re%>Week(This week)</td>
				<td colspan="2" class="td2" align="center" style="font-weight:bold;" name="week3"><%=year%>No.<%=re+1%>Week(Next week)</td>
				<%}%>
			</tr>
    		<tr>
				<td  class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11754,user.getLanguage())%></td>
				<td  class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11753,user.getLanguage())%></td>
				<td  class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11754,user.getLanguage())%></td>
				<td  class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11753,user.getLanguage())%></td>
				<td  class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11754,user.getLanguage())%></td>
				<td  class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11753,user.getLanguage())%></td>
			</tr>
			
		 <%
			int rbythj=0;
			int rbwthj=0;
			int wccshj=0;
			int kqlchj=0;
			String idstr="";
			String userid=user.getUID()+"";
			String subcompanyid1="";
			try{
				ResourceComInfo rsComInfo=new ResourceComInfo();
				subcompanyid1=rsComInfo.getSubCompanyID(userid);
			}catch(Exception e){
			}			
			String sql = "SELECT * from uf_hq_cri_casedp t1  where t1.zt = '0' "+sqlwhere+" and (t1.modedatacreater in (select id from hrmresource where subcompanyid1='"+subcompanyid1+"') "+
			" or  '"+userid+"' in  (  select resourceid from HrmRoleMembers  where roleid='788' )) ORDER BY t1.id desc ";
			//out.println(sql);
			rs.executeSql(sql);
			while(rs.next()){
				String xmmc=rs.getString("xmmc");
				String xmbh=rs.getString("xmbh");
				String xmbhtemp=rs.getString("xmbh");
				int ajsyzs = Util.getIntValue(rs.getString("ajsyzs"),0);
				rs1.executeSql(" select xmbh from uf_hq_cri_noticeoao where id = '"+xmbh+"' ");
				if(rs1.next()){
					xmbh = rs1.getString("xmbh");
				}
				String dcy=rs.getString("dcy");
				String dcystr = "";
				rs1.executeSql(" select lastname from hrmresource where id in ("+dcy+") ");
				while(rs1.next()){
					dcy = rs1.getString("lastname");
					dcystr = dcystr + dcy + ",";
				}
				
				if(!"".equals(dcystr) && ",".equals(dcystr.substring(dcystr.length()-1,dcystr.length()))){
					dcystr=dcystr.substring(0,dcystr.length()-1);
				}
								
				String dcqdrq=rs.getString("dcqdrq");
				String zt=rs.getString("zt");
				if("0".equals(zt)){
					zt = "开放";
					if("8".equals(""+user.getLanguage())) zt = "Open";
				}else if("1".equals(zt)){
					zt = "结案";
					if("8".equals(""+user.getLanguage())) zt = "Closed";
				}else if("2".equals(zt)){
					zt = "搁置";
					if("8".equals(""+user.getLanguage())) zt = "Suspend";
				}else if("3".equals(zt)){
					zt = "取消";
					if("8".equals(""+user.getLanguage())) zt = "Cancel";
				}
				
				String fzcd=rs.getString("fzcd");
				if("0".equals(fzcd)){
					fzcd = "复杂";
					if("8".equals(""+user.getLanguage())) fzcd = "complex";
				}else if("1".equals(fzcd)){
					fzcd = "简单";
					if("8".equals(""+user.getLanguage())) fzcd = "simple";
				}
				String rwly=rs.getString("jbqd");
				rs1.executeSql(" select rwly from uf_hq_cri_sourceom where id = '"+rwly+"' ");
				if(rs1.next()){
					rwly = rs1.getString("rwly");
				}
				String jblxs=rs.getString("ajcslb");
				
			 	String jblxstr = "";
				rs1.executeSql(" select jblb from uf_hq_cri_noticeoao where id = '"+xmbhtemp+"' ");
				if(rs1.next()){
					String jblx = rs1.getString("jblb");
				 	rs2.executeSql(" select jblx from uf_hq_cri_reporting where id in ("+jblx+") ");
					while(rs2.next()){
						String jblxmc = rs2.getString("jblx");
						jblxstr = jblxstr + jblxmc + ",";
					} 
				}
				
				if(!"".equals(jblxstr) && ",".equals(jblxstr.substring(jblxstr.length()-1,jblxstr.length()))){
					jblxstr=jblxstr.substring(0,jblxstr.length()-1);
				}  
				
				String yfssgs=rs.getString("yfssgs");
				String zhssgs=rs.getString("zhssgs");
				String jbzy = rs.getString("jbzy");		
				
				String bzwca = "";
				String xzjha = "";
				String bzwcb = "";
				String xzjhb = "";
				String bzwcc = "";
				String xzjhc = "";
				rs1.executeSql(" select t2.bzwc, t2.xzjh from uf_hq_cri_weeklytra t1,uf_hq_cri_weeklytra_dt1 t2  where t1.id=t2.mainid and t2.zs='"+newweek1+"' and t1.xmbh = '"+xmbhtemp+"' ");
				if(rs1.next()){
					bzwca = rs1.getString("bzwc");
					xzjha = rs1.getString("xzjh");
				}
				rs1.executeSql(" select t2.bzwc, t2.xzjh from uf_hq_cri_weeklytra t1,uf_hq_cri_weeklytra_dt1 t2  where t1.id=t2.mainid and t2.zs='"+newweek2+"' and t1.xmbh = '"+xmbhtemp+"' ");
				if(rs1.next()){
					bzwcb = rs1.getString("bzwc");
					xzjhb = rs1.getString("xzjh");
				}
				rs1.executeSql(" select t2.bzwc, t2.xzjh from uf_hq_cri_weeklytra t1,uf_hq_cri_weeklytra_dt1 t2  where t1.id=t2.mainid and t2.zs='"+newweek3+"' and t1.xmbh = '"+xmbhtemp+"' ");
				if(rs1.next()){
					bzwcc = rs1.getString("bzwc");
					xzjhc = rs1.getString("xzjh");
				}
							
				er = es.newExcelRow() ;
				er.addStringValue(xmmc, "Header"); 
				er.addStringValue(xmbh, "Header"); 				
				er.addStringValue(dcy+"", "Header"); 
				er.addStringValue(dcqdrq+"", "Header"); 
				er.addStringValue(zt+"", "Header"); 
				er.addStringValue(ajsyzs+"", "Header"); 
				er.addStringValue(fzcd+"", "Header"); 
				er.addStringValue(rwly+"", "Header"); 
				er.addStringValue(jblxstr+"", "Header");
				er.addStringValue(yfssgs+"", "Header"); 
				er.addStringValue(zhssgs+"", "Header"); 
				er.addStringValue(jbzy+"", "Header"); 
				er.addStringValue(bzwca+"", "Header"); 
				er.addStringValue(xzjha+"", "Header");
				er.addStringValue(bzwcb+"", "Header"); 
				er.addStringValue(xzjhb+"", "Header");
				er.addStringValue(bzwcc+"", "Header"); 
				er.addStringValue(xzjhc+"", "Header");
			%>		
				<tr class='rowcss'>
					<td class="td1"  align='center'><%=xmmc%></td>
					
					<% 
					if("复杂".equals(fzcd) || "complex".equals(fzcd)){
						if(ajsyzs >= 6 && ajsyzs <=7){ 
					%>
					<td class="td1" style="background:yellow" align='center'><%=xmbh%></td>
					<%
						} else if(ajsyzs >= 8){
					%>
					<td class="td1" style="background:red" align='center'><%=xmbh%></td>
					<%
						} else {
					%>
					<td class="td1" align='center'><%=xmbh%></td>
					<%  
						}
					} else {
						if(ajsyzs > 1) {
					%>
					<td class="td1" style="background:red" align='center'><%=xmbh%></td>
						<%} else {%>
					<td class="td1" align='center'><%=xmbh%></td>
					<%
						}
					}
					%>					
					<td class="td1" align='center'><%=dcystr%></td>
					<td class="td1" align='center'><%=dcqdrq%></td>
					<td class="td1" align='center'><%=zt%></td>
					<td class="td1" align='center'><%=ajsyzs%></td>
					<td class="td1" align='center'><%=fzcd%></td>
					<td class="td1" align='center'><%=rwly%></td>
					<td class="td1" align='center'><%=jblxstr%></td>
					<td class="td1" align='center'><%=yfssgs%></td>
					<td class="td1" align='center'><%=zhssgs%></td>
					<td class="td1" align='center'><%=jbzy%></td>
					
					<%
						//这个地方只能查出一条记录sql要加过滤条件
						rs1.executeSql(" select t3.* from uf_hq_cri_casedp t1, uf_hq_cri_weeklytra t2, uf_hq_cri_weeklytra_dt1 t3 where t1.xmbh=t2.xmbh and t2.id = t3.mainid and t3.zs='"+newweek1+"' and t1.xmbh='"+xmbhtemp+"' ");
						if(rs1.next()){ 
							String bzwc1 = rs1.getString("bzwc");
							String xzjh1 = rs1.getString("xzjh"); 
							%>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col1' style="width:170px;height:70px;"><%=bzwc1%></textarea></td>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col2' style="width:170px;height:70px;"><%=xzjh1%></textarea></td>
						<%}else{%>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col1' style="width:170px;height:70px;"></textarea></td>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col2' style="width:170px;height:70px;"></textarea></td>
						<%}%>
						<%
						//这个地方只能查出一条记录sql要加过滤条件
						rs1.executeSql(" select t3.* from 	uf_hq_cri_casedp t1, uf_hq_cri_weeklytra t2, uf_hq_cri_weeklytra_dt1 t3 where t1.xmbh=t2.xmbh and t2.id = t3.mainid  and t3.zs='"+newweek2+"' and t1.xmbh='"+xmbhtemp+"' ");
						if(rs1.next()){ 
							String bzwc2 = rs1.getString("bzwc");
							String xzjh2 = rs1.getString("xzjh"); 
							%>
						
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col3' style="width:170px;height:70px;"><%=bzwc2%></textarea></td>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col4' style="width:170px;height:70px;"><%=xzjh2%></textarea></td>
						<%}else{%>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col3' style="width:170px;height:70px;"></textarea></td>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col4' style="width:170px;height:70px;"></textarea></td>
					<%}%>
						<%
						//这个地方只能查出一条记录sql要加过滤条件
						rs1.executeSql(" select t3.* from uf_hq_cri_casedp t1, uf_hq_cri_weeklytra t2, uf_hq_cri_weeklytra_dt1 t3 where t1.xmbh=t2.xmbh and t2.id = t3.mainid and t3.zs='"+newweek3+"' and t1.xmbh='"+xmbhtemp+"' ");
						if(rs1.next()){ 
							String bzwc3 = rs1.getString("bzwc");
							String xzjh3 = rs1.getString("xzjh"); 
							%>
						
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col5' style="width:170px;height:70px;"><%=bzwc3%></textarea></td>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col6' style="width:170px;height:70px;"><%=xzjh3%></textarea></td>
					<%}else{%>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col5' style="width:170px;height:70px;"></textarea></td>
							<td class="td1" align='center'><textarea name='row<%=xmbh%>_col6' style="width:170px;height:70px;"></textarea></td>
					<%}%>
				</tr>
			 <%
			}			
			
			%>
			</tbody>
		</table>
		</form>
	</td>
</tr>
</TABLE>
</div>
<script type="text/javascript">
	jQuery(document).ready(function(){
		var hrmids = "";
		var ajzsSelect = "";
		jQuery("#ajzs").change(function(){
			hrmids = $("#hrmids").val();
			ajzsSelect = $("#ajzs").val();
			window.location.href = "WeekReport.jsp?hrmids="+hrmids+"&ajzs="+ajzsSelect;			
		})
		all_browse_bind("#hrmids",function(){
			hrmids = $("#hrmids").val();
			ajzsSelect = $("#ajzs").val();
			window.location.href = "WeekReport.jsp?hrmids="+hrmids+"&ajzs="+ajzsSelect;						
		})
	})
	
	function all_browse_bind( id ,func_browse){    
		var id_val_last=jQuery(id).val();
		setInterval(function(){
			var id_val = jQuery(id).val();
			if( id_val != id_val_last){
				func_browse();
			}
			id_val_last = id_val;
		},50);
	}
</script>
</body>
</html>