<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

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

 String customID = (String)session.getAttribute("customID");
if("".equals(customID)){
	customID = "-1";
}
//out.print("id:"+customID);


String tmc_pageId = "delCus002";
String tablename="";//表名
		String zdm="";//字段名
		String keyzd="";//关键字段
		String kmm="";//科目名
		String url = "";//连接URL
		String glbm = "";//关联表名
		String glzd = "";//关联字段
		String glbmkey = "";//关联表key
		String urlzd = "";//Url字段
		String sfmxb = "";//是否明细表
		String jmxsbm = "";
		String jmxszdm = "";
		String jmxskey = "";
		String jmxsglzd = "";
		String sql="select * from uf_delcustom_table";
		StringBuffer sb= new StringBuffer();
		rs.executeSql(sql);
		String flag="";
		while(rs.next()){
			String query="";
			tablename = Util.null2String(rs.getString("tablename"));
			zdm = Util.null2String(rs.getString("zdm"));
			keyzd = Util.null2String(rs.getString("keyzd"));
			kmm = Util.null2String(rs.getString("kmm"));
			url = Util.null2String(rs.getString("url"));
			glbm = Util.null2String(rs.getString("glbm"));
			glzd = Util.null2String(rs.getString("glzd"));
			glbmkey = Util.null2String(rs.getString("glbmkey"));
			urlzd = Util.null2String(rs.getString("urlzd"));
			sfmxb = Util.null2String(rs.getString("sfmxb"));
			jmxsbm = Util.null2String(rs.getString("jmxsbm"));
			jmxszdm = Util.null2String(rs.getString("jmxszdm"));
			jmxskey = Util.null2String(rs.getString("jmxskey"));
			jmxsglzd = Util.null2String(rs.getString("jmxsglzd"));
			if ("1".equals(flag)){
				sb.append("\n union all \n ");
			}
			if("1".equals(sfmxb)){
				query="select '"+kmm+"' as kmm,(select "+jmxszdm+" from "+jmxsbm+" where "+jmxskey+"=a."+jmxsglzd+") as name" +
						" ,'"+url+"'+convert(varchar(40),a."+urlzd+") as url from "+glbm+" a,"+tablename+" b " +
								"where a."+glbmkey+"=b."+glzd+" and   ','+CAST(b."+zdm+" as varchar(8000))+','   like '%,"+customID+",%'";
				sb.append(query);
				flag="1";
			}else{
				query="select '"+kmm+"' as kmm ,(select "+jmxszdm+" from "+jmxsbm+" where "+jmxskey+"=a."+jmxsglzd+") as name" +
						",'"+url+"'+convert(varchar(40),a."+urlzd+") as url from "+tablename+"  a where  ','+CAST(a."+zdm+" as varchar(8000))+','   like '%,"+customID+",%'";
				sb.append(query);
				flag="1";
			}
		}
		//out.print(sb.toString());

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
//RCMenu += "{新增客户动态,javascript:openDyInfo(),_blank} " ;
//RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					
					</td>
				</tr>
		</table>
		<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				
			</div>

	</FORM>
    
	<%
								
	String backfields = " row_number() over ( order by kmm) as id,kmm,name,url "; 
	String fromSql  = " from  ("+sb.toString()+") a";
	String sqlWhere = " where 1=1 " ;
	String orderby = " kmm" ;
	String tableString = "";
  

//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "<operates width=\"20%\">"+
 	        	    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
					 	 "     <operate href=\"javascript:editInfo();\" linkkey=\"id\" linkvaluecolumn=\"url\" text=\"查看\"  target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+
						

 	       				"</operates>";	
tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"kmm\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"40%\"  text=\"科目\" column=\"kmm\" orderkey=\"kmm\"/>"+
		"<col width=\"60%\"  text=\"名称\" column=\"name\" orderkey=\"name\"/>"+
		
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

	<script type="text/javascript">
	

	function editInfo(url1) {
		//	openFullWindowForXtable("/seahonor/crm/ModeForward.jsp?type=custom&customID=<%=customID%>&empID="+id);
			var title = "";
			var url =url1;

			var diag_vote = new window.top.Dialog();
			diag_vote.currentWindow = window;
			diag_vote.Width = 1200;
			diag_vote.Height = 600;
			diag_vote.Modal = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.isIframe=false;
		
			diag_vote.show();	
		}

		function onBtnSearchClick() {
			report.submit();
		}
		
	</script>
	</script>
			<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
