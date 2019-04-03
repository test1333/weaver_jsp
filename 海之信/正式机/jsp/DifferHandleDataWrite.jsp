<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
String idkey = request.getParameter("idkey");//id值
String operate = request.getParameter("operate");//操作
String operate_val = "";
String operatenum = request.getParameter("operatenum");//操作数量
String explanation = request.getParameter("explanation");//差异说明

String goodscate = "";
String goodsname = "";
String goodsno = "";
String original = "";
String goodscate_name = "";
String goods_name = "";
String mainid = "";
String sql = "select * from uf_checkrecord_dt1 where id = "+idkey+"";
rs.executeSql(sql);
    if(rs.next()){
        mainid = Util.null2String(rs.getString("mainid"));
        goodscate = Util.null2String(rs.getString("goodscate"));
        goodsname = Util.null2String(rs.getString("goodsname"));
        goodsno = Util.null2String(rs.getString("goodsno"));
        original = Util.null2String(rs.getString("original"));
        }
    String sql_1 = "select catename from uf_goodscate where id = replace('"+goodscate+"','57_','')";
	rs.executeSql(sql_1);
	if(rs.next()){
	       goodscate_name = Util.null2String(rs.getString("catename"));
	   }
	String sql_2 = "select goodsname from uf_goodsinfo where id = "+goodsname+"";
	rs.executeSql(sql_2);
	if(rs.next()){
	       goods_name = Util.null2String(rs.getString("goodsname"));
	   }

//插入差异处理记录表
String sql_insert = "insert into uf_differhandle (differid,goodscate,assets,goodsno,operate,operatenum,explanation,checkid)"+
                    " values("+idkey+",'"+goodscate_name+"','"+goods_name+"','"+goodsno+"','"+operate+"',"+operatenum+","+
                    "'"+explanation+"',"+mainid+")";

rs.executeSql(sql_insert);

//更新差异值
String operatex = "";
int operatenumx = 0;
int total = 0;
String sql_update = "Select * from uf_differhandle where differid = "+idkey+"";
rs.executeSql(sql_update);
while(rs.next()){
        operatex = Util.null2String(rs.getString("operate"));
        operatenumx = rs.getInt("operatenum");

        if(operatex.equals("1")||operatex.equals("3")||operatex.equals("5")){

        total=total+operatenumx;

    }else{

        total=total-operatenumx;
}
	
}
String sql_diff = "update uf_checkrecord_dt1 set stock = original+"+total+" where id = "+idkey+"";
rs.executeSql(sql_diff);

 
//response.sendRedirect("/seahonor/jsp/DifferenceHandleForBonus.jsp?idkey="+idkey+"");

%>
<script type="text/javascript">
    var parentWin;
    try{
        parentWin = parent.getParentWindow(window);
        parentWin.closeDlgARfsh();
    }catch(e){
        window.close();
    }
</script>


