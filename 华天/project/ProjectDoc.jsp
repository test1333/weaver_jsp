<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%!
public String getDocRes(String projectID){
	String[] arr = {"14","15","16","18","19","20","21","22","26","27","28"};
	String str = "";String st_flag = "";
	for(int index=0;index<arr.length;index++){
		str = str+st_flag+"-"+arr[index];
		st_flag = ",";
	}
	weaver.general.BaseBean log = new weaver.general.BaseBean();
	StringBuffer buff = new StringBuffer();
	weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
	weaver.conn.RecordSet rs_1 = new weaver.conn.RecordSet();
	String sql = "select * from workflow_billfield where fieldhtmltype=3 and type=37 and billid in("+str+")";
	log.writeLog("sql= " + sql);
	rs.executeSql(sql);
	while(rs.next()) {
		String tmp_name = Util.null2String(rs.getString("fieldname"));
		String tmp_id = Util.null2String(rs.getString("billid"));
		
		String doc_sql = "select " + tmp_name + " as docx  from FORMTABLE_MAIN_"+tmp_id.replace("-","")
			+"  where project_name='"+projectID+"'";
		log.writeLog("doc_sql= " + doc_sql);
		rs_1.executeSql(doc_sql);
		String flag = "";
		while(rs_1.next()) {
			String tmp_doc = Util.null2String(rs_1.getString("docx"));
			if(tmp_doc.length() > 0){
				buff.append(flag);buff.append(tmp_doc);flag = ",";
			}
		}
	}
	
	return buff.toString();
}
%>
<%
	Integer lg=(Integer)user.getLanguage();
	weaver.general.AccountType.langId.set(lg);
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

	String projectID = Util.null2String(request.getParameter("ProjID"));
	String name = Util.null2String(request.getParameter("name"));
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));

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
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
	<input type="hidden" name="multiIds" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
	
	    <wea:item>所有者</wea:item>
		<wea:item>
			<input type="text" name="name" id="name" class="InputStyle" value="<%=name%>"/>
		</wea:item>
		<wea:item>创建日期</wea:item>
		<wea:item>
			<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON> 
              	<SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN> 
              	<INPUT type="hidden" name="beginDate" value="<%=beginDate%>">  
            &nbsp;-&nbsp;
            <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON> 
            	<SPAN id=endDateSpan><%=endDate%></SPAN> 
            	<INPUT type="hidden" name="endDate" value="<%=endDate%>">  
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

/*Iterator<String> it = map.keySet().iterator();
while(it.hasNext()){
String tmp_id_x = it.next();
String tmp_name_x = map.get(tmp_id_x);
}*/
//	out.prinln(tmp_name_x);	
	
	String docs = getDocRes(projectID);
							
	String backfields = " t1.id, t1.docCreaterId,t1.userType,t1.doccreatedate,t1.doccreatetime,t1.docStatus,"
		+"t1.docSubject,t1.maincategory,t1.subCategory,t1.secCategory,t1.docextendname,t1.ownerid,t1.ownerType,'文档' as sy";
	String fromSql  = " from docdetail t1 ";
	String sqlWhere = " where  t1.id in("+docs+")";
	String orderby = " doccreatedate,doccreatetime " ;
	String tableString = "";
	
	if(!"".equals(beginDate)){
		sqlWhere = sqlWhere + " and doccreatedate >='"+beginDate+"'";
	}
	if(!"".equals(endDate)){
		sqlWhere = sqlWhere + " and doccreatedate <='"+endDate+"'";
	}
	if(!"".equals(name)){
		sqlWhere = sqlWhere + " and ownerid in(select id from hrmresource where lastname like '%"+name+"%')";
	}
	
//	out.println("select " + backfields +  fromSql + sqlWhere + " order by " + orderby);
	
//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                  
		tableString+=
		"       <col width=\"5%\"  text=\" \" column=\"docextendname\" orderkey=\"docextendname\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getDocIconByExtendName\"/>"+
	 	"		<col width=\"20%\"  text=\""+SystemEnv.getHtmlLabelName(58,user.getLanguage())+"\" labelid=\"58\" column=\"id\" otherpara=\"column:docSubject\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getDocNameForDocMonitor\"  orderkey=\"docSubject\" linkvaluecolumn=\"id\" linkkey=\"id\" href=\"/docs/docs/DocDsp.jsp\" target=\"_fullwindow\" />"+
		"		<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(79,user.getLanguage())+"\" labelid=\"79\" column=\"ownerid\" orderkey=\"ownerid\" otherpara=\"column:ownerType\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getName\"/>"+
	  	"		<col width=\"20%\" pkey=\"id+weaver.splitepage.transform.SptmForDoc.getAllDirName\" text=\""+SystemEnv.getHtmlLabelName(92,user.getLanguage())+"\" labelid=\"92\" column=\"secCategory\" orderkey=\"secCategory\"  transmethod=\"weaver.splitepage.transform.SptmForDoc.getAllDirName\"/>"+
	  	"		<col width=\"12%\"  text=\""+SystemEnv.getHtmlLabelName(722,user.getLanguage())+"\" labelid=\"722\" column=\"doccreatedate\" orderkey=\"docCreateDate,docCreateTime\"  otherpara=\"column:docCreateTime\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getCreateTimeForDocMonitor\"/>"+
        "		<col width=\"8%\"  text=\""+SystemEnv.getHtmlLabelName(602,user.getLanguage())+"\" labelid=\"602\" column=\"docStatus\" orderkey=\"docStatus\" otherpara=\""+user.getLanguage()+"+column:id"+"\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getDocStatus\" />"+
	   	"		<col width=\"8%\"  text=\"类型\" column=\"sy\" orderkey=\"sy\"  />"+
		"		</head>"+
    	" </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

	<script type="text/javascript">
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
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
			<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
