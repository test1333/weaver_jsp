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
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
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
	margin-top:11px;
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
<div class="reportshow">
<TABLE class=Shadow>
<tr height=10>
	<h2 style="text-align:center">每周追踪整合</h2>
</tr>
<tr>
	<td valign="top">
	<%
	String durrdate = TimeUtil.getCurrentDateString();
	durrdate = durrdate.split("-")[0];
	int total = TimeUtil.getMaxWeekNumOfYear(Integer.parseInt(durrdate));
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
	er.addStringValue("项目名称", "Header"); 
	er.addStringValue("项目编号", "Header"); 
	er.addStringValue("指定调查员", "Header"); 
	er.addStringValue("调查启动日期", "Header"); 
	er.addStringValue("案件状态", "Header");
	er.addStringValue("复杂程度", "Header");
	er.addStringValue("任务来源", "Header");
	er.addStringValue("举报类型", "Header");
	er.addStringValue("预防损失（估算）", "Header");
	er.addStringValue("追回损失（估算）", "Header");
	
	
	
	%>
	  <table width="2000px" border="1px solid" bordercolor="#000000" cellspacing="0px" style="table-layout:fixed;word-break:break-all;margin-top:10px;">
			<colgroup>
				<col width="90px" />
				<col width="90px" />
				<col width="90px" />
				<col width="90px" />
				<col width="90px" />
				<col width="90px" />
				<col width="90px" />
				<col width="90px" />
				<col width="90px" />
				<col width="90px" />
				
				<%for(int i=0;i<total*2;i++){ %>
						<col width="90px" />
				<%}%>

			</colgroup>
			<tbody>
		    <tr>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">项目名称</td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">项目编号</td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">指定调查员</td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">调查启动日期</td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">案件状态</td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">复杂程度</td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">任务来源</td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">举报类型</td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">预防损失（估算）</td>
				<td rowspan="2" class="td2" align="center" style="font-weight:bold;">追回损失（估算）</td>
				
				<%for(int i=1;i<total+1;i++){ %>
					<td colspan="2" class="td2" align="center" style="font-weight:bold;">2017第<%=i%>周</td>
				<%}%>
				
			</tr>
    		<tr>
			
				<%for(int i=0;i<total;i++){ %>
					<td  class="td2" align="center" style="font-weight:bold;">本周完成</td>
					<td  class="td2" align="center" style="font-weight:bold;">下周计划</td>
				<%}%>
				
			</tr>
			
		 <%
			int rbythj=0;
			int rbwthj=0;
			int wccshj=0;
			int kqlchj=0;
			String idstr="";
			rs.executeSql("  SELECT * from uf_hq_cri_casedp where zt = '0' ORDER BY id desc ");
			while(rs.next()){
				String xmmc=rs.getString("xmmc");
				String xmbh=rs.getString("xmbh");
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
				String dcqdrq=rs.getString("dcqdrq");
				String zt=rs.getString("zt");
				if("0".equals(zt)){
					zt = "开放";
				}else if("1".equals(zt)){
					zt = "结案";
				}else if("2".equals(zt)){
					zt = "搁置";
				}else if("3".equals(zt)){
					zt = "取消";
				}
				String fzcd=rs.getString("fzcd");
				if("0".equals(fzcd)){
					fzcd = "复杂";
				}else if("1".equals(fzcd)){
					fzcd = "简单";
				}
				String rwly=rs.getString("rwly");
				rs1.executeSql(" select * from 	uf_hq_cri_sourceom where id = '"+rwly+"' ");
				if(rs1.next()){
					rwly = rs1.getString("rwly");
				}
				String jblx=rs.getString("rwly");
				String yfssgs=rs.getString("yfssgs");
				String zhssgs=rs.getString("zhssgs");
							
				er = es.newExcelRow() ;
				er.addStringValue(xmmc, "Header"); 
				er.addStringValue(xmbh, "Header"); 				
				er.addStringValue(dcy+"", "Header"); 
				er.addStringValue(dcqdrq+"", "Header"); 
				er.addStringValue(zt+"", "Header"); 
				er.addStringValue(fzcd+"", "Header"); 
				er.addStringValue(rwly+"", "Header"); 
				er.addStringValue(jblx+"", "Header"); 
				er.addStringValue(yfssgs+"", "Header"); 
				er.addStringValue(zhssgs+"", "Header"); 
			%>		
				<tr class='rowcss'>
					<td class="td1"  align='center'><%=xmmc%></td>
					<td class="td1" align='center'><%=xmbh%></td>
					<td class="td1" align='center'><%=dcystr%></td>
					<td class="td1" align='center'><%=dcqdrq%></td>
					<td class="td1" align='center'><%=zt%></td>
					<td class="td1" align='center'><%=fzcd%></td>
					<td class="td1" align='center'><%=rwly%></td>
					<td class="td1" align='center'><%=rwly%></td>
					<td class="td1" align='center'><%=yfssgs%></td>
					<td class="td1" align='center'><%=zhssgs%></td>
					
					<%for(int i=0;i<total*2;i++){ %>
						<td class="td1" align='center' width=10><textarea readonly="readonly" name='row<%=xmbh%>_col1' style="width:70px;"></textarea></td>
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
	
	///function onShowVotingDate(){
		//alert(678);
		
		jQuery("#onFrmSubmit").bind("click",function(){
			alert(9090);
			var startdate = jQuery("#begindate").val();
			alert("==="+startdate);
		})
		
	//}
	
</script>
</body>
</html>