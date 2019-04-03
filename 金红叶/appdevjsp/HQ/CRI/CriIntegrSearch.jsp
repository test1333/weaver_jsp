<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util,java.util.*,java.math.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="subCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<%@page import="weaver.workflow.workflow.WorkflowVersion" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*,java.text.DecimalFormat" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<HTML>
<HEAD>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
	<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
	<link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
	<style>
		.hiderow{
			display:none;
		}
		.hiderowperson{
			display:none;
		}
		.hiderowunit{
			display:none;
		}
		.fieldName{
			padding-left:1px !important;
		}
	</style>
</head>
<BODY onmousedown="clickevent()" >
	<jsp:include page="/systeminfo/commonTabHead.jsp">
		<jsp:param name="mouldID" value="workflow" />
		<jsp:param name="navName" value="案件综合搜索" />
	</jsp:include>
	<%
	String titlename = "案件综合搜索" ; 
	String keyword = Util.null2String(request.getParameter("keyname"));	
	String sadwid = "";
	String ajxqid = "";
	%>
	<!-- start -->
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage()) + ",javascript:searchall(),_self}";
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{Excel,/weaver/weaver.file.ExcelOut,_self} " ;
		RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<table id="topTitle" cellpadding="0" cellspacing="0">
		<tr>
			<td>
			</td>
			<td class="rightSearchSpan" style="text-align: right;">
				<input type="hidden" name="optnum" id="optnum" value="0"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage())%>" onClick="searchall()" />
				<span title="<%=SystemEnv.getHtmlLabelName(82529, user.getLanguage())%>" class="cornerMenu"></span>
			</td>
		</tr>
	</table>  
	<div>
		<wea:layout type="3col" attributes="{expandAllGroup:true}">
			<wea:group context="<%=SystemEnv.getHtmlLabelName(82529, user.getLanguage())%>">
				<wea:item><%=SystemEnv.getHtmlLabelName(84128, user.getLanguage())%></wea:item>  
				<wea:item >
					<input class=inputstyle id="key" type=text style="width:750px;height:25px;font-size:20px;" name="key"  />
				</wea:item>
				<wea:item>
					<span style="color:red;display:none;font-weight:bold;font-size:15px;" id='titleinfo' ><%=SystemEnv.getHtmlLabelName(84128, user.getLanguage())%></span>
				</wea:item> 
			</wea:group>
		</wea:layout>
		<wea:layout type="3col">
			<wea:group context="<%=SystemEnv.getHtmlLabelName(-11590, user.getLanguage())%>">
				<wea:item>
					<div id="showdatadiv_ajinfo"></div>
				</wea:item>
			</wea:group>
			<wea:group context="<%=SystemEnv.getHtmlLabelName(-11591, user.getLanguage())%>">
				<wea:item>
					<div id="showdatadiv_person"></div>
				</wea:item>
			</wea:group>
			<wea:group context="<%=SystemEnv.getHtmlLabelName(-11592, user.getLanguage())%>">
				<wea:item>
					<div id="showdatadiv_unit"></div>
				</wea:item>
			</wea:group>
		</wea:layout>

	</div>	
