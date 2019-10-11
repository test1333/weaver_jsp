<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="/workflow/exceldesign/css/excelHtml_wev8.css">
<style media=print type="text/css">  
 .noprint{display: none; }  
</style>
<style>
.checkbox {
	display: none
}
</style>
<style type="text/css">
	.tab {
		width:100%;
		text-align:center;
		border-width: 1px;
		border-style: solid;
		border-color: #a9c6c9;
		border-collapse: collapse;
	}
	.tab tr th{
		border-width: 1px;
		border-style: solid;
		border-color: #a9c6c9;
		border-collapse: collapse;
	}
	.tab tr td {
		border-width: 1px;
		border-style: solid;
		border-color: #a9c6c9;
		border-collapse: collapse;
	}
	.input11 {
        border: none;
        overflow: hidden;
        height: 100%;
        width: 85%;
    } 
</style>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
String rkdhcs = Util.null2String(request.getParameter("rkdhcs"));
String wplx = Util.null2String(request.getParameter("wplx"));

int userid = user.getUID();
String pageID = "whfpinfohis";
String mainid = "";



%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=pageID %>"/>
<input type="hidden" name="rownum" id="rownum" value="1"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
//RCMenu += "{提交,javascript:OnSearch2(),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
//RCMenu += "{修改发票,javascript:whfp(),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
//RCMenu += "{打印,javascript:printym(),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;

%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<div id="test1"  style="width:100%;height:2%;" ></div>
	<FORM id="insertInfo" name="insertInfo" action="/goodbaby/whfp/whfpInfoHistory.jsp" method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type="button" class="e8_btn_top_first" value="打印" title="打印" onclick="printym()" style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
					</td>
				</tr>
		</table>
	
		<div>

		<%-- <div >&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="增加行" onclick="addrow()" ></div> --%>
			<table id = "mytable" class = "tab">
				<tr>
					<th>发票号</th>
					<th>发票日期</th>
					<th>币种</th>
					<th>税率</th>					
					<th>发票金额（未税）</th>
					<th>税金</th>
					<th>发票金额（含税）</th>
					<th></th>
				</tr>	
				<tr class=DataDark>
						<td></td>
						<td></td>	
						<td></td>	
						<td></td>
						<td></td>
				</tr>	
					<%
					String mxsql = "select a.id,fphm,whsj,(select bz1 from uf_hl where id=a.bz) as bz,sl,fpjews,a.sj,fpze from uf_invoice a,uf_invoice_dt1 b where a.id=b.mainid and b.rkdh = '"+rkdhcs+"'";
					rs.executeSql(mxsql);
					//out.print(mxsql);
					while(rs.next()){
						mainid = Util.null2String(rs.getString("id"));
					%>
					<tr>
					<!--<td><input datatype="int" onafterpaste="if(isNaN(value))execCommand('undo')" style="ime-mode:disabled" viewtype="1" type="text" class="input11 InputStyle" id="fph_0" name="fph_0" onkeypress="ItemCount_KeyPress()" onblur="checkcount1(this);checkItemScale(this,'发票号码长度不能超过8位，请重新输入！',0,99999999);checkinput2('fph_0','fph_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fph_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>-->
						<td  width='150px'><%=Util.null2String(rs.getString("fphm"))%></td>
						<td width='110px'><%=Util.null2String(rs.getString("whsj"))%></td>
						<td  width='150px'><%=Util.null2String(rs.getString("bz"))%></td>
					
						<td  width='150px'><%=Util.null2String(rs.getString("sl"))%></td>
						<td  width='150px'><%=Util.null2String(rs.getString("fpjews"))%></td>
						<td  width='150px'><%=Util.null2String(rs.getString("sj"))%></td>
						<td  width='150px'><%=Util.null2String(rs.getString("fpze"))%></td>
						<td width="50px">&nbsp;</td>
					</tr>
		
					<%	
					}
					%>
				
				
							
			
			<%
				String fpjewshj = "";
				String fpsjhj = "";
				String fpjehj = "";
				mxsql = "select sum(convert(numeric(10,2),fpjews)) as fpjewshj,sum(convert(numeric(10,2),a.sj)) as fpsjhj,sum(convert(numeric(10,2),a.fpze)) as  fpjehj from uf_invoice a,uf_invoice_dt1 b where a.id=b.mainid and b.rkdh = '"+rkdhcs+"'";
				rs.executeSql(mxsql);
					//out.print(mxsql);
				if(rs.next()){
					fpjewshj = Util.null2String(rs.getString("fpjewshj"));
					fpsjhj = Util.null2String(rs.getString("fpsjhj"));
					fpjehj = Util.null2String(rs.getString("fpjehj"));
				}
			%>
				<tr>
					<!--<td><input datatype="int" onafterpaste="if(isNaN(value))execCommand('undo')" style="ime-mode:disabled" viewtype="1" type="text" class="input11 InputStyle" id="fph_0" name="fph_0" onkeypress="ItemCount_KeyPress()" onblur="checkcount1(this);checkItemScale(this,'发票号码长度不能超过8位，请重新输入！',0,99999999);checkinput2('fph_0','fph_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fph_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>-->
					<td  width='150px'></td>
					<td width='110px'></td>
					<td  width='150px'></td>
					<td  width='150px'></td>
					<td  width='150px'><div id="fpjewshj"><%=fpjewshj%></div></td>
					<td  width='150px'><div id="fpsjhj"><%=fpsjhj%></div></td>
					<td  width='150px'><div id="fpjehj"><%=fpjehj%></div></td>
					<td width="50px"></td>
				</tr>
			</table>
		
		</div>
		
		
		
		
	</FORM>
	
	<div id="test3"  style="width:100%;height:21%;" ></div>
	<div>
		<table class = "tab">
		<tr>
		<th>物料名称</th>
		<th>物料类型</th>
		<th>入库单号</th>
		<th>入库日期</th>
		<th>入库单位</th>
		<%if(!"flx".equals(wplx)){%>
		<th>入库数量</th>
	    <th>实际价格(含税)</th>
		<%}%>

		<th>税率</th>
		<th>税金</th>
		<th>未税金额</th>
		<th>含税金额</th>
		<th>币种</th>
		<th>汇率</th>
		<th>人民币金额(含税)</th>
		
		<th>仓库名称</th>
		<th>物料编码</th></tr>
