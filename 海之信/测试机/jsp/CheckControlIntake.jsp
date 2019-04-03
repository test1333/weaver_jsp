<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page"/>
<%

String goodsname = request.getParameter("goodsname");//商品类别ID

String isCheck = "0";

int checkrange = 0;
int count_check = 0;
int idx =0;
if(goodsname.length()>0){	
	
	String sql = " select * from  uf_checkrecord  where status = 0 ";
	rs.executeSql(sql);
	while(rs.next()){
		checkrange = rs.getInt("checkrange");
		idx = rs.getInt("id");
	
	if(checkrange==0){
		isCheck = "1";
	}else if(checkrange==1){
		String sql_cate = " select count(id) as count_check from uf_goodsinforecord where id = "+goodsname+" "+
						"	and charindex(','+isnull(goodscate,0)+',',','+(select checkcate from uf_checkrecord where id = "+idx+")+',0,')>0 "+
						"	and charindex(','+isnull(layplace,0)+',',','+(select checkstock from uf_checkrecord where id = "+idx+")+',0,')>0 ";
		rs_dt.executeSql(sql_cate);
		if(rs_dt.next()){
			count_check = rs_dt.getInt("count_check");
		}
		if(count_check>0) {isCheck = "1";}
	}else if(checkrange==2){
		String sql_stock = " select count(id) as count_check from uf_goodsinforecord where id = "+goodsname+" "+
						"	and charindex(','+isnull(layplace,0)+',',','+(select checkstock from uf_checkrecord where id = "+idx+")+',0,')>0 ";
		rs_dt.executeSql(sql_stock);
		if(rs_dt.next()){
			count_check = rs_dt.getInt("count_check");
		}
		if(count_check>0) {isCheck = "1";}
	}else if(checkrange==3){
		String sql_customer = " select count(id) as count_check from uf_goodsinforecord where id = "+goodsname+" "+
						"	and charindex(','+isnull(customer,0)+',',','+(select customer from uf_checkrecord where id = "+idx+")+',0,')>0 "+
						"	and charindex(','+isnull(layplace,0)+',',','+(select checkstock from uf_checkrecord where id = "+idx+")+',0,')>0 ";
		rs_dt.executeSql(sql_customer);
		if(rs_dt.next()){
			count_check = rs_dt.getInt("count_check");
		}
		if(count_check>0) {isCheck = "1";}
	}else if(checkrange==4){
		String sql_all = " select count(id) as count_check from uf_goodsinforecord where id = "+goodsname+" "+
						"	and charindex(','+isnull(goodscate,0)+',',','+(select checkcate from uf_checkrecord where id = "+idx+")+',0,')>0 "+
						"	and charindex(','+isnull(customer,0)+',',','+(select customer from uf_checkrecord where id = "+idx+")+',0,')>0 "+
						"	and charindex(','+isnull(layplace,0)+',',','+(select checkstock from uf_checkrecord where id = "+idx+")+',0,')>0 ";
		rs_dt.executeSql(sql_all);
		if(rs_dt.next()){
			count_check = rs_dt.getInt("count_check");
		}
		if(count_check>0) {isCheck = "1";}
	}
 }
 	out.print(isCheck);
}
%>

