
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
</head>
<body scroll="no">
	<table  class=viewform width=100% id=oTable1 height=100% >
		<tr>
			<td  height=100% id="oTd1" name="oTd1" width="220px" style="background-color:#F8F8F8;padding-left:0px;display:none"> 
				<iframe src="" name=leftframe id=leftframe  width="100%" height="100%" frameborder=no scrolling=no >
				浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。
				</iframe>
			</td>
			<td height=100% id=oTd2 name=oTd2 width="*" id="tdcontent" style="padding-left:0px;">
				<iframe src="/seahonor/attend/agent/wfAgentAll.jsp?agentFlag=0&agented=0" name=contentframe id=contentframe width="100%" height="100%" frameborder=no scrolling=no >
				浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。
				</iframe>
			</td>
		</tr>
	</table>
</body>
</html>

