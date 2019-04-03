<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSetDataSource" %>
<%@ page import="weaver.general.BaseBean" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>
<%

	  StringBuffer dataBuff = new StringBuffer();
      String reqid = request.getParameter("reqid");//请求ID
	  String mainid = "";
	
      //out.print("abnormalDate ="+abnormalDate);

      if(reqid.length()>0){
      	String sql = " select  id from uf_orders where lastversion=1  and requestid= "+reqid;
      	//log.writeLog("sql_1="+sql);
	  	rs.executeSql(sql);
		if(rs.next()) {
			mainid = Util.null2String(rs.getString("id"));
			
		}
		sql = " select id,pm,shl from uf_orders_dt1 where mainid="+mainid;
			res.executeSql(sql);
			//log.writeLog("sql_2"+sql);
			while(res.next()){
				int num_order = 0;
				String pm = Util.null2String(res.getString("pm"));
				double shl = res.getDouble("shl");
				String dtid = Util.null2String(res.getString("id"));
				String sql1 = " select isnull(sum(rkshpshl),0) as num_order from formtable_main_36_dt1 where mainid in "
				+" (select id from formtable_main_36 where cgddnew="+reqid+") and pm="+pm+" ";
				RecordSet.executeSql(sql1);
				//log.writeLog("sql_2="+sql1);
				if(RecordSet.next()){
					num_order = RecordSet.getInt("num_order");
				}
				if(shl>num_order){
					dataBuff.append(dtid);
					dataBuff.append("###");
					dataBuff.append(num_order);
					dataBuff.append("@@@");
				}
			}
		out.print(dataBuff.toString());
   }
%>