﻿<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="goodbaby.pz.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
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
  String out_pageId = "gnsreportrkdmxcx_1";
	String sql = "";
	String year = Util.null2String(request.getParameter("year"));
	String yf = Util.null2String(request.getParameter("yf"));
	String month = "";
	if(!"".equals(yf)&&!"".equals(year)){
		if(yf.length()<=1) {
			month=year+"0"+yf;
		}else{
			month=year+yf;
		}
	}
	String bm = Util.null2String(request.getParameter("bm"));
	String yjcbzx = Util.null2String(request.getParameter("yjcbzx"));
	String company = Util.null2String(request.getParameter("company"));
	//out.print("begindate"+begindate+" enddate"+enddate);
		
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
		//RCMenu += "{导出凭证,javascript:createpz(),_self} " ;
		RCMenu += "{导出Excel,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		
		RCMenuHeight += RCMenuHeightStep ; 
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/goodbaby/gnsbb/gns-report-rkdmxcx.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="flag1" value="1">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
		
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
					<wea:item>年份</wea:item>
					<wea:item>
						<brow:browser name='year'
						viewType='0'
						browserValue='<%=year%>'
						isMustInput='1'
						browserSpanValue='<%=year%>'
						hasInput='true'
						linkUrl=''
						completeUrl='/data.jsp?type=178'
						width='60%'
						isSingle='true'
						hasAdd='false'
						browserUrl='/systeminfo/BrowserMain.jsp?url=/workflow/field/Workflow_FieldYearBrowser.jsp?resourceids=#id#'>
						</brow:browser>
					</wea:item>
					<wea:item>月份</wea:item>
					<wea:item>
						<select class="e8_btn_top middle" name="yf" id="yf">
							<option value="" <%if("".equals(yf)){%> selected<%} %>>
								<%=""%></option>
							<option value="1" <%if("1".equals(yf)){%> selected<%} %>>
								<%="1月"%></option>
							<option value="2" <%if("2".equals(yf)){%> selected<%} %>>
								<%="2月"%></option>
							<option value="3" <%if("3".equals(yf)){%> selected<%} %>>
								<%="3月"%></option>
							<option value="4" <%if("4".equals(yf)){%> selected<%} %>>
								<%="4月"%></option>
							<option value="5" <%if("5".equals(yf)){%> selected<%} %>>
								<%="5月"%></option>						
							<option value="6" <%if("6".equals(yf)){%> selected<%} %>>
								<%="6月"%></option>
							<option value="7" <%if("7".equals(yf)){%> selected<%} %>>
								<%="7月"%></option>
							<option value="8" <%if("8".equals(yf)){%> selected<%} %>>
								<%="8月"%></option>
							<option value="9" <%if("9".equals(yf)){%> selected<%} %>>
								<%="9月"%></option>
							<option value="10" <%if("10".equals(yf)){%> selected<%} %>>
								<%="10月"%></option>
							<option value="11" <%if("11".equals(yf)){%> selected<%} %>>
								<%="11月"%></option>
							<option value="12" <%if("12".equals(yf)){%> selected<%} %>>
								<%="12月"%></option>


						</select>
				</wea:item>
				 <wea:item>账套</wea:item>
                <wea:item>
                    <select class="e8_btn_top middle" style="width:200px" name="company" id="company">
                    <option value="" <%if("".equals(company)){%> selected<%} %>>
                        <%=""%></option>
                    <%
                        sql = "select distinct dw from uf_company";
                        rs.executeSql(sql);
                        while(rs.next()){
                            String dw = Util.null2String(rs.getString("dw"));
                    %>
                    <option value="<%=dw%>" <%if(dw.equals(company)){%> selected<%} %>>
                        <%=dw%></option>
                    <%
                        }
                    %>
                    </select>
                 </wea:item>
				<wea:item>一级成本中心</wea:item>
				<wea:item>
					<brow:browser name='yjcbzx'
					viewType='0'
					browserValue='<%=yjcbzx%>'
					isMustInput='1'
					browserSpanValue='<%=yjcbzx%>'
					hasInput='true'
					linkUrl=''
					completeUrl=''
					width='60%'
					isSingle='true'
					hasAdd='false'
					browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.yjcbzx'>
					</brow:browser>
			 </wea:item>
				<wea:item>工厂</wea:item>
				<wea:item>
					<brow:browser name='bm'
					viewType='0'
					browserValue='<%=bm%>'
					isMustInput='1'
					browserSpanValue='<%=Util.toScreen(DepartmentComInfo.getDepartmentname(bm),user.getLanguage())%>'
					hasInput='true'
					linkUrl='/hrm/company/HrmDepartmentDsp.jsp?id='
					completeUrl='/data.jsp?type=4'
					width='60%'
					isSingle='true'
					hasAdd='false'
					browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
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
		String backfields = "a.requestid,(select (select distinct dw from uf_company where dwzt=t.ztdm) as ztmc from uf_yjcbzxdzb t where yjcbzxmc=(select yjcbzx from uf_cbzx where id=a.cbzx)) as ztmc,(select yjcbzx from uf_cbzx where id=a.cbzx) as yjcbzx,a.zjlbm,(select portalloginid from crm_customerinfo where id=a.xtgys) as gysbh,(select name from CRM_CustomerInfo where id=a.xtgys) as gysmc"+
											",(select CKMC from uf_stocks where id=a.shck) as shckmc,rkdh,(SUBSTRING(b.lastoperatedate,0,5)+SUBSTRING(b.lastoperatedate,6,2)) as cwny,b.lastoperatedate,c.wlbh_1,d.wlmc,(select dw from uf_unitForms where id=d.dw) as dw,c.SJSHSL_1,c.DJ_1,c.JE_1,cast(isnull(c.JE_1,0.00)*isnull(e.hl,1) as numeric(12,2)) as rmbje"+
											",case when (select count(1) from uf_invoice t, uf_invoice_dt1 t1 where t.id=t1.mainid and t1.rid=a.requestid)>0 then '是' else '否' end  as sfkp,(select top 1  (SUBSTRING(t1.lastoperatedate,0,5)+SUBSTRING(t1.lastoperatedate,6,2)) from formtable_main_273 t,workflow_requestbase t1,formtable_main_273_dt1 t2 where t.requestid=t1.requestid and t.id=t2.mainid and t1.currentnodetype=3 and t2.fphm in(select t5.id from uf_invoice t5, uf_invoice_dt1 t6 where t5.id=t6.mainid and t6.rid=a.requestid)) as rzrq,"+
											"(select taxname from uf_tax_rate where id=c.sl) as sl,(select bz1 from uf_hl where id=e.biz) as bz";
		String fromSql  =  " from formtable_main_235 a,workflow_requestbase b,formtable_main_235_dt1 c,uf_materialDatas d,formtable_main_234 e";
		String sqlWhere =  "a.requestid=b.requestid and a.id=c.mainid and c.WLMC_1=d.id and c.cgsqd=e.requestid and b.currentnodetype=3 ";	
		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		//fromSql = fromSql.replaceAll("<","&lt;");
		if(!"".equals(month)){
			sqlWhere +=" and (SUBSTRING(b.lastoperatedate,0,5)+SUBSTRING(b.lastoperatedate,6,2)) ='"+month+"' ";
		}
			if(!"".equals(bm)){
			sqlWhere +=" and a.zjlbm = '"+bm+"' ";
		}
		if(!"".equals(yjcbzx)){
			sqlWhere +=" and (select yjcbzx from uf_cbzx where id=a.cbzx) = '"+yjcbzx+"' ";
		}
		 if (!"".equals(company)) {
        sqlWhere += " and (select (select distinct dw from uf_company where dwzt=t.ztdm) as ztmc from uf_yjcbzxdzb t where yjcbzxmc=(select yjcbzx from uf_cbzx where id=a.cbzx)) = '" + company + "'";
    }
		String orderby =  "a.requestid"  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.requestid\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +=
		  "<col width=\"100px\" text=\"账套\" column=\"ztmc\" orderkey=\"ztmc\" />"+ 
			"<col width=\"100px\" text=\"一级成本中心\" column=\"yjcbzx\" orderkey=\"yjcbzx\" />"+ 
			"<col width=\"100px\" text=\"工厂\" column=\"zjlbm\" orderkey=\"zjlbm\"  transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+
			"<col width=\"100px\" text=\"供方编号\" column=\"gysbh\" orderkey=\"gysbh\"  />"+ 
			"<col width=\"120px\"  text=\"供方名称\" column=\"gysmc\" orderkey=\"gysmc\"  />"+		
			"<col width=\"120px\" text=\"仓库名称\" column=\"shckmc\" orderkey=\"shckmc\"  />"+ 
			"<col width=\"120px\" text=\"入库单号\" column=\"rkdh\" orderkey=\"rkdh\" />"+ 
			"<col width=\"100px\" text=\"财务年月\" column=\"cwny\" orderkey=\"cwny\"  />"+ 
			"<col width=\"100px\" text=\"入库日期\" column=\"lastoperatedate\" orderkey=\"lastoperatedate\"  />"+ 
			"<col width=\"100px\" text=\"物料代码\" column=\"wlbh_1\" orderkey=\"wlbh_1\"  />"+ 	 
			"<col width=\"100px\" text=\"物料名称\" column=\"wlmc\" orderkey=\"wlmc\"  />"+ 
			"<col width=\"100px\" text=\"入库单位\" column=\"dw\" orderkey=\"dw\"  />"+ 
			"<col width=\"100px\" text=\"入库数量\" column=\"SJSHSL_1\" orderkey=\"SJSHSL_1\"  />"+ 
			"<col width=\"100px\" text=\"采购单价\" column=\"DJ_1\" orderkey=\"DJ_1\"  />"+ 
			"<col width=\"100px\" text=\"采购金额\" column=\"JE_1\" orderkey=\"JE_1\"  />"+ 
			"<col width=\"100px\" text=\"金额人民币\" column=\"rmbje\" orderkey=\"rmbje\"  />"+ 
			"<col width=\"100px\" text=\"是否开票\" column=\"sfkp\" orderkey=\"sfkp\"  />"+ 
			"<col width=\"100px\" text=\"入账年月\" column=\"je9\" orderkey=\"rzrq\"  />"+ 
			"<col width=\"100px\" text=\"发票号\" column=\"requestid\" orderkey=\"requestid\"  transmethod=\"goodbaby.gns.bb.BbTransUtil.getFphm\"/>"+
			"<col width=\"100px\" text=\"税率\" column=\"je10\" orderkey=\"sl\"  />"+  
			"<col width=\"100px\" text=\"货币\" column=\"je10\" orderkey=\"bz\"  />"+  
			"<col width=\"100px\" text=\"付款凭证号\" column=\"requestid\" orderkey=\"requestid\"  transmethod=\"goodbaby.gns.bb.BbTransUtil.getfkpzh\"/>"+  
			"</head>"+
		 "</table>";
		
	//showExpExcel="false"
	%>
	<TABLE width="100%">
	  <tr>
		<td>
			<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="false"/>
		</td>
	  </tr>
	</TABLE>
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
		
		
		

	
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>