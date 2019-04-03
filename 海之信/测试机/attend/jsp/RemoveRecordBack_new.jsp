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
			sql = " update  uf_m_sign_status set status =0 where s_id= "+tmpid;
            rs.executeSql(sql);
			
            sql = " insert into uf_Invalid_out(InvalidID,operator,operateTime,isActive) "
                    +" values("+tmpid+","+userid+",CONVERT(varchar(100),GETDATE(),20),1) ";
            rs.executeSql(sql);
            //out.print("sql="+sql);   
        }
    }
    response.sendRedirect("/seahonor/attend/jsp/SH_Mobile_Info_Removed_1.jsp");
%>