</body>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript>
	jQuery(document).ready(function(){
		ajaxinit();
		function keyevent(){ 
			if(event.keyCode==13){
				searchall();
			} 
			setTimeout(function(){
				jQuery(".fieldName").attr("style","padding-left:5px!important;")
			},500);
		} 			
		document.onkeydown = keyevent; 	
	})	
	
	function clickevent(){		
		var key=jQuery("#optnum").val();
		if(key=="200"){
			$("#rightMenuIframe").contents().find("#menuItemDivId1").show();
		}else{
			$("#rightMenuIframe").contents().find("#menuItemDivId1").hide();
		}		
	}	
	function searchall(){
		jQuery("#optnum").val(0);
		showdata();
		showdata_persion();
		showdata_unit();
	}	
	function ajaxinit(){
		var ajax=false;
		try{
			ajax = new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e){
			try{
				ajax = new ActiveXObject("Microsoft.XMLHTTP");
			}catch(E){
				ajax = false;
			}
		}
		if(!ajax && typeof XMLHttpRequest!='undefined'){
			ajax = new XMLHttpRequest();
		}
		return ajax;
	}
	function showdata(){		
		var key=jQuery("#key").val(); 
		key=key.trim();
		if(key!=""){		
			var html="<table id='scrollarea' name='scrollarea' width='100%' height='100%' style='display:inline;zIndex:-1' ><tr><td align='center' valign='center'><fieldset style='width:100%'><img src='/images/loading2_wev8.gif'><%=SystemEnv.getHtmlLabelName(20204,user.getLanguage())%></fieldset></td></tr></table>";
			document.all("showdatadiv_ajinfo").innerHTML=html;
			var ajax=ajaxinit();
			ajax.open("POST","CriIntegrSearchAjax.jsp",true);
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("key="+key);
			//获取执行状态
			ajax.onreadystatechange = function() {
				//如果执行状态成功，那么就把返回信息写到指定的层里
				if (ajax.readyState == 4 && ajax.status == 200){
					try{
						jQuery("#optnum").val((jQuery("#optnum").val())*1+1);
						document.all("showdatadiv_ajinfo").innerHTML=ajax.responseText;
						createExcel();
					}catch(e){
						return false;
					}
				}
			}
		}else{
			jQuery("#titleinfo").show();
			setTimeout(function(){
				jQuery("#titleinfo").hide();
			},2000)
		}
	}		
	function showdata_persion(){		
		var key=jQuery("#key").val(); 
		key=key.trim();
		if(key!=""){		
			var html="<table id='scrollarea' name='scrollarea' width='100%' height='100%' style='display:inline;zIndex:-1' ><tr><td align='center' valign='center'><fieldset style='width:100%'><img src='/images/loading2_wev8.gif'><%=SystemEnv.getHtmlLabelName(20204,user.getLanguage())%></fieldset></td></tr></table>";
			document.all("showdatadiv_person").innerHTML=html;
			var ajax=ajaxinit();
			ajax.open("POST","CriIntegrSearchAjax_persion.jsp",true);
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("key="+key);
			//获取执行状态
			ajax.onreadystatechange = function() {
				//如果执行状态成功，那么就把返回信息写到指定的层里
				if (ajax.readyState == 4 && ajax.status == 200){
					try{
						jQuery("#optnum").val((jQuery("#optnum").val())*1+1);
						document.all("showdatadiv_person").innerHTML=ajax.responseText;
						createExcel();
					}catch(e){
						return false;
					}
				}
			}
		}else{
			jQuery("#titleinfo").show();
			setTimeout(function(){
				jQuery("#titleinfo").hide();
			},2000)
		}
	}
	function showdata_unit(){		
		var key=jQuery("#key").val(); 
		key=key.trim();
		if(key!=""){		
			var html="<table id='scrollarea' name='scrollarea' width='100%' height='100%' style='display:inline;zIndex:-1' ><tr><td align='center' valign='center'><fieldset style='width:100%'><img src='/images/loading2_wev8.gif'><%=SystemEnv.getHtmlLabelName(20204,user.getLanguage())%></fieldset></td></tr></table>";
			document.all("showdatadiv_unit").innerHTML=html;
			var ajax=ajaxinit();
			ajax.open("POST","CriIntegrSearchAjax_unit.jsp",true);
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("key="+key);
			//获取执行状态
			ajax.onreadystatechange = function() {
				//如果执行状态成功，那么就把返回信息写到指定的层里
				if (ajax.readyState == 4 && ajax.status == 200){
					try{
						jQuery("#optnum").val((jQuery("#optnum").val())*1+1);
						document.all("showdatadiv_unit").innerHTML=ajax.responseText;
						createExcel();
					}catch(e){
						return false;
					}
				}
			}
		}else{
			jQuery("#titleinfo").show();
			setTimeout(function(){
				jQuery("#titleinfo").hide();
			},2000)
		}
	}		
	function showALL(){
		jQuery(".hiderow").show();
		jQuery("#showALL").hide();
	}
	function showALLperson(){
		jQuery(".hiderowperson").show();
		jQuery("#showALLperson").hide();
	}
	function showALLunit(){
		jQuery(".hiderowunit").show();
		jQuery("#showALLunit").hide();
	}	
	function createExcel(){				
		var key=jQuery("#optnum").val(); 
		if(key=="3"){		
			var ajax=ajaxinit();
			var aj=jQuery("#aj").val(); 
			var person=jQuery("#person").val(); 
			var unit=jQuery("#unit").val(); 
			ajax.open("POST","CriIntegrSearchExcel.jsp",true);
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("aj="+aj+"&person="+person+"&unit="+unit);
			//获取执行状态
			ajax.onreadystatechange = function() {
				//如果执行状态成功，那么就把返回信息写到指定的层里
				if (ajax.readyState == 4 && ajax.status == 200){
					try{
						jQuery("#optnum").val(ajax.status);
						$("#rightMenuIframe").contents().find("#menuItemDivId1").show();
					}catch(e){
						jQuery("#optnum").val(e);
					}
				}
			}
		}
	}
</script>
</html>