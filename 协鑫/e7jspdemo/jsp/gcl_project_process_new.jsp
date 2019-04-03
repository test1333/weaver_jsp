<%@ page language="java" contentType="text/html; charset=GBK" %>
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
		<style type="text/css">
		.container {
			position: relative;
			overflow: hidden;
			font-size: 0;
		}
		div {
			float: left;
		}
		.cssBefore1 {
			width: 15px;
			height: 0;
			border: 10px solid LightSkyBlue;
			border-left-color: #fff;
		}
		.cssBefore2 {
			width:82%;
			height: 20px;
			color:white;
			background-color: LightSkyBlue;
			text-align:center;
			vertical-align: middle;
			font-size: 9pt;
		}
		.cssBefore3 {
			width: 15px;
			height: 0;
			border: 10px solid #fff;
			border-left-color: LightSkyBlue;
		}
		
		.cssAfter1 {
			width: 15px;
			height: 0;
			border: 10px solid DodgerBlue;
			border-left-color: #fff;
		}
		.cssAfter2 {
			width:82%;
			height: 20px;
			color:white;
			background-color: DodgerBlue;
			text-align:center;
			vertical-align: middle;
			font-size: 9pt;
		}
		.cssAfter3 {
			width: 15px;
			height: 0;
			border: 10px solid #fff;
			border-left-color: DodgerBlue;
		}
	
	<!--li{float:left;list-style:none;}-->
