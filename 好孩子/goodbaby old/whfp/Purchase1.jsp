<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="goodbaby.pz.GetGNSTableName"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	int user_id = user.getUID();
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

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
</head>
<%
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	String star = Util.null2String(request.getParameter("OA_STDATE"));
	String endr = Util.null2String(request.getParameter("OA_ENDDATE"));
	String rkdh = Util.null2String(request.getParameter("rkdh"));
	String wlmc = Util.null2String(request.getParameter("wlmc"));
	String wlbm = Util.null2String(request.getParameter("wlbm"));
	String wllx = Util.null2String(request.getParameter("wllx"));
	String czlx = Util.null2String(request.getParameter("czlx"));
	String delid = Util.null2String(request.getParameter("delid"));
	String hm =  Util.null2String(request.getParameter("hm"));
	 int userid  = user.getUID();
	String tmc_pageId = "purchase11t1";
	GetGNSTableName gg = new GetGNSTableName();
	String tablename_rk = gg.getTableName("RKD");//入库单
	String tablename_dd = gg.getTableName("CGDD");//订单
	String tablename_ht = gg.getTableName("FKJHT");//非框架合同
	if("del".equals(czlx)){
		String str ="delete uf_invoice where id = '"+delid+"'";
		rs.executeSql(str);
		str = "delete uf_invoice_dt1 where mainid = '"+delid+"'";
		rs.executeSql(str);
	}
%>
	


<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
//RCMenu += "{修改发票,javascript:whfp(),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{删除发票,javascript:del(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action="/goodbaby/whfp/Purchase1.jsp" method=post>
	<input type = "hidden" id="czlx" name="czlx" value="<%=czlx%>">
	<input type = "hidden" id="delid" name="delid" value="<%=delid%>">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type="button" class="e8_btn_top_first"  value="删除发票" title="删除发票"  onclick="del()" style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
						<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>																  
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
		</table>
		<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>入库日期 </wea:item>
				<wea:item>
					<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(OA_STDATE,OA_STDATEspan)"></button> 
					<SPAN id=OA_STDATEspan><%=star%></SPAN> 
					<INPUT  type="hidden" name="OA_STDATE" value="<%=star%>">----&nbsp;&nbsp;&nbsp;<button type="button" class=Calendar id="SelectDate1" onclick="gettheDate(OA_ENDDATE,OA_ENDDATEspan)"></button> 
					<SPAN id=OA_ENDDATEspan><%=endr%></SPAN> 
					<INPUT  type="hidden" name="OA_ENDDATE" value="<%=endr%>"> 					
				</wea:item>
				<wea:item>入库单号</wea:item>
				<wea:item>
					<input name="rkdh" id="rkdh" class="InputStyle" type="text" value="<%=rkdh%>"/>
				</wea:item>	
				<wea:item>物料名称</wea:item>
				<wea:item>
					<input name="wlmc" id="wlmc" class="InputStyle" type="text" value="<%=wlmc%>"/>
				</wea:item>
				<wea:item>物料编码</wea:item>
				<wea:item>
					<input name="wlbm" id="wlbm" class="InputStyle" type="text" value="<%=wlbm%>"/>
				</wea:item>
				<wea:item>物料类型</wea:item>
				<wea:item>
					<select class=inputstyle  size=1 name="wllx" style=width:150>
						<option value="">&nbsp;</option>
						<option value="1" <%if(wllx.equals("1")) {%>selected<%}%>>服务</option>
						<option value="2" <%if(wllx.equals("2")) {%>selected<%}%>>零星</option>
						<option value="3" <%if(wllx.equals("3")) {%>selected<%}%>>投资</option>
					</select>
				</wea:item>
				<wea:item>发票号码</wea:item>
				<wea:item>
					<input name="hm" id="hm" class="InputStyle" type="text" value="<%=hm%>"/>
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
    String backfields="";
	String fromSql ="";
	String sqlWhere = "";
     backfields = " tt.lbid,tt.id,tt.gysmc,tt.fphm,tt.fpze,tt.xtkh,tt.wlmc,tt.wlbm,tt.wllx1,tt.rkdh,tt.rkrq,tt.rkdw,tt.rksl ,tt.sjjg,tt.ckmc,rkrqid,xght,fkxh,fktj,fkje,htbh ";
	 fromSql  = " from (select (select buydl  from uf_NPP where id = (select wllx from uf_materialDatas  where WLBM =ud.wlbm))as lbid, ui.fplx,ui.id,(select GYSMC from uf_suppmessForm where id =ui.gys) as gysmc,ui.fphm,ui.xtkh,ui.fpze,(select WLMC from uf_materialDatas  where id = ud.wlmc) as wlmc,ud.wlbm,(select ub.buydl  from uf_buydl ub where ub.id =ud.wllx1) as wllx1,ud.rkdh,ud.rkrq,(select dw  from  uf_unitForms  where id=ud.rkdw) as rkdw ,ud.rksl,ud.sjjg,(select CKMC from uf_stocks  where id = ud.ckmc) as ckmc,a.requestid as rkrqid,b.xght,b.fkxh,b.fktj,b.fkje,(select htbh from "+tablename_ht+" where requestid=b.xght) as htbh from uf_invoice ui join uf_invoice_dt1  ud on ui.id = ud.mainid  join workflow_requestbase w on w.requestid =ud.rid join "+tablename_rk+" a on ud.rid=a.requestid join  "+tablename_rk+"_dt1 b on a.id=b.mainid) tt";
	 sqlWhere = " where 1=1 and tt.fplx ='0' and tt.lbid='2'";
	if(!"".equals(rkdh)){
		sqlWhere +=" and tt.rkdh like '%"+rkdh+"%'";
	}
	if(!"".equals(wlmc)){
		sqlWhere +=" and tt.wlmc like '%"+wlmc+"%'";
	}
	if(!"".equals(wlbm)){
		sqlWhere +=" and tt.wlbm like '%"+wlbm+"%'";
	}
	if(userid!=1){
		sqlWhere +=" and tt.xtkh = '"+userid+"'";
	}
	if(!"".equals(wllx)){
		sqlWhere +=" and tt.lbid = '"+wllx+"'";
	}		
	if(!"".equals(star)){
		sqlWhere +=" and tt.rkrq >= '"+star+"'";
	}
	if(!"".equals(endr)){
		sqlWhere +=" and tt.rkrq <='"+endr+"'";
	}
	if(!"".equals(hm)){
		sqlWhere +=" and tt.fphm like '%"+hm+"%'";
	}
	//out.print("select "+backfields+fromSql+sqlWhere);
	String orderby = " tt.id " ;
	String tableString = "";
   //out.print("select "+backfields+fromSql+sqlWhere+" order by "+orderby);
