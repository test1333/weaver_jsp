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
	 int userid  = user.getUID();
	String tmc_pageId = "purchase211";
	GetGNSTableName gg = new GetGNSTableName();
	String tablename_rk = gg.getTableName("RKD");//入库单
	String tablename_dd = gg.getTableName("CGDD");//订单
	String tablename_ht = gg.getTableName("FKJHT");//非框架合同
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
RCMenu += "{申请发票,javascript:whfp(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action="/goodbaby/whfp/Purchase2.jsp" method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type="button" class="e8_btn_top_first"  value="申请发票" title="申请发票"  onclick="whfp()" style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
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
     backfields = " (select name from crm_customerinfo where id=tt.xtgys) as xtkhmc,tt.lbid, tt.id,tt.xtgys,tt.wlmc,tt.cgsqd,tt.RKDH,tt.rksj,tt.dw,tt.SJSHSL_1,tt.DJ_1,tt.JE_1,tt.ck,tt.WLBH_1,tt.lxmc,tt.lxid,rkrqid,xght,fkxh,fktj,fkje,htbh ";
	 fromSql  = " from (select (select buydl  from uf_NPP where id = (select wllx from uf_materialDatas  where WLBM =c.WLBH_1))as lbid, (select dbo.fpsfwh(c.cgsqd,a.requestid)) as zt, a.id,a.xtgys, (select WLMC from uf_materialDatas  where id = c.WLMC_1) as wlmc ,(select ub.buydl  from uf_buydl ub join  uf_NPP un on un.buydl=ub.id join uf_materialDatas  um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id  from uf_buydl ub join  uf_NPP un on un.buydl=ub.id join uf_materialDatas  um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj ,(select dw  from  uf_unitForms  where id= (select DW from uf_materialDatas  where id = c.WLMC_1)) as dw,c.SJSHSL_1,c.JE_1,c.DJ_1,c.cgsqd,(select CKMC from uf_stocks  where id = a.SHCK) as ck,c.WLBH_1,a.requestid as rkrqid,c.xght,c.fkxh,c.fktj,c.fkje,(select htbh from "+tablename_ht+" where requestid=c.xght) as htbh from  "+tablename_rk+"  a join workflow_requestbase b on a.requestid=b.requestid join "+tablename_rk+"_dt1 c on c.mainid = a.id  where b.currentnodetype >= 3 ) tt  ";
	 sqlWhere = " where 1=1 and tt.zt=2 and tt.lbid<>'2' ";
	if(!"".equals(rkdh)){
		sqlWhere +=" and tt.RKDH like '%"+rkdh+"%'";
	}
	if(!"".equals(wlmc)){
		sqlWhere +=" and tt.wlmc like '%"+wlmc+"%'";
	}
	if(!"".equals(wlbm)){
		sqlWhere +=" and tt.WLBH_1 like '%"+wlbm+"%'";
	}
	if(userid!=1){
		sqlWhere +=" and tt.xtgys = '"+userid+"'";
	}
	if(!"".equals(wllx)){
		sqlWhere +=" and tt.lxid = '"+wllx+"'";
	}		
	if(!"".equals(star)){
		sqlWhere +=" and tt.rksj >= '"+star+"'";
	}
	if(!"".equals(endr)){
		sqlWhere +=" and tt.rksj <='"+endr+"'";
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
		tableString+="<col width=\"10%\"  text=\"物料名称\" column=\"wlmc\" orderkey=\"wlmc\"/>"+
		"<col width=\"8%\"  text=\"物料类型\" column=\"lxmc\" orderkey=\"lxmc\"/>"+
		"<col width=\"8%\"  text=\"入库单号\" column=\"RKDH\" orderkey=\"RKDH\" linkvaluecolumn=\"rkrqid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\"/>"+
		"<col width=\"8%\"  text=\"入库日期\" column=\"rksj\" orderkey=\"rksj\"/>"+
		"<col width=\"8%\"  text=\"入库单位\" column=\"dw\" orderkey=\"dw\"/>"+
		"<col width=\"8%\"  text=\"入库数量\" column=\"SJSHSL_1\" orderkey=\"SJSHSL_1\"/>"+
		"<col width=\"10%\"  text=\"实际价格(含税)\" column=\"DJ_1\" orderkey=\"DJ_1\"/>"+
		"<col width=\"8%\"  text=\"仓库名称\" column=\"ck\" orderkey=\"ck\"/>"+
		"<col width=\"8%\"  text=\"物料编码\" column=\"WLBH_1\" orderkey=\"WLBH_1\"/>"+
		"<col width=\"8%\"  text=\"供应商\" column=\"xtkhmc\" orderkey=\"xtkhmc\"/>"+
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
			
			if(ids==""){
				top.Dialog.alert("请选择数据");
				return ;
			}
			if(ids.match(/,$/)){
				ids = ids.substring(0,ids.length-1);
			}
			//alert("ids："+ids);
			var checkresult = "";
			 jQuery.ajax({
             type: "POST",
             url: "/goodbaby/whfp/checkdata.jsp",
             data: {'ids':ids,'type':'flx'},
             dataType: "text",
             async:false,//同步   true异步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        checkresult=data;
						
                      }
        	 });
			// alert(checkresult);
			// if(checkresult == "1"){
			//	top.Dialog.alert("所选开票项，50部门不同，请重新选择");
			//	return ;
			// }
			  if(checkresult == "2"){
				top.Dialog.alert("所选开票项，币种不同，请重新选择");
				return ;
			 }

			var xhr = null;
			if (window.ActiveXObject) {//IE浏览器
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			}else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}
			if (null != xhr) {
				xhr.open("GET","/goodbaby/whfp/pdht.jsp?ids="+ids, false);
				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert(text);
							if(text=='1'){
								Dialog.alert("该类物料发票填写必须是同一个合同的订单！");
								return;
							}else{
								var url = "/goodbaby/whfp/whfpInfoUrl.jsp?ids="+ids+"&type=insert&wplx=flx";
								var title = "";
								openDialog(url,title);
							}									
						}	
					}
				}
					xhr.send(null);			
			}
			
			
			
			
			
			
			
			
			
			
			//window.location="/goodbaby/ztb/bidUrl.jsp?id ="+aid;
			//parent.location.href = "/goodbaby/ztb/bidUrl.jsp?id ="+aid;
			//window.location.href = "/goodbaby/ztb/bidUrl.jsp?id ="+aid;
			
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
