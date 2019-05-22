<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.hrm.User" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ taglib uri="/browserTag" prefix="brow" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<HTML>
<HEAD>
    <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
    <script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
    <script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            var idkey = _C.uP('idkey')
            // alert("idkey="+idkey);
            if (idkey === '0') {
                Dialog.alert('打卡数据同步成功!')
            }
        })
    </script>
    <style>
        .checkbox {
            display: none
        }
    </style>
</head>
<%
    // User user = new User();
    String imagefilename = "/images/hdReport_wev8.gif";
    String titlename = SystemEnv.getHtmlLabelName(20536, user.getLanguage());
    String needfav = "1";
    String needhelp = "";

    int userid = user.getUID();//获取当前登录用户的ID
    String idkey = Util.null2String(request.getParameter("idkey"));
    String fromdate = Util.null2String(request.getParameter("fromdate"));
    Boolean isAdmin = false;
    String sql = "";
    sql = " select count(id) as num_admin from HrmRoleMembers where roleid=84 and resourceid=" + userid;
    rs.executeSql(sql);
    if (rs.next()) {
        int num_admin = rs.getInt("num_admin");
        if (num_admin > 0) {
            isAdmin = true;
        }
    }
    if (!isAdmin) {
        response.sendRedirect("/notice/noright.jsp");
        return;
    }

%>
<BODY scroll="no">
<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
				<%=SystemEnv.getHtmlLabelName(20536, user.getLanguage()) %>
			</span>
</div>
<div id="dialog">
    <div id='colShow'></div>
</div>
<%@include file="/systeminfo/TopTitle_wev8.jsp" %>
<jsp:include page="/systeminfo/commonTabHead.jsp">
    <jsp:param name="mouldID" value="voting"/>
    //指定图标id
    <jsp:param name="navName" value="考勤数据同步"/>
    //指定显示的名称
</jsp:include>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    RCMenu += "{同步,javascript:firm(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="AttendOperation.jsp" method=post>
    <div>
        <wea:layout type="4col">
            <wea:group context="选择日期">
                <wea:item>考勤日期</wea:item>
                <wea:item>
                    <button type="button" class=Calendar id="fromdatedate"
                            onclick="onshowVotingEndDate('fromdate','fromdateSpan')"></BUTTON>
                    <SPAN id=fromdateSpan><%=fromdate%></SPAN>
                    <INPUT class=inputstyle id="searchInput" type="hidden" name="fromdate" value="<%=fromdate%>">
                </wea:item>
            </wea:group>
        </wea:layout>
    </div>
    <div id="_xTable" style="background:#FFFFFF;padding:0px;width:100%" valign="top">
    </div>
</FORM>
<script type="text/javascript">
    function firm () {
        var syncDate = jQuery('#searchInput').val()
        if (syncDate !== '') {
            Dialog.confirm('确定同步所选日期的考勤数据', function () {
                // check_form(report, fromdatedate)
                report.action = 'AttendOperation.jsp'
                report.submit()
                var content = '正在同步数据，请稍候....'
                showPrompt(content)
            }, function () {}, 320, 90, false)
        } else {
            Dialog.alert('请先选择日期!')
        }
    }

</script>
<script language="javascript" src="/js/ecology8/selectbox/js/jquery.selectbox-0.2_wev8.js"></script>
<script language="javascript" src="/js/browser/WorkFlowBrowser_wev8.js"></script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
<script type="text/javascript" src="/workflow/request/js/requesthtml_wev8.js"></script>
</BODY>
</HTML>
