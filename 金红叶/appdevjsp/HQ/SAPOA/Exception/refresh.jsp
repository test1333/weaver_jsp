<%@page import="weaver.general.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.general.BaseBean"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
        String upd_flag=Util.null2String(request.getParameter("upd_flag"));
		   String lc_no=Util.null2String(request.getParameter("lc_no"));
		   String sql1="update zoat00020 set upd_flag='"+upd_flag+"' where lc_no= '"+lc_no+"'";
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


