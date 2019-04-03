<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
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

	String remindID = Util.null2String(request.getParameter("remindID"));

	
	String deDate1 = "";
	String deTime1 = "";

	String stopID = "";
	String dateField = "";
	String timeField = "";
	int remindtimetype = 0;
	String tableName = "";
	String infowhere = "";
	int selStopInfo = 0;
	
	int remindHZ = 0;
	String title = "";
	String deDate = "";
	String deTime = "";
	String incrementnum = "0";
	int incrementunit = 0;
	int incrementway = 0;
	int receivertype = 0;
	String remarks = "";
	int over_active = 0;
	int areaType = 0;
	String areaVal = "";
	int level = 10;
	int triggertype = 0;
	String weeks = "";
	String months = "";
	String days = "";
	String triggercycletime = "";
	int creater = 0;
	int now_user = user.getUID();
	String sql = "select * from uf_remindRecord where id= " + remindID;
//	System.out.println("sql = " + sql);
	RecordSet.executeSql(sql);
	if(RecordSet.next()){
		title = Util.null2String(RecordSet.getString("title")); 
		over_active = Util.getIntValue(RecordSet.getString("over_active"),0);
		remindHZ = Util.getIntValue(RecordSet.getString("remindHZ"),0);
		deDate = Util.null2String(RecordSet.getString("deDate"));
		deTime = Util.null2String(RecordSet.getString("deTime"));
		incrementnum = RecordSet.getString("incrementnum");
		incrementunit = Util.getIntValue(RecordSet.getString("incrementunit"),0);
		incrementway = Util.getIntValue(RecordSet.getString("incrementway"),0);
		receivertype = Util.getIntValue(RecordSet.getString("receivertype"),0);
		remarks = Util.null2String(RecordSet.getString("remarks"));
		areaType = Util.getIntValue(RecordSet.getString("areaType"),0);
		areaVal = Util.null2String(RecordSet.getString("areaVal"));
		level = Util.getIntValue(RecordSet.getString("level"),10);
		triggertype = Util.getIntValue(RecordSet.getString("triggertype"),0);
		
		triggercycletime = Util.null2String(RecordSet.getString("triggercycletime"));
		weeks = Util.null2String(RecordSet.getString("weeks"));
	    months = Util.null2String(RecordSet.getString("months"));
	    days = Util.null2String(RecordSet.getString("days"));
	    
	    creater = Util.getIntValue(RecordSet.getString("creater"),0);
	}
	boolean isOver = false;
	boolean isEnd = false;
	int flagx = 0;
	sql = " select count(*) as count_cc from HrmResource where id="+now_user+" and seclevel>=(select seclevel from HrmResource where id="+creater+")";
//	out.println("sql = " + sql);
	RecordSet.executeSql(sql);
	if(RecordSet.next()){
		flagx = RecordSet.getInt("count_cc");
	}
	if(flagx > 0){
		isOver = true;
	}
	flagx = 0;
	sql = "select count(id) as count_cc from uf_remindFilter where remindID="+remindID+" and remindEmp="+now_user+" and is_active=0";
	RecordSet.executeSql(sql);
	if(RecordSet.next()){
		flagx = RecordSet.getInt("count_cc");
	}
	if(flagx > 0){
		isEnd = true;
	}

%>

<script type="text/javascript">
	function colseMe(){
		if(confirm("确认关闭提醒给我？")){
			frmMain.submit();
			
			
		}
	}
	
</script>

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
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=weaver name=frmMain action="/seahonor/remind/RemindGiveEmpOper.jsp" method=post>
		<input type="hidden" name="remindID" id="remindID" value="<%=remindID %>">
		<input type="hidden" name="operation" id="operation" value="colsex">
	
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>

			</tr>
		</table>

