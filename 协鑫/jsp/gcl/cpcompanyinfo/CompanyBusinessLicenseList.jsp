<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%> 
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<%@ include file="/systeminfo/init.jsp" %>
<style type="text/css">
<!--
TABLE.ListStyle {
	width:"100%" ;
	BACKGROUND-COLOR: #b8c2c8 ;
	BORDER-Spacing:1px; 
}
.xTable_info{
	margin-top:0px;
	text-align:right;
	font-size:9pt;
}
-->

</style>
<%	

	//�ܹؼ���һ�������������жϺ���ҳ���Ƿ񿪷��༭Ȩ��
	//0--ֻ�������˾�Ĳ鿴Ȩ�ޣ�û��ά��Ȩ��
	//1--ӵ�������˾�鿴��ά��ȫ��
	String showOrUpdate =Util.null2String(request.getParameter("showOrUpdate"));
	//�������������ÿһ���û����Եģ������ڴ������������Ե�����ɾ����û����
	
	String companyid = Util.null2String(request.getParameter("companyid"));
	String o4searchTX = Util.null2String(request.getParameter("o4searchTX"));
	String o4searchSL = Util.null2String(request.getParameter("o4searchSL"));
	//System.out.println(o4searchTX);
	String sqlwhere1 = "";
	if(!o4searchTX.equals("")){
		sqlwhere1 = " and "+o4searchSL+" like '%"+o4searchTX+ "%'";
	}
	int language=user.getLanguage();
	String backfields = " t1.licenseid,t1.licenseaffixid,(select tla.affixindex from CPLMLICENSEAFFIX tla where tla.licenseaffixid = t1.licenseaffixid) affixindex,(select tla.licensename from CPLMLICENSEAFFIX tla where tla.licenseaffixid = t1.licenseaffixid) licensename,t1.dateinssue,t1.departinssue,t1.memo,t1.affixdoc,t1.createdatetime ,'"+showOrUpdate+"'  as showOrUpdate,"+language+" as language";
	String fromSql = " CPBUSINESSLICENSE t1 ";
	String sqlwhere = " where t1.isdel='T' and t1.companyid =" + companyid + sqlwhere1;
	String sqlorderby = " t1.licenseaffixid ";
	String sqlsortway = " asc ";
	String refCompanyNameParam = "column:licensename";
	String refComlog = "column:showOrUpdate+column:language";

	StringBuffer tableString = new StringBuffer();
	tableString .append(" <table instanceid=\"workflowRequestListTable\" tabletype=\"none\" pagesize=\"8\" width=\"100%\" isfixed=\"true\" isnew= \"true\" > ");
	//tableString .append(" <checkboxpopedom    popedompara=\"column:t1.licenseid\" showmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getIsShowBox\" />");
	tableString .append(" <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+sqlwhere+"\"  sqlorderby=\""+sqlorderby+"\"  sqlprimarykey=\"t1.licenseid\" sqlisdistinct=\"false\" sqlsortway=\""+sqlsortway+"\"  />");
	tableString .append(" <head>");                  
	tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(31019,user.getLanguage())+"\"  column=\"affixindex\"   orderkey=\"affixindex\"  align=\"center\"   		width=\"8%\"  transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getAffixindex\" />");      
    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(30945,user.getLanguage())+"\"  column=\"licenseid\"   orderkey=\"licenseid\"   otherpara=\""+refCompanyNameParam+"\"   align=\"center\"   		width=\"20%\"  transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getLicensename\" />");
    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(27319,user.getLanguage())+"\" column=\"dateinssue\"    align=\"center\"  width=\"10%\"	 />");
    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(125912,user.getLanguage())+"\" column=\"departinssue\"   align=\"center\"  width=\"20%\" />");        
    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(20820,user.getLanguage())+"\"   column=\"memo\" orderkey=\"memo\" align=\"center\"  width=\"10%\"  />");
    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(156,user.getLanguage())+"\" column=\"affixdoc\" transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getAffixDown\"  width=\"5%\"  align=\"center\"  />");     
    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(722,user.getLanguage())+"\" column=\"createdatetime\"    align=\"center\"  width=\"16%\" />");       
     tableString.append("	<col  text=\""+SystemEnv.getHtmlLabelName(30585,user.getLanguage()) +"\"  column=\"licenseid\"     otherpara=\""+refComlog+"\"    align=\"center\"   width=\"16%\"   transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getLicenseOperating\"/>");
         
    tableString.append(" </head> </table>");
%>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<div sytle="padding:10px">
<wea:SplitPageTag   tableString="<%=tableString.toString()%>"  mode="run"  isShowBottomInfo="false"/>
</div>
<script type="text/javascript">
	
		function getOperating(id,companyid){
			if(id==1){
				window.parent.beforeEditorView('viewBtn',companyid,'<%=showOrUpdate%>');
			}else if(id==2){
				window.parent.beforeEditorView('editBtn',companyid,'<%=showOrUpdate%>');
			}else if(id==3){
				window.parent.delMutiList2Info(companyid);
			}
	}
	
	/*ˢ������ҳ��*/
	function reloadListContent(){
		window.location.reload();
	}
	/*��ù�˾��˾֤�� ID*/
	function getrequestids(){
		var requestids = _xtable_CheckedRadioId();
		return requestids;
	}
	function openConter(id){
				window.parent.beforeEditorView('viewBtn',id,'<%=showOrUpdate%>');
	}	
</script>