<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<%@ page import="goodbaby.pz.GetGNSTableName"%>
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
float sums =(float)0.00;
String ids = Util.null2String(request.getParameter("ids"));
String types = Util.null2String(request.getParameter("type"));
String wplx = Util.null2String(request.getParameter("wplx"));

int userid = user.getUID();
String pageID = "whfpinfo1";
String fphj = Util.null2String(request.getParameter("fphj"));
String fphm = Util.null2String(request.getParameter("fphm"));
String gsyids = Util.null2String(request.getParameter("gsyid"));
String xtgysids = Util.null2String(request.getParameter("xtgysid"));
GetGNSTableName gg = new GetGNSTableName();
String tablename = gg.getTableName("RKD");
String cgddtable = gg.getTableName("CGDD");//订单
String kjtable =  gg.getTableName("FKJHT");//非框架合同
String zjlbm = "";
String yjcbzx = "";
String fpbz = "";
String fpbzid = "";
String fpsl ="";
String sql_dt = "";
String fpslname = "";
String gsmc = "";
String gssh = "";
String zjlsql = "select zjlbm,(select yjcbzx from uf_cbzx where id=a.cbzx) as yjcbzx  from "+tablename+" a where id in("+ids+")";
//out.print(zjlsql);
rs.executeSql(zjlsql);
while(rs.next()){
	if(!"".equals(zjlbm)){
		break;
	}
	yjcbzx = Util.null2String(rs.getString("yjcbzx"));
	zjlbm = Util.null2String(rs.getString("zjlbm"));
}
zjlsql = "select gsmc,gssh from uf_yjcbzxdzb where yjcbzxmc='"+yjcbzx+"'";
rs.executeSql(zjlsql);
if(rs.next()){
	gsmc = Util.null2String(rs.getString("gsmc"));
	gssh = Util.null2String(rs.getString("gssh"));
}


zjlsql = "select (select bz1 from uf_hl where id=c.BIZ) as bz,c.biz  from "+tablename+" a, "+tablename+"_dt1 b,"+cgddtable+" c  where a.id=b.mainid and b.cgsqd=c.requestid and a.id in("+ids+")";
rs.executeSql(zjlsql);
while(rs.next()){
	if(!"".equals(fpbz)){
		break;
	}
	fpbz = Util.null2String(rs.getString("bz"));
	fpbzid = Util.null2String(rs.getString("biz"));
}

zjlsql = "select (select taxname from uf_tax_rate where id=c.taxRate) as taxname,(select rate from uf_tax_rate where id=c.taxRate) as rate from "+tablename+" a, "+tablename+"_dt1 b,"+cgddtable+" c  where a.id=b.mainid and b.cgsqd=c.requestid and a.id in("+ids+")";
rs.executeSql(zjlsql);
while(rs.next()){
	if(!"".equals(fpsl)){
		break;
	}
	fpsl = Util.null2String(rs.getString("rate"));
	fpslname = Util.null2String(rs.getString("taxname"));
}
if(!"人民币".equals(fpbz)&&!"".equals(fpbz)){
	fpslname = "0%";
	fpsl = "0.00";
}
//if(fphm.length()>4){
//	String mainid = "";
//	String sql1 = "insert into uf_invoice(gys,xtkh,fphm,fpze,whsj,formmodeid,modedatacreater,fplx) values ('"+gsyids+"','"+xtgysids+"','"+fphm+"','"+fphj+"',CONVERT(varchar(10),GETDATE(),120),60,1,1)";
	//out.print("sql1----"+sql1+"----");
