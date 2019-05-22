﻿<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
	String rid = Util.null2String(request.getParameter("rid"));
	//out.print("ids-----"+ids);
%>
<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=pageID%>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<div class="zDialog_div_content" id="differencehandle" name="differencehandle">
				<wea:layout type="4col">				
				<wea:group context="" attributes="{'samePair':'SetInfo','groupOperDisplay':'none','itemAreaDisplay':'block'}">
					<wea:item attributes="{'colspan':'4','isTableList':'true'}">
					
					<table class=ListStyle cellspacing=1 border="1">
						<colgroup>
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="20%">
						</colgroup>
						<tr >
							<td>供应商</td>
							<td>合计金额</td>
							<td>最终报价单价(含税)</td>
							<td>预计交期(单位:天)</td>
							<td>报价明细</td>
						</tr>
						
					<%
					String sqls = "select count(id) as cont from  formtable_main_227 where aid ='"+rid+"'  ";
					int a = 0;
					rs.executeSql(sqls);
					if(rs.next()){
						a = rs.getInt("cont");
					}
					
					String strsql = "select d.yjyq,d.BJJE,d.HJJE,(select c.name from  crm_customerinfo c where id =d.GYSBM1) as GYS from formtable_main_227  d where d.aid = '"+rid+"'  order by d.BJJE asc ";
					
					rs.executeSql(strsql);
					//out.print(strsql);
					int fieldscount = 0;
					while(rs.next()){//1
						String BJJE = Util.null2String(rs.getString("BJJE"));
						String HJJE = Util.null2String(rs.getString("HJJE"));
						String GYSBM1 = Util.null2String(rs.getString("GYS"));
						String yjyq = Util.null2String(rs.getString("yjyq"));

				%>		
				<tr >
				<td style="boder:1"><%=GYSBM1%></td>		
				<td style="boder:1"><%=HJJE%></td>			
				<td style="boder:1"><%=BJJE%></td>
				<td style="boder:1"><%=yjyq%></td>
				<%if(fieldscount==0){%>
					<td  rowspan="<%=a%>" style ="text-align:center"><a href="/goodbaby/xj/XjMxlist.jsp?rid=<%=rid%>">报价明细<a/></td>	
				<%}%>
			
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
 