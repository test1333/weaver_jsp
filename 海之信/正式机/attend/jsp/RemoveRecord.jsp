<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />

<%
    String sql = "";
    int userid = user.getUID();
    String ids = Util.null2String(request.getParameter("id"));
    //out.print("ids="+ids+"0");
    if(!"".equals(ids)){
    	String tmp_ids[] = ids.split(",");
        for(int i=0;i<tmp_ids.length;i++){
            String tmpid = tmp_ids[i].toString();
            //out.print("tmpid="+tmpid);
            sql = " select count(id) as num_cc from uf_Invalid_out where InvalidID = "+tmpid+" ";
            rs.executeSql(sql);
            out.print("sql="+sql); 
            if(rs.next()){
                int num_cc = rs.getInt("num_cc");
                if(num_cc==0){
                    sql = " insert into uf_Invalid_out(InvalidID,operator,operateTime,isActive) "
                    +" values("+tmpid+","+userid+",CONVERT(varchar(100),GETDATE(),20),0) ";
                    res.executeSql(sql); 
                    out.print("sql="+sql);    
                }else{
                    sql = " update  uf_Invalid_out set operateTime = CONVERT(varchar(100),GETDATE(),20),isActive=0 where InvalidID= "+tmpid;
                    res.executeSql(sql);
                    out.print("sql="+sql); 
                }
            }  
        }
    }
    response.sendRedirect("/seahonor/attend/jsp/SH_Mobile_Info_1.jsp");
%>


