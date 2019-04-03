<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.conn.RecordSet" %>
<%
		String requestid = Util.null2String(request.getParameter("requestid"));
		RecordSet rs = new RecordSet();
		String sql = "";
		String tableName = "";
		String  txr = "";//填写人
		String sqrygbm = "";// 创建员工编码
		String sqrq = "";// 申请日期
		String ccmd = "";// 出差目的
		String cclx = "L_009";//出差类型
		
		
		sql = "Select tablename From Workflow_bill Where id=(Select formid From workflow_base Where id=62)";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		String mainID = "";
		if (!"".equals(tableName)) {
			String sql_1 = "select * from " + tableName + " where requestid = "+ requestid;
			new BaseBean().writeLog("sql1---------" + sql_1);
			rs.executeSql(sql_1);
			if (rs.next()) {
				txr = Util.null2String(rs.getString("txr"));//填写人
				sqrq = Util.null2String(rs.getString("sqrq"));//填写日期
				ccmd = Util.null2String(rs.getString("ccmd"));//出差目的
				mainID = Util.null2String(rs.getString("id"));
				
				ccmd = ccmd.replace("<br>", " ").replace("&nbsp;", " ");
				
				if(ccmd.length()>250) ccmd = ccmd.substring(0,250);
			}
			sqrq = sqrq.replace("-", "/");
			sql = "select * from hrmresource where id = '"+txr+"'";
			rs.executeSql(sql);
			if(rs.next()){
				sqrygbm = rs.getString("workcode");
			}
			
			String sql_2 = "select * from "+tableName+"_dt1 where mainid="+mainID;
			rs.executeSql(sql_2);
			while(rs.next()){
				String tmp_id = Util.null2String(rs.getString("id"));
				String emp_code = Util.null2String(rs.getString("gh"));
				String start_date = Util.null2String(rs.getString("sjksrq"));
				String start_time = Util.null2String(rs.getString("sjkssj"));
				String end_date = Util.null2String(rs.getString("sjjsrq"));   
				String end_time = Util.null2String(rs.getString("sjjssj"));
				String leave_time = Util.null2String(rs.getString("sjccxss"));
				
				start_date = start_date.replace("-", "/");
				end_date = end_date.replace("-", "/");
				
				String s_id = requestid + "_" + tmp_id;
				sql = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark)"
						+ " values "
						+ "("
						+ "newID()"
						+ ",'"
						+ s_id
						+ "','"
						+ emp_code
						+ "','"
						+ start_date
						+ "','"
						+ start_time 
						+ "','"
						+ end_date
						+ "','"
						+ end_time
						+"','"
						+ leave_time
						+ "','"
						+ cclx
						+ "','"
						+ sqrygbm + "','"+sqrq+"','"+ccmd+"')";
				out.println("sql = " + sql +"<br>");
			}
		} 
%>