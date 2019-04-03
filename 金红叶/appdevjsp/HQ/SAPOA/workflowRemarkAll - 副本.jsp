<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%

String saprequestid = Util.null2String(request.getParameter("requestid")) ;
int saplan = Util.getIntValue(request.getParameter("lan"),7) ;
    String requestid="";
	String requestids="";
	String pernr_f="";
	String lc_type = "";
	String ref_no = "";
	String flag="";
	String sql="select lc_no,pernr_f,lc_type,ref_no from zoat00020 where oa_md5='"+saprequestid+"'";
	rs.executeSql(sql);
	if(rs.next()){
		requestid = Util.null2String(rs.getString("lc_no"));
		pernr_f = Util.null2String(rs.getString("pernr_f"));
		lc_type = Util.null2String(rs.getString("lc_type"));
		ref_no =  Util.null2String(rs.getString("ref_no"));
	}
	if(!"".equals(requestid)){
		sql="select lc_no from zoat00020 where lc_type='"+lc_type+"' and ref_no ='"+ref_no+"'" ;
		rs.executeSql(sql);
		while(rs.next()){
			requestids=requestids+flag+Util.null2String(rs.getString("lc_no"));
			flag=",";
		}
	}
	if("".equals(requestid)){
		sql="select lc_no,pernr_f,lc_type,ref_no from zoat00030 where oa_md5='"+saprequestid+"'";
		rs.executeSql(sql);
		if(rs.next()){
			requestid = Util.null2String(rs.getString("lc_no"));
			pernr_f = Util.null2String(rs.getString("pernr_f"));
			lc_type = Util.null2String(rs.getString("lc_type"));
			ref_no =  Util.null2String(rs.getString("ref_no"));
		}
		if(!"".equals(requestid)){
		sql="select lc_no from zoat00030 where lc_type='"+lc_type+"' and ref_no ='"+ref_no+"'" ;
			rs.executeSql(sql);
			while(rs.next()){
				requestids=requestids+flag+Util.null2String(rs.getString("lc_no"));
				flag=",";
			}
		}
	}
	if("".equals(requestid)){
		response.sendRedirect("/appdevjsp/HQ/SAPOA/noright.jsp?lan="+saplan);
		return;
	}
request.getSession().setAttribute("weaver_user@bean", User.getUser(Integer.valueOf("11000209"), 0));
User user = HrmUserVarify.getUser (request , response);
user.setLanguage(saplan);
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);

%>
<%!
public String getState(String state,int saplan) {
		String statename = "";
		if(saplan==8){
			if ("0".equals(state)) {
				statename = "Approval";
			} else if ("2".equals(state)) {
				statename = "Submit";
			} else if ("3".equals(state)) {
				statename = "Return";
			} else if ("4".equals(state)) {
				statename = "Reopen";
			} else if ("5".equals(state)) {
				statename = "Delete";
			} else if ("6".equals(state)) {
				statename = "Activation";
			} else if ("7".equals(state)) {
				statename = "Retransmission";
			} else if ("9".equals(state)) {
				statename = "Comment";
			} else if ("e".equals(state)) {
				statename = "Compulsory filing";
			} else if ("t".equals(state)) {
				statename = "CC";
			} else if ("s".equals(state)) {
				statename = "Supervise";
			} else if ("i".equals(state)) {
				statename = "Process intervention";
			} else if ("1".equals(state)) {
				statename = "Save";
			} else {
				statename = "";
			}
		}
		else{
			if ("0".equals(state)) {
				statename = "批准";
			} else if ("2".equals(state)) {
				statename = "提交";
			} else if ("3".equals(state)) {
				statename = "退回";
			} else if ("4".equals(state)) {
				statename = "重新打开";
			} else if ("5".equals(state)) {
				statename = "删除";
			} else if ("6".equals(state)) {
				statename = "激活";
			} else if ("7".equals(state)) {
				statename = "转发";
			} else if ("9".equals(state)) {
				statename = "批注";
			} else if ("e".equals(state)) {
				statename = "强制归档";
			} else if ("t".equals(state)) {
				statename = "抄送";
			} else if ("s".equals(state)) {
				statename = "督办";
			} else if ("i".equals(state)) {
				statename = "流程干预";
			} else if ("1".equals(state)) {
				statename = "保存";
			} else {
				statename = "";
			}
		}
		return statename;
	}

    public String removeHtmlTag(String content) {
		Pattern p = Pattern.compile("<([a-zA-Z]+)[^<>]*>(.*?)</\\1>");
		Matcher m = p.matcher(content);
		if (m.find()) {
			content = content
					.replaceAll("<([a-zA-Z]+)[^<>]*>(.*?)</\\1>", "$2");
			content = removeHtmlTag(content);
		}
		return content;
	}

