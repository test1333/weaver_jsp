<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
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


String tmc_pageId = "delCus003";

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
		String kmm_dt="";
		String name_dt="";
		String url_dt="";
		String sql="select * from uf_delcontact_table";
		StringBuffer sb= new StringBuffer();
		String sql_dt="";
		rs.executeSql(sql);
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
		
			if("1".equals(sfmxb)){
				query="select '"+kmm+"' as kmm,(select "+jmxszdm+" from "+jmxsbm+" where "+jmxskey+"=a."+jmxsglzd+") as name" +
						" ,'"+url+"'+convert(varchar(40),a."+urlzd+") as url from "+glbm+" a,"+tablename+" b " +
								"where a."+glbmkey+"=b."+glzd+" and   ','+CAST(b."+zdm+" as varchar(8000))+','   like '%,"+customID+",%'";
			
			}else{
				query="select '"+kmm+"' as kmm ,(select "+jmxszdm+" from "+jmxsbm+" where "+jmxskey+"=a."+jmxsglzd+") as name" +
						",'"+url+"'+convert(varchar(40),a."+urlzd+") as url from "+tablename+"  a where  ','+CAST(a."+zdm+" as varchar(8000))+','   like '%,"+customID+",%'";
			
			}
			//out.print(query);
			sql_dt="select count(1) as count from ( "+query+") a";
			rs_dt.executeSql(sql_dt);
			int count=0;
			if(rs_dt.next()){
				count = rs_dt.getInt("count");
			}
			if(count > 0){
%>
<wea:layout type="table" attributes="{'cols':'2','cws':'50%,50%'}">
<wea:group context="<%=kmm%>">
	<wea:item type="thead">内容</wea:item>
	<wea:item type="thead"></wea:item>
	
<%
				rs_dt.executeSql(query);
				while(rs_dt.next()){
					kmm_dt = Util.null2String(rs_dt.getString("kmm"));
					name_dt = Util.null2String(rs_dt.getString("name"));
					url_dt = Util.null2String(rs_dt.getString("url"));
%>
					<wea:item><%=name_dt%></wea:item>
					<wea:item>
				    <a href="javascript:editInfo('<%=url_dt%>');">查看</a>
					</wea:item>
<%
				}
%>
</wea:group>
</wea:layout>
<%				
			}


		}
		//out.print(sb.toString());

%>


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
