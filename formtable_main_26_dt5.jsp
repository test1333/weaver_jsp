<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>


<html>
<head>
<script type="text/javascript" src="/js/weaver.js"></script>
<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>

<%

String requestid = Util.null2String(request.getParameter("requestid"));
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage = 15;

String imagefilename = "/images/hdDOC.gif";
String titlename = "列表";
String needfav ="1";
String needhelp ="";
%>

<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table width=100% height=100%>
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

<FORM id=weaver NAME=SearchForm STYLE="margin-bottom:0" action="" method="post">
<input type=hidden name=operation>

<TABLE width="100%">
	<tr>
		<td>
            <%
            String backfields = "rownum as sortnum,ZZI_TPM_ITEM,ZZI_CAMP_TYPE,ZZI_CAMP_DESR,ZZI_FUND_TYPE_K,ZZI_FUND_TYPE,ZZ_SETT_MODE_K,ZZ_SETT_MODE,ZZI_IS_TQLINGHUO,ZZI_APPLY_V,ZZ_YS_ID, "+
		                    " ZZC_BUDGET_ZY,RESIDULE_BUGET,ZZI_SELL_IN,ZZI_CONSUM_RATE,ZZI_ROL_RATE,ZZI_IS_CONTACT,ZZI_PRODUCT_ID,ZZI_PROD_NAME,ZZI_SKU,ZZI_ZBRAND,ZZI_ZCATEGORY, "+
		                    " ZZI_ZSERISS,ZZI_TP_DATE_S,ZZI_TP_DATE_E,ZZI_JH_DATE_S,ZZI_JH_DATE_E,ZZI_DM_PUR_PR,ZZI_DM_SALE_PR,ZZI_TP_PUR_PR,ZZI_TP_SALE_PR,ZZI_TP_QUAN,"+
		                    " ZZI_P3_SALE_QUN,ZZI_FB,ZZI_DISPLAY_TYPE";
			String fromSql =" from  formtable_main_26_dt5 ";
			String sqlWhere =" where mainid in (select id from formtable_main_26 where requestid = "+requestid+") ";
			String orderby = " sortnum " ;
			String tableString = " ";
        	
            tableString =" <table tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"asc\" />"+
                           "			<head>";
			tableString+="  <col width=\"50px\"  text=\"序号\" column=\"sortnum\" orderkey=\"sortnum\"/>"+
			"  				<col width=\"100px\"  text=\"活动类型\" column=\"ZZI_CAMP_TYPE\" orderkey=\"ZZI_CAMP_TYPE\"/>"+
			"               <col width=\"100px\"  text=\"活动描述\" column=\"ZZI_CAMP_DESR\" orderkey=\"ZZI_CAMP_DESR\"/>"+
			"               <col width=\"100px\"  text=\"费用科目\" column=\"ZZI_FUND_TYPE\" orderkey=\"ZZI_FUND_TYPE\"/>"+
			"               <col width=\"100px\"  text=\"结算方式\" column=\"ZZ_SETT_MODE\" orderkey=\"ZZ_SETT_MODE\"/>"+
			"               <col width=\"100px\"  text=\"是否提前领货\" column=\"ZZI_IS_TQLINGHUO\" orderkey=\"ZZI_IS_TQLINGHUO\"/>"+
			"               <col width=\"100px\"  text=\"费用申请金额\" column=\"ZZI_APPLY_V\" orderkey=\"ZZI_APPLY_V\"/>"+
			"               <col width=\"100px\"  text=\"预算单号\" column=\"ZZ_YS_ID\" orderkey=\"ZZ_YS_ID\"/>"+
			"               <col width=\"100px\"  text=\"已使用预算\" column=\"ZZC_BUDGET_ZY\" orderkey=\"ZZC_BUDGET_ZY\"/>"+
			"               <col width=\"100px\"  text=\"可用预算\" column=\"RESIDULE_BUGET\" orderkey=\"RESIDULE_BUGET\"/>"+
			"               <col width=\"100px\"  text=\"预计销量(元)\" column=\"ZZI_SELL_IN\" orderkey=\"ZZI_SELL_IN\"/>"+
			"               <col width=\"100px\"  text=\"预计费比%\" column=\"ZZI_CONSUM_RATE\" orderkey=\"ZZI_CONSUM_RATE\"/>"+
			"               <col width=\"100px\"  text=\"预计ROI%\" column=\"ZZI_ROL_RATE\" orderkey=\"ZZI_ROL_RATE\"/>"+
			"               <col width=\"100px\"  text=\"是否合约内费用\" column=\"ZZI_IS_CONTACT\" orderkey=\"ZZI_IS_CONTACT\"/>"+
			"               <col width=\"100px\"  text=\"品牌\" column=\"ZZI_ZBRAND\" orderkey=\"ZZI_ZBRAND\"/>"+
			"               <col width=\"100px\"  text=\"品类\" column=\"ZZI_ZCATEGORY\" orderkey=\"ZZI_ZCATEGORY\"/>"+
			"               <col width=\"100px\"  text=\"产品系列\" column=\"ZZI_ZSERISS\" orderkey=\"ZZI_ZSERISS\"/>"+
			"               <col width=\"100px\"  text=\"SKU号\" column=\"ZZI_SKU\" orderkey=\"ZZI_SKU\"/>"+
			"               <col width=\"100px\"  text=\"产品编号\" column=\"ZZI_PRODUCT_ID\" orderkey=\"ZZI_PRODUCT_ID\"/>"+
			"               <col width=\"100px\"  text=\"标准DM进价\" column=\"ZZI_DM_PUR_PR\" orderkey=\"ZZI_DM_PUR_PR\"/>"+
			"               <col width=\"100px\" text=\"标准DM售价\" column=\"ZZI_DM_SALE_PR\" orderkey=\"ZZI_DM_SALE_PR\"/>"+
			"               <col width=\"100px\"  text=\"申请活动进货价\" column=\"ZZI_TP_PUR_PR\" orderkey=\"ZZI_TP_PUR_PR\"/>"+
			"               <col width=\"100px\"  text=\"申请活动出货价\" column=\"ZZI_TP_SALE_PR\" orderkey=\"ZZI_TP_SALE_PR\"/>"+
			"               <col width=\"100px\"  text=\"活动起始日期\" column=\"ZZI_TP_DATE_S\" orderkey=\"ZZI_TP_DATE_S\"/>"+
			"               <col width=\"100px\"  text=\"活动结束日期\" column=\"ZZI_TP_DATE_E\" orderkey=\"ZZI_TP_DATE_E\"/>"+
			"               <col width=\"100px\"  text=\"进货起始日期\" column=\"ZZI_JH_DATE_S\" orderkey=\"ZZI_JH_DATE_S\"/>"+
			"               <col width=\"100px\"  text=\"进货结束日期\" column=\"ZZI_JH_DATE_E\" orderkey=\"ZZI_JH_DATE_E\"/>"+
			"               <col width=\"100px\"  text=\"申请活动(箱)\" column=\"ZZI_TP_QUAN\" orderkey=\"ZZI_TP_QUAN\"/>"+
			"               <col width=\"100px\" text=\"前3个月平均进货销量\" column=\"ZZI_P3_SALE_QUN\" orderkey=\"ZZI_P3_SALE_QUN\"/>"+
			"               <col width=\"100px\"  text=\"符合标准\" column=\"ZZI_FB\" orderkey=\"ZZI_FB\"/>"+
			"               <col width=\"100px\"  text=\"二级陈列形式\" column=\"ZZI_DISPLAY_TYPE\" orderkey=\"ZZI_DISPLAY_TYPE\"/>"+
                           "			</head>"+
                           "</table>";
         %>
         <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" />
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
<tr>
	<td height="10" colspan="3"></td>
</tr>

</table>


<script type="text/javascript">
</script>
</BODY>
</HTML>
