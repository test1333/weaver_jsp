
<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@page import="weaver.proj.util.PropUtil"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CptSearchComInfo" class="weaver.cpt.search.CptSearchComInfo" scope="session" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />

<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CostcenterComInfo" class="weaver.hrm.company.CostCenterComInfo" scope="page"/>
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page"/>
<jsp:useBean id="CapitalAssortmentComInfo" class="weaver.cpt.maintenance.CapitalAssortmentComInfo" scope="page"/>
<jsp:useBean id="CapitalStateComInfo" class="weaver.cpt.maintenance.CapitalStateComInfo" scope="page"/>
<jsp:useBean id="CapitalTypeComInfo" class="weaver.cpt.maintenance.CapitalTypeComInfo" scope="page"/>
<jsp:useBean id="AssetUnitComInfo" class="weaver.lgc.maintenance.AssetUnitComInfo" scope="page"/>
<jsp:useBean id="AssetComInfo" class="weaver.lgc.asset.AssetComInfo" scope="page"/>
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page"/>
<jsp:useBean id="DepreMethodComInfo" class="weaver.cpt.maintenance.DepreMethodComInfo" scope="page"/>
<jsp:useBean id="CapitalModifyFieldComInfo" class="weaver.cpt.capital.CapitalModifyFieldComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<%
String isclose = Util.null2String(request.getParameter("isclose"));
String isDialog = Util.null2String(request.getParameter("isdialog"));
String isDialog2 = Util.null2String(request.getParameter("isdialog2"));
if("".equals( isDialog)&&!"".equals(isDialog2)){
	isDialog=isDialog2;
}
%>
<%

String nameQuery=Util.null2String(request.getParameter("flowTitle"));

String CurrentUser = ""+user.getUID();
String capitalid = ""+Util.getIntValue(request.getParameter("capitalid"),0);
String subcomid = Util.null2String(request.getParameter("subcomid"));
String departmentid = Util.null2String(request.getParameter("departmentid"));
String resourceid = Util.null2String(request.getParameter("resourceid"));
String fromdate = Util.null2String(request.getParameter("fromdate"));
String todate = Util.null2String(request.getParameter("todate"));
String oldval = Util.null2String(request.getParameter("oldval"));
String curval = Util.null2String(request.getParameter("curval"));
String fieldname = Util.null2String(request.getParameter("fieldname"));


String pageId=Util.null2String(PropUtil.getPageId("cpt_cptcapitalmodifyview"));
%>

<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/cpt/js/common_wev8.js"></script>
<script type="text/javascript">
var parentWin;
if("<%=isDialog %>"=="1"){
	parentWin = parent.parent.getParentWindow(parent.window);
	var parentDialog = parent.parent.getDialog(parent);
}
if("<%=isclose%>"=="1"){
	parentWin.onBtnSearchClick();
	parentWin.closeDialog();	
}
</script>
</HEAD>
<%
String titlename = "";
if(CptSearchComInfo.getIsData().equals("1")){
	titlename = SystemEnv.getHtmlLabelName(1509,user.getLanguage());
}else{
	titlename = SystemEnv.getHtmlLabelName(535,user.getLanguage());
}

String imagefilename = "/images/hdHRMCard_wev8.gif";
titlename = "";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=frmain name=frmain action="CptCapitalModifyView.jsp" method=post>
<input type="hidden" name="pageId" id="pageId" value="<%=pageId  %>" />
<input type="hidden" name="capitalid" value="<%=capitalid %>">
<input type="hidden" id=isdialog2 name="isdialog2" value="<%=isDialog %>">
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right; width:500px!important">
			<span id="advancedSearch" class="advancedSearch" style="display:"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
			<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>

