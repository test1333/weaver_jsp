<%@page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<HTML>
<HEAD>
<link href="/css/Weaver.css" type=text/css rel=STYLESHEET></link>
<script type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
<style>
	#loading {
	Z-INDEX: 20001; BORDER-BOTTOM: #ccc 1px solid; POSITION: absolute; BORDER-LEFT: #ccc 1px solid; PADDING-BOTTOM: 8px; PADDING-LEFT: 8px; PADDING-RIGHT: 8px; BACKGROUND: #ffffff; HEIGHT: auto; BORDER-TOP: #ccc 1px solid; BORDER-RIGHT: #ccc 1px solid; PADDING-TOP: 8px; TOP: 40%; LEFT: 45%
}
</HEAD>
<%
	String arrOtherTab="[";
	// arrOtherTab+="{	title:'已办传阅子流程',autoScroll : true,url:'/gcl/ybgw/dbgw_all.jsp',id:'t8887'}";
	arrOtherTab+=",{title:'人事任免',autoScroll : true,url:'/gcl/ybgw/dbgw_rsrm.jsp',id:'t8888'}";
	arrOtherTab+=",{title:'行政公告',autoScroll : true,url:'/gcl/ybgw/dbgw_xzgg.jsp',id:'t8889'}";
	arrOtherTab+=",{title:'会议纪要',autoScroll : true,url:'/gcl/ybgw/dbgh_hyjy.jsp',id:'t8890'}";
	arrOtherTab+="]";

%>
<script type="text/javascript">

<style type="text/css">
    #i{
        width: 100%;
        height: 90%;
        scrolling: auto;
    }
    $(document.body).css({"overflow-y":"hidden";"overflow-x":"hidden";});
</style>
</head>

<body scroll="no"> 
<DIV style="" id=loading><SPAN><IMG align=absMiddle src="/images/loading2.gif"></SPAN> <SPAN id=loading-msg><%=SystemEnv.getHtmlLabelName(19945,user.getLanguage())%></SPAN> </DIV>
<table width="100%" style="min-width:820px;height:100%;">
	<colgroup>
		<col width="5">
		<col width="">
		<col width="5">
	</colgroup>
	<tr style="height:1px;">
		<td></td>
		<td>
			
			<table cellpadding="0" cellspacing="0" width="100%" border="0">
			  	<tr>
			  		<td width="6px" height="28px;" style="">
						<div id="tab-left" class="tab-left-selected" style="">
							
						</div>
					</td>
					<td>
						<div id="tab-center" >
							<ul>
								<li sid='OA1'  first=yes url='/gcl/gwmh/dbgw/ybgw_all.jsp'><div class="tab-selected tab-item" ><a href='javascript:void(0)'>已办传阅子流程</a></div><li>
								<li sid='OA2'  url='/gcl/gwmh/ybgw/ybgw_rsrm.jsp'><div class="tab-item" ><a href='javascript:void(0)'>人事任免</a></div><li>
								<li sid='OA3'  url='/gcl/gwmh/ybgw/ybgw_xzgg.jsp'><div class="tab-item" ><a href='javascript:void(0)'>行政公告</a></div><li>
								<li sid='OA4'  url='/gcl/gwmh/ybgw/ybgw_hyjy.jsp'><div class="tab-item" ><a href='javascript:void(0)'>会议纪要</a></div><li>
							</ul>
						</div>
					</td>
					<td width="6px" style="">
						<div id="tab-right" style=""></div>
					</td>
			  	</tr>
	  		</table>
 
		
		</td>
		<td></td>
			
	</tr>
	<tr style="height:100%">
		<td colspan="3" style="height:100%">
			
		  <div id="content" style="height:100%">
				<iframe src='/gcl/gwmh/ybgw/ybgw_all.jsp'  id='iframepage'  frameBorder=0 scrolling=auto width=100% height='100%' onload="loading()"  style='display:block;'></iframe>
		  </div>
		</td>
	</tr>
</table>
<script type="text/javascript" language="javascript">   
	  function loading(){
		  $("#loading").hide();
	 }

	$("#tab-left").addClass("tab-left-selected");
	
	$(function(){
		initMenuWidth();
		$("#tab-center li").click(function(){
			$("#tab-center li .tab-selected").removeClass("tab-selected");
			$(this).children("div").addClass("tab-selected");
			$("#content iframe").css("display","none");
			var temid=$(this).attr("sid");
			if($(this).attr("first")=="yes"){
				$("#tab-left").removeClass("tab-left-unselected");
				$("#tab-left").addClass("tab-left-selected");
				
				$("#iframepage").css("display","block");
				
			}else{
				$("#tab-left").removeClass("tab-left-selected");
				$("#tab-left").addClass("tab-left-unselected");
				if($("#"+$(this).attr("sid")).attr("src")==undefined){
				  $("#content").append(	" <iframe src=''  id='"+$(this).attr("sid")+"'  frameBorder=0 onload=\"loading()\" scrolling=auto width='100%'  height='100%' onload='loading();'  style='display:none;'></iframe>");
				  $("#"+$(this).attr("sid")).attr("src",$(this).attr("url")).load(function(){});
					$("#loading").hide();
					$("#loading").show();
				}else{
					$("#loading").hide();
				}
			}
		
			
				$("#"+$(this).attr("sid")).css("display","block");
		});
		window.onresize=function(){
			var ifms=document.getElementsByTagName("iframe");
			for(var i=0;i<ifms.length;i++ ){
				ifms[i].height=document.body.clientHeight-getElementTop(ifms[i])-3;
			}
		}
	});
	function getElementTop(element){
	　　　　var actualTop = element.offsetTop;
	　　　　var current = element.offsetParent;

	　　　　while (current !== null){
	　　　　　　actualTop += current.offsetTop;
	　　　　　　current = current.offsetParent;
	　　　　}

	　　　　return actualTop;
	　　}
	function initMenuWidth(){
		var tabWidth=0;
		$("#tab-center li").each(function(e,e2){
			tabWidth+=$(e2).width();
		});
		$("#tab-center ul").css("width",tabWidth+10);
	}
</script>
</body>
</HTML>

