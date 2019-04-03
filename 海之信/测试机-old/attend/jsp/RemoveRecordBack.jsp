<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />

<%
    String sql = "";
    int userid = user.getUID();
    String ids = Util.null2String(request.getParameter("id"));
    out.print("ids="+ids+"0");
    if(!"".equals(ids)){
    	String tmp_ids[] = ids.split(",");
        for(int i=0;i<tmp_ids.length;i++){
            String tmpid = tmp_ids[i].toString();
            //out.print("tmpid="+tmpid);
            sql = " update uf_Invalid_out set operateTime = CONVERT(varchar(100),GETDATE(),20),isActive=1 where InvalidID= "+tmpid;
            rs.executeSql(sql);
            //out.print("sql="+sql);   
        }
    }
    response.sendRedirect("/seahonor/attend/jsp/SH_Mobile_Info_Removed.jsp");
%>


