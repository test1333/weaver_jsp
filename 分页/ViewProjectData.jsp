<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.common.xtable.*" %>		
<%@ include file="/systeminfo/init.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="cmutil" class="weaver.ce.util.CommonTransUtil" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
		<SCRIPT language="javascript" src="/js/weaver.js"></script>
		<link rel='stylesheet' type='text/css' href='/js/extjs/resources/css/ext-all.css' />
		<link rel='stylesheet' type='text/css' href='/js/extjs/resources/css/xtheme-gray.css'/>
		<link rel='stylesheet' type='text/css' href='/css/weaver-ext.css' />
		<script type='text/javascript' src='/js/extjs/adapter/ext/ext-base.js'></script>
		<script type='text/javascript' src='/js/extjs/ext-all.js'></script>   
		<%if(user.getLanguage()==7) {%>
			<script type='text/javascript' src='/js/extjs/build/locale/ext-lang-zh_CN_gbk.js'></script>
			<script type='text/javascript' src='/js/weaver-lang-cn-gbk.js'></script>
		<%} else if(user.getLanguage()==8) {%>
			<script type='text/javascript' src='/js/extjs/build/locale/ext-lang-en.js'></script>
			<script type='text/javascript' src='/js/weaver-lang-en-gbk.js'></script>
		<%} else if(user.getLanguage()==9) {%>
			<script type='text/javascript' src='/js/extjs/build/locale/ext-lang-zh_TW.js'></script>
			<script type='text/javascript' src='/js/weaver-lang-tw-gbk.js'></script>
		<%}%>
		<script type="text/javascript" src="/js/WeaverTableExt.js"></script>  
		<link rel="stylesheet" type="text/css" href="/css/weaver-ext-grid.css" />
	</head>
	<%
		String customerId = Util.null2String(request.getParameter("customerId"));
		String customerName = "";
		if (!"".equals(customerId)) {
			rs.executeSql("select upgradePath from CE_CustomerSystemRecord where customerId = " + customerId);
			if (rs.next()) {
				customerName = Util.null2String(rs.getString(1));
			}
		}
		
		String imagefilename = "/images/hdReport.gif";
		String titlename = (!customerName.equals("")?customerName.substring(1):"")+"QC记录列表";
		String needfav = "1";
		String needhelp = "";
	%>
	<BODY  style="overflow: hidden">
		<%@ include file="/systeminfo/TopTitle.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
		<%
			RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage()) + ",javascript:document.frmMain.submit();,_self} ";
			RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu.jsp"%>
		<form name="frmMain" action="QCRecordList.jsp" method="post">
		<input type="hidden" name="search" value="1">
		<table width=100% height=96% border="0" cellspacing="0" cellpadding="0" valign="top">
			<colgroup>
				<col width="10">
				<col width="">
				<col width="10">
			</colgroup>
			<tr style="height: 10px;">
				<td height="10" colspan="3"></td>
			</tr>
			<tr>
				<td></td>
				<td valign="top">
					<TABLE class=Shadow>
						<tr>
							<td valign="top">
								<TABLE class=ViewForm id=searchTable></TABLE>
											<%
												String tableString = "";
												String backfields = " t.BG_BUG_ID,t.BG_STATUS,t.BG_RESPONSIBLE,t.BG_DETECTED_BY,t.BG_summary ";
												String fromSql = " td.bug t";
												String sqlWhere = " where t.BG_USER_05 = '"+customerName+"'";
												String orderby = " t.BG_BUG_ID ";
												//System.out.println("select "+backfields+" from "+fromSql+ sqlWhere);
											
												ArrayList xTableColumnList=new ArrayList();
												
												TableColumn xTableColumn_qc=new TableColumn();
												xTableColumn_qc.setColumn("BG_BUG_ID");
												xTableColumn_qc.setDataIndex("BG_BUG_ID");
												xTableColumn_qc.setHeader("QC号");
												xTableColumn_qc.setSortable(true);
												xTableColumn_qc.setHideable(true);
												xTableColumn_qc.setTarget("_fullwindow");
												xTableColumn_qc.setHref("/tdinfo/TdInfoDetail.jsp");
												xTableColumn_qc.setLinkkey("bug_id");
												xTableColumn_qc.setWidth(0.004); 
												xTableColumnList.add(xTableColumn_qc);
												
												TableColumn xTableColumn_desc=new TableColumn();
												xTableColumn_desc.setColumn("BG_summary");
												xTableColumn_desc.setDataIndex("BG_summary");
												xTableColumn_desc.setHeader("概述");
												xTableColumn_desc.setSortable(true);
												xTableColumn_desc.setHideable(true);
												xTableColumn_desc.setTarget("_fullwindow");
												xTableColumn_desc.setHref("/tdinfo/TdInfoDetail.jsp");
												xTableColumn_desc.setLinkkey("bug_id");
												xTableColumn_desc.setWidth(0.025); 
												xTableColumnList.add(xTableColumn_desc);
												
												
												TableColumn xTableColumn_status=new TableColumn();
												xTableColumn_status.setColumn("BG_STATUS");
												xTableColumn_status.setDataIndex("BG_STATUS");
												xTableColumn_status.setHeader("状态");
												xTableColumn_status.setSortable(true);
												xTableColumn_status.setHideable(true);
												xTableColumn_status.setWidth(0.005); 
												xTableColumnList.add(xTableColumn_status);
												
												TableColumn xTableColumn_do=new TableColumn();
												xTableColumn_do.setColumn("BG_RESPONSIBLE");
												xTableColumn_do.setDataIndex("BG_RESPONSIBLE");
												xTableColumn_do.setHeader("开发人");
												xTableColumn_do.setTransmethod("weaver.splitepage.transform.SptmForTDInfo.getTechnologyManager");
												xTableColumn_do.setPara_1("column:BG_RESPONSIBLE");
												xTableColumn_do.setSortable(true);
												xTableColumn_do.setHideable(true);
												xTableColumn_do.setWidth(0.005); 
												xTableColumnList.add(xTableColumn_do);
												
												TableColumn xTableColumn_test=new TableColumn();
												xTableColumn_test.setColumn("BG_DETECTED_BY");
												xTableColumn_test.setDataIndex("BG_DETECTED_BY");
												xTableColumn_test.setHeader("第一测试人");
												xTableColumn_test.setTransmethod("weaver.splitepage.transform.SptmForTDInfo.getTechnologyManager");
												xTableColumn_test.setPara_1("column:BG_DETECTED_BY");
												xTableColumn_test.setSortable(true);
												xTableColumn_test.setHideable(true);
												xTableColumn_test.setWidth(0.005); 
												xTableColumnList.add(xTableColumn_test);
												

												TableSql xTableSql=new TableSql();
												xTableSql.setBackfields(backfields);
												xTableSql.setPageSize(20);
												xTableSql.setSqlform(fromSql);
												xTableSql.setSqlwhere(sqlWhere);
												xTableSql.setSqlprimarykey("t.BG_BUG_ID");
												xTableSql.setSqlisdistinct("true");
												xTableSql.setSort(orderby);
												xTableSql.setDir(TableConst.DESC);
												xTableSql.setPoolname("ecologytd");

												Table xTable=new Table(request); 
												
												xTable.setTableGridType(TableConst.NONE);
												xTable.setTableNeedRowNumber(true);
												xTable.setTableSql(xTableSql);
												xTable.setTableColumnList(xTableColumnList);
											%>
											<%=xTable.toString4()%>
							</td>
						</tr>
					</TABLE>
				</td>
				<td></td>
			</tr>
		</table>
		</form>
	</BODY>
<script type="text/javascript">
function onRefresh(){
	_table.refresh();
}

document.onkeydown=keyListener;
function keyListener(e){
    e = e ? e : event;   
    if(e.keyCode == 13){    
    	frmMain.submit();    
    }    
}
function onShowQCUser(spanname,inputname,tempname){
	var id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/customersystem/qc/QCUserBrowser.jsp");
	try {
        jsid = new VBArray(id).toArray();
    } catch(e) {
        return;
    }
	if (jsid != null) {
        if (jsid[0] != "0" && jsid[1]!="") {
            document.all(spanname).innerHTML = jsid[1] + "&nbsp;" + jsid[0];
            document.all(inputname).value = jsid[1];
            document.all(tempname).value = jsid[1] + "&nbsp;" + jsid[0];
        } else {
            document.all(spanname).innerHTML = "";
            document.all(inputname).value = "";
            document.all(tempname).value = "";
        }
    }
}
</script>
</HTML>