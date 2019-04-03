<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String checkid = request.getParameter("checkid_temp");//商品类别ID

if(checkid.length()>0){
String isCheck = "0";
   		String diffnum = "";
        String total = "";
        String sqlx = "  select count(*) as diffnum from (select a.id as cate,b.id as idkey,a.catename "+
    	        "    , c.goodsname,b.goodscate,b.goodsname as goodsnamex,"+
    	        "    b.goodsno,b.originalx, b.original,b.actual,b.stock,b.difference,b.remark,b.explanation,b.assets, "+
    	        "    b.actual-b.original as differencex,b.actual-b.stock as difference_x,b.difference_temp from uf_goodscate a "+
    	        "    join (select * from uf_checkrecord_dt1 where mainid = "+checkid+" and mark is null) b "+
    	        "    on cast(a.id as varchar(max)) =replace(cast(b.goodscate as varchar(max)),'57_','') "+
    	        "    join uf_goodsinforecord c on b.assets = c.id where b.actual-b.stock != 0 ) s ";
        rs.executeSql(sqlx);
        if(rs.next()){
           diffnum = Util.null2String(rs.getString("diffnum"));
        }

        String sql_wfend = " select COUNT(requestid) as total from workflow_requestbase where currentnodetype != 3 and requestid in( "+
                           " select requestid from uf_HandleDataToWF where checkid = "+checkid+" ) ";
         rs.executeSql(sql_wfend);
        if(rs.next()){
           total = Util.null2String(rs.getString("total"));
        }

        if(diffnum.equals("0")&&total.equals("0")){
          isCheck = "1";
        }
out.print(isCheck);
}
%>

