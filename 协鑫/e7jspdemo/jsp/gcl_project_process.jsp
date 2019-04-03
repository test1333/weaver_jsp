<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<style>
.sp1{
	display:inline-block;
	width:50%;
	height:20px;
	background:#0066CC;
	text-align:center;
	color:white;
	float: left;
    line-height: 20px;
    vertical-align: middle;
}

.sp2{
	display:inline-block;
	width:50%;
	height:20px;
	background:#97CBFF;
	text-align:center;
	color:white;
	float: left;
    line-height: 20px;
    vertical-align: middle;
}

   .container {
      position: relative;
      overflow: hidden;
   }
   div {
     float: left;
   }
   .test1 {
      width: 0;
      height: 0;
      border: 10px solid blue;
      border-left-color: #fff;
    }
    .test2 {
      
      height: 20px;
	    color:white;
      background-color: blue;
	    text-align:center;
	    vertical-align: middle;
    }
    .test3 {
      width: 0;
      height: 0;
      border: 10px solid #fff;
      border-left-color: blue;
    }

</style>
<HTML>
	<HEAD>
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String imagefilename = "/images/hdReport.gif";
	int emp_id = user.getUID();
	String sub_com = ResourceComInfo.getSubCompanyID(""+emp_id);
	int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
	int	perpage = 10;
	String titlename = "培训报名情况";
	String needfav ="1";
	String needhelp ="";

	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String departmentid = Util.null2String(request.getParameter("departmentid")) ;
	String qname=Util.null2String(request.getParameter("flowTitle"));

	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));

	String operDate = Util.null2String(request.getParameter("operDate"));

	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String isActive = Util.null2String(request.getParameter("isActive"));
	String standard = Util.null2String(request.getParameter("standard"));
	
	String out_pageId = "out_info";
	
	int userid = user.getUID();
	Boolean isAdmin=false;
	String sql="";
	sql=" select count(id) as num_admin from HrmRoleMembers where roleid=36 and resourceid="+userid;
	rs.executeSql(sql);
	if(rs.next()){
		int num_admin=rs.getInt("num_admin");
		if(num_admin>0){
			isAdmin=true;
		}
	}


	String projName = Util.null2String(request.getParameter("projName"));
	String projCode = Util.null2String(request.getParameter("projCode"));
	String projStatus = Util.null2String(request.getParameter("projStatus"));
	String projManager = Util.null2String(request.getParameter("projManager"));
	String projClient = Util.null2String(request.getParameter("projClient"));
	String projC_address = Util.null2String(request.getParameter("projC_address"));
	String projC_contactor = Util.null2String(request.getParameter("projC_contactor"));
	String projC_tel = Util.null2String(request.getParameter("projC_tel"));

	String sql_proj = " select id,xmmc,khmc,gsdz,lxr,lxdh,xmfzr,cjrq,ssdw,xmzt from formtable_main_2471 where id=1 ";
	rs.executeSql(sql_proj);
	//out.print(sql_proj);
	if(rs.next()){
		projName = Util.null2String(rs.getString("xmmc"));
		projCode = Util.null2String(rs.getString("cjrq"));
		projStatus = Util.null2String(rs.getString("xmzt"));
		projManager = Util.null2String(rs.getString("xmfzr"));
		projClient = Util.null2String(rs.getString("khmc"));
		projC_address = Util.null2String(rs.getString("gsdz"));
		projC_contactor = Util.null2String(rs.getString("lxr"));
		projC_tel = Util.null2String(rs.getString("lxdh"));
	}
	%>
	<BODY>
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
							<FORM id=report name=report STYLE="margin-bottom:0" action="" method="post">
								<input type="hidden" name="multiRequestIds" value="">
								<input type="hidden" name="operation" value="">
								<table width=100% class=ViewForm>
									<colgroup>
									<col width="10%"></col>
									<col width="10%"></col>
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
									<tr style="height:1px;"><td class=Line colspan=11></td></tr>
								</table>

			<div>
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
						<td class=Field>项目名称</td>
						<td class=Field><%=projName%></td>
						<td class=Field>项目编号</td>
						<td class=Field><%=projCode%></td>
						<td class=Field>项目状态</td>
						<td class=Field><%=projStatus%></td>
						<td class=Field>项目负责人</td>
						<td class=Field><%=projManager%></td>
					</tr>

					<tr>
						<td class=Field>客户名称</td>
						<td class=Field><%=projClient%></td>
						<td class=Field>公司地址</td>
						<td class=Field><%=projC_address%></td>
						<td class=Field>联系人</td>
						<td class=Field><%=projC_contactor%></td>
						<td class=Field>联系方式</td>
						<td class=Field><%=projC_tel%></td>
					</tr>
				</table>
			</div>

			<div>
				<ul style="list-style-type:none;"">
  					<li>
					<div class="container">
						<div class="test1"></div>
						<div class="test2">整理初步设计方案</div>
						<div class="test3"></div>
					</div>
					</li>
					<li>
					<div class="container">
					<div class="test1"></div>
					<div class="test2">搜集详细资料</div>
					<div class="test3"></div>
					</div>
					</li>
					<li>
					<div class="container">
					<div class="test1"></div>
					<div class="test2">签订合作意向书</div>
					<div class="test3"></div>
					</div>
					</li>
					</ul>
				<!--<table width="100%" class=ViewForm>	
					<colgroup>
					<col width="15%"></col>
					<col width="15%"></col>
					<col width="15%"></col>
					<col width="15%"></col>
					<col width="15%"></col>
					<col width="15%"></col>
					<col></col>
					</colgroup>
				
					<tr>
						<td class=Field>整理初步设计方案</td>
						<td class=Field>搜集详细资料</td>
						<td class=Field>签订合作意向书</td>
						<td class=Field>设计详细方案</td>
						<td class=Field>签订合同</td>
						<td class=Field>归档</td>
					</tr>
				</table>-->
			</div>

								<TABLE width="100%">
									<tr>
										<td valign="top">
										<%
											String backfields = " id,ssxm,rwmc,fzr,xgwd,xglc,sfkx,sfkxyj,tjrq ";
											String fromSql  = " from formtable_main_2481 ";
											String sqlWhere = " ssxm = 1 ";
											// out.println("select "+ backfields + fromSql + " where " + sqlWhere);
											//out.println(sqlWhere);
											String orderby = " ssxm " ;
											String tableString = "";
											tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
												"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"ssxm\" sqlsortway=\"desc\" />"+
												"			<head>"+
												" 				<col width=\"14%\" text=\"任务名称\" column=\"rwmc\" orderkey=\"rwmc\"  />"+
												" 				<col width=\"14%\" text=\"负责人\" column=\"fzr\" orderkey=\"fzr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
												"				<col width=\"14%\" text=\"相关文档\" column=\"xgwd\" orderkey=\"xgwd\"  />"+
												"				<col width=\"14%\" text=\"相关流程\" column=\"xglc\" orderkey=\"xglc\" />"+
												" 				<col width=\"14%\" text=\"是否可行\" column=\"sfkx\" orderkey=\"sfkx\"  />"+
												" 				<col width=\"14%\" text=\"是否可行性意见\" column=\"sfkxyj\" orderkey=\"sfkxyj\"  />"+
												" 				<col width=\"14%\" text=\"提交日期\" column=\"tjrq\" orderkey=\"tjrq\"  />"+
												"			</head>"+
												"</table>";
											%>
											<wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" showExpExcel="true" />
										</td>
									</tr>
								</TABLE>
							</FORM>
						</td>
					</tr>
				</TABLE>
			</td>
			<td></td>
		</tr>
		<tr><td height="10" colspan="3"></td></tr>
	</table>
	<script type="text/javascript">
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
		
		function invalidRecord(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids="+ids);
			if(ids == ""){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
				return false;
			}
			Dialog.confirm("确认该考勤记录有效？", function (){
	        		report.action="/seahonor/attend/jsp/sh_removeRecord.jsp?id="+ids+"&optype=0";
					report.submit();
				}, function () {}, 320, 90,false);
		}	

		function removeRecord(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids="+ids);
			if(ids == ""){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
				return false;
			}
			Dialog.confirm("确定移除该考勤记录？", function (){
	        		report.action="/seahonor/attend/jsp/sh_removeRecord.jsp?id="+ids+"&optype=1";
					report.submit();
				}, function () {}, 320, 90,false);
		}
		//查看地图
		/*function showMap(id, uid, thisDate){
			parent.parent.location.href = "/hrm/HrmTab.jsp?_fromURL=mobileSignIn&showMap=true&id="+id+"&uid="+uid+"&thisDate="+thisDate;
		}
		href=\"javascript:this.showMap('sign9',operater,operate_date)\"
		*/
		//编辑
		function onagentedit(id){
				dialog = new window.top.Dialog();
				dialog.currentWindow = window;
				var operate_id = id;
				//alert("operate_id="+operate_id);
				var url = "/seahonor/attend/jsp/SH_mobile_his.jsp?id="+operate_id;
				dialog.Title = "操作历史记录";
				dialog.Width = 600;
				dialog.Height =550;
				dialog.Drag = true;
				 
				dialog.URL = url;
				dialog.show();
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
		var resourceid = document.getElementById('resourceid').value; //获取文本控件的值
		//alert("resourceid="+resourceid);
		//var row = document.getElementById('row').value; //获取下拉框控件的值
		//拼接出最终报表访问路径，并对完整的路径进行编码转换，防止乱码问题
		var reportURL = cjkEncode("http://58.247.6.130:8075/WebReport/ReportServer?reportlet=monthHoliday02.cpt&__pi__=false&emp_id="+resourceid);
		//alert("reportURL="+reportURL);
		//var reportURL = cjkEncode("../ReportServer?reportlet=/demo/parameter/number1.cpt¶=" + num + "&row=" + row);
		document.report.action = reportURL; //通过form的name获取表单，并将报表访问路径赋给表单的action
		document.report.submit(); //触发表单提交事件
		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
	<script type="text/javascript" src="/js/selectDateTime.js"></script>
</BODY>
</HTML>