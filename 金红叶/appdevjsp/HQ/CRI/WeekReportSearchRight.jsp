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
	height:6px;
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
<body id=body onscroll="parent.myFrameL.body.scrollTop=parent.myFrameR.body.scrollTop">
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{导出excel,/weaver/weaver.file.ExcelOut,_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<div class="reportshow">
<TABLE class=Shadow>
<tr height=10>
	<table width="100%">
		<colgroup>
			<col width="72%" />
			<col width="40%" />
		</colgroup>
		<tbody>
		<tr>
			<td style="float:right;">
				<div style="font-size:16px;font-weight:900;margin-top:3px;">每周追踪整合对应周查询</div>
			<td>
		</tr>
		</tbody>
	</table>
</tr>
<tr>
	<td valign="top">
	<%
	String durrdates = TimeUtil.getCurrentDateString();
	String durrdate = Util.null2String(request.getParameter("YEARS"),durrdates);
	durrdate = durrdate.split("-")[0];
	int total = TimeUtil.getMaxWeekNumOfYear(Integer.parseInt(durrdate));
	String departmentid = Util.null2String(request.getParameter("departmentid"));
	String weekBeginDay = Util.null2String(request.getParameter("ksrq"));
	
	int YEARS = Integer.parseInt(durrdate.split("-")[0]);
	int YEAR = Util.getIntValue(request.getParameter("YEAR"),YEARS);
	String selectzt = "0,1,2,3,4,5,6,7";
	String ZT = Util.null2String(request.getParameter("xzzt"),selectzt);
	
	
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
	  <table width="2000" border="1px solid" bordercolor="#000000" cellspacing="0px" style="table-layout:fixed;word-break:break-all;margin-top:10px;">
			<colgroup>
				<%for(int i=0;i<total*2;i++){%>
					<col width="90" />
				<%}%>
			</colgroup>
			<tbody>
		    <tr>
				<%for(int i=1;i<total+1;i++){%>
					<td colspan="2" class="td2" align="center" style="font-weight:bold;"><%=YEAR%>第<%=i%>周</td>
				<%}%>
			</tr>
    		<tr>
				<%for(int i=0;i<total;i++){%>
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
			rs.executeSql("  SELECT * from uf_hq_cri_casedp where zt in ("+ZT+") and substr(dcqdrq,0,4) = '"+YEAR+"' ORDER BY id desc ");
			while(rs.next()){
				String xmmc=rs.getString("xmmc");
				String xmbh=rs.getString("xmbh");
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
					<%for(int i=1;i<=total;i++){ %>						
						<%
						//这个地方只能查出一条记录sql要加过滤条件
						rs1.executeSql(" select t3.* from uf_hq_cri_casedp t1, uf_hq_cri_weeklytra t2, uf_hq_cri_weeklytra_dt1 t3 where t1.xmbh=t2.xmbh and t2.id = t3.mainid and t3.nz='"+(i)+"' and t1.xmbh='"+xmbhtemp+"' ");
						if(rs1.next()){ 
							String bzwc1 = rs1.getString("bzwc");
							String xzjh1 = rs1.getString("xzjh"); 
							%>
							<td class="td1" align='center' width=10><textarea readonly="readonly"  style="width:70px;"><%=bzwc1%></textarea></td>
							<td class="td1" align='center' width=10><textarea readonly="readonly"  style="width:70px;"><%=xzjh1%></textarea></td>
						<%}else{%>
							<td class="td1" align='center' width=10><textarea readonly="readonly"  style="width:70px;"></textarea></td>
							<td class="td1" align='center' width=10><textarea readonly="readonly"  style="width:70px;"></textarea></td>
						<%}%>						
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
</body>
</html>