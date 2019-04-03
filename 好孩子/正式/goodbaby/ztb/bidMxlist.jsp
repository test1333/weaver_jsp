<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
int userid = user.getUID();
String pageID = "AAAAAAAACCCCCC";
%>
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
<style type="text/css">
	.tab {
		width:100%;
		text-align:center;
		border-width: 1px;
		border-style: solid;
		border-color: #a9c6c9;
	}
</style>
</head>

<%
	String ids = Util.null2String(request.getParameter("id"));
	//out.print("ids-----"+ids);
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
	<div class="zDialog_div_content" id="differencehandle" name="differencehandle">
				<wea:layout type="4col">				
				<wea:group context="详细数据" attributes="{'samePair':'SetInfo','groupOperDisplay':'none','itemAreaDisplay':'block'}">
					<wea:item attributes="{'colspan':'4','isTableList':'true'}">
					
					<table class=ListStyle cellspacing=1>
						<colgroup>
							<col width="13%">
							<col width="13%">
							<col width="13%">
							<col width="13%">
							<col width="12%">
							<col width="12%">
							<col width="12%">
							<col width="12%">
						</colgroup>
						<tr class=header>
							<td>名称</td>
							<td>编码</td>
							<td>品牌</td>
							<td>型号</td>
							<td>规格</td>
							<td>数量</td>
							<td>单位</td>
							<td>报价</td>
						</tr>
						
					<%
					String strsql = "select * from uf_gysbjb_dt1 where mainid = '"+ids+"' ";
					rs.executeSql(strsql);
					//out.print(strsql);
					int fieldscount = 0;
					while(rs.next()){//1
						String wlbm = Util.null2String(rs.getString("BM_1"));
						String xh = Util.null2String(rs.getString("XH_1"));
						String gg = Util.null2String(rs.getString("GG_1"));
						String dw1 = Util.null2String(rs.getString("DW_1"));
						String dw = "";
						String dwsql = "select * from uf_unitForms where id  = '"+dw1+"'";
						RecordSet.executeSql(dwsql);
						if(RecordSet.next()){
							dw = RecordSet.getString("dw");
						}
						String pp = Util.null2String(rs.getString("PP_1"));
						String sl = Util.null2String(rs.getString("SHUL_1"));
						String mc = Util.null2String(rs.getString("WLMC_1"));
						String bjje = Util.null2String(rs.getString("BJJE_1"));
						//out.print("pp-----"+pp);
				%>	
						
						
				<%if(fieldscount%2==1){%><tr class=DataDark><%}%>
				<%if(fieldscount%2==0){%><tr class=DataLight><%}%>		
				<td><%=mc%></td>		
				<td><%=wlbm%></td>			
				<td><%=pp%></td>			
				<td><%=xh%></td>			
				<td><%=gg%></td>			
				<td><%=sl%></td>		
				<td><%=dw%></td>			
				<td><%=bjje%></td>	
				</tr>
				<%
						fieldscount++;	
					}
				
				%>
					</table>
					
					
					</wea:item>
				</wea:group>				
				
				
				
				</wea:layout>
		</div>
 </BODY>
</HTML>
 