//	rs.executeSql(sql1);
//	sql1 = "select max(id) as mid from uf_invoice where gys='"+gsyids+"' and fphm = '"+fphm+"'  ";
//	rs.executeSql(sql1);
//	if(rs.next()){
//		mainid = rs.getString("mid");
//	}
//	ModeRightInfo modeRightInfo = new ModeRightInfo();
//	modeRightInfo.editModeDataShare(1, 60, Integer.parseInt(mainid));
//	modeRightInfo.editModeDataShareForModeField(1, 60, Integer.parseInt(mainid));
//	String sql2 = "select tt.id,tt.xtgys,tt.WLMC_1,tt.requestid,tt.cgsqd,tt.gys,tt.dwid,tt.RKDH,tt.SHCK,tt.rksj,tt.SJSHSL_1,tt.DJ_1,tt.JE_1,tt.WLBH_1,tt.lxmc,tt.lxid from (select a.id,a.requestid,a.xtgys,c.WLMC_1,c.gys,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select WLLX from  uf_materialDatas um where um.id =c.WLMC_1)as npplx,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj,(select DW from uf_materialDatas where id = c.WLMC_1)as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,a.SHCK,c.WLBH_1,c.cgsqd from "+tablename+" a join workflow_requestbase b on a.requestid=b.requestid join  "+tablename+"_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 ) tt where tt.id in("+ids+")";
//	rs.executeSql(sql2);
//	while(rs.next()){
//		String id = Util.null2String(rs.getString("id"));
//		String xtgys = Util.null2String(rs.getString("xtgys"));//id
//		String WLMC_1 = Util.null2String(rs.getString("WLMC_1"));//id
//		String RKDH = Util.null2String(rs.getString("RKDH"));
//		String rksj = Util.null2String(rs.getString("rksj"));
//		String dwid = Util.null2String(rs.getString("dwid"));//id
//		String SJSHSL_1 = Util.null2String(rs.getString("SJSHSL_1"));
//		String DJ_1 = Util.null2String(rs.getString("DJ_1"));
//		String JE_1 = Util.null2String(rs.getString("JE_1"));
//		String ckid = Util.null2String(rs.getString("SHCK"));//id
//		String WLBH_1 = Util.null2String(rs.getString("WLBH_1"));
//		String lxmc = Util.null2String(rs.getString("lxmc"));
//		String lxid = Util.null2String(rs.getString("lxid"));
//		String npplx = Util.null2String(rs.getString("npplx"));
//		String cgsqd = Util.null2String(rs.getString("cgsqd"));		
//		String ddlc = Util.null2String(rs.getString("cgsqd"));
//		String rid = Util.null2String(rs.getString("requestid"));
//		String str ="insert into uf_invoice_dt1 (wlmc,wlbm,wllx,wllx1,rkdh,rkrq,rkdw,rksl,sjjg,ckmc,ddlc,rid,mainid) values('"+WLMC_1+"','"+WLBH_1+"','"+npplx+"','"+lxid+"','"+RKDH+"','"+rksj+"','"+dwid+"','"+SJSHSL_1+"','"+DJ_1+"','"+ckid+"','"+ddlc+"','"+rid+"','"+mainid+"')";
//		rs.executeSql(str);		
		//out.print("str----"+str+"----");
//	}
	
//}

