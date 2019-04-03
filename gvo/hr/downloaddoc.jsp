<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String imagefileid =Util.null2String(request.getParameter("fileid")); 
String doccreaterid = "1";
String sql="select b.doccreaterid from docimagefile a,docdetail b where a.docid=b.id and imagefileid='"+imagefileid+"'";
rs.execute(sql);
if(rs.next()){
	doccreaterid = Util.null2String(rs.getString("doccreaterid"));
}
request.getSession().setAttribute("weaver_user@bean", User.getUser(Integer.valueOf(doccreaterid), 0));
request.getRequestDispatcher("/weaver/weaver.file.FileDownload?fileid="+ imagefileid + "&download=1").forward(request, response);

%>
