
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.MD5"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
 int user_id = user.getUID();
  String Remark = Util.null2String(request.getParameter("Remark"));
 String sql="select workcode ,Convert(varchar,GETDATE(),120) now from hrmresource where id="+user_id;
 String workcode="";
 String nowtime="";
 rs.executeSql(sql);
 if(rs.next()){
    workcode=Util.null2String(rs.getString("workcode"));
    nowtime=Util.null2String(rs.getString("now"));
 }
 String ConvertString="mubeatestCN"+Remark;
 MD5 md5 = new MD5();

 String Md5Info= md5.getMD5ofStr(ConvertString);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
    <body>
        <form name="LoginSubmit" action="https://www.cwt-online.com.cn/TicketClient/User/SSOLogin.aspx" method="POST">
            <input type="hidden" name='UName' value="mubeatest" />
            <input type="hidden" name='Language' value="CN" />
            <input type="hidden" name='Remark' value="<%=Remark%>" />
            <input type="hidden" name='CompanyId' value="" />
            <input type="hidden" name='PageId' value="" />
           <!-- <input type="hidden" name= 'Timestamp' value="2017-08-01 13:21:12" />-->
            <input type="hidden" name='Md5Info' value="<%=Md5Info%>" />
        </form>
        <script langu="JavaScript" type="text/javascript">
            LoginSubmit.submit();
        </script>
    </body>
</html>
	

