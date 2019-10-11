<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="gvo.cowork.AddContactInfo" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
	int userid = user.getUID();
	BaseBean log = new BaseBean();
	FileUpload fu = new FileUpload(request);
    String info = Util.null2String(fu.getParameter("info")).replaceAll("\n","<br>").replaceAll("\r\n","<br>").replaceAll(" ","&nbsp;");//提交类型
	String attach = Util.null2String(fu.getParameter("attach"));
	AddContactInfo aci = new AddContactInfo();
	aci.addInfo(attach,userid+"",info);
%>
<script type="text/javascript">
 alert("提交成功");
 window.close();
</script>