<!-- advanced search -->
<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:">
	<wea:layout type="4col">
	    <wea:group context='<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage())%>'>
	    	<wea:item><%=SystemEnv.getHtmlLabelName(685,user.getLanguage())%></wea:item>
	    	<wea:item>
	    		<input class=InputStyle name=fieldname id=fieldname value="<%=fieldname %>" />
	    	</wea:item>
	    	<wea:item><%=SystemEnv.getHtmlLabelName(723,user.getLanguage())%></wea:item>
	    	<wea:item>
	    		<span class="wuiDateSpan" selectId="selectenddate_sel" selectValue="">
				    <input class=wuiDateSel type="hidden" name="fromdate" value="<%=fromdate%>">
				    <input class=wuiDateSel  type="hidden" name="todate" value="<%=todate%>">
				</span>
	    	</wea:item>
	    	<wea:item><%=SystemEnv.getHtmlLabelName(6056,user.getLanguage())%></wea:item>
	    	<wea:item>
	    		<input class=InputStyle name=oldval id=oldval value="<%=oldval %>" />
	    	</wea:item>
	    	<wea:item><%=SystemEnv.getHtmlLabelName(1450,user.getLanguage())%></wea:item>
	    	<wea:item>
	    		<input class=InputStyle name=curval id=curval value="<%=curval %>" />
	    	</wea:item>
	    	<wea:item><%=SystemEnv.getHtmlLabelName(99,user.getLanguage())%></wea:item>
	    	<wea:item>
	    		<brow:browser  name="resourceid" browserValue='<%=resourceid%>' browserSpanValue='<%=Util.toScreen(ResourceComInfo.getResourcename (resourceid),user.getLanguage())%>' browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp" completeUrl="/data.jsp"  isMustInput="1" viewType="0" browserOnClick=""  hasInput="true"  isSingle="true" hasBrowser = "true" />
	    	</wea:item>
	    	<wea:item><%=SystemEnv.getHtmlLabelNames("99,124",user.getLanguage())%></wea:item>
	    	<wea:item>
	    		<brow:browser  name="departmentid" browserValue='<%=departmentid%>' browserSpanValue='<%=Util.toScreen(DepartmentComInfo.getDepartmentname(departmentid ),user.getLanguage())%>' browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp" completeUrl="/data.jsp?type=4"  isMustInput="1" viewType="0" browserOnClick=""  hasInput="true"  isSingle="true" hasBrowser = "true" />
	    	</wea:item>
	    	<wea:item><%=SystemEnv.getHtmlLabelNames("99,141",user.getLanguage())%></wea:item>
	    	<wea:item>
	    		<brow:browser  name="subcomid" browserValue='<%=subcomid%>' browserSpanValue='<%=Util.toScreen(SubCompanyComInfo.getSubCompanyname (subcomid ),user.getLanguage())%>' browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp" completeUrl="/data.jsp?type=164"  isMustInput="1" viewType="0" browserOnClick=""  hasInput="true"  isSingle="true" hasBrowser = "true" />
	    	</wea:item>
	    	<wea:item></wea:item>
	    	<wea:item></wea:item>
	    </wea:group>
	    
	    
	    <wea:group context="">
	    	<wea:item type="toolbar">
	    		<input class="zd_btn_submit" type="submit" name="submit1" value="<%=SystemEnv.getHtmlLabelNames("197",user.getLanguage())%>"/>
	    		<input class="zd_btn_cancle" type="reset" name="reset" value="<%=SystemEnv.getHtmlLabelNames("2022",user.getLanguage())%>"/>
	    		<input class="zd_btn_cancle" type="button" name="cancel" id="cancel" value="<%=SystemEnv.getHtmlLabelNames("201",user.getLanguage())%>"  />
	    	</wea:item>
	    </wea:group>
	    
	</wea:layout>
</div>


<%

String sqlWhere = " where t1.field=t2.field and t1.cptid="+capitalid;

if(!"".equals(nameQuery)){
	sqlWhere+=" and t2.name like '%"+nameQuery+"%'";
}

