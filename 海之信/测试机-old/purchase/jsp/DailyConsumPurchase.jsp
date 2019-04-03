<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
	String sql = "";
	String requestId = "";//id
	//String qj_id = request.getParameter("id");//快递公司ID
	StringBuffer dataBuff = new StringBuffer();


	String  Name  = "";//商品名称id
	String goodsname = "";//商品名称
	String  Numbers = "";//商品数量
	String sum = "";//库存量
	String price = "";//平均单价
	
	String val = request.getParameter("val");

	    sql = "select f2.Name,(select goodsname from uf_goodsinfo where id = f2.Name) goodsname,f2.Numbers from uf_Purchase_dt1 f2 left join uf_Purchase f1 on f1.id=f2.mainid where f1.id="+val;
	   /* sql = "select Sender,(select lastname from HrmResource where id = Sender) as lastname,DateTime,Money,ReceiverAdd from formtable_main_102 where id in( " + val +"0 )";//( " + ids + "0 )";*/
	    rs.executeSql(sql);       
	    //out.print("sql="+sql);
	    log.writeLog("sql="+sql);   
		while(rs.next() ) {	

		Name = Util.null2String(rs.getString("Name"));
		dataBuff.append(Name);
		dataBuff.append("###");

		goodsname = Util.null2String(rs.getString("goodsname"));
		dataBuff.append(goodsname);
		dataBuff.append("###");

		sql = "select sum(num) as sum from uf_goodsinforecord where infoid ="+Name+" and isnull(status,0) = 0 ";
		rs1.executeSql(sql);
		while(rs1.next() ) {	
		   	sum = Util.null2String(rs1.getString("sum"));
		   	if ("".equals(sum)) {
			   	dataBuff.append("0");
				dataBuff.append("###");
			}else{
					dataBuff.append(sum);
					dataBuff.append("###");
				}
		 }

		Numbers = Util.null2String(rs.getString("Numbers"));
		dataBuff.append(Numbers);
		dataBuff.append("###");	

		sql = "select convert(decimal(10,2),avg(s.price)) price from (select top 3 price from uf_outinrecord where operaterecord=0 and origin=3 and goodsname in(select id from uf_goodsinforecord where infoid="+Name+") order by operatetime desc)s";	

		rs1.executeSql(sql);
		while(rs1.next() ) {	
		   	price = Util.null2String(rs1.getString("price"));

		   		if ("".equals(price)) {
				   	dataBuff.append("0");
					dataBuff.append("@@@");
				}else{
					dataBuff.append(price);
					dataBuff.append("@@@");
				}
			}
		}
		out.print(dataBuff.toString());
	//}	
%>