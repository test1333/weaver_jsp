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
<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
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
String types = Util.null2String(request.getParameter("type"));
String wplx = Util.null2String(request.getParameter("wplx"));

int userid = user.getUID();
String pageID = "AAAAAAAAAAAA";
String fphj = Util.null2String(request.getParameter("fphj"));
String fphm = Util.null2String(request.getParameter("fphm"));
String gsyids = Util.null2String(request.getParameter("gsyid"));
String xtgysids = Util.null2String(request.getParameter("xtgysid"));
String tablename="formtable_main_243";
String zjlbm = "";
String zjlsql = "select zjlbm from "+tablename+" where id in("+ids+")";
rs.executeSql(zjlsql);
while(rs.next()){
	if(!"".equals(zjlbm)){
		break;
	}
	zjlbm = Util.null2String(rs.getString("zjlbm"));
}
if(fphm.length()>4){
	String mainid = "";
	String sql1 = "insert into uf_invoice(gys,xtkh,fphm,fpze,whsj,formmodeid,modedatacreater,fplx) values ('"+gsyids+"','"+xtgysids+"','"+fphm+"','"+fphj+"',CONVERT(varchar(10),GETDATE(),120),60,1,1)";
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
	String sql2 = "select tt.id,tt.xtgys,tt.WLMC_1,tt.requestid,tt.cgsqd,tt.gys,tt.dwid,tt.RKDH,tt.SHCK,tt.rksj,tt.SJSHSL_1,tt.DJ_1,tt.JE_1,tt.WLBH_1,tt.lxmc,tt.lxid from (select a.id,a.requestid,a.xtgys,c.WLMC_1,c.gys,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select WLLX from  uf_materialDatas um where um.id =c.WLMC_1)as npplx,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj,(select DW from uf_materialDatas where id = c.WLMC_1)as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,a.SHCK,c.WLBH_1,c.cgsqd from "+tablename+" a join workflow_requestbase b on a.requestid=b.requestid join  "+tablename+"_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 ) tt where tt.id in("+ids+")";
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
<input type="hidden" name="indexnum" id="indexnum" value="1"/>
<input type="hidden" name="mustfileds" id="mustfileds" value="fph_0,fprq_0,fpsl_0,fpjews_0,fpsj_0,fpje_0"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<div id="test1"  style="width:100%;height:2%;" ></div>
	<FORM id="insertInfo" name="insertInfo" action="/goodbaby/whfp/whfpInfo.jsp" method=post>
		<input type = "hidden" id ="fphj" name="fphj" value="<%=sums%>"
		
		<div>
		<p><input type="button" value="增加行" onclick="addrow()" >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="提交" onclick="OnSearch2()" >
			<table id = "mytable">
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
					<td><input datatype="int" onafterpaste="if(isNaN(value))execCommand('undo')" style="ime-mode:disabled" viewtype="1" type="text" class="InputStyle" id="fph_0" name="fph_0" onkeypress="ItemCount_KeyPress()" onblur="checkcount1(this);checkItemScale(this,'发票号码长度不能超过8位，请重新输入！',0,99999999);checkinput2('fph_0','fph_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fph_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>
					<td width='100px'>&nbsp;&nbsp;<button type="button" class=Calendar id="selectfprq_0" onclick="onshowPlanDate('fprq_0','fprq_0Span')"></BUTTON>
                        <SPAN id="fprq_0Span" ><img src="/images/BacoError_wev8.gif" align="absMiddle"></SPAN>
                        <INPUT type="hidden" name="fprq_0" id="fprq_0" value="">
					</td>
					<td> <input type="text" id="bz_0" value="EMb" disabled/></td>
					<td><input datalength="2" datatype="float" style="ime-mode:disabled" onafterpaste="if(isNaN(value))execCommand('undo')" viewtype="1" type="text" class="InputStyle" id="fpsl_0" name="fpsl_0" onkeypress="ItemDecimal_KeyPress('fpsl_0',15,2)" onblur="checkFloat(this);checkinput2('fpsl_0','fpsl_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fpsl_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>
					<td><input datalength="2" datatype="float" style="ime-mode:disabled" onafterpaste="if(isNaN(value))execCommand('undo')" viewtype="1" type="text" class="InputStyle" id="fpjews_0" name="fpjews_0" onkeypress="ItemDecimal_KeyPress('fpjews_0',15,2)" onblur="checkFloat(this);checkinput2('fpjews_0','fpjews_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fpjews_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>
					<td><input datalength="2" datatype="float" style="ime-mode:disabled" onafterpaste="if(isNaN(value))execCommand('undo')" viewtype="1" type="text" class="InputStyle" id="fpsj_0" name="fpsj_0" onkeypress="ItemDecimal_KeyPress('fpsj_0',15,2)" onblur="checkFloat(this);checkinput2('fpsj_0','fpsj_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fpsj_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>
					<td><input datalength="2" datatype="float" style="ime-mode:disabled" onafterpaste="if(isNaN(value))execCommand('undo')" viewtype="1" type="text" class="InputStyle" id="fpje_0" name="fpje_0" onkeypress="ItemDecimal_KeyPress('fpje_0',15,2)" onblur="checkFloat(this);checkinput2('fpje_0','fpje_0span',this.getAttribute('viewtype'))" value="" onchange="" onpropertychange="" _listener=""><span id="fpje_0span" style="word-break:break-all;word-wrap:break-word"><img src="/images/BacoError_wev8.gif" align="absMiddle"></span></td>
					<td><a href="#" onclick="delrow(this,0)">删除</a></td>
				</tr>
				
			
			
			
			</table>
		
		</div>
		
		
		
		
	</FORM>
	
	<div id="test3"  style="width:100%;height:21%;" ></div>
	<div>
		<table class = "tab">
		<tr><th>物料名称</th><th>物料类型</th><th>入库单号</th><th>入库日期</th><th>入库单位</th><th>入库数量</th><th>实际价格(含税)</th><th>仓库名称</th><th>物料编码</th></tr>
<%
	String sql = "select tt.id,tt.xtgys,tt.wlmc,tt.WLMC_1,tt.cgsqd,tt.gys,tt.dwid,tt.RKDH,tt.SHCK,tt.rksj,tt.dw,tt.SJSHSL_1,tt.DJ_1,tt.JE_1,tt.ck,tt.WLBH_1,tt.lxmc,tt.lxid from (select a.id,a.xtgys,c.WLMC_1,c.gys,(select WLMC from uf_materialDatas where id = c.WLMC_1) as wlmc ,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj ,(select dw from uf_unitForms where id= (select DW from uf_materialDatas where id = c.WLMC_1)) as dw,(select DW from uf_materialDatas where id = c.WLMC_1)as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,(select CKMC from uf_stocks where id = a.SHCK) as ck,a.SHCK,c.WLBH_1,c.cgsqd from  "+tablename+" a join workflow_requestbase b on a.requestid=b.requestid join  "+tablename+"_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 ) tt where tt.id in("+ids+")";
	rs.executeSql(sql);
	float sum = (float) 0.00;
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
		if(JE_1.length()<1){
			JE_1 = "0.00";
		}
		if(DJ_1.length()<1){
			DJ_1 = "0.00";
		}
		//sum = sum + Float.parseFloat(JE_1);
		sum = sum + Float.parseFloat(DJ_1)*Float.parseFloat(SJSHSL_1);
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
        function addrow(){
            var c=document.getElementById('mytable');//获得表格的信息
            var lec =c.rows.length;
			var inde = jQuery("#indexnum").val();
			var index = parseInt(inde)+1;
			
			var z=c.rows[0].cells;//如果不是空表，首先获得表格有多少列，先获取再插入新行
            var x=c.insertRow(lec);
            for(var i=0;i<z.length;i++){//依次向新行插入表格列数的单元格
				var y=x.insertCell(i);
				
				if(i==0){
                    y.innerHTML = "<input datatype=\"int\" onafterpaste=\"if(isNaN(value))execCommand('undo')\" style=\"ime-mode:disabled\" viewtype=\"1\" type=\"text\" class=\"InputStyle\" id=\"fph_"+inde+"\" name=\"fph_"+inde+"\" onkeypress=\"ItemCount_KeyPress()\" onblur=\"checkcount1(this);checkItemScale(this,'发票号码长度不能超过8位，请重新输入！',0,99999999);checkinput2('fph_"+inde+"','fph_"+inde+"span',this.getAttribute('viewtype'))\" value=\"\" onchange=\"\" onpropertychange=\"\" _listener=\"\"><span id=\"fph_"+inde+"span\" style=\"word-break:break-all;word-wrap:break-word\"><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></span>";
				}else if(i==1){
					y.width="100px";
					y.innerHTML = "&nbsp;&nbsp;<button type=\"button\" class=Calendar id=\"selectfprq_"+inde+"\" onclick=\"onshowPlanDate('fprq_"+inde+"','fprq_"+inde+"Span')\"></BUTTON>"+
                        "<SPAN id=\"fprq_"+inde+"Span\" ><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></SPAN>"+
                        "<INPUT type=\"hidden\" name=\"fprq_"+inde+"\" id=\"fprq_"+inde+"\" value=\"\">";
				}else if(i==2){
					y.innerHTML = "<input type=\"text\" id=\"bz_"+inde+"\" value=\"EMb\" disabled/>";
				}else if(i==3){
					y.innerHTML = "<input datalength=\"2\" datatype=\"float\" style=\"ime-mode:disabled\" onafterpaste=\"if(isNaN(value))execCommand('undo')\" viewtype=\"1\" type=\"text\" class=\"InputStyle\" id=\"fpsl_"+inde+"\" name=\"fpsl_"+inde+"\" onkeypress=\"ItemDecimal_KeyPress('fpsl_"+inde+"',15,2)\" onblur=\"checkFloat(this);checkinput2('fpsl_"+inde+"','fpsl_"+inde+"span',this.getAttribute('viewtype'))\" value=\"\" onchange=\"\" onpropertychange=\"\" _listener=\"\"><span id=\"fpsl_"+inde+"span\" style=\"word-break:break-all;word-wrap:break-word\"><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></span>";
				}else if(i==4){
					y.innerHTML = "<input datalength=\"2\" datatype=\"float\" style=\"ime-mode:disabled\" onafterpaste=\"if(isNaN(value))execCommand('undo')\" viewtype=\"1\" type=\"text\" class=\"InputStyle\" id=\"fpjews_"+inde+"\" name=\"fpjews_"+inde+"\" onkeypress=\"ItemDecimal_KeyPress('fpjews_"+inde+"',15,2)\" onblur=\"checkFloat(this);checkinput2('fpjews_"+inde+"','fpjews_"+inde+"span',this.getAttribute('viewtype'))\" value=\"\" onchange=\"\" onpropertychange=\"\" _listener=\"\"><span id=\"fpjews_"+inde+"span\" style=\"word-break:break-all;word-wrap:break-word\"><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></span>";
				}else if(i==5){
					y.innerHTML = "<input datalength=\"2\" datatype=\"float\" style=\"ime-mode:disabled\" onafterpaste=\"if(isNaN(value))execCommand('undo')\" viewtype=\"1\" type=\"text\" class=\"InputStyle\" id=\"fpsj_"+inde+"\" name=\"fpsj_"+inde+"\" onkeypress=\"ItemDecimal_KeyPress('fpsj_"+inde+"',15,2)\" onblur=\"checkFloat(this);checkinput2('fpsj_"+inde+"','fpsj_"+inde+"span',this.getAttribute('viewtype'))\" value=\"\" onchange=\"\" onpropertychange=\"\" _listener=\"\"><span id=\"fpsj_"+inde+"span\" style=\"word-break:break-all;word-wrap:break-word\"><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></span>";
				}else if(i==6){
					y.innerHTML = "<input datalength=\"2\" datatype=\"float\" style=\"ime-mode:disabled\" onafterpaste=\"if(isNaN(value))execCommand('undo')\" viewtype=\"1\" type=\"text\" class=\"InputStyle\" id=\"fpje_"+inde+"\" name=\"fpje_"+inde+"\" onkeypress=\"ItemDecimal_KeyPress('fpje_"+inde+"',15,2)\" onblur=\"checkFloat(this);checkinput2('fpje_"+inde+"','fpje_"+inde+"span',this.getAttribute('viewtype'))\" value=\"\" onchange=\"\" onpropertychange=\"\" _listener=\"\"><span id=\"fpje_"+inde+"span\" style=\"word-break:break-all;word-wrap:break-word\"><img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\"></span>";
				}else if(i==7){
					y.innerHTML="<a href=\"#\" onclick=delrow(this,"+inde+")>删除</a>";//删除当前行
				}
            }
			jQuery("#indexnum").val(index);
			var chkFields = jQuery("#mustfileds").val();
			if(chkFields == ""){
				chkFields = "fph_"+inde+",fprq_"+inde+",fpsl_"+inde+",fpjews_"+inde+",fpsj_"+inde+",fpje_"+inde;
			}else{
				chkFields = chkFields+",fph_"+inde+",fprq_"+inde+",fpsl_"+inde+",fpjews_"+inde+",fpsj_"+inde+",fpje_"+inde;
			}
			jQuery("#mustfileds").val(chkFields);
       
        }

        function delrow(_id,inde){
			var i=_id.parentNode.parentNode.rowIndex;
			document.getElementById('mytable').deleteRow(i);
			var chkFields = jQuery("#mustfileds").val();
			//alert(chkFields);
			var replacestr = "fph_"+inde+",fprq_"+inde+",fpsl_"+inde+",fpjews_"+inde+",fpsj_"+inde+",fpje_"+inde;
			chkFields = chkFields.replace(replacestr, "");
			//alert(chkFields);
			jQuery("#mustfileds").val(chkFields);
			
			// var x=document.getElementById("mytable");
			// x.deleteRow(_id);//删除一行
        }
	
	
	
	
	
	
	
	
	
	
	
	
	///
	function OnSearch2(){
		var chkFields = jQuery("#mustfileds").val();
		if(!check_form(insertInfo,chkFields)) return false;
		var typess = "<%=types%>";
		var dialog = parent.getDialog(window);
		var parentWin = parent.getParentWindow(window);
		var ph = "";
		var je = 0.00;
		var dgje = "";//每张发票金额串
		var slc = "";//
		var sjc ="";//
		var numr = 0;
		var zjlbm = "<%=zjlbm%>";
		//alert(zjlbm);
		//
		var ind = jQuery("#indexnum").val();
		for(var i =0;i<parseInt(ind);i++){
			if(jQuery("#fph_"+i).length>0){
				if(jQuery("#fph_"+i).val().length<=0){
					Dialog.alert("请填写发票！");
					return ;
				}
				ph = ph+jQuery("#fph_"+i).val()+",";
				var je_ = jQuery("#fpje_"+i).val();
				if(je_.length<=0){
					je_ =0.00;
				}
				dgje = dgje+je_+ ",";
				slc = slc + jQuery("#fpsl_"+i).val()+",";
				sjc = sjc + jQuery("#fpsj_"+i).val()+",";
				je = je+parseFloat(je_);
				numr++;
			}
		}
		
		
		
		
		var idsz = jQuery("#ids").val();//ids判断
		if(idsz.indexOf(",") != -1 && numr>1){
			Dialog.alert("只能  一张发票可以对应多个订单，多张发票可以对应一个订单");
			return ;
		}
		
		
		ph = ph.substring(0,ph.length-1);
		slc = slc.substring(0,slc.length-1);
		sjc = sjc.substring(0,sjc.length-1);
		dgje = dgje.substring(0,dgje.length-1);
		
		//alert(ph);
		if(parseFloat(jQuery("#fphj").val())<je){
			Dialog.alert("发票金额大于实际金额");
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
					xhr.open("GET","/goodbaby/whfp/insert.jsp?fphm="+ph+"&slc="+slc+"&sjc="+slc+"&dgje="+dgje+"&wplx="+wplx+"&ids="+ids_val+"&fphj="+fphj_val+"&gsyid="+gsyid_val+"&xtgysid="+xtgysid_val+"&zjlbm="+zjlbm, false);
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
				parentWin.location.reload();
				dialog.closeByHand();
				
				
			}
		
		}
	}
		

	

							
	
	
	
	
	
	
	
	
	function resetCondtion2(){
		insertInfo.fphm.value = "";
	}
	//fphj document.report.fphj.value = <%=sum%>;
	
	
	function ssu(){
		var sum_val = jQuery("#sum").val();
		jQuery("#fphj").val(sum_val);
	}
	jQuery(document).ready(function(){
		setTimeout("ssu()", 500);
		
	})	
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>

</BODY>
</HTML>