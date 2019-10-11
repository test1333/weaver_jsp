<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.general.Util"%>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="GetFormDetailInfo" class="weaver.workflow.automatic.GetFormDetailInfo" scope="page" />
<jsp:useBean id="DataSourceXML" class="weaver.servicefiles.DataSourceXML" scope="page" />

<html>
<head>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script language="javascript" src="/js/weaver_wev8.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/dragBox/parentShowcol_wev8.js"></script>
<link rel="stylesheet" href="/css/ecology8/request/requestView_wev8.css" type="text/css" />
<script type="text/javascript" src="/wui/common/jquery/plugin/jQuery.modalDialog_wev8.js"></script>
<script type="text/javascript" src="/wui/common/jquery/plugin/wuiform/jquery.wuiform_wev8.js"></script>
<link href="/js/checkbox/jquery.tzCheckbox_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
</head>
<%
String imagefilename = "/images/hdDOC_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(23076,user.getLanguage())+" - "+SystemEnv.getHtmlLabelName(367,user.getLanguage());
String needfav ="1";
String needhelp ="";

String ids = Util.null2String(request.getParameter("ids"));
String xzyh = Util.null2String(request.getParameter("xzyh"));
String yhmc = Util.null2String(request.getParameter("yhmc"));
String fkq = Util.null2String(request.getParameter("fkq"));

%>
<body id='setbody' >
<div class="zDialog_div_content">
<script language=javascript >
var parentWin = parent.parent.getParentWindow(parent);
</script>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(1),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
// if(viewid.equals("")){
// RCMenu += "{"+SystemEnv.getHtmlLabelName(125540,user.getLanguage())+",javascript:submitData(2),_self} " ;//保存后详细设置
// RCMenuHeight += RCMenuHeightStep ;
// }

//RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:onBack(),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
		<td class="rightSearchSpan" style="text-align:right; width:500px!important">
			<input type="button" id="submitData" value="<%=SystemEnv.getHtmlLabelName(86 ,user.getLanguage()) %>" class="e8_btn_top" onclick="submitData(1)"/>
			
			<span title="<%=SystemEnv.getHtmlLabelName(23036 ,user.getLanguage()) %>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<form name="frmmain" method="post" action="" style="height:100%;">
<wea:layout>
	<wea:group context='请选择' attributes="{'samePair':'BaseInfo','groupOperDisplay':'none'}">
	  <wea:item>选择银行</wea:item>
			<wea:item>
				<wea:required id="xzyh" required="false" value='<%=xzyh%>'>				
				<brow:browser viewType="0" name="xzyh"
                        	browserValue="<%=xzyh%>"
                            browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.gns_bank"
                            hasInput="true" hasBrowser="true" isMustInput='1'
                            isSingle="false"
                            width="165px"
                            linkUrl=""
                            browserSpanValue="<%=xzyh%>">
                        </brow:browser>
				</wea:required>
			</wea:item>
		</wea:group>
	</wea:layout>
</form>
	<div id="zDialog_div_bottom" class="zDialog_div_bottom">
		<input type="button" style="display:none;" class=zd_btn_submit accessKey=S  id=btnsearch value="S-<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%>"></input>
		<wea:layout needImportDefaultJsAndCss="false">
			<wea:group context=""  attributes="{'groupDisplay':'none'}">
				<wea:item type="toolbar">
					<input type="button" class=zd_btn_cancle accessKey=T  id=btncancel value="T-<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>" onclick="onClose();"></input>
				</wea:item>
			</wea:group>
		</wea:layout>
		<script type="text/javascript">
			jQuery(document).ready(function(){
				resizeDialog(document);
			});
		</script>
	</div>
</div>
</body>
</html>
<script language="javascript">

jQuery(document).ready(function(){
	jQuery("#shifou").val("0");
 jQuery("input[type=checkbox]").each(function(){
  if(jQuery(this).attr("tzCheckbox")=="true"){
   jQuery(this).tzCheckbox({labels:['','']});
  }
 });
});

$(document).ready(function(){
	wuiform.init();
});


function onClose(){
	parentWin.closeDialog();
}
function submitData(type){
	if(type=='1'){
		// var rq = jQuery("#fkq").val();//20181217
		var yh = jQuery("#xzyh").val();
		if(yh.length<1){
			Dialog.alert("请选择银行！");
			return false;
		}
		// if(rq.length<1){
			// Dialog.alert("请输入日期！");//20181217
			// return false;
		// }
		
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		}else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
			//alert()
		if (null != xhr) {
			xhr.open("GET","/goodbaby/payment/dateInfo.jsp?ids=<%=ids%>&type=Update&yh="+yh, false);//20181217
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
			
	}
	window.parent.closeDialogP();
	
		
}

</script>
<script language=javascript src="/js/checkData_wev8.js"></script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
