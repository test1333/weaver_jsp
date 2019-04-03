<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String differid_detail = request.getParameter("differid_detail");
String idkey = request.getParameter("idkey");
String idx = differid_detail+"-1";
String sql = "delete from uf_differhandle where id in ("+idx+")";
rs.executeSql(sql);

//¸üÐÂ²îÒìÖµ
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

//response.sendRedirect("/seahonor/jsp/DifferenceHandleEdit.jsp?idkey="+idkey+"");

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
