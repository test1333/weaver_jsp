
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="TaiSon.kq.CreateLDKFlowAction"%>
<%@ page import="TaiSon.kq.KqUtil"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%!
	public void createFlow(String ryid) {
			if("".equals(ryid)) {
				return;
			}
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			String endDate =TimeUtil.dateAdd(sf.format(new Date()).substring(0, 7)+"-01", -1);
			String startDate = endDate.substring(0, 7)+"-01";
			KqUtil kq = new KqUtil();
			RecordSet rsff = new RecordSet();
			RecordSet rs_dt = new RecordSet();
			RecordSet rs_dt2 = new RecordSet();
			String sql_dt = "";
			String sql = "select id from hrmresource where (id in(select distinct xm from uf_tsmygskqry) or id in(select distinct xm from uf_jtzbkqry)) and id="+ryid;
		
			rsff.executeSql(sql);
			if(rsff.next()) {
				ryid = Util.null2String(rsff.getString("id"));
				sql_dt = "SELECT  TO_CHAR(TO_DATE('"+startDate+"', 'YYYY-MM-DD') + ROWNUM - 1, 'YYYY-MM-DD') DAY_ID   FROM DUAL " + 
						"CONNECT BY ROWNUM <= TO_DATE('"+endDate+"', 'YYYY-MM-DD') - TO_DATE('"+startDate+"', 'YYYY-MM-DD') + 1";
				rs_dt.execute(sql_dt);
				while(rs_dt.next()) {
					String cldate = Util.null2String(rs_dt.getString("DAY_ID"));
					rs_dt2.execute("{Call ks_calEmpDayAtten("+ryid+",'"+cldate+"')}");
					
				}
			}			
			kq.insertLdkData(startDate, endDate);
			int count =0;
			sql = "select count(1) as count from uf_kq_ldk_mid where ryid='"+ryid+"'";
			rsff.executeSql(sql);
			if(rsff.next()) {
				count = rsff.getInt("count");
			}
			if(count >0) {
				CreateLDKFlowAction clfa = new CreateLDKFlowAction();
				try {
					clfa.createFlow(ryid);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}	
	}
%>
<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
	<script type="text/javascript">	
				
		function onCheckup1(){
			if(window.confirm('你是否同步所有组织数据？')){
				document.report.multiIds.value = "1";
				document.report.submit();
			}
		}
				
		function onBtnSearchClick() {
			report.submit();
		}
					
	</script>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
boolean isShow = false;

int userid = user.getUID();

String multiIds = Util.null2String(request.getParameter("multiIds"));
String cfr = Util.null2String(request.getParameter("cfr"));


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

	RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{创建流程,javascript:onCheckup1(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=/TaiSon/kq/updateldkFlow.jsp method=post>
		<input type="hidden" name="multiIds" value="-1">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>

			</tr>
		</table>
			<%
		if("1".equals(multiIds)){
			createFlow(cfr);
			boolean isOver = true;
			if(isOver){
				out.println("<font size=\"5px\" color=\"red\">执行完成，触发成功!</font>");
			}else{
				out.println("<font size=\"5px\" color=\"red\">执行完成，触发失败!</font>");
			}
		}
		
			
	%>

<wea:layout type="2col">
<wea:group context="创建漏打卡流程" attributes="test">


<wea:item>选择人员</wea:item>
                <wea:item>
                <brow:browser viewType="0"  name="cfr" browserValue="<%=cfr%>"
                browserOnClick=""
                browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                completeUrl="/data.jsp" width="165px"
                browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(cfr),user.getLanguage())%>">
                </brow:browser>
                </wea:item>


	<wea:item>&nbsp;&nbsp;</wea:item>
		<wea:item>
		<table width="30%">
			<tr>

			</tr>
			<tr>
				<td><input name="hi1" type="button" value="触发流程" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:100px;height:30px;font-size:15px;" onClick="onCheckup()"></td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!--<td><input name="hi" type="button" value="刷新" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:80px;height:30px;font-size:15px;" onClick="onBtnSearchClick1()"></td>-->
			</tr>
		</table>
			<script type="text/javascript">	
				
				function onCheckup(){
					if(window.confirm('是否触发流程？')){
						document.report.multiIds.value = "1";
						document.report.submit();
				    }
				}
								
				function onBtnSearchClick1() {
					report.submit();
				}
					
			</script>
		
			 </wea:item>
		


</wea:group>
</wea:layout>	
			
	</FORM>

</BODY>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>

</HTML>
	