</style>
	</head>
	<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0); 
		response.flushBuffer();%>
	<%
	int emp_id = user.getUID();
	String sub_com = ResourceComInfo.getSubCompanyID(""+emp_id);
	int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
	int	perpage = 10;
	String cjkc_name = Util.null2String(request.getParameter("cjkc_name"));
	String imagefilename = "/images/hdDOC.gif";
	String titlename = "项目任务信息";
	String needfav ="1";
	String needhelp ="";

	String billid = Util.null2String(request.getParameter("billid"));
	
	String projName = Util.null2String(request.getParameter("projName"));
	String projCode = Util.null2String(request.getParameter("projCode"));
	String projStatus = Util.null2String(request.getParameter("projStatus"));
	String projManager = Util.null2String(request.getParameter("projManager"));
	String projClient = Util.null2String(request.getParameter("projClient"));
	String projC_address = Util.null2String(request.getParameter("projC_address"));
	String projC_contactor = Util.null2String(request.getParameter("projC_contactor"));
	String projC_tel = Util.null2String(request.getParameter("projC_tel"));
	String projID = Util.null2String(request.getParameter("projID"));
	
	String xmStatus = Util.null2String(request.getParameter("xmStatus"));
	String xmManager = Util.null2String(request.getParameter("xmManager"));
	String xmClient = Util.null2String(request.getParameter("xmClient"));

	String sql_proj = " select id,xmmc,khmc as khmc1,gsdz,lxr,lxdh,xmfzr as xmfzr1,cjrq,ssdw,xmzt as xmzt1,"
	+" (select lastname from Hrmresource where id=xmfzr) as xmManager, "
	+" (select khsh from formtable_main_2470 where id=khmc) as khName, "
	//+" decode(xmzt,0,'整理初步设计方案',1,'搜集详细资料',2,'签订合作意向书',3,'设计详细方案',4,'签订合同',5,'归档','填写相关信息') as p_status "
	+" from formtable_main_2471 where id= "+billid;
	
	String sql_xxx = "select a.id,a.xmmc,a.khmc,a.gsdz,a.lxr,a.lxdh,a.xmfzr,a.cjrq,a.ssdw,a.xmzt,b.lastname,c.khmc khName,"
	+" decode(a.xmzt,0,'整理初步设计方案',1,'搜集详细资料',2,'签订合作意向书',3,'设计详细方案',4,'签订合同',5,'归档','填写相关信息') as p_status"
	+" from formtable_main_2471 a,Hrmresource b,formtable_main_2470 c where a.xmfzr=b.id and a.khmc=c.id and a.id="+billid;
	rs.executeSql(sql_xxx);
	//out.print(sql_xxx);
	if(rs.next()){
		projID = Util.null2String(rs.getString("id"));
		projName = Util.null2String(rs.getString("xmmc"));
		projCode = Util.null2String(rs.getString("cjrq"));
		projStatus = Util.null2String(rs.getString("xmzt"));
		xmStatus = Util.null2String(rs.getString("p_status"));
		xmManager = Util.null2String(rs.getString("lastname"));
		projManager = Util.null2String(rs.getString("xmfzr"));
		projClient = Util.null2String(rs.getString("khmc"));
		xmClient = Util.null2String(rs.getString("khName"));
		projC_address = Util.null2String(rs.getString("gsdz"));
		projC_contactor = Util.null2String(rs.getString("lxr"));
		projC_tel = Util.null2String(rs.getString("lxdh"));
	}
	%>
	<BODY>
		<%@ include file="/systeminfo/TopTitle.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:autoSubmit(),_top} " ;
		RCMenuHeight += RCMenuHeightStep ;
		
		if("".equals(projStatus)){
			RCMenu += "{整理初步设计方案,javascript:gcl_firm(),_top} " ;
			RCMenuHeight += RCMenuHeightStep ;
		}
		
		if("0".equals(projStatus)){
			RCMenu += "{搜集详细资料,javascript:gcl_firm(),_top} " ;
			RCMenuHeight += RCMenuHeightStep ;
		}
		
		if("1".equals(projStatus)){
			RCMenu += "{签订合作意向书,javascript:gcl_firm(),_top} " ;
			RCMenuHeight += RCMenuHeightStep ;
		}
		
		if("2".equals(projStatus)){
			RCMenu += "{设计详细方案,javascript:gcl_firm(),_top} " ;
			RCMenuHeight += RCMenuHeightStep ;
		}
		
		if("3".equals(projStatus)){
			RCMenu += "{签订合同,javascript:gcl_firm(),_top} " ;
			RCMenuHeight += RCMenuHeightStep ;
		}
		
		if("4".equals(projStatus)){
			RCMenu += "{归档,javascript:gcl_firm(),_top} " ;
			RCMenuHeight += RCMenuHeightStep ;
		}
		%>
		<%@ include file="/systeminfo/RightClickMenu.jsp" %>
		<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
			<colgroup>
			<col width="10">
			<col width="">
			<col width="10">
			<tr>
				<td height="10" colspan="3"></td>
			</tr>
			<tr>
				<td ></td>
				<td valign="top">
					<TABLE class=Shadow>
						<tr>
							<td valign="top">
								<FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" target="_parent" method="post">
									<input type="hidden" name="multiRequestIds" value="">
									<input type="hidden" name="operation" value="">
				<table width="100%" class=ViewForm>
					<colgroup>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col></col>
					</colgroup>
				
					<tr>
						<td>项目名称</td>
						<td class=Field><%=projName%></td>
						<td>项目编号</td>
						<td class=Field><%=projCode%></td>
						<td>项目状态</td>
						<td class=Field><%=xmStatus%></td>
						<td>项目负责人</td>
						<td class=Field><%=xmManager%></td>
					</tr>

					<tr>
						<td>客户名称</td>
						<td class=Field><%=xmClient%></td>
						<td>公司地址</td>
						<td class=Field><%=projC_address%></td>
						<td>联系人</td>
						<td class=Field><%=projC_contactor%></td>
						<td>联系方式</td>
						<td class=Field><%=projC_tel%></td>
					</tr>
					
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>

			<table width="100%" class=ViewForm>
				<colgroup>
					<col width="16%"></col>
					<col width="16%"></col>
					<col width="16%"></col>
					<col width="16%"></col>
					<col width="16%"></col>
					<col width="16%"></col>
					<col></col>
				</colgroup>
				<tr>
					<td>
						<div class="container">
							<div id="zt0_1" class="cssBefore1"></div>
							<div id="zt0_2" class="cssBefore2" onclick="javascript:gcl_onclick_0();">整理初步设计方案</div>
							<div id="zt0_3" class="cssBefore3"></div>
						</div>
					</td>
					<td>
						<div class="container">
							<div id="zt1_1" class="cssBefore1"></div>
							<div id="zt1_2" class="cssBefore2" onclick="javascript:gcl_onclick_1();">搜集详细资料</div>
							<div id="zt1_3" class="cssBefore3"></div>
						</div>
					</td>
					<td>
						<div class="container">
							<div id="zt2_1" class="cssBefore1"></div>
							<div id="zt2_2" class="cssBefore2" onclick="javascript:gcl_onclick_2();">签订合作意向书</div>
							<div id="zt2_3" class="cssBefore3"></div>
						</div>
					</td>
					<td>
						<div class="container">
							<div id="zt3_1" class="cssBefore1"></div>
							<div id="zt3_2" class="cssBefore2" onclick="javascript:gcl_onclick_3();">设计详细方案</div>
							<div id="zt3_3" class="cssBefore3"></div>
						</div>
					</td>
					<td>
						<div class="container">
							<div id="zt4_1" class="cssBefore1"></div>
							<div id="zt4_2" class="cssBefore2" onclick="javascript:gcl_onclick_4();">签订合同</div>
							<div id="zt4_3" class="cssBefore3"></div>
						</div>
					</td>
					<td>
						<div class="container">
							<div id="zt5_1" class="cssBefore1"></div>
							<div id="zt5_2" class="cssBefore2"onclick="javascript:gcl_onclick_5();" >归档</div>
							<div id="zt5_3" class="cssBefore3"></div>
						</div>
					</td>
				</tr>
			</table>
			<TABLE width="100%" height="100%">
				<tr>
					<td height="80%">
						<div id="taskDiv" style="height:100%;">
						<div>
					</td>
				</tr>
				<tr>
					
				</tr>
				<tr>
					
				</tr>
			</TABLE>
		</FORM>
							</td>
						</tr>
					</TABLE>
				</td>
				<td></td>
			</tr>
			<tr>
				<td height="10" colspan="3"></td>
			</tr>
		</table>
		<script type="text/javascript">
		jQuery(window).load(function() {
			//console.log("onload;111")
			changeProjCSS();
			//autoSubmit();
			var tmp_URL = autoSubmit();
			//alert(tmp_URL);
			
			var gcl_innerHTML = "";
			gcl_innerHTML = "<iframe name=\"reportFrame\" width=\"100%\" height=\"100%\" src=\" "+tmp_URL+" \"></iframe>";
			//alert(gcl_innerHTML);
			document.getElementById("taskDiv").innerHTML = gcl_innerHTML;
			//alert(document.getElementById("taskDiv").innerHTML);
		});
		/*
		jQuery(document).ready(function () {
			//console.log("onload again;111")
			changeProjCSS();
		});
		
		$(window).load(function() {
			//console.log("onload;")
			changeProjCSS();
		});
		
		$(document).ready(function () {
			//console.log("onload again;")
			changeProjCSS();
		});
		*/
		
		function gcl_onclick_0(){
			var projID = "<%=projID%>";
			var xmStatusNow = "<%=projStatus%>";
			//alert("xmStatusNow="+xmStatusNow);
			if(xmStatusNow>=0){
				var gcl_innerHTML = "";
				var reportURL = cjkEncode("/formmode/search/CustomSearchBySimple.jsp?customid=601&treesqlwhere=SSXM="+projID);
				gcl_innerHTML = "<iframe name=\"reportFrame\" width=\"100%\" height=\"100%\" src=\" "+reportURL+" \"></iframe>";
				//alert(gcl_innerHTML);
				document.getElementById("taskDiv").innerHTML = gcl_innerHTML;
			}else{
				alert("无法查看本项目的后续状态内容!");
			}
		}
		
		function gcl_onclick_1(){
			var projID = "<%=projID%>";
			var xmStatusNow = "<%=projStatus%>";
			//alert("xmStatusNow="+xmStatusNow);
			if(xmStatusNow>=1){
				var gcl_innerHTML = "";
				var reportURL = cjkEncode("/formmode/search/CustomSearchBySimple.jsp?customid=1101&treesqlwhere=SSXM="+projID);
				gcl_innerHTML = "<iframe name=\"reportFrame\" width=\"100%\" height=\"100%\" src=\" "+reportURL+" \"></iframe>";
				//alert(gcl_innerHTML);
				document.getElementById("taskDiv").innerHTML = gcl_innerHTML;
			}else{
				alert("无法查看本项目的后续状态内容!");
			}
		}
		
		function gcl_onclick_2(){
			var projID = "<%=projID%>";
			var xmStatusNow = "<%=projStatus%>";
			//alert("xmStatusNow="+xmStatusNow);
			if(xmStatusNow>=2){
				var gcl_innerHTML = "";
				var reportURL = cjkEncode("/formmode/search/CustomSearchBySimple.jsp?customid=1102&treesqlwhere=SSXM="+projID);
				gcl_innerHTML = "<iframe name=\"reportFrame\" width=\"100%\" height=\"100%\" src=\" "+reportURL+" \"></iframe>";
				//alert(gcl_innerHTML);
				document.getElementById("taskDiv").innerHTML = gcl_innerHTML;
			}else{
				alert("无法查看本项目的后续状态内容!");
			}
		}
		
		function gcl_onclick_3(){
			var projID = "<%=projID%>";
			var xmStatusNow = "<%=projStatus%>";
			//alert("xmStatusNow="+xmStatusNow);
			if(xmStatusNow>=3){
				var gcl_innerHTML = "";
				var reportURL = cjkEncode("/formmode/search/CustomSearchBySimple.jsp?customid=1103&treesqlwhere=SSXM="+projID);
				gcl_innerHTML = "<iframe name=\"reportFrame\" width=\"100%\" height=\"100%\" src=\" "+reportURL+" \"></iframe>";
				//alert(gcl_innerHTML);
				document.getElementById("taskDiv").innerHTML = gcl_innerHTML;
			}else{
				alert("无法查看本项目的后续状态内容!");
			}
		}
		
		function gcl_onclick_4(){
			var projID = "<%=projID%>";
			var xmStatusNow = "<%=projStatus%>";
			//alert("xmStatusNow="+xmStatusNow);
			if(xmStatusNow>=4){
				var gcl_innerHTML = "";
				var reportURL = cjkEncode("/formmode/search/CustomSearchBySimple.jsp?customid=1104&treesqlwhere=SSXM="+projID);
				gcl_innerHTML = "<iframe name=\"reportFrame\" width=\"100%\" height=\"100%\" src=\" "+reportURL+" \"></iframe>";
				//alert(gcl_innerHTML);
				document.getElementById("taskDiv").innerHTML = gcl_innerHTML;
			}else{
				alert("无法查看本项目的后续状态内容!");
			}
		}
		
		function gcl_onclick_5(){
			var projID = "<%=projID%>";
			var xmStatusNow = "<%=projStatus%>";
			//alert("xmStatusNow="+xmStatusNow);
			if(xmStatusNow>=5){
				//拼接出最终报表访问路径，并对完整的路径进行编码转换，防止乱码问题
				var reportURL = cjkEncode("/gcl/jsp/gcl_proj_docinfo.jsp?proj_id="+projID);
				var gcl_innerHTML = "";
				gcl_innerHTML = "<iframe name=\"reportFrame\" width=\"100%\" height=\"100%\" src=\" "+reportURL+" \"></iframe>";
				//alert(gcl_innerHTML);
				document.getElementById("taskDiv").innerHTML = gcl_innerHTML;
			}else{
				alert("无法查看本项目的后续状态内容!");
			}
		}
		///formmode/search/CustomSearchBySimple.jsp?customid=601 0
		///formmode/search/CustomSearchBySimple.jsp?customid=1101 1
		///formmode/search/CustomSearchBySimple.jsp?customid=1102 2
		///formmode/search/CustomSearchBySimple.jsp?customid=1103 3
		///formmode/search/CustomSearchBySimple.jsp?customid=1104 4
		function changeProjCSS(){
			var statusStr = "<%=projStatus%>";
			var id_1 = "#zt"+statusStr+"_1";
			var id_2 = "#zt"+statusStr+"_2";
			var id_3 = "#zt"+statusStr+"_3";
			$(id_1).attr('class','cssAfter1');
			$(id_2).attr('class','cssAfter2');
			$(id_3).attr('class','cssAfter3');
		}
		
		function gcl_firm(){
			var projectName = "<%=projName%>";
			var xmID = "<%=projID%>"
			var tmp_status = "<%=projStatus%>"
			//alert(tmp_status);
			//document.weaver.action="/gcl/jsp/gcl_projEdit.jsp?projName="+projectName+" ";
			document.weaver.action="gcl_projEdit.jsp?projName="+projectName+"&projid="+xmID+"&opttype="+tmp_status+"";
			document.weaver.submit();
		}
		//cjkEncode方法的实现代码，放在网页head中或者用户自己的js文件中
		function cjkEncode(text) {                                                                          
			if (text == null) {       
				return "";       
			}       
			var newText = "";       
			for (var i = 0; i < text.length; i++) {       
				var code = text.charCodeAt (i);        
				if (code >= 128 || code == 91 || code == 93) {  //91 is "[", 93 is "]".       
					newText += "[" + code.toString(16) + "]";       
				} else {       
					newText += text.charAt(i);       
				}       
			}       
			return newText;       
		} 
		
		function autoSubmit() {
			//var resourceid = document.getElementById('resourceid').value; //获取文本控件的值
			var projID = "<%=projID%>";
			var tmp_customid = 0;
			var tmp_status = "<%=projStatus%>"; 
			var reportURL = "";
			if	(tmp_status==5){
				reportURL = cjkEncode("http://10.31.2.116/gcl/jsp/gcl_proj_docinfo.jsp?proj_id="+projID);
			}else{
				if(tmp_status==0){
					tmp_customid = 601;
				}else if(tmp_status==1){
					tmp_customid = 1101;
				}else if(tmp_status==2){
					tmp_customid = 1102;
				}else if(tmp_status==3){
					tmp_customid = 1103;
				}else if(tmp_status==4){
					tmp_customid = 1104;
				}
			
			//拼接出最终报表访问路径，并对完整的路径进行编码转换，防止乱码问题
			reportURL = cjkEncode("http://10.31.2.116/formmode/search/CustomSearchBySimple.jsp?customid="+tmp_customid+"&treesqlwhere=SSXM="+projID);
			}
			//alert("reportURL="+reportURL);
			//document.weaver.action = reportURL; //通过form的name获取表单，并将报表访问路径赋给表单的action
			//document.weaver.submit(); //触发表单提交事件
			return reportURL;
		}
		</script>
		<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
		<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
	</BODY>
</HTML>