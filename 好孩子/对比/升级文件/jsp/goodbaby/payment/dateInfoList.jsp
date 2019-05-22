<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
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
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
int userid = user.getUID();
String pageID = "data12311";

String gysmcs = Util.null2String(request.getParameter("gysmcs"));
String pkbhs = Util.null2String(request.getParameter("pkbhs"));

String pklcid = Util.null2String(request.getParameter("pklcid"));
String pc = Util.null2String(request.getParameter("pc"));


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
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	// RCMenu += "{数据处理,javascript:opera(),_self} " ;
	// RCMenuHeight += RCMenuHeightStep ;
	// RCMenu += "{废弃不用,javascript:fq(),_self} " ;
	// RCMenuHeight += RCMenuHeightStep ;
	  RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
	  RCMenuHeight += RCMenuHeightStep;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
	<input type="hidden" name="aa" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" id="cflc" name = "cflc"  value="分批处理" class="e8_btn_top" onClick="opera()" />
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
	
	    <wea:item>供应商名称</wea:item>
		<wea:item>
			<input type="text" name="gysmcs" id="gysmcs" class="InputStyle" value="<%=gysmcs%>"/>
		</wea:item>
		
	    <wea:item>排款编号</wea:item>
		<wea:item>
			<input type="text" name="pkbhs" id="pkbhs" class="InputStyle" value="<%=pkbhs%>"/>
		</wea:item>

	</wea:group>
	
	<wea:group context="">
		<wea:item type="toolbar">
			<input class="e8_btn_submit" type="submit" name="submit_1" onClick="OnSearch()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
		</wea:item>
	</wea:group>
	
</wea:layout>

</div>
	</FORM>
	<%	
	String backfields = " uu.id,uu.gysmc,uu.pkbhs,uu.flag,uu.pcno,uu.pklcid,uu.cnqr, uu.bcyf,uu.bcsf,uu.khh,uu.yhzh,uu.lhh,uu.jgh,case when uu.zhsk='0' then '是' else '否' end as zhsk,uu.cnaps,uu.remark "; 
	String fromSql  = " from (select id,flag,pklcid,pcno,cnqr,(select pkbh from formtable_main_275 where requestid = pklcid) as pkbhs ,(select u.GYSMC from uf_suppmessForm u where u.id =gys ) as gysmc, bcyf,bcsf, khh,yhzh,lhh,jgh,zhsk,cnaps,remark from uf_fkzjb) uu ";
	String sqlWhere = " where  1=1 and flag = 1 and cnqr = 0 and pcno= '"+pc+"' and pklcid='"+pklcid+"' ";	
	// if(userid!=1){
		// sqlWhere =sqlWhere+" and uu.BMTJR = '"+userid+"' ";
	// }
	String orderby = " uu.id " ;
	String tableString = "";
	//out.println("select "+ backfields + fromSql + "where " + sqlWhere);
	
//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(pageID,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+pageID+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                  
	  tableString+="<col width=\"10%\" text=\"排款编号\" column=\"pkbhs\" orderkey=\"pkbhs\"/>"+
	  "<col width=\"10%\" text=\"供应商\" column=\"gysmc\" orderkey=\"gysmc\"/>"+
	  "<col width=\"10%\" text=\"本次应付款\" column=\"bcyf\" orderkey=\"bcyf\" />"+
	  "<col width=\"10%\" text=\"本次实付\" column=\"bcsf\" orderkey=\"bcsf\" />"+
	  "<col width=\"10%\" text=\"收款银行\" column=\"khh\" orderkey=\"khh\" />"+
	  "<col width=\"10%\" text=\"收款银行账户\" column=\"yhzh\" orderkey=\"yhzh\" />"+
	  "<col width=\"10%\" text=\"收款行联行号\" column=\"lhh\" orderkey=\"lhh\" />"+
	  "<col width=\"10%\" text=\"收款行机构号\" column=\"jgh\" orderkey=\"jgh\" />"+	  
	  "<col width=\"10%\" text=\"是否中行收款\" column=\"zhsk\" orderkey=\"zhsk\" />"+
	  "	<col width=\"10%\" text=\"CNAPS行号\" column=\"cnaps\" orderkey=\"cnaps\" />"+
	  "	<col width=\"10%\" text=\"备注\" column=\"remark\" orderkey=\"remark\"  />"+
	  "	</head>"+
         " </table>";
	
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  showExpExcel="false"/>

	<script type="text/javascript">	
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
	}	
	
	function onBtnSearchClick() {
		report.submit();
	}
	function setCheckbox(chkObj) {
		if (chkObj.checked == true) {
			chkObj.value = 1;
		} else {
			chkObj.value = 0;
		}
	}
	function opera(){
		var ids = _xtable_CheckedCheckboxId();
		//alert("ids："+ids);
		if(ids==""){
			top.Dialog.alert("请选择数据");
			return ;
		}
		if(ids.match(/,$/)){
			ids = ids.substring(0,ids.length-1);
		}
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		}else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			xhr.open("GET","/goodbaby/payment/dateInfo.jsp?type=check&ids="+ids, false);
			xhr.onreadystatechange = function () {
				if (xhr.readyState == 4) {
					if (xhr.status == 200){
						var text = xhr.responseText;
						text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						if(text=='1'){
							Dialog.alert("只能选择同一排款编码！");
							return;
						}						
					}
				}
			}
			xhr.send(null);			
		}		
		var url = "/goodbaby/payment/xzyhTab.jsp?ids="+ids;
		var title = "";
		openDialog(url,title);
	}	
	function openDialog(url,title){
		dialog = new window.top.Dialog();
		dialog.currentWindow = window;
		var url = url;
		dialog.Title = title;
		dialog.Width = 400;
		dialog.Height = 500;
		dialog.Drag = true;
		dialog.URL = url;		
		dialog.maxiumnable=false;//允许最大化	
		dialog.show();
	}
	</script>
</BODY>
</HTML>
