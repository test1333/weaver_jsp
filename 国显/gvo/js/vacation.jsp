<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSetDataSource" %>
<%@ page import="weaver.general.BaseBean" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<%

	  StringBuffer dataBuff = new StringBuffer();
	  //weaver.conn.RecordSetDataSource rsds = new weaver.conn.RecordSetDataSource("local_HR");
      String reqid = request.getParameter("reqid");//requestId
      if(reqid.length()>0){
      	String sql = " SELECT sjksrq,sjkssj,sjjsrq,sjjssj,sjccxss,cccs,cccslx,jtgj,zsbz,hsbz FROM formtable_main_440_dt1 where mainid=(select id from formtable_main_440 where requestid="+reqid+") ";
      	//out.print("sql ="+sql);
	  	rs.executeSql(sql);
	 	while(rs.next()) {
   			String startDate = Util.null2String(rs.getString("sjksrq"));
			dataBuff.append(startDate);
			dataBuff.append("###");

			String startTime = Util.null2String(rs.getString("sjkssj"));
			dataBuff.append(startTime);
			dataBuff.append("###");

			String enddate = Util.null2String(rs.getString("sjjsrq"));
			dataBuff.append(enddate);
			dataBuff.append("###");

			String endTime = Util.null2String(rs.getString("sjjssj"));
			dataBuff.append(endTime);
			dataBuff.append("###");

			String vacationTimes = Util.null2String(rs.getString("sjccxss"));
			dataBuff.append(vacationTimes);
			dataBuff.append("###");

			String city = Util.null2String(rs.getString("ccs3"));
			dataBuff.append(city);
			dataBuff.append("###");

			String cityType = Util.null2String(rs.getString("cccslx"));
			dataBuff.append(cityType);
			dataBuff.append("###");

			String transTools = Util.null2String(rs.getString("jtgj"));
			dataBuff.append(transTools);
			dataBuff.append("###");
			String sql_tool = "select jtgj from formtable_main_116 where id="+transTools;
			res.executeSql(sql_tool);
			//log.writeLog("sql_1="+sql_1);
			if(res.next()){
				String tools_name = Util.null2String(res.getString("jtgj"));
				dataBuff.append(tools_name);
			}
			dataBuff.append("###");

			String hotelStandard = Util.null2String(rs.getString("zsbz"));
			dataBuff.append(hotelStandard);
			dataBuff.append("###");

			String foodStandard = Util.null2String(rs.getString("hsbz"));
			dataBuff.append(foodStandard);
			dataBuff.append("@@@");
			}
		}
		out.print(dataBuff.toString());
%>