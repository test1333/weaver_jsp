<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
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
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
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
</style>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
float sums =(float)0.00;
String ids = Util.null2String(request.getParameter("ids"));
int userid = user.getUID();
String pageID = "AAAAAAAAAAAA";
String fphj = Util.null2String(request.getParameter("fphj"));
String fphm = Util.null2String(request.getParameter("fphm"));
String gsyids = Util.null2String(request.getParameter("gsyid"));
String xtgysids = Util.null2String(request.getParameter("xtgysid"));
if(fphm.length()>4){
	String mainid = "";
	String sql1 = "insert into uf_invoice(gys,xtkh,fphm,fpze,whsj,formmodeid,modedatacreater) values ('"+gsyids+"','"+xtgysids+"','"+fphm+"','"+fphj+"',CONVERT(varchar(16),GETDATE(),120),60,1)";
	//out.print("sql1----"+sql1+"----");
	rs.executeSql(sql1);
	sql1 = "select max(id) as mid from uf_invoice where gys='"+gsyids+"' and fphm = '"+fphm+"'  ";
	rs.executeSql(sql1);
	if(rs.next()){
		mainid = rs.getString("mid");
	}
	ModeRightInfo modeRightInfo = new ModeRightInfo();
	modeRightInfo.editModeDataShare(1, 60, Integer.parseInt(mainid));
	modeRightInfo.editModeDataShareForModeField(1, 60, Integer.parseInt(mainid));
	String sql2 = "select tt.id,tt.xtgys,tt.WLMC_1,tt.requestid,tt.cgsqd,tt.gys,tt.dwid,tt.RKDH,tt.SHCK,tt.rksj,tt.SJSHSL_1,tt.DJ_1,tt.JE_1,tt.WLBH_1,tt.lxmc,tt.lxid from (select a.id,a.requestid,a.xtgys,c.WLMC_1,c.gys,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select WLLX from  uf_materialDatas um where um.id =c.WLMC_1)as npplx,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj,(select DW from uf_materialDatas where id = c.WLMC_1)as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,a.SHCK,c.WLBH_1,c.cgsqd from formtable_main_243 a join workflow_requestbase b on a.requestid=b.requestid join formtable_main_243_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 ) tt where tt.id in("+ids+")";
	rs.executeSql(sql2);
	while(rs.next()){
		String id = Util.null2String(rs.getString("id"));
		String xtgys = Util.null2String(rs.getString("xtgys"));//id
		String WLMC_1 = Util.null2String(rs.getString("WLMC_1"));//id
		String RKDH = Util.null2String(rs.getString("RKDH"));
		String rksj = Util.null2String(rs.getString("rksj"));
		String dwid = Util.null2String(rs.getString("dwid"));//id
		String SJSHSL_1 = Util.null2String(rs.getString("SJSHSL_1"));
		String DJ_1 = Util.null2String(rs.getString("DJ_1"));
		String JE_1 = Util.null2String(rs.getString("JE_1"));
		String ckid = Util.null2String(rs.getString("SHCK"));//id
		String WLBH_1 = Util.null2String(rs.getString("WLBH_1"));
		String lxmc = Util.null2String(rs.getString("lxmc"));
		String lxid = Util.null2String(rs.getString("lxid"));
		String npplx = Util.null2String(rs.getString("npplx"));
		String cgsqd = Util.null2String(rs.getString("cgsqd"));		
		String ddlc = Util.null2String(rs.getString("cgsqd"));
		String rid = Util.null2String(rs.getString("requestid"));
		String str ="insert into uf_invoice_dt1 (wlmc,wlbm,wllx,wllx1,rkdh,rkrq,rkdw,rksl,sjjg,ckmc,ddlc,rid,mainid) values('"+WLMC_1+"','"+WLBH_1+"','"+npplx+"','"+lxid+"','"+RKDH+"','"+rksj+"','"+dwid+"','"+SJSHSL_1+"','"+DJ_1+"','"+ckid+"','"+ddlc+"','"+rid+"','"+mainid+"')";
		rs.executeSql(str);		
		//out.print("str----"+str+"----");
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
<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<div id="test1"  style="width:100%;height:2%;" ></div>
	<FORM id="insertInfo" name="insertInfo" action="/goodbaby/whfp/edit.jsp" method=post>
	<div class="zDialog_div_content" id="differencehandle" name="differencehandle">
				<wea:layout type="4col">				
				<wea:group context="详细数据" attributes="{'samePair':'SetInfo','groupOperDisplay':'none','itemAreaDisplay':'block'}">
					<wea:item attributes="{'colspan':'4','isTableList':'true'}">
					
					<table class=ListStyle cellspacing=1>
						<colgroup>
							<col width="25%">
							<col width="25%">
							<col width="25%">
						</colgroup>
						<tr class=header>
							<td>开票方</td>
							<td>合计总额</td>
							<td>发票号码</td>
						</tr>
						
					<%
					String mxsql = "select c.xtkh,(select 	GYSMC from uf_suppmessForm where id =c.gys) as gysmc,c.gys ,c.fphm ,c.fpze from uf_invoice c where id  in ("+ids+")";
					rs.executeSql(mxsql);
					//out.print(mxsql);
					if(rs.next()){
						String gysmc = Util.null2String(rs.getString("gysmc"));
						String gsyid = Util.null2String(rs.getString("gys"));
						String xtgysid = Util.null2String(rs.getString("xtkh"));
						String fphms = Util.null2String(rs.getString("fphm"));
						String fpze = Util.null2String(rs.getString("fpze"));
						
						
					%>
					<tr class=DataDark>
						<td><%=gysmc%><input type="hidden" name="gsyid" id="gsyid" class="InputStyle" value="<%=gsyid%>"/><input type="hidden" name="xtgysid" id="xtgysid" class="InputStyle" value="<%=xtgysid%>"/></td>	
						<td><input type = "text" id ="fphj" name="fphj" value="<%=fpze%>" readonly></td>	
						<td><input type="text" name="fphm" id="fphm" class="InputStyle" value="<%=fphms%>" onchange="jsjg()" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" />
						<input type="hidden" name="ids" id="ids" class="InputStyle" value="<%=ids%>"/>
						</td>
					</tr>
					
					
					<%	
					}
					%>
					</table>
					
					
					</wea:item>
				</wea:group>
				<div id="test2"  style="width:100%;height:2%;" ></div>
				<wea:group context="">
					<wea:item type="toolbar">
						<input class="e8_btn_submit" type="button" name="submit_2" onClick="OnSearch2()" value="提交"/>
						<span class="e8_sep_line">|</span>
						<input class="e8_btn_cancel" type="button" name="reset2" onclick="resetCondtion2()" value="重置"/>
					</wea:item>
				</wea:group>
				
				
				
				</wea:layout>
		</div>
		
		
	</FORM>
	
	<div id="test3"  style="width:100%;height:21%;" ></div>
	<div>
		<table class = "tab">
		<tr><th>物料名称</th><th>物料类型</th><th>入库单号</th><th>入库日期</th><th>入库单位</th><th>入库数量</th><th>实际价格(含税)</th><th>仓库名称</th><th>物料编码</th></tr>
<%
	String sql = "select ui.id,(select GYSMC from uf_suppmessForm where id =ui.gys) as gysmc,ui.fphm,ui.fpze,(select WLMC from uf_materialDatas  where id = ud.wlmc) as wlmc,ud.wlbm,(select ub.buydl  from uf_buydl ub where ub.id =ud.wllx1) as wllx1,ud.rkdh,ud.rkrq,(select dw  from  uf_unitForms  where id=ud.rkdw) as rkdw ,ud.rksl,ud.sjjg,(select CKMC from uf_stocks  where id = ud.ckmc) as ckmc from uf_invoice ui join uf_invoice_dt1  ud on ui.id = ud.mainid  join workflow_requestbase w on w.requestid =ud.rid where ui.id in("+ids+")";
	rs.executeSql(sql);
	float sum = (float) 0.00;
	while(rs.next()){
		String id = Util.null2String(rs.getString("id"));
		String gysmc = Util.null2String(rs.getString("gysmc"));
		String wlmc = Util.null2String(rs.getString("wlmc"));
		String RKDH = Util.null2String(rs.getString("rkdh"));
		String rksj = Util.null2String(rs.getString("rkrq"));
		String dw = Util.null2String(rs.getString("rkdw"));
		
		String SJSHSL_1 = Util.null2String(rs.getString("rksl"));
		String DJ_1 = Util.null2String(rs.getString("sjjg"));
		if(JE_1.length()<1){
			JE_1 = "0.00";
		}
		if(DJ_1.length()<1){
			DJ_1 = "0.00";
		}
		//sum = sum + Float.parseFloat(JE_1);
		
		sum = sum + Float.parseFloat(DJ_1)*Float.parseFloat(SJSHSL_1);
		
		
		String ck = Util.null2String(rs.getString("ckmc"));
		String WLBH_1 = Util.null2String(rs.getString("wlbm"));
		String lxmc = Util.null2String(rs.getString("wllx1"));
		String ddlc = Util.null2String(rs.getString("cgsqd"));
		%>
		<tr>
			<td><%=wlmc%></td>
			<td><%=lxmc%></td>
			<td><%=RKDH%></td>
			<td><%=rksj%></td>
			<td><%=dw%></td>
			<td><%=SJSHSL_1%></td>
			<td><%=DJ_1%></td>
			<td><%=ck%></td>
			<td><%=WLBH_1%></td>
		</tr>		
	<%
		}	
	%>
		<tr>	
			<td><input type = 'hidden' id= "sum" name = "sum" value="<%=sum%>"></td><td></td><td></td><td></td><td></td><td></td><td></td>
		</tr>
		</table>
	</div>
	<script type="text/javascript">	
	function OnSearch2(){
		var dialog = parent.getDialog(window);
		var parentWin = parent.getParentWindow(window);
		var fphm_val = jQuery("#fphm").val();
		if(fphm_val.length<=0){
			Dialog.alert("请填写发票！");
			return ;
		}
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		}else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			xhr.open("GET","/goodbaby/whfp/pdsf.jsp?fphm="+fphm_val, false);
			xhr.onreadystatechange = function () {
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
 						var text = xhr.responseText;
						text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						if(text=='1'){
							Dialog.alert("发票已存在，请重新填写！");
							return;
						}else{
							var r=confirm("是否确认提交发票号码？！");
							if(r==true){
								jQuery("#insertInfo").submit();	
								// parentWin.location.reload();
								// dialog.closeByHand();	
							}
						}
								
					}	
				}
			}
				xhr.send(null);			
		}
		
		
		
		
		
		
		
		
	}

	function resetCondtion2(){
		insertInfo.fphm.value = "";
	}
	//fphj document.report.fphj.value = <%=sum%>;
		
		
		
		
		
		
		
		
	</script>
	
</BODY>
</HTML>