<wea:layout type="2col">
<wea:group context="提醒信息" attributes="test">
<wea:item attributes="{'colspan':'full'}">
<font color="#FF0000">信息提醒</font>
</wea:item>	

	<wea:item>标题</wea:item>
	<wea:item><%=title%></wea:item>
	
	<wea:item>提醒创建人</wea:item>
	<wea:item><%=ResourceComInfo.getResourcename(""+creater)%>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<%
			if(isEnd){
				out.println("<font color=\"red\">已经关闭提醒我！</font>");
			}else{
			if(isOver){
		%>
			<input type=button class="e8_btn_top" onclick="colseMe();" value="不要提醒"></input>
		<%}
			}%>
		
	</wea:item>
		
	<wea:item>是否启用</wea:item>
	<wea:item>
		<%
			if(over_active==1) out.println("Yes");
			else out.println("No");
		%>
	</wea:item>	
		
	<wea:item>提醒类型</wea:item>
	<wea:item>
		<%
			if(remindHZ == 1) out.println("即时提醒");
			else if(remindHZ == 1) out.println("到期提醒");
			else if(remindHZ == 1) out.println("循环提醒");
		%>
	</wea:item>	
		
	<%
	if(remindHZ == 2 || remindHZ == 3){
	%>
	<wea:item>到期日期</wea:item>
	<wea:item><%=deDate%> <%=deTime%></wea:item>	
	<wea:item>时间增量</wea:item>
	<wea:item><%if(incrementway==1) out.println("提前"); else if(incrementway==2) out.println("延迟"); %>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=incrementnum%>&nbsp;&nbsp;
		<%
			if(incrementunit==1) out.println("分钟"); 
			else if(incrementunit==2) out.println("小时"); 
			else if(incrementunit==3) out.println("天"); 
			else if(incrementunit==4) out.println("月"); 
		%>
	</wea:item>
	
	<%}%>
	<wea:item>提醒内容</wea:item>
	<wea:item> <%=remarks%></wea:item>
	
	<wea:item>提醒人员</wea:item>
	<wea:item><%if(areaType==1) out.println("人员"); 
				else if(areaType==2) out.println("分部"); 
				else if(areaType==3) out.println("部门"); 
				else if(areaType==4) out.println("角色"); 
				else if(areaType==5) out.println("所有人"); 
			%></wea:item>
	<wea:item>具体</wea:item>
	<wea:item><%
			String areaArr[] = areaVal.split(",");
			String areaFlag = " ";
			if(areaType==1){
				for(int index=0;index<areaArr.length;index++){
					out.println(areaFlag);
					out.println(ResourceComInfo.getResourcename(areaArr[index]));
				}
				
			}else if(areaType==2){
				for(int index=0;index<areaArr.length;index++){
					out.println(areaFlag);
					out.println(SubCompanyComInfo.getSubCompanyname(areaArr[index]));
				}
			}else if(areaType==3){
				for(int index=0;index<areaArr.length;index++){
					out.println(areaFlag);
					out.println(DepartmentComInfo.getDepartmentname(areaArr[index]));
				}
			}else if(areaType==4){
				for(int index=0;index<areaArr.length;index++){
					out.println(areaFlag);
					out.println(RolesComInfo.getRolesRemark(areaArr[index]));
				}
			}else if(areaType==5){
			}
			out.println("&nbsp");out.println("&nbsp");out.println("&nbsp");out.println(level);
			%>
	</wea:item>	
				
	<wea:item>定时器运行频率</wea:item>
	<wea:item><%
				if(triggertype==1) {
					out.println("每隔 "); out.println(triggercycletime);out.println(" 分钟"); 
				}else if(triggertype==2){
					out.println("每隔 "); out.println(triggercycletime);out.println(" 小时"); 
				}else if(triggertype==3){
					out.println("每隔 "); out.println(triggercycletime); out.println(" 天"); 
				}else if(triggertype==4){
					out.println("周 -> "); out.println(weeks);
				}else if(triggertype==5){
					out.println("月 -> 每"); out.println(months);out.println("月  的"); out.println(days);out.println("天"); 
				}else if(triggertype==5){
					out.println("仅一次"); 
				}
			%></wea:item>
				
    </wea:group>					
	</FORM>

</BODY>
</HTML>