<%
	String sql = "select (select wlmc from uf_materialDatas where id=a.wlmc) as wlmc,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id where un.id=a.wllx ) as lxmc,rkdh,rkrq,(select dw from uf_unitForms where id= a.rkdw) as rkdw,rksl,sjjg,taxname,sj,wsje,je,bz,hl,rmbje,(select CKMC from uf_stocks where id = a.ckmc) as ckmc ,wlbm from uf_invoice_dt1 a where a.mainid="+mainid;
	//out.print(sql);
	//String sql = "select tt.id,tt.xtgys,tt.wlmc,tt.WLMC_1,tt.cgsqd,tt.gys,tt.dwid,tt.RKDH,tt.SHCK,tt.rksj,tt.dw,tt.SJSHSL_1,tt.DJ_1,tt.JE_1,tt.ck,tt.WLBH_1,tt.lxmc,tt.lxid from (select a.id,a.xtgys,c.WLMC_1,c.gys,(select WLMC from uf_materialDatas where id = c.WLMC_1) as wlmc ,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj ,(select dw from uf_unitForms where id= (select DW from uf_materialDatas where id = c.WLMC_1)) as dw,(select DW from uf_materialDatas where id = c.WLMC_1)as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,(select CKMC from uf_stocks where id = a.SHCK) as ck,a.SHCK,c.WLBH_1,c.cgsqd from  "+tablename+" a join workflow_requestbase b on a.requestid=b.requestid join  "+tablename+"_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 ) tt where tt.id in("+ids+")select a.id,a.xtgys,c.WLMC_1,c.gys,(select WLMC from uf_materialDatas where id = c.WLMC_1) as wlmc ,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj ,(select dw from uf_unitForms where id= (select DW from uf_materialDatas where id = c.WLMC_1)) as dw,(select DW from uf_materialDatas where id = c.WLMC_1)as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,(select CKMC from uf_stocks where id = a.SHCK) as ck,a.SHCK,c.WLBH_1,c.cgsqd from  "+tablename+" a join workflow_requestbase b on a.requestid=b.requestid join  formtable_main_243_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 and a.id in("+ids+")";
	rs.executeSql(sql);
	float sum = (float) 0.00;
	float sum2 = (float) 0.00;
	float sumrmb = (float) 0.00;
	float sumsj = (float) 0.00;
	while(rs.next()){
		String wlmc = Util.null2String(rs.getString("wlmc"));
		String lxmc = Util.null2String(rs.getString("lxmc"));
		String rkdh = Util.null2String(rs.getString("rkdh"));
		String rkrq = Util.null2String(rs.getString("rkrq"));
		String rkdw = Util.null2String(rs.getString("rkdw"));//id		
		String rksl = Util.null2String(rs.getString("rksl"));
		String sjjg = Util.null2String(rs.getString("sjjg"));
		String taxname = Util.null2String(rs.getString("taxname"));
		String sj = Util.null2String(rs.getString("sj"));
		String wsje = Util.null2String(rs.getString("wsje"));
		String je = Util.null2String(rs.getString("je"));
		String bz = Util.null2String(rs.getString("bz"));
		String hl = Util.null2String(rs.getString("hl"));
		String rmbje = Util.null2String(rs.getString("rmbje"));

		String ckmc = Util.null2String(rs.getString("ckmc"));
		String wlbm = Util.null2String(rs.getString("wlbm"));
		
		if("".equals(wsje)){
			wsje = "0";
		}
		if("".equals(je)){
			je = "0";
		}
		if("".equals(rmbje)){
			rmbje = "0";
		}
		if("".equals(sj)){
			sj = "0.00";
		}
		sumsj = sumsj + Float.parseFloat(sj);
		//sum = sum + Float.parseFloat(JE_1);
		sum = sum + Float.parseFloat(wsje);
		sum2 = sum2 + Float.parseFloat(je);
		sumrmb = sumrmb + Float.parseFloat(rmbje);
		%>
		<tr>
			<td><%=wlmc%></td>
			<td><%=lxmc%></td>
			<td><%=rkdh%></td>
			<td><%=rkrq%></td>
			<td><%=rkdw%></td>
			<%if(!"flx".equals(wplx)){%>
			<td><%=rksl%></td>
			<td><%=sjjg%></td>
			<%}%>
			<td><%=taxname%></td>
			<td><%=sj%></td>
			<td><%=wsje%></td>
			<td><%=je%></td>
			<td><%=bz%></td>
			<td><%=hl%></td>
			<td><%=rmbje%></td>
			<td><%=ckmc%></td>
			<td><%=wlbm%></td>
		</tr>		
	<%
		}	
		DecimalFormat decimalFormat=new DecimalFormat(".00");
		String wsjeall=decimalFormat.format(sum);
		String jeall=decimalFormat.format(sum2);
		String rmball=decimalFormat.format(sumrmb);
		String sjall=decimalFormat.format(sumsj);
		if(".00".equals(wsjeall)){
			wsjeall = "0.00";
		}
		if(".00".equals(jeall)){
			jeall = "0.00";
		}
		if(".00".equals(rmball)){
			rmball = "0.00";
		}
		if(".00".equals(sjall)){
			sjall = "0.00";
		}
	%>
		<tr>
			<td style="text-align:right;font-weight:bold" >合计：</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<%if(!"flx".equals(wplx)){%>
			<td></td>
			<td></td>
			<%}%>
			<td></td>
			<td><%=sjall%></td>
			<td><%=wsjeall%></td>
			<td><%=jeall%></td>
			<td></td>
			<td></td>
			<td><%=rmball%></td>
			<td></td>
			<td></td>
		</tr>		
		
		</table>
	</div>
	<script type="text/javascript">	
	
		function printym(){
			window.print();
		}
	

	
	
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>

</BODY>
</HTML>