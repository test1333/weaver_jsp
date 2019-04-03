<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="weaver.common.util.taglib.ShowColUtil"%>
<%
out.clear();
User user = HrmUserVarify.getUser(request,response);
/*if(!HrmUserVarify.checkUserRight("ModeSetting:All", user)){
	response.sendRedirect("/notice/noright.jsp");
 	return;
}*/
RecordSet rs =  new RecordSet();
String action = Util.null2String(request.getParameter("action"));
if("cleanColWidth".equalsIgnoreCase(action)){
	String customid = Util.null2String(request.getParameter("customid"));
	if(!"".equals(customid)){
		String pageId = "mode_customsearch:" + customid;
		String sql = "delete from user_default_col where pageid = '"+pageId+"'";
		rs.execute(sql);
		ShowColUtil.removeDefaultColsMap(pageId);
	}
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("status", "1");
	out.print(jsonObject.toString());
	return;
}else if("cleanColWidthByUser".equalsIgnoreCase(action)){
	String customid = Util.null2String(request.getParameter("customid"));
	if(!"".equals(customid)){
		String pageId = "mode_customsearch:" + customid;
		String sql = "delete from user_default_col where pageid = '"+pageId+"' and userid = "+user.getUID()+"";
		rs.execute(sql);
		ShowColUtil.removeDefaultColsMap(pageId);
	}
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("status", "1");
	out.print(jsonObject.toString());
	return;
}
%>