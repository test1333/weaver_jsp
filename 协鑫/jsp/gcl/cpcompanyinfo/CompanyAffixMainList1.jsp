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
	//Ҫ���ҵ���
	String companyid = Util.null2String(request.getParameter("companyid"));
	String userId = String.valueOf(user.getUID()); //��ǰ�û�Id
	String moudel = Util.null2String(request.getParameter("moudel"));
	//System.out.println(moudel);
	String backfields = " t1.id,t1.searchname,t1.LASTUPDATETIME";
	String fromSql = " CPCOMPANYAFFIXSEARCH t1 ";
	String sqlwhere = " where t1.isdel='T' and t1.companyid= "+companyid +" and t1.userid="+userId+" and t1.whichmoudel='"+moudel+"'";
	String sqlorderby = " t1.LASTUPDATETIME ";
	String sqlsortway = " desc ";
		
	StringBuffer tableString = new StringBuffer();
	tableString .append(" <table instanceid=\"workflowRequestListTable\" tabletype=\"checkbox\" pagesize=\"5\" width=\"100%\" isfixed=\"true\" isnew= \"true\" _style= \"true\"> ");
	tableString .append(" <checkboxpopedom    popedompara=\"column:id\" showmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getIsShowBox\" />");
	tableString .append(" <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+sqlwhere+"\"  sqlorderby=\""+sqlorderby+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\""+sqlsortway+"\"  />");
	tableString .append(" <head>");                  
	if(moudel.equals("search")){       
    	tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(30959,user.getLanguage())+"\"  column=\"searchname\"   orderkey=\"archivenum\"  		width=\"35%\"  />");
    }
    if(moudel.equals("delivery")){
    	tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(30960,user.getLanguage())+"\"  column=\"searchname\"   orderkey=\"archivenum\"  		width=\"35%\"  />");
    }
    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(26805,user.getLanguage())+"\" column=\"LASTUPDATETIME\"  align=\"center\"   width=\"17%\"	 />");
   
    tableString.append(" </head> </table>");
	        
%>
<div style="padding:5px">
<wea:SplitPageTag   tableString="<%=tableString.toString()%>"  mode="run"  isShowTopInfo="false" isShowBottomInfo="true"/>	
</div>
<script type="text/javascript">
	jQuery(document).ready(function(){
		
	});
	/*ˢ������ҳ��*/
	function reloadListContent(){
		window.location.reload();
	}
	/*����������� ID*/
	function getrequestids(){
		var requestids = _xtable_CheckedCheckboxId();
		return requestids;
	}
</script>