if(!"".equals(fieldname)){
	sqlWhere+=" and t2.name like '%"+fieldname+"%'";
}
if(!"".equals(oldval)){
	sqlWhere+=" and t1.oldvalue like '%"+oldval+"%'";
}
if(!"".equals(curval)){
	sqlWhere+=" and t1.currentvalue like '%"+curval+"%'";
}
if(!"".equals(resourceid)){
	sqlWhere+=" and t1.resourceid='"+resourceid+"'";
}
if(!"".equals(departmentid)){
	sqlWhere+=" and exists ( select 1 from hrmresource tt where tt.departmentid='"+departmentid+"' and tt.id=t1.resourceid )" ;
}
if(!"".equals(subcomid)){
	sqlWhere+=" and exists ( select 1 from hrmresource tt where tt.subcompanyid1='"+subcomid+"' and tt.id=t1.resourceid )" ;
}
if(!"".equals(fromdate)){
	sqlWhere+=" and t1.modifydate>='"+fromdate+"'";
}
if(!"".equals(todate)){
	sqlWhere+=" and t1.modifydate<='"+todate+"'";
}



String orderby =" id ";
String tableString = "";
int perpage=16;                                 
String backfields = " t1.id,t1.cptid,t1.field,t1.oldvalue,t1.currentvalue,t1.resourceid,t1.modifydate,t2.name ";
String fromSql  = " CptCapitalModify t1,CptCapitalModifyField t2 ";

tableString =   " <table  pageId=\""+pageId+"\"  instanceid=\"CptCapitalAssortmentTable\" tabletype=\"none\"  pagesize=\""+PageIdConst.getPageSize(pageId,user.getUID(),"cpt")+"\"  >"+
				//" <checkboxpopedom  id=\"checkbox\" popedompara=\"column:id\" showmethod='weaver.cpt.util.CapitalTransUtil.getCanDelCptAssortmentShare' />"+
                "       <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"DESC\" sqlisdistinct=\"true\" />"+
                "       <head>"+
                "           <col width=\"5%\"  text=\""+SystemEnv.getHtmlLabelName(685,user.getLanguage())+"\" column=\"name\" orderkey=\"name\"   />"+
                "           <col width=\"5%\"  text=\""+SystemEnv.getHtmlLabelName(6056,user.getLanguage())+"\" column=\"oldvalue\" orderkey=\"oldvalue\"  />"+
                "           <col width=\"5%\"  text=\""+SystemEnv.getHtmlLabelName(1450,user.getLanguage())+"\" column=\"currentvalue\" orderkey=\"currentvalue\"   />"+
                "           <col width=\"5%\"  text=\""+SystemEnv.getHtmlLabelName(99,user.getLanguage())+"\" column=\"resourceid\" orderkey=\"resourceid\"  transmethod='weaver.hrm.resource.ResourceComInfo.getResourcename' />"+
                "           <col width=\"5%\"  text=\""+SystemEnv.getHtmlLabelName(723,user.getLanguage())+"\" column=\"modifydate\" orderkey=\"modifydate\"  />"+
                "       </head>"+
           /**     "     <popedom column=\"id\"  ></popedom> "+
                "		<operates>"+
					"		<operate href=\"javascript:onDetail();\" text=\""+SystemEnv.getHtmlLabelName(1293,user.getLanguage())+"\" target=\"_self\" index=\"1\"/>"+
				"		</operates>"+          **/       
                " </table>";
%>

<wea:SplitPageTag  tableString='<%=tableString %>'  mode="run" />

 
</FORM>
<script language="javascript">
function back()
{
	window.history.back(-1);
}
 
function onBtnSearchClick(){
	frmain.submit();
}
$(function(){
	$("#topTitle").topMenuTitle({searchFn:onBtnSearchClick});
});
</script>
<%
if("1".equals(isDialog)){
	%>
<div id="zDialog_div_bottom" class="zDialog_div_bottom">
<wea:layout>
	<wea:group context="">
    	<wea:item type="toolbar">
    		<input class="zd_btn_cancle" type="button" name="cancel" onclick="parentDialog.closeByHand();"  value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>"/>
    	</wea:item>
    </wea:group>
</wea:layout>
</div>	
	
	<%
}
%>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</body>
</html>
