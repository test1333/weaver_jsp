<%@page import="weaver.general.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.general.BaseBean"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
        String sjwc1=Util.null2String(request.getParameter("sjwc"));
		   String wcbl1=Util.null2String(request.getParameter("wcbl"));
		   String alarmid=Util.null2String(request.getParameter("alarmid"));
		    String action=Util.null2String(request.getParameter("action"));
		   String sql1="update uf_action_plan set sjwc='"+sjwc1+"',wcbl='"+wcbl1+"' where id= '"+action+"'";
		rs.execute(sql1);
%>
<script type="text/javascript">
	
	
  var parentWin;
	try{
		parentWin = parent.getParentWindow(window);
		parentWin.closeDlgARfsh();
	}catch(e){
		window.close();
	}
</script>