%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
<input type="hidden" name="rownum" id="rownum" value="1"/>
<input type="hidden" name="mustfileds" id="mustfileds" value="fph_0,fprq_0,fpsl_0,fpjews_0,fpsj_0,fpje_0"/>
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
	<FORM id="insertInfo" name="insertInfo" action="/goodbaby/whfp/whfpInfo.jsp" method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type="button" class="e8_btn_top_first"  value="提交" title="提交"  onclick="OnSearch2()" style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
						<input type="button" class="e8_btn_top_first" value="打印" title="打印" onclick="printym()" style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
					</td>
				</tr>
		</table>
		<input type = "hidden" id ="fphj" name="fphj" value="<%=sums%>"/>
		<input type = "hidden" id ="fpsl" name="fpsl" value="<%=fpsl%>"/>
	
		<div>

		<%-- <div >&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="增加行" onclick="addrow()" ></div> --%>
		<div id="div0button" class="noprint"  style="width:103px; "> 
		&nbsp;&nbsp;&nbsp;&nbsp;
     <button class="addbtn_p" type="button" id="addbutton0" name="addbutton0" onclick="addrow();return false;" title="添加"></button> 
    </div>
			<table id = "mytable" class = "tab">
				<tr>
					<th>发票号</th>
					<th>发票日期</th>
					<th>币种</th>
					<th>税率</th>					
					<th>发票金额（未税）</th>
					<th>税金</th>
					<th>发票金额（含税）</th>
					<th>操作</th>
				</tr>		
					<%
					String mxsql = "select a.xtgys,(select 	GYSMC from uf_suppmessForm where id =c.gys) as gysmc,c.gys from  "+tablename+" a join workflow_requestbase b on a.requestid=b.requestid join  "+tablename+"_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 and a.id in ("+ids+")";
					rs.executeSql(mxsql);
					//out.print(mxsql);
					if(rs.next()){
						String gysmc = Util.null2String(rs.getString("gysmc"));
						String gsyid = Util.null2String(rs.getString("gys"));
						String xtgysid = Util.null2String(rs.getString("xtgys"));
						
					%>
					<tr class=DataDark>
						<td><input type="hidden" name="gsyid" id="gsyid" class="InputStyle" value="<%=gsyid%>"/></td>
						<td><input type="hidden" name="xtgysid" id="xtgysid" class="InputStyle" value="<%=xtgysid%>"/></td>	
						<td><input type="hidden" name="ids" id="ids" class="InputStyle" value="<%=ids%>"/></td>	
						<td></td>
						<td></td>
					</tr>
		
					<%	
					}
					%>
				
				<tr>
					<!--<td><input datatype="int" onafterpaste="if(isNaN(value))execCommand('undo')" style="ime-mode:disabled" viewtype="1" type="text" class="input11 InputStyle" id="fph_0" name="fph_0" onkeypress="ItemCount_KeyPress()" onblur="checkcount1(this);checkItemScale(this,'发票号码长度不能超过8位，请重新输入！',0,99999999);checkinput2('fph_0','fph_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fph_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>-->
					<td  width='150px'><input datatype="text" style="ime-mode:disabled" viewtype="1" type="text" class="input11 InputStyle" id="fph_0" name="fph_0" onkeyup="this.value=this.value.replace(/[^0-9a-zA-Z\-]/g,'')" onblur="checkinput2('fph_0','fph_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fph_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>
					<td width='110px'>&nbsp;&nbsp;<button type="button" class=Calendar id="selectfprq_0" onclick="onshowPlanDate('fprq_0','fprq_0Span')"></BUTTON>
                        <SPAN id="fprq_0Span" ><img src="/images/BacoError_wev8.gif" align="absMiddle"></SPAN>
                        <INPUT type="hidden" name="fprq_0" id="fprq_0" value="">
					</td>
					<td  width='150px'> <input class="input11" type="text" id="bz_0" value="<%=fpbz%>" disabled/></td>
				
					<td  width='150px'><input datalength="2" datatype="float" style="ime-mode:disabled" onafterpaste="if(isNaN(value))execCommand('undo')" viewtype="1" type="text" class="input11 InputStyle" id="fpsl_0" name="fpsl_0" onkeypress="ItemDecimal_KeyPress('fpsl_0',15,2)" onblur="checkFloat(this);checkinput2('fpsl_0','fpsl_0span',this.getAttribute('viewtype'))" value="<%=fpsl%>" onchange="" onpropertychange="" _listener=""><span id="fpsl_0span" style="word-break:break-all;word-wrap:break-word"></span></td>
					<td  width='150px'><input datalength="2" datatype="float" style="ime-mode:disabled" onafterpaste="if(isNaN(value))execCommand('undo')" viewtype="1" type="text" class="input11 InputStyle" id="fpjews_0" name="fpjews_0" onkeypress="ItemDecimal_KeyPress('fpjews_0',15,2)" onblur="checkFloat(this);checkinput2('fpjews_0','fpjews_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fpjews_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>
					<td  width='150px'><input datalength="2" datatype="float" style="ime-mode:disabled" onafterpaste="if(isNaN(value))execCommand('undo')" viewtype="1" type="text" class="input11 InputStyle" id="fpsj_0" name="fpsj_0" onkeypress="ItemDecimal_KeyPress('fpsj_0',15,2)" onblur="checkFloat(this);checkinput2('fpsj_0','fpsj_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fpsj_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>
					<td  width='150px'> <input class="input11" type="text" id="fpje_0" value="" readonly/></td>
					<td width="50px">&nbsp;&nbsp;<a href="#" onclick="delrow(this,0)">删除</a>&nbsp;&nbsp;</td>
				</tr>
				
			
			
			
			</table>
			<table id = "mytable2" class = "tab">
			<tr id="heji1">
					<!--<td><input datatype="int" onafterpaste="if(isNaN(value))execCommand('undo')" style="ime-mode:disabled" viewtype="1" type="text" class="input11 InputStyle" id="fph_0" name="fph_0" onkeypress="ItemCount_KeyPress()" onblur="checkcount1(this);checkItemScale(this,'发票号码长度不能超过8位，请重新输入！',0,99999999);checkinput2('fph_0','fph_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fph_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>-->
					<td  width='150px'></td>
					<td width='110px'></td>
					<td  width='150px'></td>
					<td  width='150px'></td>
					<td  width='150px'><div id="fpjewshj">0.00</div></td>
					<td  width='150px'><div id="fpsjhj">0.00</div></td>
					<td  width='150px'><div id="fpjehj">0.00</div></td>
					<td width="50px"></td>
				</tr>
			</table>
		
		</div>
		<div style="font-weight:bold;" >开票单位：<%=gsmc%>&nbsp;&nbsp;税号：<%=gssh%></div>
		
		
		
		
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
	String sql = "select a.id,a.xtgys,c.WLMC_1,c.gys,d.wlmc ,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id where un.id=d.wllx ) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id where un.id=d.wllx ) as lxid,a.RKDH,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj ,(select dw from uf_unitForms where id= d.dw) as dw,d.dw as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,(select CKMC from uf_stocks where id = a.SHCK) as ck,a.SHCK,c.WLBH_1,c.cgsqd  "
				+" ,e.HL,e.taxRate,(select taxname from uf_tax_rate where id=e.taxRate) as taxname,e.BIZ,(select bz1 from uf_hl where id=e.BIZ) as bz,  cast(round(isnull(c.JE_1,0)/(1+isnull((select rate from uf_tax_rate where id=e.taxRate),0)),2)   as   numeric(12,2)) as wsje,contactDtId,(select rate from uf_tax_rate where id=e.taxRate) as rate "
				+" from  "+tablename+" a , workflow_requestbase b ,"+tablename+"_dt1 c ,uf_materialDatas d,"+cgddtable+" e"
				+" where  a.requestid=b.requestid"
				+" and c.mainid = a.id "
				+" and c.cgsqd=e.requestid"
				+" and c.wlmc_1 = d.id"
				+" and b.currentnodetype >= 3 "
				+" and a.id in("+ids+")";
	//out.print(sql);
	//String sql = "select tt.id,tt.xtgys,tt.wlmc,tt.WLMC_1,tt.cgsqd,tt.gys,tt.dwid,tt.RKDH,tt.SHCK,tt.rksj,tt.dw,tt.SJSHSL_1,tt.DJ_1,tt.JE_1,tt.ck,tt.WLBH_1,tt.lxmc,tt.lxid from (select a.id,a.xtgys,c.WLMC_1,c.gys,(select WLMC from uf_materialDatas where id = c.WLMC_1) as wlmc ,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj ,(select dw from uf_unitForms where id= (select DW from uf_materialDatas where id = c.WLMC_1)) as dw,(select DW from uf_materialDatas where id = c.WLMC_1)as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,(select CKMC from uf_stocks where id = a.SHCK) as ck,a.SHCK,c.WLBH_1,c.cgsqd from  "+tablename+" a join workflow_requestbase b on a.requestid=b.requestid join  "+tablename+"_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 ) tt where tt.id in("+ids+")select a.id,a.xtgys,c.WLMC_1,c.gys,(select WLMC from uf_materialDatas where id = c.WLMC_1) as wlmc ,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj ,(select dw from uf_unitForms where id= (select DW from uf_materialDatas where id = c.WLMC_1)) as dw,(select DW from uf_materialDatas where id = c.WLMC_1)as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,(select CKMC from uf_stocks where id = a.SHCK) as ck,a.SHCK,c.WLBH_1,c.cgsqd from  "+tablename+" a join workflow_requestbase b on a.requestid=b.requestid join  formtable_main_243_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 and a.id in("+ids+")";
	rs.executeSql(sql);
	String sum = "0.00";
	String sum2 =  "0.00";
	String sumrmb = "0.00";
	String sumsj =  "0.00";
	while(rs.next()){
		String id = Util.null2String(rs.getString("id"));
		String xtgys = Util.null2String(rs.getString("xtgys"));//id
		String wlmc = Util.null2String(rs.getString("wlmc"));
		String WLMC_1 = Util.null2String(rs.getString("WLMC_1"));//id
		String RKDH = Util.null2String(rs.getString("RKDH"));
		String rksj = Util.null2String(rs.getString("rksj"));
		String dw = Util.null2String(rs.getString("dw"));
		String dwid = Util.null2String(rs.getString("dwid"));//id		
		String SJSHSL_1 = Util.null2String(rs.getString("SJSHSL_1"));
		String DJ_1 = Util.null2String(rs.getString("DJ_1"));
		String JE_1 = Util.null2String(rs.getString("JE_1"));
		String HL = Util.null2String(rs.getString("HL"));
		String taxname = Util.null2String(rs.getString("taxname"));
		String bz = Util.null2String(rs.getString("bz"));
		String wsje = Util.null2String(rs.getString("wsje"));
		String rate = Util.null2String(rs.getString("rate"));
		String sj = "0.00";
		String rmbje = "0.00";
		String contactDtId =  Util.null2String(rs.getString("contactDtId"));
		
		if("".equals(rate)){
			rate = "0";
		}
		if(DJ_1.length()<1){
			DJ_1 = "0.00";
		}
	
		if("".equals(HL)){
			HL="1.0000";
		}
		if("flx".equals(wplx)){
			JE_1 = "0.00";
			sql_dt = "select fkje,cast(round(isnull(fkje,0)/(1+"+rate+"),2)   as   numeric(12,2)) as wsje from "+kjtable+"_dt1 where id="+contactDtId;
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				JE_1 =  Util.null2String(rs_dt.getString("fkje")); 
				wsje =  Util.null2String(rs_dt.getString("wsje"));
			}
		}
		if(JE_1.length()<1){
			JE_1 = "0.00";
		}
		if("".equals(wsje)){
			wsje = "0.00";
		}
		sql_dt = "select   cast(round("+JE_1+"-"+wsje+",2) as numeric(12,2)) as sj,   cast(round("+JE_1+"*"+HL+",2)   as   numeric(12,2)) as rmbje ";
		//out.print(sql_dt);
		rs_dt.executeSql(sql_dt);
		if(rs_dt.next()){
			sj = Util.null2String(rs_dt.getString("sj"));
			rmbje = Util.null2String(rs_dt.getString("rmbje"));
		}
		if("".equals(rmbje)){
			rmbje = "0.00";
		}
		if("".equals(sj)){
			sj = "0.00";
		}
		sql_dt = "select cast("+sumsj+"+"+sj+" as numeric(12,2)) as sumsj,cast("+sum+"+"+wsje+" as numeric(12,2)) as sumws,cast("+sum2+"+"+JE_1+" as numeric(12,2)) as sum1,cast("+sumrmb+"+"+rmbje+" as numeric(12,2)) as sumrmbje";
	
		rs_dt.executeSql(sql_dt);
		if(rs_dt.next()){
			sumsj =rs_dt.getString("sumsj");
			sum = rs_dt.getString("sumws");
			sum2 = rs_dt.getString("sum1");
			sumrmb = rs_dt.getString("sumrmbje");
		}
		
		//sumsj = sumsj + Float.parseFloat(sj);
		//sum = sum + Float.parseFloat(JE_1);
		//sum = sum + Float.parseFloat(wsje);
		//sum2 = sum2 + Float.parseFloat(JE_1);
		//sumrmb = sumrmb + Float.parseFloat(rmbje);
		String ck = Util.null2String(rs.getString("ck"));
		String ckid = Util.null2String(rs.getString("SHCK"));//id
		String WLBH_1 = Util.null2String(rs.getString("WLBH_1"));
		String lxmc = Util.null2String(rs.getString("lxmc"));
		String lxid = Util.null2String(rs.getString("lxid"));
		String ddlc = Util.null2String(rs.getString("cgsqd"));
		%>
		<tr>
			<td><%=wlmc%></td>
			<td><%=lxmc%></td>
			<td><%=RKDH%></td>
			<td><%=rksj%></td>
			<td><%=dw%></td>
			<%if(!"flx".equals(wplx)){%>
			<td><%=SJSHSL_1%></td>
			<td><%=DJ_1%></td>
			<%}%>
			<td><%=taxname%></td>
			<td><%=sj%></td>
			<td><%=wsje%></td>
			<td><%=JE_1%></td>
			<td><%=bz%></td>
			<td><%=HL%></td>
			<td><%=rmbje%></td>
			<td><%=ck%></td>
			<td><%=WLBH_1%></td>
		</tr>		
	<%
		}	
		DecimalFormat decimalFormat=new DecimalFormat(".00");
		String wsjeall=sum+"";
		String jeall=sum2+"";
		String rmball=sumrmb+"";
		String sjall=sumsj+"";
		if("".equals(wsjeall)){
			wsjeall = "0.00";
		}
		if("".equals(jeall)){
			jeall = "0.00";
		}
		if("".equals(rmball)){
			rmball = "0.00";
		}
		if("".equals(sjall)){
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
	jQuery(document).ready(function(){
		bindchange("0");

	});
	
	function bindchange(index){
		jQuery("#fpjews_"+index).bind('change',function(){
			var fpsl_val = jQuery("#fpsl_"+index).val();
			var fpjews_val = jQuery("#fpjews_"+index).val();
			if(fpjews_val == ""){
				fpjews_val = "0";
			}
			if(fpsl_val == ""){
				fpsl_val = "0";
			}
			var fpsj_val = accMul(fpjews_val,fpsl_val).toFixed(2);
			jQuery("#fpsj_"+index).val(fpsj_val);
			jQuery("#fpsj_"+index+"span").html("");
			jQuery("#fpje_"+index).val(accAdd(fpjews_val,fpsj_val));
			sumALlmoney();
		})
		jQuery("#fpsj_"+index).bind('change',function(){
			var fpsj_val = jQuery("#fpsj_"+index).val();
			var fpjews_val = jQuery("#fpjews_"+index).val();
			if(fpsj_val == ""){
				fpsj_val = "0";
			}
			if(fpjews_val == ""){
				fpjews_val = "0";
			}
			jQuery("#fpje_"+index).val(accAdd(fpjews_val,fpsj_val));
			sumALlmoney();
		})

		jQuery("#fpsl_"+index).bind('change',function(){
			var fpsl_val = jQuery("#fpsl_"+index).val();
			var fpjews_val = jQuery("#fpjews_"+index).val();
			if(fpjews_val == ""){
				fpjews_val = "0";
			}
			if(fpsl_val == ""){
				fpsl_val = "0";
			}
			var fpsj_val = accMul(fpjews_val,fpsl_val);
			jQuery("#fpsj_"+index).val(fpsj_val);
			jQuery("#fpsj_"+index+"span").html("");
			jQuery("#fpje_"+index).val(accAdd(fpjews_val,fpsj_val));
			sumALlmoney();
		})
	}
	function sumALlmoney(){
		var ind = jQuery("#rownum").val();
		var fpjewshj_val = "0";
		var fpsjhj_val = "0";
		var fpjehj_val = "0";
		for(var index =0;index<ind;index++){
			if(jQuery("#fpjews_"+index).length>0){
				var fpsj_val = jQuery("#fpsj_"+index).val();
				var fpje_val = jQuery("#fpje_"+index).val();
				var fpjews_val = jQuery("#fpjews_"+index).val();
				if(fpsj_val == ""){
					fpsj_val = 0;
				}
				if(fpje_val == ""){
					fpje_val = 0;
				}
				if(fpjews_val == ""){
					fpjews_val = 0;
				}
				fpjewshj_val = accAdd(fpjewshj_val,fpjews_val);
				fpsjhj_val = accAdd(fpsjhj_val,fpsj_val);
				fpjehj_val = accAdd(fpjehj_val,fpje_val);
			}
		}
		fpjewshj_val = fpjewshj_val.toFixed(2);
		fpsjhj_val = fpsjhj_val.toFixed(2);
		fpjehj_val = fpjehj_val.toFixed(2);
		jQuery("#fpjewshj").html(fpjewshj_val);
		jQuery("#fpsjhj").html(fpsjhj_val);
		jQuery("#fpjehj").html(fpjehj_val);
	}
	function accAdd(arg1,arg2){
		var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
		m=Math.pow(10,Math.max(r1,r2))
		return (arg1*m+arg2*m)/m
	}

	function accMul(arg1,arg2)
	{
		var m=0,s1=arg1.toString(),s2=arg2.toString();
		try{m+=s1.split(".")[1].length}catch(e){}
		try{m+=s2.split(".")[1].length}catch(e){}
		return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)
	}


        function addrow(){
            var c=document.getElementById('mytable');//获得表格的信息
            var lec =c.rows.length;
			var inde = jQuery("#rownum").val();
			var index = parseInt(inde)+1;
			
			var z=c.rows[0].cells;//如果不是空表，首先获得表格有多少列，先获取再插入新行
            var x=c.insertRow(lec);
            for(var i=0;i<z.length;i++){//依次向新行插入表格列数的单元格
				var y=x.insertCell(i);
				
				if(i==0){
					y.width="150px";
                    y.innerHTML = "<input datatype=\"text\"  style=\"ime-mode:disabled\" viewtype=\"1\" type=\"text\" class=\" input11 InputStyle\" id=\"fph_"+inde+"\" name=\"fph_"+inde+"\" onkeyup=\"this.value=this.value.replace(/[^0-9a-zA-Z\-]/g,'')\" onblur=\"checkinput2('fph_"+inde+"','fph_"+inde+"span',this.getAttribute('viewtype'))\" value=\"\" onchange=\"\" onpropertychange=\"\" _listener=\"\"><span id=\"fph_"+inde+"span\" style=\"word-break:break-all;word-wrap:break-word\"><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></span>";
				}else if(i==1){
					y.width="110px";
					y.innerHTML = "&nbsp;&nbsp;<button type=\"button\" class=Calendar id=\"selectfprq_"+inde+"\" onclick=\"onshowPlanDate('fprq_"+inde+"','fprq_"+inde+"Span')\"></BUTTON>"+
                        "<SPAN id=\"fprq_"+inde+"Span\" ><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></SPAN>"+
                        "<INPUT type=\"hidden\" name=\"fprq_"+inde+"\" id=\"fprq_"+inde+"\" value=\"\">";
				}else if(i==2){
					y.width="150px";
					y.innerHTML = "<input class=\"input11\" type=\"text\" id=\"bz_"+inde+"\" value=\"<%=fpbz%>\" disabled/>";
				}else if(i==3){	
					y.width="150px";				
					y.innerHTML = "<input datalength=\"2\" datatype=\"float\" style=\"ime-mode:disabled\" onafterpaste=\"if(isNaN(value))execCommand('undo')\" viewtype=\"1\" type=\"text\" class=\"input11 InputStyle\" id=\"fpsl_"+inde+"\" name=\"fpsl_"+inde+"\" onkeypress=\"ItemDecimal_KeyPress('fpsl_"+inde+"',15,2)\" onblur=\"checkFloat(this);checkinput2('fpsl_"+inde+"','fpsl_"+inde+"span',this.getAttribute('viewtype'))\" value=\"<%=fpsl%>\" onchange=\"\" onpropertychange=\"\" _listener=\"\"><span id=\"fpsl_"+inde+"span\" style=\"word-break:break-all;word-wrap:break-word\"></span>";
				}else if(i==4){
					y.width="150px";
					y.innerHTML = "<input datalength=\"2\" datatype=\"float\" style=\"ime-mode:disabled\" onafterpaste=\"if(isNaN(value))execCommand('undo')\" viewtype=\"1\" type=\"text\" class=\"input11 InputStyle\" id=\"fpjews_"+inde+"\" name=\"fpjews_"+inde+"\" onkeypress=\"ItemDecimal_KeyPress('fpjews_"+inde+"',15,2)\" onblur=\"checkFloat(this);checkinput2('fpjews_"+inde+"','fpjews_"+inde+"span',this.getAttribute('viewtype'))\" value=\"\" onchange=\"\" onpropertychange=\"\" _listener=\"\"><span id=\"fpjews_"+inde+"span\" style=\"word-break:break-all;word-wrap:break-word\"><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></span>";
				}else if(i==5){
					y.width="150px";
					y.innerHTML = "<input class=\"input11\" datalength=\"2\" datatype=\"float\" style=\"ime-mode:disabled\" onafterpaste=\"if(isNaN(value))execCommand('undo')\" viewtype=\"1\" type=\"text\" class=\"input11 InputStyle\" id=\"fpsj_"+inde+"\" name=\"fpsj_"+inde+"\" onkeypress=\"ItemDecimal_KeyPress('fpsj_"+inde+"',15,2)\" onblur=\"checkFloat(this);checkinput2('fpsj_"+inde+"','fpsj_"+inde+"span',this.getAttribute('viewtype'))\" value=\"\" onchange=\"\" onpropertychange=\"\" _listener=\"\"><span id=\"fpsj_"+inde+"span\" style=\"word-break:break-all;word-wrap:break-word\"><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></span>";
				}else if(i==6){
					y.width="150px";
				y.innerHTML = "<input type=\"text\" class=\"input11\" id=\"fpje_"+inde+"\" value=\"\" readonly/>";
				}else if(i==7){
					y.width="50px";
					y.innerHTML="&nbsp;&nbsp;<a href=\"#\" onclick=delrow(this,"+inde+")>删除&nbsp;&nbsp;</a>";//删除当前行
				}
            }
			jQuery("#rownum").val(index);
			var chkFields = jQuery("#mustfileds").val();
			if(chkFields == ""){
				chkFields = "fph_"+inde+",fprq_"+inde+",fpjews_"+inde+",fpsj_"+inde;
			}else{
				chkFields = chkFields+",fph_"+inde+",fprq_"+inde+",fpjews_"+inde+",fpsj_"+inde;
			}
			jQuery("#mustfileds").val(chkFields);
			bindchange(inde);
       
        }

        function delrow(_id,inde){
			var i=_id.parentNode.parentNode.rowIndex;
			document.getElementById('mytable').deleteRow(i);
			var chkFields = jQuery("#mustfileds").val();
			//alert(chkFields);
			var replacestr = "fph_"+inde+",fprq_"+inde+",fpjews_"+inde+",fpsj_"+inde+",fpje_"+inde;
			chkFields = chkFields.replace(replacestr, "");
			//alert(chkFields);
			jQuery("#mustfileds").val(chkFields);
			
			// var x=document.getElementById("mytable");
			// x.deleteRow(_id);//删除一行
        }

		function printym(){
			window.print();
		}
	
	
	
	
	
	
	
	
	
	
	
	
	///
	function OnSearch2(){
		var chkFields = jQuery("#mustfileds").val();
		if(!check_form(insertInfo,chkFields)) return false;
		var typess = "<%=types%>";
		//var dialog = parent.parent.getDialog(window);
		var parentWin = window.parent;
	
		//alert("333");
		var ph = "";
		var je = "0";
		var dgje = "";//每张发票金额串
		var fpjehs = "";//每张发票金额串
		var slc = "";//
		var sjc ="";//
		var numr = 0;
		var zjlbm = "<%=zjlbm%>";
		var wlwsje ="<%=wsjeall%>";
		var fpbz = "<%=fpbzid%>";
		var fpsls = "";
		var fprqs = "";
		//alert(zjlbm);
		//
	//	alert("222");
		var ind = jQuery("#rownum").val();
		//alert(ind);
		for(var i =0;i<parseInt(ind);i++){
			if(jQuery("#fph_"+i).length>0){
				if(jQuery("#fph_"+i).val().length<=0){
					Dialog.alert("请填写发票！");
					return ;
				}
				var fphm =jQuery("#fph_"+i).val();
				if(fphm != ""){
					if((","+ph+",").indexOf(","+fphm+",")>-1){
						alert("当前页面填写的发票号码重复，请检查");
					}
				}
				ph = ph+jQuery("#fph_"+i).val()+",";
				var je_val = jQuery("#fpjews_"+i).val();
				if(je_val == ""){
					je_val ="0";
				}
				dgje = dgje+je_val+ ",";
				sjc = sjc + jQuery("#fpsj_"+i).val()+",";
				
				fprqs = fprqs+ jQuery("#fprq_"+i).val()+",";
				fpjehs = fpjehs+ jQuery("#fpje_"+i).val()+",";
				fpsls = fpsls+ jQuery("#fpsl_"+i).val()+",";
				je = accAdd(je,je_val);
				numr++;
			}
		}
		//alert(sjc);
		//alert(fpjehs);
		
		
		var idsz = jQuery("#ids").val();//ids判断
		if(idsz.indexOf(",") != -1 && numr>1){
			Dialog.alert("只能  一张发票可以对应多个订单，多张发票可以对应一个订单");
			return ;
		}
		
		
		ph = ph.substring(0,ph.length-1);
		//slc = slc.substring(0,slc.length-1);
		sjc = sjc.substring(0,sjc.length-1);
		dgje = dgje.substring(0,dgje.length-1);
		fprqs = fprqs.substring(0,fprqs.length-1);
		fpjehs = fpjehs.substring(0,fpjehs.length-1);
		fpsls = fpsls.substring(0,fpsls.length-1);
		//alert(ph);
		if(Number(je)>Number(wlwsje)){
			Dialog.alert("发票金额大于实际金额,请检查");
			return ;
		}
		//
		//var fphm_val = jQuery("#fphm").val();
		var a = 1;
		if(ph.length<=0){
			Dialog.alert("请填写发票！");
			return ;
		}else{
			var xhr = null;
			if (window.ActiveXObject) {//IE浏览器
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			}else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}
			if (null != xhr) {
				xhr.open("GET","/goodbaby/whfp/pdsf.jsp?fphm="+ph+"&type="+typess, false);
				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							if(text=='1'){
								a = 1;
								Dialog.alert("发票已存在，请重新填写！");
								return;
							}else{
								a = 2;
							}
									
						}	
					}
				}
					xhr.send(null);			
			}
		}
		if(a == 2){
			var r=confirm("是否确认提交发票号码？！");
			if(r==true){
				var fphj_val = jQuery("#fphj").val();
				var gsyid_val = jQuery("#gsyid").val();
				var xtgysid_val = jQuery("#xtgysid").val();
				var ids_val = jQuery("#ids").val();
				var wplx = "<%=wplx%>";
				var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				}else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				//alert()
				if (null != xhr) {
					xhr.open("GET","/goodbaby/whfp/insert.jsp?fphm="+ph+"&slc="+fpsls+"&sjc="+sjc+"&dgje="+dgje+"&wplx="+wplx+"&ids="+ids_val+"&fphj="+fphj_val+"&gsyid="+gsyid_val+"&xtgysid="+xtgysid_val+"&zjlbm="+zjlbm+"&fprqs="+fprqs+"&fpjehs="+fpjehs+"&fpbz="+fpbz, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
							}	
						}
					}
						xhr.send(null);			
				}
				
				
				
				parentWin.MainCallback1();
			}
			
		
		}
		
	}
		

	

							
	
	
	
	
	
	
	
	
	function resetCondtion2(){
		insertInfo.fphm.value = "";
	}
	//fphj document.report.fphj.value = <%=sum%>;
	
	
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>

</BODY>
</HTML>