<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%!
// JSP中的方法
public static String CreateTmpOnlineUserId(	RecordSet rs ,ArrayList<String> onlineuserids)throws Exception
{
String userids = "";
rs.execute("delete from TmpOnlineUserId");

for(int i=0;onlineuserids!=null&&i<onlineuserids.size();i++){
rs.execute("INSERT INTO TmpOnlineUserId VALUES ("+onlineuserids.get(i)+")");
}
return userids;
}
%>
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" />
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />

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
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String departmentid_para = Util.null2String(request.getParameter("departmentid")) ;
	String subcompanyid_para=Util.null2String(request.getParameter("subcompanyid1"));//分部
	String companyid_para = Util.null2String(request.getParameter("companyid")) ;
	if("0".equals(subcompanyid_para)) subcompanyid_para = "";
	String chkSubCompany=Util.null2o(request.getParameter("chkSubCompany"));//子分部是否包含
	String uworkcode=Util.null2String(request.getParameter("uworkcode"));//编号
	String uname=Util.null2String(request.getParameter("uname"));//姓名
	String utel=Util.null2String(request.getParameter("utel"));//电话
	String umobile=Util.null2String(request.getParameter("umobile"));//移动电话
	String uemail=Util.null2String(request.getParameter("uemail"));//电子邮件
	String qname=Util.null2String(request.getParameter("flowTitle"));

	
	String effeStartDate =Util.null2String(request.getParameter("effeStartDate"));//日期的定义
	String invalidDate =Util.null2String(request.getParameter("invalidDate"));//日期的定义
	String Sender=Util.null2String(request.getParameter("Sender"));//寄件人
	String ExpressCompany=Util.null2String(request.getParameter("ExpressCompany"));//快递公司
	String temp_val = "ForTheCost";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= temp_val %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{"+SystemEnv.getHtmlLabelName(-9846,user.getLanguage())+",javascript:firm(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
		<!--增加一个隐藏的input，好传参数给另外一个页面和本地页面获取值，一般通过jsp传参数action是通过name字段，而在本页面获取值是通过jQuery获取id -->
			<input type="hidden" id="ExpressCompany" name="ExpressCompany"  value="<%=ExpressCompany%>" /> 
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;"><input
						type="text" class="searchInput" name="flowTitle"
						value="<%=qname %>" /> 			<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span><span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>

			<% // 查询条件 %>
			<!--  '--'是时间的分开线，其中wea:item相当于td -->
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>寄件日期</wea:item>
				<wea:item>
			    <button type="button" class=Calendar id="selecteffeStartDateAll" onclick="onshowVotingEndDate('effeStartDate','effeStartDateSpan')"></BUTTON> 
            	<SPAN id=effeStartDateSpan><%=effeStartDate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" id="SHeffeStartDateAll" name="effeStartDate" value="<%=effeStartDate%>"> 
            	 -&nbsp;&nbsp;
			    <button type="button" class=Calendar id="SHinvalidDate" onclick="onshowVotingEndDate('invalidDate','invalidDateSpan')"></BUTTON> 
            	 <SPAN id=invalidDateSpan><%=invalidDate%></SPAN> 
            	 <INPUT type="hidden" id="invalidDateSH" name="invalidDate" value="<%=invalidDate%>">
			     </wea:item>
				<wea:item>寄件人</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="Sender" browserValue="<%=Sender %>" 
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(Sender),user.getLanguage())%>">
				</brow:browser>
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
		
		String backfields = " id,DateTime,SendDate,SenderDepartment,Sender,case ExpressCompany when '1' then '顺丰快递' when '2' then '申通快递' when '3' then 'DHL' when '4' then 'EMS' end as ExpressCompany,ReceiverAdd,case PayMethod when '0' then '月结' when '1' then '现结' else '到付' end as PayMethod,Money,case State when '0' then '待结算' else '已结算' end as State ";
		String fromSql  = " from formtable_main_102 f ";
		//String sqlWhere = " 1=1 ";  currentnodetype =3; 3是代表归档状态
		//String sqlWhere = " requestid in(select requestid from workflow_requestbase where currentnodetype =3 ) "
		//+" and PayMethod=0 ";
		//PayMethod为-0是月结，1为现结，2为到付，State为0是待结算，1为已结算。
		String sqlWhere = " PayMethod=0 and State =0 "; 
		
		//String sqlWhere = " where gysylqxxkzjydqrq <= convert(char(10),getdate(),120) and gysylqxxkzjydqrq is not null ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		// String orderby = " id " ;一般是这个id排序，但是如果按照时间的话，就要按照时间来排序，
		String orderby = " SendDate " ;
		String tableString = "";
		
		//寄件人(对于单行文本的处理方法)
		if(!Sender.equals("")) 
		sqlWhere+=" and Sender="+Sender;

		//这是一个快递公司的判断条件
		if(!ExpressCompany.equals("")) 
		sqlWhere+=" and ExpressCompany in("+ExpressCompany+")";
		//这是一个日期的比较的
		//if(!effeStartDate.equals("")) //日期的定义，记住effeStartDate要加''，
		//sqlWhere+=" and DueDate='" +effeStartDate+"'";
	
		//这是一个时间段日期的比较。effeStartDate是选择的开始日期  invalidDate选择的结束日期 DateTime需要比较的寄件日期
		if(!"".equals(effeStartDate)){
			sqlWhere +=" and DateTime>='"+effeStartDate+"' ";
			if(!"".equals(invalidDate)){
				sqlWhere +=" and DateTime<='"+invalidDate+"' ";
			}
		}else{
			if(!"".equals(invalidDate)){
				sqlWhere +=" and DateTime<='"+invalidDate+"' ";
			}
		}
		//out.println(sqlWhere);
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//  sqlprimarykey=\"id\" sqlsortway=\"Asc\" 这是默认的升序
		String  operateString= "";
		tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(temp_val,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+temp_val+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" sumColumns=\"Money\" showCountColumn=\"true\"/>"+
		operateString+
		"			<head>";
		tableString+="<col width=\"10%\" labelid=\"-9563\" text=\"寄件人\" column=\"Sender\" orderkey=\"Sender\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+	
			"<col width=\"10%\" labelid=\"-9550\" text=\"寄件人部门\" column=\"SenderDepartment\" orderkey=\"SenderDepartment\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
			"<col width=\"10%\" labelid=\"-9549\" text=\"寄件日期\" column=\"SendDate\" orderkey=\"SendDate\" />"+
			"<col width=\"10%\" labelid=\"-9559\" text=\"快递公司\" column=\"ExpressCompany\" orderkey=\"ExpressCompany\"/>"+
			"<col width=\"10%\" labelid=\"-10050\" text=\"预估费用\" column=\"Money\" orderkey=\"Money\" />"+
			"<col width=\"10%\" labelid=\"-9560\" text=\"支付方式\" column=\"PayMethod\" orderkey=\"PayMethod\" />"+
			"		<col width=\"10%\" labelid=\"-9676\" text=\"结算状态\" column=\"State\" orderkey=\"State\" />"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">

	function firm(){

				//获得流程的id主键
				var ids = _xtable_CheckedCheckboxId();
				//alert("ids="+ids);

				if(ids != ""){

	                if(confirm("是否确认结算？")){
	     			
						// 在隐藏input中通过id字段获取页面的快递公司
						var company = jQuery("#ExpressCompany").val();
						var slUrl = "/seahonor/express/jsp/SettleAccount.jsp?ids="+ids+"&ExpressCompany="+company;
						// 打开一个新页面  JS
						window.open(slUrl);
	                //	report.action = "SettleAccount.jsp?ids="+ids;
	                //	report.submit();
	                }  
				}else{
							top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
					   }   
            }
	function onShowSubcompanyid1(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#subcompanyid1span").html(data.name);
				jQuery("#subcompanyid1").val(data.id);
				makechecked();
			}else{
				jQuery("#subcompanyid1span").html("");
				jQuery("#subcompanyid1").val("");
			}
		}
	}
	
	function onShowDepartmentid(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#departmentidspan").html(data.name);
				jQuery("#departmentid").val(data.id);
				makechecked();
			}else{
				jQuery("#departmentidspan").html("");
				jQuery("#departmentid").val("");
			}
		}
	}
	
		function makechecked() {
			if ($GetEle("subcompanyid1").value != "") {
				$($GetEle("chkSubCompany")).css("display", "");
				$($GetEle("lblSubCompany")).css("display", "");
			} else {
				$($GetEle("chkSubCompany")).css("display", "none");
				$($GetEle("chkSubCompany")).attr("checked", "");
				$($GetEle("lblSubCompany")).css("display", "none");
			}
			jQuery("body").jNice();
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
	</script>
	<!-- 日期的js引用 -->
	<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>