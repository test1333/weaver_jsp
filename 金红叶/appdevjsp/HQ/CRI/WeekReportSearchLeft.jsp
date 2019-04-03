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
	width:45px;
	text-align:center;
	padding:5px!important;
	height:42px;
}
.td2{
	width:20px;
	text-align:center;
	font-weight:bold;
	background-color:#d2d2d2;
	padding:5px!important;
	height:45px;
}
.reportshow{
	margin-top:11px;
	margin-left:6px;
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
<body id=body onscroll="parent.myFrameR.body.scrollTop=parent.myFrameL.body.scrollTop">
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{导出excel,/weaver/weaver.file.ExcelOut,_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<%
String sqlwhere = "";
String durrdate = TimeUtil.getCurrentDateString();
//String year = durrdate.split("-")[0];
int YEARS = Integer.parseInt(durrdate.split("-")[0]);
int YEAR = Util.getIntValue(request.getParameter("YEAR"),YEARS);
String ZT = Util.null2String(request.getParameter("xzzt"));
if(!"".equals(ZT)){
	sqlwhere += " and zt='"+ZT+"' ";
}
String ZS = Util.null2String(request.getParameter("ajzs"));
if(!"".equals(ZS)){
	if("1".equals(ZS)){
		sqlwhere += " and (ajsyzs >= 6 and ajsyzs <= 7 and fzcd = '0')";
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

String rsdcy = "";
%>
<form id="formid"  name="myform" method ='post'  action='WeekReportOpertion.jsp' >
<div class="reportshow">
<TABLE class=Shadow>
<tr height=10>
	<table width="100%">
		<colgroup>
			<col width="4%" />
			<col width="10%" />
			<col width="4%" />
			<col width="10%" />
			<col width="6%" />
			<col width="10%" />
			<col width="8%" />
			<col width="10%" />
			<col width="15%" />
			<col width="15%" />
		</colgroup>
		<tbody>
		<tr>
			<td>
				<div style="font-weight:bold;font-size:16px;float:left;"><%=SystemEnv.getHtmlLabelName(15933,user.getLanguage())%></div>
			</td>
			<td>
				<select name="type" class="textarea" id="monthSelect">
					<% 
						for(int i=2017;i<YEARS+2;i++){ %>
							<option value = "<%=i%>" <%if(YEAR==i){out.print("selected");}%>><%=i%></option>
					<%	}
					%>
				</select>
			</td>
			<td>
				<div style="font-weight:bold;font-size:16px;float:left;"><%=SystemEnv.getHtmlLabelName(-11624,user.getLanguage())%></div>
			</td>
			<td>
				<select name="type" class="textarea" id="ztSelect">
					<%
					if("7".equals(""+user.getLanguage())){
					%>
					<option value = ""></option>
					<option value = "0" <%if("0".equals(ZT)){%> selected <%}%>>开放</option>
					<option value = "1" <%if("1".equals(ZT)){%> selected <%}%>>结案</option>
					<option value = "2" <%if("2".equals(ZT)){%> selected <%}%>>搁置</option>
					<option value = "3" <%if("3".equals(ZT)){%> selected <%}%>>取消</option>
					<option value = "4" <%if("4".equals(ZT)){%> selected <%}%>>开放中</option>
					<option value = "5" <%if("5".equals(ZT)){%> selected <%}%>>结案中</option>
					<option value = "6" <%if("6".equals(ZT)){%> selected <%}%>>搁置中</option>
					<option value = "7" <%if("7".equals(ZT)){%> selected <%}%>>取消中</option>
					<%} else {%>
					<option value = ""></option>
					<option value = "0" <%if("0".equals(ZT)){%> selected <%}%>>Open</option>
					<option value = "1" <%if("1".equals(ZT)){%> selected <%}%>>Closed</option>
					<option value = "2" <%if("2".equals(ZT)){%> selected <%}%>>Suspend</option>
					<option value = "3" <%if("3".equals(ZT)){%> selected <%}%>>Cancel</option>
					<option value = "4" <%if("4".equals(ZT)){%> selected <%}%>>In Open</option>
					<option value = "5" <%if("5".equals(ZT)){%> selected <%}%>>In Closed</option>
					<option value = "6" <%if("6".equals(ZT)){%> selected <%}%>>In Suspend</option>
					<option value = "7" <%if("7".equals(ZT)){%> selected <%}%>>In Cancel</option>
					<%}%>
				</select>
			</td>
			<td>
				<div style="font-weight:bold;font-size:16px;float:left;"><%=SystemEnv.getHtmlLabelName(-11436,user.getLanguage())%></div>
			</td>
			<td>
				 <brow:browser viewType="0" name="hrmids" id="hrmids" browserValue="<%=hrmids%>" browserOnClick="" browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp" hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1' completeUrl="/data.jsp" width="100%" browserSpanValue="<%=resourc.getLastname(hrmids)%>"> </brow:browser>
			</td>
			<td align="center">
				<div style="font-weight:bold;font-size:16px;"><%=SystemEnv.getHtmlLabelName(-12673,user.getLanguage())%>:</div>
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
			<td style="float:right;">
				<div style="font-size:16px;font-weight:900;"><%=SystemEnv.getHtmlLabelName(-11035,user.getLanguage())%></div>
			<td>
		</tr>
		</tbody>
	</table>
</tr>
<tr>
	<td valign="top">
	<%
	String departmentid = Util.null2String(request.getParameter("departmentid"));
	String weekBeginDay = Util.null2String(request.getParameter("ksrq"));
	User usertemp = HrmUserVarify.getUser (request , response) ;
	int userid=usertemp.getUID();
	ExcelFile.init();
	String fileName ="每周追踪整合统计报表";
	ExcelFile.setFilename(fileName) ;
	ExcelStyle excelStyle = ExcelFile.newExcelStyle("Header");
	excelStyle.setFontcolor(ExcelStyle.WeaverHeaderFontcolor);
	excelStyle.setFontbold(ExcelStyle.WeaverHeaderFontbold);
	excelStyle.setAlign(ExcelStyle.WeaverHeaderAlign);
	ExcelSheet es = ExcelFile.newExcelSheet(fileName);
	ExcelRow er = es.newExcelRow() ;
	er = es.newExcelRow() ;
	er.addStringValue(SystemEnv.getHtmlLabelName(-11221,user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11220,user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11321,user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11439,user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11357,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11437,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11623,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11389,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11465,user.getLanguage()), "Header");
	er.addStringValue(SystemEnv.getHtmlLabelName(-11466,user.getLanguage()), "Header");
	
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
	
	%>
	  <table width="100%" border="1px solid" bordercolor="#000000" cellspacing="0px" style="table-layout:fixed;word-break:break-all;margin-top:10px;">
			<colgroup>
				<col width="6%" />
				<col width="6%" />
				<col width="6%" />
				<col width="6%" />
				<col width="6%" />
				<col width="6%" />
				<col width="6%" />
				<col width="6%" />
				<col width="6%" />
				<col width="6%" />
				<col width="6%" />
			</colgroup>
			<tbody>
		    <tr>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11221,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11220,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11321,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11439,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11357,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11437,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11623,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11389,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11465,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11466,user.getLanguage())%></td>
				<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11236,user.getLanguage())%></td>
			</tr>		
		 <%
			int rbythj=0;
			int rbwthj=0;
			int wccshj=0;
			int kqlchj=0;
			String idstr="";
			
			String subcompanyid1="";
			try{
				ResourceComInfo rsComInfo=new ResourceComInfo();
				subcompanyid1=rsComInfo.getSubCompanyID(userid+"");
			}catch(Exception e){
			}
			String sql = "SELECT * from uf_hq_cri_casedp where substr(dcqdrq,0,4) = '"+YEAR+"' "+sqlwhere+
			" and (modedatacreater in (select id from hrmresource where subcompanyid1='"+subcompanyid1+"' )" +
			" or '"+userid+"' in ( select resourceid from HrmRoleMembers  where roleid='623' )) ORDER BY id desc ";
			//out.print(sql);
			rs.executeSql(sql);
			while(rs.next()){
				String xmmc=rs.getString("xmmc");
				String xmbh=rs.getString("xmbh");
				int ajsyzs = Util.getIntValue(rs.getString("ajsyzs"),0);
				String xmbhtemp=rs.getString("xmbh");
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
				}else if("4".equals(zt)){
					zt = "开放中";
					if("8".equals(""+user.getLanguage())) zt = "In Open";
				}else if("5".equals(zt)){
					zt = "结案中";
					if("8".equals(""+user.getLanguage())) zt = "In Closed";
				}else if("6".equals(zt)){
					zt = "搁置中";
					if("8".equals(""+user.getLanguage())) zt = "In Suspend";
				}else if("7".equals(zt)){
					zt = "取消中";
					if("8".equals(""+user.getLanguage())) zt = "In Cancel";
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
				rs1.executeSql(" select * from 	uf_hq_cri_sourceom where id = '"+rwly+"' ");
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
							
				er = es.newExcelRow() ;
				er.addStringValue(xmmc, "Header"); 
				er.addStringValue(xmbh, "Header"); 				
				er.addStringValue(dcy+"", "Header"); 
				er.addStringValue(dcqdrq+"", "Header"); 
				er.addStringValue(zt+"", "Header"); 
				er.addStringValue(fzcd+"", "Header"); 
				er.addStringValue(rwly+"", "Header"); 
				er.addStringValue(jblxstr+"", "Header");
				er.addStringValue(yfssgs+"", "Header");
				er.addStringValue(zhssgs+"", "Header"); 
			%>		
				<tr class='rowcss'>
					<td class="td1"  align='center'><%=xmmc%></td>
					<% 
					if("复杂".equals(fzcd) || "complex".equals(fzcd)){
						if(ajsyzs >= 6 && ajsyzs <= 7){ 
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
					<td class="td1" align='center'><%=fzcd%></td>
					<td class="td1" align='center'><%=rwly%></td>
					<td class="td1" align='center'><%=jblxstr%></td>
					<td class="td1" align='center'><%=yfssgs%></td>
					<td class="td1" align='center'><%=zhssgs%></td>
					<td class="td1" align='center'><%=jbzy%></td>
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
</body>
<script language=javascript>
	jQuery(document).ready(function(){
		var YEAR = "";
		var xzzt = "";
		var hrmids = "";
		var ajzsSelect = "";
		jQuery("#monthSelect").change(function(){	
			YEAR = $("#monthSelect").val();
			xzzt = $("#ztSelect").val();
			hrmids = $("#hrmids").val();
			ajzsSelect = $("#ajzsSelect").val();
			window.location.href = "WeekReportSearchLeft.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect;			
			parent.document.getElementById('myFrameR').src="WeekReportSearchRight.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect;
		})
		jQuery("#ztSelect").change(function(){		
		    YEAR = $("#monthSelect").val();
			xzzt = $("#ztSelect").val();
			hrmids = $("#hrmids").val();
			ajzsSelect = $("#ajzsSelect").val();
            //alert("00000:"+"WeekReportSearchLeft.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect);		
			window.location.href = "WeekReportSearchLeft.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect;			
			parent.document.getElementById('myFrameR').src="WeekReportSearchRight.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect;
		})
		
		jQuery("#ajzsSelect").change(function(){
			YEAR = $("#monthSelect").val();
			xzzt = $("#ztSelect").val();
			hrmids = $("#hrmids").val();
			ajzsSelect = $("#ajzsSelect").val();
			//alert("1111:"+"WeekReportSearchLeft.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect);	
			window.location.href = "WeekReportSearchLeft.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect;			
			parent.document.getElementById('myFrameR').src="WeekReportSearchRight.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect;
		})
		
		all_browse_bind("#hrmids",function(){
			YEAR = $("#monthSelect").val();
			xzzt = $("#ztSelect").val();
			hrmids = $("#hrmids").val();
			ajzsSelect = $("#ajzsSelect").val();
			//alert("2222:"+"WeekReportSearchLeft.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect);	
			window.location.href = "WeekReportSearchLeft.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect;			
			parent.document.getElementById('myFrameR').src="WeekReportSearchRight.jsp?YEAR="+YEAR+"&xzzt="+xzzt+"&hrmids="+hrmids+"&ajzs="+ajzsSelect;
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
</html>