%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
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
	String titlename ="流转意见";
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();

	
	%>
	<script language="javascript" type="text/javascript" src="/FCKEditor/swfobject_wev8.js"></script>
<script type="text/javascript" src="/js/select/script/jquery-1.8.3.min_wev8.js"></script>	 
<script language="vbs" src="/js/string2VbArray.vbs"></script>       
<script type="text/javascript" src="/js/jquery.table_wev8.js"></script>
<script language="javascript" type="text/javascript" src="/js/init_wev8.js"></script>
<script language="javascript"  src="/js/wbusb_wev8.js"></script>
<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
<script type='text/javascript' src='/js/jquery-autoco/wui/common/page/initWui.jspmplete/jquery.autocomplete_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
<script language=javascript src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/lang/weaver_lang_7%>_wev8.js"></script>
<script type="text/javascript" src="/js/messagejs/highslide/highslide-full_wev8.js"></script>
<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
<script type="text/javascript" src="/wui/common/jquery/plugin/wuiform/jquery.wuiform_wev8.js"></script>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title=""></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		
		
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="requestids" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					
				</tr>
			</table>
			
			
		</FORM>

		    <wea:layout type="table" attributes="{'cols':'6','cws':'15%,10%,15%,15%,15%,30%'}">
				<wea:group context="流转意见"  attributes="{'groupDisplay':'none'}" >
				<%
				 if(saplan==8){
				%>
				<wea:item type="thead">NodeName</wea:item>
				<wea:item type="thead">Approver</wea:item>
				<wea:item type="thead">Post</wea:item>
			    <wea:item type="thead">Operation type</wea:item>
				<wea:item type="thead">Operation Time</wea:item>
				<wea:item type="thead">Opinion</wea:item>
				<%}else{%>
				<wea:item type="thead">审批节点</wea:item>
				<wea:item type="thead">审批人</wea:item>
				<wea:item type="thead">岗位</wea:item>
			    <wea:item type="thead">操作类型</wea:item>
				<wea:item type="thead">时间</wea:item>
				<wea:item type="thead">签字意见</wea:item>
				<%}%>
				
		
	<%
		String nodename="";
		String lastname="";
		String jobtitlename="";
		String time="";
		String logtype="";
		String remark="";
		String sql_remark="select d.nodename,  a.operator,b.lastname,c.jobtitlename,a.operatedate||' '||a.operatetime as time, a.logtype, remark "+
      					"from workflow_requestlog a,hrmresource b,hrmjobtitles c,workflow_nodebase d where a.operator=b.id and b.jobtitle=c.id "+
                        " and a.nodeid=d.id and a.requestid in("+requestids+")  and a.logtype not in ('e') "+
     					"  order by a.operatedate asc ,a.operatetime asc";
		rs.executeSql(sql_remark);
		while(rs.next()){
			nodename = Util.null2String(rs.getString("nodename"));
			lastname = Util.null2String(rs.getString("lastname"));
			jobtitlename = Util.null2String(rs.getString("jobtitlename"));
			time = Util.null2String(rs.getString("time"));
			logtype = Util.null2String(rs.getString("logtype"));
			logtype = getState(logtype,saplan);
			remark = removeHtmlTag(Util.null2String(rs.getString("remark")));

		

	%>
			   <wea:item><%=nodename%></wea:item>			
			   <wea:item><%=lastname%></wea:item>
			   <wea:item><%=jobtitlename%></wea:item>			    
			   <wea:item><%=logtype%></wea:item>
			   <wea:item><%=time%></wea:item>
			   <wea:item><%=remark%></wea:item>	
		<%}%>		
				
				 
	  
		   </wea:group>
			</wea:layout>
	


	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}

	</script>
</BODY>
</HTML>