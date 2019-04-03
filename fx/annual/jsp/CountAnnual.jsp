<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />

<%
    String ids = Util.null2String(request.getParameter("id"));
    String sql = "";
    String idkey="";
    String tmp_ids=ids+"0";
    out.print("tmp_ids="+tmp_ids);
    if(!"".equals(ids)){
        sql = " select * from hrmresource where id in("+tmp_ids+") ";
        rs.executeSql(sql);
        while(rs.next()){
            String emp_id=Util.null2String(rs.getString("id"));
            String startdate=Util.null2String(rs.getString("startdate"));
            sql=" select count(id) as num_cc from HrmAnnualManagement where resourceid= "+emp_id+" ";
            res.executeSql(sql);
            if(res.next()){
                int num_cc=res.getInt("num_cc");
                
                if(num_cc>0){
                    sql=" update HrmAnnualManagement set annualdays=dbo.fx_first_annual_days('"+startdate+"',5) "
                    +" where resourceid="+emp_id+" and annualyear=CONVERT(varchar(4), GETDATE(), 23) "; 
                    res.executeSql(sql);
                    String sql_up=" update formtable_main_59 set annual_days=dbo.fx_first_annual_days('"+startdate+"',5), "
                    +" status=0 where emp_id="+emp_id+" ";
                    res.executeSql(sql_up);  
                }else{
                    sql=" insert into HrmAnnualManagement(resourceid,annualdays,annualyear,status) "
                    +" values("+emp_id+",dbo.fx_first_annual_days('"+startdate+"',5),CONVERT(varchar(4), GETDATE(), 23),'1') ";  
                    res.executeSql(sql);
                    
                    String sql_up=" update formtable_main_59 set annual_days=dbo.fx_first_annual_days('"+startdate+"',5), "
                    +" status=0 where emp_id="+emp_id+" ";
                    res.executeSql(sql_up);    
                }
            }
            
        }
        //log.writeLog("sql1="+sql);
        idkey="0";
        out.print("sql="+sql);
		
    }else{
        idkey="1";
        //return;
    }
   
    response.sendRedirect("/fx/annual/jsp/AnnualUndo.jsp?idkey="+idkey+" ");
%>


