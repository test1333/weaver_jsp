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
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%

String isDialog = Util.null2String(request.getParameter("isdialog"));
String typename = Util.null2String(request.getParameter("typename"));
String backto = Util.null2String(request.getParameter("backto"));



String OA_DATE = Util.null2String(request.getParameter("OA_DATE"));
String year = Util.null2String(request.getParameter("year"));


%>
<html>
<head>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>

<script language="javascript" src="/js/weaver_wev8.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/dragBox/parentShowcol_wev8.js"></script>
<script type="text/javascript" src="/js/init_wev8.js"></script>
<link rel="stylesheet" href="/css/ecology8/request/requestView_wev8.css" type="text/css" />
<script type="text/javascript" src="/wui/common/jquery/plugin/jQuery.modalDialog_wev8.js"></script>
<script type="text/javascript" src="/wui/common/jquery/plugin/wuiform/jquery.wuiform_wev8.js"></script>
<link href="/js/checkbox/jquery.tzCheckbox_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
<style>
body {
    height: auto;
	width: auto;
}
.checkbox {
	display: none
}
.hideBlockDiv {
    width: 30px;
    float: right;
    display: none !important;
}
.e8_grouptitle{
	font-size:25px !important;
	text-align:center;
}
.cs{
	font-size:25px !important;
	text-align:center;
}
.div2{
	float:left;
}
</style>
</head>

<%
String imagefilename = "/images/hdDOC_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(23076,user.getLanguage())+" - "+SystemEnv.getHtmlLabelName(367,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<body id='setbody'>
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
		<td class="rightSearchSpan" style="text-align:right; width:500px!important">
	
			
		</td>
	</tr>
</table>
<input type="hidden" id="operate" name="operate" value="edit">
<div style = "width:50.5%;margin:150px auto;" id="advancedSearchDiv" > 
				<!--span>薪资年月:</span>
				<BUTTON type="button" class=Calendar id="SelectDate" onclick="gettheDate(OA_DATE,OA_DATEspan)"></BUTTON> 
            	<SPAN id=OA_DATEspan name = "OA_DATEspan"><%=OA_DATE%></SPAN> 
            	<INPUT  type="hidden" id = "OA_DATE" name="OA_DATE" value="<%=OA_DATE%>"--> 
			<wea:layout>
				<wea:group context="薪资年月" attributes="{'samePair':'SetInfo','groupOperDisplay':'none','itemAreaDisplay':'block'}">
					<wea:item><span class = "cs"  >年份</span></wea:item>
	                    <wea:item>
	                        <brow:browser name='year' viewType='0' browserValue='<%=year%>' isMustInput='1' browserSpanValue='<%=year%>' hasInput='true'
								linkUrl= '' completeUrl='/data.jsp?type=178' width='60%' isSingle='true' hasAdd='false' 
								browserUrl='/systeminfo/BrowserMain.jsp?url=/workflow/field/Workflow_FieldYearBrowser.jsp?resourceids=#id#'>
							</brow:browser> 
						</wea:item>	
					<wea:item><span class = "cs">月份</span></wea:item>
	                    <wea:item><select id="months" name="months" onchange="" >
								<option value=""></option>
								<option value="1">一月</option>
								<option value="2">二月</option>
								<option value="3">三月</option>
								<option value="4">四月</option>
								<option value="5">五月</option>
								<option value="6">六月</option>
								<option value="7">七月</option>
								<option value="8">八月</option>
								<option value="9">九月</option>
								<option value="10">十月</option>
								<option value="11">十一月</option>
								<option value="12">十二月</option>
							</select>   
					</wea:item>	
				
				</wea:group>
			</wea:layout>	
			<div style="margin:40px auto;">
				<div style = "border:1px solid #968989;width:90px;height:30px;margin-left:229px;border-radius: 9px 9px 9px 9px;background-color:#2690e3;line-height:30px;text-align:center;font-size:17px;" class="div2">
				<a href="javascript:void(0)" style="color:white;" onclick="salaryToHr()"  >提交</a>
				</div>
				<div style = "width:90px;height:30px;line-height:30px;text-align:center;font-size:17px;" class="div2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<div style = "border:1px solid #968989;width:90px;height:30px;border-radius: 9px 9px 9px 9px;background-color:#2690e3 ;line-height:30px;text-align:center;font-size:17px;" class="div2">
				<a href="javascript:void(0)" style="color:white;" onclick="resetCondtion()">清空</a>
				</div>
			</div>

</div>



</body>
</html>
<script type="text/javascript">

function salaryToHr(){
	var year = document.getElementsByName("year")[0].value;
	
	var month = jQuery("#months").val();
	if(year.length<4){
		Dialog.alert("请选择薪资年份");
		return ;
	}
	if(month.length<1){
		Dialog.alert("请选择薪资月份");
		return ;
	}
	if(Number(month)<10){
		month = "0"+month;
	}
	var rq = year+"-"+month+"-01";
	if(rq.length<8){
		Dialog.alert("请检查选择的薪资年月");
		return ;
	}
	// alert("年-----"+year+"--月----"+month)
	// alert(rq);
	// return;
	var xhr = null;  
	if(window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP"); 
	}else if (window.XMLHttpRequest){ 
                    xhr =new XMLHttpRequest(); 
	}
	if (null!= xhr) { 
		xhr.open("GET","/commcache/cacheMonitor.jsp?isreload=1",false);//清除缓存
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4){ 
				if(xhr.status==200){ 
					var text= xhr.responseText; 
				} 
			} 
		} 
		xhr.send(); 
	}
	// var msg = "是否执行"+year+"年"+month+"月的薪资数据汇总？"; 
	// Dialog.confirm(msg, function (){
		// alert（1）	
	// });
	top.Dialog.confirm("是否执行"+year+"年"+month+"月的薪资数据汇总？", function (){
		var result = checkSF(rq);
		if(!result){
			Dialog.alert("该薪资年月的数据已执行过汇总，不能多次汇总！");
		}else{
			Dialog.alert(result);
		}
		
		
	}, function () {
		
		// alert(2);//取消
					}, 320, 90,true);
}
function checkSF(dates){
	var res = true;
	var xhr = null;  
	if(window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP"); 
	}else if (window.XMLHttpRequest){ 
                    xhr =new XMLHttpRequest(); 
	}
	if (null!= xhr) { 
		xhr.open("GET","/gvo/hrm/salary/check.jsp?rq="+dates,false);
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4){ 
				if(xhr.status==200){ 
					var text= xhr.responseText; 
					text=text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
					if(text == '1'){
						res = false;
					}else if(text == '2'){
						res = "该薪资年月的数据还未被整理！";
					}else{
						res = text;
					}
				} 
			} 
		} 
		xhr.send(); 
	}
	return res;
	
}

</script>
<script language=javascript src="/js/checkData_wev8.js"></script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
