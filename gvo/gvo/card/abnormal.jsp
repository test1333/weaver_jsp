<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSetDataSource" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

	  StringBuffer dataBuff = new StringBuffer();
	  weaver.conn.RecordSetDataSource rsds = new weaver.conn.RecordSetDataSource("local_HR");
      String abnormalDate = request.getParameter("abnormalDate");//异常日期
	  String emp_code = request.getParameter("emp_code");//异常日期
      String key_id = "";//key_id
	  //String emp_code = "";//工号
	  String chn_name = "";//姓名
	  String att_datetime = "";//日期时间
	  String inorout = "";//标志位
	  String inorout_1 = "";//标志位解释
      //out.print("abnormalDate ="+abnormalDate);
	  //v_ats_originality_data
      if(abnormalDate.length()>0&&emp_code.length()>0){
      String sql = " select key_id,emp_code,chn_name,att_datetime,machineid,case when inorout='0000' then '上班卡' when inorout='0001' then '下班卡' else '无标识' end as inorout_1,inorout  from v_ats_originality_data where convert(varchar(20),att_datetime,23) = '"+abnormalDate+"' "
	  			+" and emp_code='"+emp_code+"' ";
      //out.print("sql ="+sql);
	  rsds.executeSql(sql);
		while(rsds.next()) {
   			key_id = Util.null2String(rsds.getString("key_id"));
   			dataBuff.append(key_id);
			dataBuff.append("###");
			chn_name = Util.null2String(rsds.getString("chn_name"));
			dataBuff.append(chn_name);
			dataBuff.append("###");
			att_datetime = Util.null2String(rsds.getString("att_datetime"));
			dataBuff.append(att_datetime);
			dataBuff.append("###");
			inorout_1 = Util.null2String(rsds.getString("inorout_1"));
			dataBuff.append(inorout_1);
			dataBuff.append("###");
			inorout = Util.null2String(rsds.getString("inorout"));
			dataBuff.append(inorout);
			//dataBuff.append("###");
			dataBuff.append("@@@");
		}
		out.print(dataBuff.toString());
   }
%>