//  右侧鼠标 放上可以点击
String  operateString= "";
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
	"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"tt.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+	
    operateString+
    "			<head>";
		tableString+="<col width=\"8%\"  text=\"物料名称\" column=\"wlmc\" orderkey=\"wlmc\"/>"+
		"<col width=\"8%\"  text=\"物料类型\" column=\"wllx1\" orderkey=\"wllx1\"/>"+	
		"<col width=\"8%\"  text=\"发票号码\" column=\"fphm\" orderkey=\"fphm\" linkvaluecolumn=\"rkdh\" linkkey=\"rkdhcs\" href=\"/goodbaby/whfp/whfpInfoHistoryUrl.jsp?wplx=lx\" target=\"_fullwindow\"/>"+
		"<col width=\"8%\"  text=\"入库单号\" column=\"rkdh\" orderkey=\"rkdh\" linkvaluecolumn=\"rkrqid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\"/>"+
		"<col width=\"8%\"  text=\"入库日期\" column=\"rkrq\" orderkey=\"rkrq\"/>"+
		"<col width=\"8%\"  text=\"入库单位\" column=\"rkdw\" orderkey=\"rkdw\"/>"+
		"<col width=\"8%\"  text=\"入库数量\" column=\"rksl\" orderkey=\"rksl\"/>"+
		"<col width=\"8%\"  text=\"实际价格(含税)\" column=\"sjjg\" orderkey=\"sjjg\"/>"+
		"<col width=\"8%\"  text=\"开票总额(含税)\" column=\"fpze\" orderkey=\"fpze\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=60&amp;formId=-268&amp;opentype=0&amp;customid=54&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+		
		"<col width=\"8%\"  text=\"仓库名称\" column=\"ckmc\" orderkey=\"ckmc\"/>"+
		"<col width=\"8%\"  text=\"物料编码\" column=\"wlbm\" orderkey=\"wlbm\"/>"+
		"<col width=\"8%\"  text=\"供应商\" column=\"gysmc\" orderkey=\"gysmc\"/>"+
		"<col width=\"8%\"  text=\"合同编号\" column=\"htbh\" orderkey=\"htbh\"  linkvaluecolumn=\"xght\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\"/>"+
		"<col width=\"8%\"  text=\"付款序号\" column=\"fkxh\" orderkey=\"fkxh\"/>"+

	"          </head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
        function onBtnSearchClick() {
			report.submit();
		 }
		 
		function whfp(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids："+ids);
			if(ids==""){
				top.Dialog.alert("请选择数据");
				return ;
			}
			if(ids.match(/,$/)){
				ids = ids.substring(0,ids.length-1);
			}
			if(ids.indexOf(",")!=-1){
				top.Dialog.alert("每次只能选择一条数据进行维护!");
				return;				
			}
			
			
			var xhr = null;
			if (window.ActiveXObject) {//IE浏览器
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			}else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}
			if (null != xhr) {
				xhr.open("GET","/goodbaby/whfp/pdsf.jsp?ids="+ids+"&type=edit", false);
				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							if(text=='1'){
								Dialog.alert("发票已被付款流程引用，不可更改！");
								return;
							}else{
								var url = "/goodbaby/whfp/edit.jsp?ids="+ids;
								var title = "更新发票";
								openDialog(url,title);								
							}
									
						}	
					}
				}
					xhr.send(null);			
			}
			
		}
		
		
		function del(){
			var ids = _xtable_CheckedCheckboxId();
			//alert(ids);
			if(ids==""){
				top.Dialog.alert("请选择数据");
				return ;
			}
			if(ids.match(/,$/)){
				ids = ids.substring(0,ids.length-1);
			}
			if(ids.indexOf(",")!=-1){
				top.Dialog.alert("每次只能选择一条数据进行维护!");
				return;				
			}
			
			
			var xhr = null;
			if (window.ActiveXObject) {//IE浏览器
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			}else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}
			if (null != xhr) {
				xhr.open("GET","/goodbaby/whfp/pdsf.jsp?ids="+ids+"&type=delete", false);
				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							if(text=='1'){
								Dialog.alert("发票已被付款流程引用，不可删除！");
								return;
							}else{
								jQuery("#czlx").val("del");
								jQuery("#delid").val(ids);
								report.submit();
							}
									
						}	
					}
				}
					xhr.send(null);			
			}
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		function openDialog(url,title){
			dialog = new window.top.Dialog();
			dialog.currentWindow = window;
			var url = url;
			dialog.Title = title;
			dialog.Width = 1200;
			dialog.Height = 600;
			dialog.Drag = true;
			dialog.URL = url;
			dialog.maxiumnable=true;//允许最大化
			dialog.show();
		}

		// function undo(){
			// var ids = _xtable_CheckedCheckboxId();
			///alert(sqr);
            /// if(ids!=null && ids!=""){
			 // alert(ids);
			  	// var xhr = null;
				// if (window.ActiveXObject) {//IE浏览器
					// xhr = new ActiveXObject("Microsoft.XMLHTTP");
				// } else if (window.XMLHttpRequest) {
					// xhr = new XMLHttpRequest();
				// }
				// if (null != xhr) {
					// xhr.open("GET","/gvo/pingfen/undo.jsp?id="+ids, false);
					// xhr.onreadystatechange = function () {
						// if (xhr.readyState == 4) {
							// if (xhr.status == 200) {
								// var text = xhr.responseText;
								// text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
								//alert(text);
								
							// }	
						// }
					// }
					// xhr.send(null);			
				// }
				// window.location.reload();
			// }
		// }
	</script>
	
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
