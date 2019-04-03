<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuInfoHandler" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuInfo" %>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />

<%

%>

<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/js/ecology8/request/requestView_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/wf_search_requestView_wev8.js"></script>
</head>
<body>
<%@ include file="/systeminfo/leftMenuCommon.jsp" %>
	<table cellspacing="0" cellpadding="0" class="flowsTable">
		<tr>
			<td>
				<iframe id="myFrameL" name="myFrameL"  src="/appdevjsp/HQ/CRI/WeekReportSearchLeft.jsp" class="flowFrame" frameborder="0" ></iframe>
			</td>
			<td style="width:430px;">
				<iframe id="myFrameR" name="myFrameR"  src="/appdevjsp/HQ/CRI/WeekReportSearchRight.jsp" class="flowFrame" frameborder="0" ></iframe>
			</td>
		</tr>
	</table>
</body>
</html>