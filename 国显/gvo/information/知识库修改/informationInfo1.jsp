<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
	
<html>
<head>
<script type="text/javascript" src="/js/weaver.js"></script>
<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
<link rel="stylesheet" type="text/css" href="/gvo/information/css/css.css">
</head>



<BODY>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.weaver.submit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table style=" background-repeat:repeat-x;" width=100% height=100% border="0" cellspacing="0" cellpadding="0" background="/gvo/information/images/bannern.jpg">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	
</tr>
<tr>
	<td valign="top">
		<TABLE class=Shadow style=" background-color:#EDF1F5">
		<tr>
		<div class="zstop" style="height:180px; width:100%; position:relative;">
		  <div class="zslr" style=" position:absolute; width:90px; height:90px; left:30px; top:105px; color:#fff;"><a href="/formmode/view/AddFormMode.jsp?modeId=1001&formId=-325&type=1"  target="_blank">知识录入</a></div>
		  <div class="zscx" style=" position:absolute; width:90px; height:90px; left:150px; top:105px; color:#fff;"><a href="/formmode/search/CustomSearchBySimple.jsp?customid=961&e71459318042984=" target="_blank">知识查询</a></div>
		</div>
		
		<td valign="top">

<FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
	<input type="hidden" name="multiRequestIds" value="">
	<input type="hidden" name="operation" value="">
<div class="juzhong" style=" text-align:center;">
<div class="juzhong" style="margin:0 auto; width:1050px; padding-top:50px;">

<table width=100% class=ViewForm>
<tr>

<div class="ruodian1">
     <div class="ruodian">
        <a href="/gvo/information/informationInfoWeak.jsp" target="_blank">弱电类</a>
	 </div>
	 <div class="rdlist">
	    <ul>
	      <li>弱电类：包含综合布线、网络、视频系统、考勤门禁、监控系统和电话等异常问题的解决办法和技术手册。</li>
	    </ul>
	 </div>
	 </div>
	 <div class="yunwei1">
	 <div class="yunwei">
	    <a href="/gvo/information/informationInfoO&M.jsp" target="_blank">运维类</a>
	  </div>
	   <div class="ywlist">
	     <ul>
	      <li>运维类：包含桌面运维、存储技术、会务支持、服务器和数据库等异常问题的解决办法和技术手册。</li>      
	     </ul>
	  </div> 
	  </div>
	  <div class="yingyong1">
	   <div class="yingyong">
	     <a href="/gvo/information/informationInfosystem.jsp" target="_blank">应用系统</a>
		 </div>
		  <div class="yylist">
	     <ul>
	      <li>应用系统类：包含以应用系统和办公系统为主的各软件系统的异常问题解决办法和技术手册，主要由SAP ERP、Kingdee ERP、鼎捷 ERP、泛微OA、EMC D2、HR、BI、旧OA和FineReport等系统。</li>
	     </ul>
	 </div>  
	  
</div>
   
 
      
	 

   

     
	 

   
</tr>
</table></div></div>
</FORM>
		</td>
		</tr>
		</TABLE>
	</td>
	<!--<td></td>-->
</tr>
<tr>
	<!--<td height="10" colspan="3"></td>-->
</tr>

</table>


<script type="text/javascript">

function onShowResourceID(inputname,spanname){
	var opts={
			_dwidth:'550px',
			_dheight:'550px',
			_url:'about:blank',
			_scroll:"no",
			_dialogArguments:"",
			_displayTemplate:"#b{name}",
			_displaySelector:"",
			_required:"no",
			_displayText:"",
			value:""
		};
	var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //获得窗口的水平位置;
	opts.top=iTop;
	opts.left=iLeft;
		
	datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp",
	    		"","addressbar=no;status=0;scroll="+opts._scroll+";dialogHeight="+opts._dheight+";dialogWidth="+opts._dwidth+";dialogLeft="+opts.left+";dialogTop="+opts.top+";resizable=0;center=1;");
	if (datas) {
		if (datas.id!= "") {
			
			$("#"+spanname).html("<A href='javascript:openhrm("+datas.id+");' onclick='pointerXY(event);'>"+datas.name+"</A>");

			$("input[name="+inputname+"]").val(datas.id);
		}else{
			$("#"+spanname).html("");
			$("input[name="+inputname+"]").val("");
		}
	}
}
</script>
	<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>
