<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@page import="weaver.fna.maintenance.FnaCostCenter"%>
<%@page import="weaver.workflow.field.BrowserComInfo"%>
<%@page import="weaver.fna.general.FnaSplitPageTransmethod"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<%
	int user_id = user.getUID();
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



int orgType = Util.getIntValue(request.getParameter("orgType"), 2);
String subId = Util.null2String(request.getParameter("subId")).trim();
String depId = Util.null2String(request.getParameter("depId")).trim();
String fccId = Util.null2String(request.getParameter("fccId")).trim();
String kmid = Util.null2String(request.getParameter("kmid")).trim();
String kmidname="";
StringBuffer shownameSub = new StringBuffer();
StringBuffer shownameDep = new StringBuffer();
StringBuffer shownameFcc = new StringBuffer();
String orgIds = "";
String orgTypeName = "";
String sql="";
if(!"".equals(kmid)){

sql="select name from FnaBudgetfeeType where id="+kmid;
rs.executeSql(sql);
if(rs.next()){
	kmidname = Util.null2String(rs.getString("name")).trim();
}
}
int ksyear=Util.getIntValue(request.getParameter("ksyear"),0);
int ksyue=Util.getIntValue(request.getParameter("ksyue"),1);
if(ksyear==0){
	rs.executeSql("select id, fnayear from FnaYearsPeriods order by status desc,fnayear desc");
	if(rs.next()){
		ksyear = Util.getIntValue(rs.getString("fnayear"));
	}
}

int jsyear=Util.getIntValue(request.getParameter("jsyear"),0);
int jsyue=Util.getIntValue(request.getParameter("jsyue"),1);
if(jsyear==0){
	rs.executeSql("select id, fnayear from FnaYearsPeriods order by status desc,fnayear desc");
	if(rs.next()){
		jsyear = Util.getIntValue(rs.getString("fnayear"));
	}
}

if(orgType == 1){
	sql = "select a.id, a.subcompanyname name from HrmSubCompany a where a.id in ("+subId+") ORDER BY a.showorder, a.subcompanycode, a.subcompanyname";
	orgIds = subId;
	orgTypeName = SystemEnv.getHtmlLabelName(141, user.getLanguage());
}else if(orgType == 2){
	sql = "select a.id, a.departmentname name from HrmDepartment a where a.id in ("+depId+") ORDER BY a.showorder, a.departmentcode, a.departmentname";
	orgIds = depId;
	orgTypeName = SystemEnv.getHtmlLabelName(124, user.getLanguage());
}else if(orgType == FnaCostCenter.ORGANIZATION_TYPE){
	sql = "select a.id, a.name name from FnaCostCenter a where a.id in ("+fccId+") ORDER BY a.code, a.name";
	orgIds = fccId;
	orgTypeName = SystemEnv.getHtmlLabelName(515, user.getLanguage());
}

subId="";depId="";fccId="";

if(!"".equals(orgIds)){
	rs.executeSql(sql);
	while(rs.next()){
		if(orgType == 1){
			if(shownameSub.length() > 0){
				shownameSub.append(",");
				subId+=",";
			}
			shownameSub.append(Util.null2String(rs.getString("name")).trim());
			subId+=Util.null2String(rs.getString("id")).trim();
		}else if(orgType == 2){
			if(shownameDep.length() > 0){
				shownameDep.append(",");
				depId+=",";
			}
			shownameDep.append(Util.null2String(rs.getString("name")).trim());
			depId+=Util.null2String(rs.getString("id")).trim();
		}else if(orgType == FnaCostCenter.ORGANIZATION_TYPE){
			if(shownameFcc.length() > 0){
				shownameFcc.append(",");
				fccId+=",";
			}
			shownameFcc.append(Util.null2String(rs.getString("name")).trim());
			fccId+=Util.null2String(rs.getString("id")).trim();
		}
	}
}

String tmc_pageId = "fna001";
%>
	


