<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<%
		StringBuffer buff = new StringBuffer();
      String purchaselist = request.getParameter("id");
      String assetsNameID = "";
      String assetsName = "";
      String purchaseNum = "";
      String price = "";

      if(purchaselist.length()>0){
      String sql = " select f1.requestid,f2.Name,f2.Numbers,f2.Price from formtable_main_45_dt1 f2 left join formtable_main_45 f1 "
                   +" on f1.id = f2.mainid where f2.mainid = (select id from formtable_main_45 where requestId = " +purchaselist+ ") ";
      rs.executeSql(sql);
		while(rs.next()) {
   			assetsNameID = Util.null2String(rs.getString("Name"));
            String sql_x = "select goodsname from uf_goodsinfo where id = "+assetsNameID+" ";
            rs1.executeSql(sql_x);
            if(rs1.next()){
            assetsName = Util.null2String(rs1.getString("goodsname"));
         }
            buff.append(assetsNameID);buff.append("###");
            buff.append(assetsName);buff.append("###");
            price = Util.null2String(rs.getString("Price"));
            buff.append(price);buff.append("###");
            purchaseNum = Util.null2String(rs.getString("Numbers"));
            buff.append(purchaseNum);buff.append("@@@");
		}
		out.print(buff.toString());
   }

%>
