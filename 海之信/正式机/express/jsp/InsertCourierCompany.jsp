<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
	String sql = "";
	String requestId = "";//id
	//String qj_id = request.getParameter("id");//快递公司ID
	StringBuffer dataBuff = new StringBuffer();


	String  Sender  = "";//寄件人
	String lastname = "";//寄件人名字
	String  DateTime = "";//寄件日期
	String Money = "";//快递费用
	String  ActualFee  = "";//实际费用
	String  ReceiverAdd = "";//收件地址
	String kdcode = "";
	String state1 ="0";
	String val_detail="";
	
	
	String val = request.getParameter("val");

	    /*sql = "select f1.requestId,f2.Money,f2.ActualFee,f2.ReceiverAdd from formtable_main_41_dt1 f2 left join  formtable_main_41 f1 on f1.id = f2.mainid where f2.mainid = (select id from formtable_main_41 where requestId = " +qj_id+ ")";*/
	    sql = "select f.Sender,(select lastname from HrmResource where id = f.Sender) as lastname,f.DateTime,fd.Money,fd.ReceiverAdd,fd.kdcode,fd.id as val_detail from formtable_main_76 f,formtable_main_76_dt1 fd where f.id=fd.mainid and fd.id in( " + val +"0 )  order by f.DateTime asc ";//( " + ids + "0 )";
	    rs.executeSql(sql);       
	    //out.print("sql="+sql);
	    log.writeLog("sql="+sql);   
		while( rs.next() ) {	

		Sender = Util.null2String(rs.getString("Sender"));
		dataBuff.append(Sender);
		dataBuff.append("###");

		lastname = Util.null2String(rs.getString("lastname"));
		dataBuff.append(lastname);
		dataBuff.append("###");

		DateTime = Util.null2String(rs.getString("DateTime"));
		dataBuff.append(DateTime);
		dataBuff.append("###");

		Money = Util.null2String(rs.getString("Money"));
		dataBuff.append(Money);
		dataBuff.append("###");
	
		ActualFee = Util.null2String(rs.getString("Money"));
   		dataBuff.append(ActualFee);
		dataBuff.append("###");
		
		kdcode = Util.null2String(rs.getString("kdcode"));
		kdcode = kdcode.replaceAll("&nbsp;", " ");
   		dataBuff.append(kdcode);
		dataBuff.append("###");
		

		ReceiverAdd = Util.null2String(rs.getString("ReceiverAdd"));
		/*	if(haspurchasenum.equals("")){
				haspurchasenum = "0";
			}*/
	   		dataBuff.append(ReceiverAdd);
	   		dataBuff.append("###");
	   		
	   		val_detail =  Util.null2String(rs.getString("val_detail"));
	   		dataBuff.append(val_detail);
	   		dataBuff.append("###");
	              dataBuff.append(state1);
			dataBuff.append("@@@");

			
		}
		out.print(dataBuff.toString());
	//}	
%>