<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{导出Excel,javascript:_xtable_getAllExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=/dp/report/fnareport.jsp method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
		</table>
		<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">

				<wea:item><%=SystemEnv.getHtmlLabelName(18748,user.getLanguage())%></wea:item><!-- 预算单位 -->
		    <wea:item>
				<select id="orgType" name="orgType" onchange="orgType_onchange();" style="width: 80px;float: left;">
						<option value="1" <%=(orgType==1)?"selected":"" %>><%=SystemEnv.getHtmlLabelName(141, user.getLanguage()) %></option><!-- 分部 -->
					<option value="2" <%=(orgType==2)?"selected":"" %>><%=SystemEnv.getHtmlLabelName(124, user.getLanguage()) %></option><!-- 部门 -->
				
					<option value="<%=FnaCostCenter.ORGANIZATION_TYPE %>" 
						<%=(orgType==FnaCostCenter.ORGANIZATION_TYPE)?"selected":"" %>><%=SystemEnv.getHtmlLabelName(515, user.getLanguage()) %></option><!-- 成本中心 -->
				</select>

				<span id="spanSubId" style="display: none;">
			        <brow:browser viewType="0" id="subId" name="subId" browserValue='<%=subId %>' 
			                browserUrl='<%=new BrowserComInfo().getBrowserurl("194")+"%3Fshow_virtual_org=-1%26selectedids=#id#" %>'
			                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput="1"
			                completeUrl="/data.jsp?show_virtual_org=-1&type=194"  temptitle='<%= SystemEnv.getHtmlLabelName(141,user.getLanguage())%>'
			                browserSpanValue='<%=shownameSub.toString() %>' width="60%" 
			                
			                >
			        </brow:browser>
			    </span>

	            <span id="spanDepId" style="display: none;">
			        <brow:browser viewType="0" id="depId" name="depId" browserValue='<%=depId %>' 
			                browserUrl='<%=new BrowserComInfo().getBrowserurl("57")+"%3Fshow_virtual_org=-1%26resourceids=#id#" %>'
			                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput="1"
			                completeUrl="/data.jsp?show_virtual_org=-1&type=57"  temptitle='<%= SystemEnv.getHtmlLabelName(124,user.getLanguage())%>'
			                browserSpanValue='<%=shownameDep.toString() %>' width="60%" 
			                >
			        </brow:browser>
			    </span>
	            
				 <span id="spanFccId" style="display: none;">
			        <brow:browser viewType="0" id="fccId" name="fccId" browserValue='<%=fccId %>' 
			                browserUrl="/systeminfo/BrowserMain.jsp?url=/fna/browser/costCenter/FccBrowserMulti.jsp%3Fselectids=#id#"
			                hasInput="true" isSingle="false" hasBrowser="true" isMustInput="1"
			                completeUrl="/data.jsp?type=FnaCostCenter"  temptitle='<%= SystemEnv.getHtmlLabelName(515,user.getLanguage())%>'
			                browserSpanValue='<%=shownameFcc.toString() %>' width="60%" 
			               	>
			        </brow:browser>
			    </span>
				   </wea:item>
			<wea:item><%=SystemEnv.getHtmlLabelNames("1462",user.getLanguage())%></wea:item><!-- 预算科目 -->
	<wea:item>			
<span id="kmid" >
			        <brow:browser viewType="0" name="kmid" browserValue='<%=kmid %>' 
			               browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.kemu"
			                hasInput="true" isSingle="false" hasBrowser="true" isMustInput="1"
			             temptitle='<%= SystemEnv.getHtmlLabelName(515,user.getLanguage())%>'
			                browserSpanValue='<%=kmidname %>' width="60%" 
			               	>
			        </brow:browser>
			    </span>
				   </wea:item>
					<wea:item>开始期间</wea:item><!-- 预算单位 -->
					 <wea:item>
						<select id="ksyear" name="ksyear" style="width: 60px;">
				<%
				rs.executeSql("select id, fnayear from FnaYearsPeriods order by fnayear desc");
				while(rs.next()){
					int _fnayear = Util.getIntValue(rs.getString("fnayear"));
				%>
					<option value="<%=_fnayear %>" <%=(_fnayear==ksyear)?"selected":"" %>><%=_fnayear %> 年</option>
				<%
				}
				%>
				</select>
				<select id="ksyue" name="ksyue" style="width: 60px;">
					<option value="1" <%=(ksyue==1)?"selected":"" %>>1月</option>
					<option value="2" <%=(ksyue==2)?"selected":"" %>>2月</option>
					<option value="3" <%=(ksyue==3)?"selected":"" %>>3月</option>
					<option value="4" <%=(ksyue==4)?"selected":"" %>>4月</option>
					<option value="5" <%=(ksyue==5)?"selected":"" %>>5月</option>
					<option value="6" <%=(ksyue==6)?"selected":"" %>>6月</option>
					<option value="7" <%=(ksyue==7)?"selected":"" %>>7月</option>
					<option value="8" <%=(ksyue==8)?"selected":"" %>>8月</option>
					<option value="9" <%=(ksyue==9)?"selected":"" %>>9月</option>
					<option value="10" <%=(ksyue==10)?"selected":"" %>>10月</option>
					<option value="11" <%=(ksyue==11)?"selected":"" %>>11月</option>
					<option value="12" <%=(ksyue==12)?"selected":"" %>>12月</option>
				</select>	

					</wea:item>

					<wea:item>结束期间</wea:item><!-- 预算单位 -->
					 <wea:item>
						<select id="jsyear" name="jsyear" style="width: 60px;">
				<%
				rs.executeSql("select id, fnayear from FnaYearsPeriods order by fnayear desc");
				while(rs.next()){
					int _fnayear = Util.getIntValue(rs.getString("fnayear"));
				%>
					<option value="<%=_fnayear %>" <%=(_fnayear==jsyear)?"selected":"" %>><%=_fnayear %> 年</option>
				<%
				}
				%>
				</select>
				<select id="jsyue" name="jsyue" style="width: 60px;">
					<option value="1" <%=(jsyue==1)?"selected":"" %>>1月</option>
					<option value="2" <%=(jsyue==2)?"selected":"" %>>2月</option>
					<option value="3" <%=(jsyue==3)?"selected":"" %>>3月</option>
					<option value="4" <%=(jsyue==4)?"selected":"" %>>4月</option>
					<option value="5" <%=(jsyue==5)?"selected":"" %>>5月</option>
					<option value="6" <%=(jsyue==6)?"selected":"" %>>6月</option>
					<option value="7" <%=(jsyue==7)?"selected":"" %>>7月</option>
					<option value="8" <%=(jsyue==8)?"selected":"" %>>8月</option>
					<option value="9" <%=(jsyue==9)?"selected":"" %>>9月</option>
					<option value="10" <%=(jsyue==10)?"selected":"" %>>10月</option>
					<option value="11" <%=(jsyue==11)?"selected":"" %>>11月</option>
					<option value="12" <%=(jsyue==12)?"selected":"" %>>12月</option>
				</select>	

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
    String orid="";
	if(orgType==1){
        orid = subId;
	}else if(orgType==2){
        orid = depId;
	}else if(orgType==18004){
		orid = fccId;
	}
	String periodid="";
	sql="select id from FnaYearsPeriods where fnayear='"+ksyear+"' and status=1";
    rs.executeSql(sql);
	if(rs.next()){
		periodid = Util.null2String(rs.getString("id"));
		
	}
	String ksqj="";
	sql="select startdate,enddate from FnaYearsPeriodsList where fnayearid='"+periodid+"' and isactive=1 and Periodsid="+ksyue+"";
	rs.executeSql(sql);
	if(rs.next()){
		ksqj = Util.null2String(rs.getString("startdate"));
		
	}

	String jsqj="";
	sql="select startdate,enddate from FnaYearsPeriodsList where fnayearid='"+periodid+"' and isactive=1 and Periodsid="+jsyue+"";
	rs.executeSql(sql);
	if(rs.next()){
		jsqj = Util.null2String(rs.getString("enddate"));
		
	}

	String kmname="";
	if("".equals(kmidname)){
		kmname="全部";
	}else{
		kmname=kmidname;
	}
	String backfields = "id,'"+orgTypeName+"' as fylx,dbo.[getcdztName](organizationtype,budgetorganizationid) as cdzt,'"+kmname+"' as km,'"+ksqj+"' as ksqj,'"+jsqj+"' as jsqj,isnull(dbo.[getyszje](id,"+ksyue+","+jsyue+",'"+kmid+"'),0) yszje, "+
	" isnull(dbo.[getfy](organizationtype,budgetorganizationid,'"+periodid+"',3,"+ksyue+","+jsyue+",'"+kmid+"'),0) sqje,isnull(dbo.[getfy](organizationtype,budgetorganizationid,'"+periodid+"',1,"+ksyue+","+jsyue+",'"+kmid+"'),0) spje , "+
	" isnull(dbo.[getfy](organizationtype,budgetorganizationid,'"+periodid+"',2,"+ksyue+","+jsyue+",'"+kmid+"'),0) yfsje,isnull(dbo.[getyszje](id,"+ksyue+","+jsyue+",'"+kmid+"'),0)-isnull(dbo.[getfy](organizationtype,budgetorganizationid,'"+periodid+"',3,"+ksyue+","+jsyue+",'"+kmid+"'),0) kyje   "; 
	String fromSql  = " from FnaBudgetInfo a";
	String sqlWhere = " where 1=1 and status=1 and organizationtype='"+orgType+"' and budgetorganizationid in("+orid+") and budgetperiods='"+periodid+"' ";
	String orderby = " id" ;
	if("".equals(orid)){
		sqlWhere +=" and 2=1 ";
	}
	if(!"".equals(kmid)){
		sqlWhere +=" and exists(select 1 from FnaBudgetInfoDetail where budgetinfoid=a.id and budgettypeid in (select id from FnaBudgetfeeType where dbo.[isxjkm](id,"+kmid+")='S'))";
	}
	//out.print("select "+backfields+fromSql+sqlWhere);
	String tableString = "";
 


//  右侧鼠标 放上可以点击
String  operateString= "";

tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"10%\"  text=\"费用类型\" column=\"fylx\" orderkey=\"fylx\"/>"+
		"<col width=\"10%\" text=\"承担主体\" column=\"cdzt\" orderkey=\"cdzt\"/>"+
		"<col width=\"10%\" text=\"科目\" column=\"km\" orderkey=\"km\"/>"+
		"<col width=\"10%\" text=\"开始期间\" column=\"ksqj\" orderkey=\"ksqj\"/>"+
		"<col width=\"10%\" text=\"结束期间\" column=\"jsqj\" orderkey=\"jsqj\"/>"+
		"<col width=\"10%\" text=\"预算总金额\" column=\"yszje\" orderkey=\"yszje\" transmethod=\"weaver.fna.general.FnaSplitPageTransmethod.fmtAmount\"/>"+
		"<col width=\"10%\" text=\"申请金额\" column=\"sqje\" orderkey=\"sqje\" transmethod=\"weaver.fna.general.FnaSplitPageTransmethod.fmtAmount\"/>"+
		"<col width=\"10%\" text=\"审批金额\" column=\"spje\" orderkey=\"spje\" transmethod=\"weaver.fna.general.FnaSplitPageTransmethod.fmtAmount\"/>"+
		"<col width=\"10%\" text=\"已发生金额\" column=\"yfsje\" orderkey=\"yfsje\" transmethod=\"weaver.fna.general.FnaSplitPageTransmethod.fmtAmount\"/>"+
		"<col width=\"10%\" text=\"可用金额\" column=\"kyje\" orderkey=\"kyje\" transmethod=\"weaver.fna.general.FnaSplitPageTransmethod.fmtAmount\"/>"+
	
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

	<script type="text/javascript">

jQuery(document).ready(function(){
	orgType_onchange();
});

	function orgType_onchange(){
	var spanSubIdObj = jQuery("#spanSubId");
	var spanDepIdObj = jQuery("#spanDepId");
	var spanFccIdObj = jQuery("#spanFccId");
	spanSubIdObj.hide();
	spanDepIdObj.hide();
	spanFccIdObj.hide();
	
	var orgType = jQuery("#orgType").val();
	if(orgType=="1"){
		spanSubIdObj.show();
	}else if(orgType=="2"){
		spanDepIdObj.show();
	}else if(orgType=="<%=FnaCostCenter.ORGANIZATION_TYPE %>"){
		spanFccIdObj.show();
	}
}

	
		function onBtnSearchClick() {
			var orgType_val=jQuery("#orgType").val();
			var subId_val=jQuery("#subId").val();
			var depId_val=jQuery("#depId").val();
			var fccId_val=jQuery("#fccId").val();
			var ksyear_val=jQuery("#ksyear").val();
			var ksyue_val=jQuery("#ksyue").val();
			var jsyear_val=jQuery("#jsyear").val();
			var jsyue_val=jQuery("#jsyue").val();
			if(orgType_val=='1' && subId_val==''){
				alert("请选择分部");
				return;
			}
			if(orgType_val=='2' && depId_val==''){
				alert("请选择部门");
				return;
			}
			if(orgType_val=='18004' && fccId_val==''){
				alert("请选择成本中心");
				return;
			}
			if(ksyear_val !=jsyear_val){
				alert("请不要跨年查询");
				return;
			}
			if(Number(jsyue_val)<Number(ksyue_val)){
				alert("结束期间应大于等于开始期间");
				return;
			}
			//alert(orgType_val+","+depId_val+","+fccId_val+","+ksyear_val+","+ksyue_val+","+jsyear_val+","+jsyue_val+",")
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
	</script>
			<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
