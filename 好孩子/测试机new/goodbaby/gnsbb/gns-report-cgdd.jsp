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
    String out_pageId = "gnsreportcgdd_1";
	String sql = "";
	
	String wlmc = Util.null2String(request.getParameter("wlmc"));

	String cgdl = Util.null2String(request.getParameter("cgdl"));
	String cgdlspan = "";
  if(!"".equals(cgdl)){
      sql = "select buydl from uf_buydl where id="+cgdl;
      rs.executeSql(sql);
      if(rs.next()){
          cgdlspan = Util.null2String(rs.getString("buydl"));
      }
  }
	String flag1 =Util.null2String(request.getParameter("flag1"));

	String yjcbzx = Util.null2String(request.getParameter("yjcbzx"));
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	String beginDate1 = Util.null2String(request.getParameter("beginDate1"));
	String endDate1 = Util.null2String(request.getParameter("endDate1"));
	String zt = Util.null2String(request.getParameter("zt"));
	String bm = Util.null2String(request.getParameter("bm"));
	String nppdl = Util.null2String(request.getParameter("nppdl"));
	String nppxl = Util.null2String(request.getParameter("nppxl"));
	String cbzx = Util.null2String(request.getParameter("cbzx"));
	String cbzxspan = "";
	 if(!"".equals(cbzx)){
      sql = "select cbzxbmmc from uf_cbzx where id="+cbzx;
      rs.executeSql(sql);
      if(rs.next()){
          cbzxspan = Util.null2String(rs.getString("cbzxbmmc"));
      }
  }
	GetGNSTableName gg = new GetGNSTableName();
	String lrktablename = gg.getTableName("RKD");
	String cgddtablename = gg.getTableName("CGDD");
	String cgsqtablename = gg.getTableName("CGSQ");
	//out.print("begindate"+begindate+" enddate"+enddate);
		if("".equals(flag1)&&userid!=1){
		sql = " select departmentid from hrmresource where id=dbo.emp_leaps_fuc_6("+userid+",50,1)";
		rs.executeSql(sql);
		if(rs.next()){
			bm = Util.null2String(rs.getString("departmentid"));
		}

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
		//RCMenu += "{导出凭证,javascript:createpz(),_self} " ;
		RCMenu += "{导出Excel,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		
		RCMenuHeight += RCMenuHeightStep ; 
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/goodbaby/gnsbb/gns-report-cgdd.jsp" method=post>
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
				<wea:item>50部门</wea:item>
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

				 <wea:item>采购大类</wea:item>
                <wea:item>
                    <brow:browser viewType="0" name="cgdl" id="cgdl"
                                  browserValue="<%=cgdl%>"
                                  browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.btn_buydl01"
                                  hasInput="true" hasBrowser="true" isMustInput='1'
                                  isSingle="false"
                                  width="165px"
                                  linkUrl=""
                                  browserSpanValue="<%=cgdlspan%>">
                    </brow:browser>
          </wea:item>
					<wea:item>NPP大类</wea:item>
				<wea:item>
					<brow:browser name='nppdl'
					viewType='0'
					browserValue='<%=nppdl%>'
					isMustInput='1'
					browserSpanValue='<%=nppdl%>'
					hasInput='true'
					linkUrl=''
					completeUrl=''
					width='60%'
					isSingle='true'
					hasAdd='false'
					browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.nppBIG'>
					</brow:browser>
			 </wea:item>
			 <wea:item>NPP小类</wea:item>
				<wea:item>
					<brow:browser name='nppxl'
					viewType='0'
					browserValue='<%=nppxl%>'
					isMustInput='1'
					browserSpanValue='<%=nppxl%>'
					hasInput='true'
					linkUrl=''
					completeUrl=''
					width='60%'
					isSingle='true'
					hasAdd='false'
					browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.NPP'>
					</brow:browser>
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
			 	<wea:item>成本中心</wea:item>
				<wea:item>
					<brow:browser name='cbzx'
					viewType='0'
					browserValue='<%=cbzx%>'
					isMustInput='1'
					browserSpanValue='<%=cbzxspan%>'
					hasInput='true'
					linkUrl=''
					completeUrl=''
					width='60%'
					isSingle='true'
					hasAdd='false'
					browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.cbzx'>
					</brow:browser>
			 </wea:item>
					<wea:item>状态</wea:item>
					<wea:item>
						<select class="e8_btn_top middle" name="zt" id="zy">
							<option value="" <%if("".equals(zt)){%> selected<%} %>>
								<%=""%></option>
							<option value="0" <%if("0".equals(zt)){%> selected<%} %>>
								<%="发起"%></option>
							<option value="1" <%if("1".equals(zt)){%> selected<%} %>>
								<%="审批中"%></option>
							<option value="2" <%if("2".equals(zt)){%> selected<%} %>>
								<%="审批完成"%></option>
						


						</select>
					</wea:item>
			
				<wea:item>物料名称</wea:item>
				<wea:item>
                 <input name="wlmc" id="wlmc" class="InputStyle" type="text" value="<%=wlmc%>"/>
        </wea:item>
				<wea:item>下达日期</wea:item>
                <wea:item>
                    <button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON>
                        <SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN>
                        <INPUT type="hidden" name="beginDate" id="beginDate" value="<%=beginDate%>">
                    &nbsp;-&nbsp;
                    <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON>
                        <SPAN id=endDateSpan><%=endDate%></SPAN>
                        <INPUT type="hidden" name="endDate" id="endDate" value="<%=endDate%>">
        </wea:item>
				<wea:item>交货日期</wea:item>
                <wea:item>
                    <button type="button" class=Calendar id="selectBeginDate1" onclick="onshowPlanDate('beginDate1','selectBeginDateSpan1')"></BUTTON>
                        <SPAN id=selectBeginDateSpan1 ><%=beginDate1%></SPAN>
                        <INPUT type="hidden" name="beginDate1" id="beginDate1" value="<%=beginDate1%>">
                    &nbsp;-&nbsp;
                    <button type="button" class=Calendar id="selectEndDate1" onclick="onshowPlanDate('endDate1','endDateSpan1')"></BUTTON>
                        <SPAN id=endDateSpan1><%=endDate1%></SPAN>
                        <INPUT type="hidden" name="endDate1" id="endDate1" value="<%=endDate1%>">
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
		String backfields = "b.zjlbm,b.requestid,(select (select bmenu from uf_NPP where id=wllx)  from uf_materialDatas where id=b.WLMC) as wllxname,(select buydl from uf_buydl where id=b.cgdl) as cgdl,b.wllx,(select yjcbzx from uf_cbzx where id=b.cbzx) as yjcbzx,(select cbzxbmmc from uf_cbzx where id=b.cbzx) as CBZX,dbo.get_gns_fykm(isnull(b.fykm,''),b.cbzx,b.WLMC,'0') as fykm,dbo.get_gns_fykm(isnull(b.fykm,''),b.cbzx,b.WLMC,'1') as kmdm,(select selectname from workflow_billfield a, workflow_bill t,workflow_selectitem c where a.billid=t.id and c.fieldid=a.id  and t.tablename='"+cgsqtablename+"' and a.fieldname='SFYYS' and selectvalue=(select t1.SFYYS from "+cgsqtablename+" t1,"+cgsqtablename+"_dt1 t2 where t1.id=t2.mainid and t2.id=b.dtid)) as SFYYS,(select t1.cgsqdbh from "+cgsqtablename+" t1,"+cgsqtablename+"_dt1 t2 where t1.id=t2.mainid and t2.id=b.dtid "+
					" ) as cgsqdbh,b.DDBH ,b.WLBM,(select wlmc from uf_materialDatas where id=b.WLMC) as WLMC,(select pp from uf_gfdzb where id=b.pinpai) as pinpai,b.XH,b.GG,(select dw from uf_unitForms where id=b.dw) as DW,b.DJ, b.CGSL,cast(isnull(b.DJ,0)*isnull(b.CGSL,0) as numeric(10,2)) as HJYBJE,(select taxname from uf_tax_rate where id=b.taxRate) as taxRate,(select bz1 from uf_hl where id=b.BIZ) as biz,b.HL,a.createdate "+
					" ,YQJHRQ,b.cgsl-(select isnull(sum(isnull(sjshsl_1,0)),0) from "+lrktablename+" t1,"+lrktablename+"_dt1 t2,workflow_requestbase t3 where t1.id=t2.mainid and t3.requestid=t1.requestid and t2.cgsqd=a.requestid and t3.currentnodetype>=3) as wjhsl, (select isnull(sum(isnull(sjshsl_1,0)),0) from "+lrktablename+" t1,"+lrktablename+"_dt1 t2,workflow_requestbase t3 where t1.id=t2.mainid and t3.requestid=t1.requestid and t2.cgsqd=a.requestid and t3.currentnodetype>=3) as rksl "+
					" ,SQRXX,	(select gysmc from uf_suppmessForm where id=b.gysmc) as GYSMC,'' as sfbgz,case when a.currentnodetype=3 then '审批完成' when a.currentnodetype=0 then '发起' else '审批中' end as zt,SQRXX as cgy,SHDW,SHR,(select mobile from hrmresource where id=b.shr) as shrdh,YSBH,case when b.cgdl='2' then b.wlbm else '' end as gdzcbh,'' as yz,''as gzrq,'' as ysynx,'' as ysynx1,'' as ytzj,'' as jz,'' as cssr,''as czss";
		String fromSql  =  " from workflow_requestbase a,"+cgddtablename+" b";
		String sqlWhere =  " a.requestid=b.requestid ";
		if(!"".equals(bm)){
			sqlWhere +=" and b.zjlbm = '"+bm+"' ";
		}
		if(!"".equals(cgdl)){
			sqlWhere +=" and b.cgdl = '"+cgdl+"' ";
		}
			if(!"".equals(nppxl)){
			sqlWhere +=" and (select wllx from uf_materialDatas where id=b.WLMC) ='"+nppxl+"' ";
		}
		if(!"".equals(nppdl)){
			sqlWhere +=" and (select (select zml from uf_NPP where id=wllx)  from uf_materialDatas where id=b.WLMC) ='"+nppdl+"' ";
		}
		if(!"".equals(yjcbzx)){
			sqlWhere +=" and (select yjcbzx from uf_cbzx where id=b.cbzx) = '"+yjcbzx+"' ";
		}
		if(!"".equals(cbzx)){
			sqlWhere +=" and b.cbzx = '"+cbzx+"' ";
		}
		if(!"".equals(zt)){
			if("0".equals(zt)){
				sqlWhere +=" and a.currentnodetype = 0 ";
			}else if("1".equals(zt)){
				sqlWhere +=" and a.currentnodetype in(1,2) ";
			}else{
				sqlWhere +=" and a.currentnodetype >= 3 ";
			}
			
		}
		if(!"".equals(wlmc)){
			sqlWhere +=" and (select wlmc from uf_materialDatas where id=b.WLMC) like '%"+wlmc+"%' ";
		}
		if(!"".equals(beginDate)){
			sqlWhere +=" and a.createdate >='"+beginDate+"' ";
		}
		if(!"".equals(endDate)){
			sqlWhere +=" and a.createdate <='"+endDate+"' ";
		}
		if(!"".equals(beginDate1)){
			sqlWhere +=" and yqjhrq >='"+beginDate1+"' ";
		}
		if(!"".equals(endDate1)){
			sqlWhere +=" and yqjhrq <='"+endDate1+"' ";
		}
		
	

		
		
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "b.requestid "  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"b.requestid\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"200px\" text=\"部门\" column=\"sqrxx\" orderkey=\"sqrxx\"  transmethod=\"goodbaby.gns.bb.BbTransUtil.getPersonAllDepartmentName\"/>"+
		  "<col width=\"100px\" text=\"50部门\" column=\"zjlbm\" orderkey=\"zjlbm\"  transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+
		  "<col width=\"100px\" text=\"采购类型\" column=\"cgdl\" orderkey=\"cgdl\"  />"+ 
			"<col width=\"100px\" text=\"物料类型\" column=\"wllxname\" orderkey=\"wllxname\" />"+ 
			"<col width=\"100px\" text=\"一级成本中心\" column=\"yjcbzx\" orderkey=\"yjcbzx\"  />"+ 
			"<col width=\"100px\" text=\"成本中心\" column=\"cbzx\" orderkey=\"cbzx\"  />"+ 
			"<col width=\"100px\" text=\"科目\" column=\"fykm\" orderkey=\"fykm\"  />"+ 
			"<col width=\"100px\" text=\"科目代码\" column=\"kmdm\" orderkey=\"kmdm\"  />"+ 
			"<col width=\"100px\" text=\"是否有预算\" column=\"sfyys\" orderkey=\"sfyys\"  />"+ 
			"<col width=\"100px\" text=\"采购申请编号\" column=\"cgsqdbh\" orderkey=\"cgsqdbh\"  />"+ 
			"<col width=\"100px\"  text=\"订单编号\" column=\"ddbh\" orderkey=\"ddbh\"  />"+
			"<col width=\"100px\"  text=\"物料代码\" column=\"wlbm\" orderkey=\"wlbm\" />"+
			"<col width=\"100px\" text=\"物料名称\" column=\"wlmc\" orderkey=\"wlmc\"  />"+ 
			"<col width=\"100px\" text=\"品牌\" column=\"pinpai\" orderkey=\"pinpai\"  />"+ 	
			"<col width=\"100px\" text=\"型号\" column=\"xh\" orderkey=\"xh\"  />"+ 		
			"<col width=\"100px\" text=\"规格\" column=\"GG\" orderkey=\"GG\"  />"+ 
			"<col width=\"100px\" text=\"单位\" column=\"DW\" orderkey=\"DW\"  />"+ 
			"<col width=\"100px\" text=\"P0/单价\" column=\"DJ\" orderkey=\"DJ\"  />"+ 
			"<col width=\"100px\" text=\"订单数量\" column=\"cgsl\" orderkey=\"cgsl\"  />"+ 
			"<col width=\"100px\" text=\"金额\" column=\"hjybje\" orderkey=\"hjybje\"  />"+ 
			"<col width=\"100px\" text=\"税率\" column=\"taxRate\" orderkey=\"taxRate\"  />"+ 
			"<col width=\"100px\" text=\"币种\" column=\"biz\" orderkey=\"biz\"  />"+ 
			"<col width=\"100px\" text=\"汇率\" column=\"hl\" orderkey=\"hl\"  />"+ 		
			"<col width=\"100px\" text=\"下达日期\" column=\"createdate\" orderkey=\"createdate\"  />"+ 	
			"<col width=\"100px\" text=\"要求交货日期\" column=\"yqjhrq\" orderkey=\"yqjhrq\"  />"+ 
			"<col width=\"100px\" text=\"未交货数量\" column=\"wjhsl\" orderkey=\"wjhsl\"  />"+ 
			"<col width=\"100px\" text=\"入库数量\" column=\"rksl\" orderkey=\"rksl\"  />"+ 
			"<col width=\"100px\" text=\"申请人\" column=\"sqrxx\" orderkey=\"sqrxx\"  transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/>"+ 
			"<col width=\"100px\" text=\"供方名称\" column=\"gysmc\" orderkey=\"gysmc\"  />"+ 
			"<col width=\"100px\" text=\"是否变更中\" column=\"sfbgz\" orderkey=\"sfbgz\"  />"+ 
			"<col width=\"100px\" text=\"采购员\" column=\"cgy\" orderkey=\"cgy\"   transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/>"+ 
			"<col width=\"100px\" text=\"收货地址\" column=\"shdw\" orderkey=\"shdw\"  />"+ 
			"<col width=\"100px\" text=\"收货人\" column=\"shr\" orderkey=\"shr\"  transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/>"+ 
			"<col width=\"100px\" text=\"收货人电话\" column=\"shrdh\" orderkey=\"shrdh\"  />"+ 
			"<col width=\"100px\" text=\"状态\" column=\"zt\" orderkey=\"zt\"  />"+ 
			"<col width=\"100px\" text=\"预算编号\" column=\"ysbh\" orderkey=\"ysbh\"  />"+ 
			"<col width=\"100px\" text=\"固定资产编号\" column=\"gdzcbh\" orderkey=\"gdzcbh\"  />"+ 
			"<col width=\"100px\" text=\"原值\" column=\"yz\" orderkey=\"yz\"  />"+
			"<col width=\"100px\" text=\"购置日期\" column=\"gzrq\" orderkey=\"gzrq\"  />"+
			"<col width=\"100px\" text=\"原使用年限\" column=\"ysynx\" orderkey=\"ysynx\"  />"+
			"<col width=\"100px\" text=\"已使用年限\" column=\"ysynx1\" orderkey=\"ysynx1\"  />"+
			"<col width=\"100px\" text=\"已提折旧\" column=\"ytzj\" orderkey=\"ytzj\"  />"+
			"<col width=\"100px\" text=\"净值\" column=\"jz\" orderkey=\"jz\"  />"+
			"<col width=\"100px\" text=\"出售收入\" column=\"cssr\" orderkey=\"cssr\"  />"+
			"<col width=\"100px\" text=\"处置损失\" column=\"czss\" orderkey=\"czss\"  />"+
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