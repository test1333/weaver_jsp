<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
		String emp_id= Util.null2String(request.getParameter("emp_id"));
		String start_day = Util.null2String(request.getParameter("start_day"));;
		String start_time = Util.null2String(request.getParameter("start_time"));;
		String end_day = Util.null2String(request.getParameter("end_day"));;
		String end_time = Util.null2String(request.getParameter("end_time"));;
		
		out.println(emp_id + ","+start_day+ "," + start_time +","+end_day +","+end_time+"<br>");
		
		String sql = " select * from FORMTABLE_MAIN_10 where CFLB=0 ";
		StringBuffer buffer_1 = new StringBuffer();
		StringBuffer buffer_2 = new StringBuffer();
		StringBuffer buffer_3 = new StringBuffer();
		rs.executeSql(sql);
		int sum_cc = 0;
		int flag  = 0;
		
	//	System.out.println("***************************************");
		
		buffer_1.append(" select sum(x.COUNT_CC) as sum_cc from (");
		buffer_2.append(" select sum(x.COUNT_CC) as sum_cc from (");
		buffer_3.append(" select sum(x.COUNT_CC) as sum_cc from (");
		
		while(rs.next()){
			
			if(flag++ !=0){
				buffer_1.append(" union all ");
				buffer_2.append(" union all ");
				buffer_3.append(" union all ");
			}
			
			String tmp_table_name = Util.null2String(rs.getString("lcb"));
			String tmp_emp_id_field = Util.null2String(rs.getString("ryzd"));
			
			String tmp_add_sql = "";
			// 解决排除哺乳假 判断的
			String tmp_whatWhere = Util.null2String(rs.getString("whatWhere"));
			if(!"".equals(tmp_whatWhere)){
				tmp_whatWhere = tmp_whatWhere.replaceAll("#", "'");
				tmp_add_sql = tmp_add_sql + " and " + tmp_whatWhere;
			}
			// 解决未提交流程不判断
			String tmp_TableInfo = Util.null2String(rs.getString("TableInfo"));
			
//			out.println(tmp_table_name);out.println("##");out.println(tmp_TableInfo);out.println("<br>");
			
			if("1".equals(tmp_TableInfo)){
				tmp_add_sql = tmp_add_sql + " and mainid in(select id from "+ tmp_table_name.substring(0,tmp_table_name.lastIndexOf("_"))
					+" where requestid in(select requestid from workflow_requestbase where currentnodetype>0)) ";
			}else{
				tmp_add_sql =  tmp_add_sql + " and requestid in(select requestid from workflow_requestbase where currentnodetype>0) ";
			}
			
			String tmp_start_day_field_1 = Util.null2String(rs.getString("sqksrqzd"));
			String tmp_start_time_field_1 = Util.null2String(rs.getString("sqkssjzd"));
			String tmp_end_day_field_1 = Util.null2String(rs.getString("sqjsrqzd"));
			String tmp_end_time_field_1 = Util.null2String(rs.getString("sqjssjzd"));
			
			String tmp_start_day_field = Util.null2String(rs.getString("sjksrqzd"));
			String tmp_start_time_field = Util.null2String(rs.getString("sjkssjzd"));
			String tmp_end_day_field = Util.null2String(rs.getString("sjjsrqzd"));
			String tmp_end_time_field = Util.null2String(rs.getString("sjjssjzd"));
			
			//  实际的日期和时间存在时，就调实际日期+时间
			
			buffer_1.append(" select count(*) as count_cc from ");buffer_1.append(tmp_table_name);
			buffer_1.append(" where ");buffer_1.append(tmp_emp_id_field);buffer_1.append(" = ");buffer_1.append(emp_id);
			buffer_1.append(" and trim(");			
			buffer_1.append(tmp_start_day_field_1);buffer_1.append(")||' '||trim(");buffer_1.append(tmp_start_time_field_1);
			buffer_1.append(")<'");buffer_1.append(start_day);buffer_1.append(" ");buffer_1.append(start_time);buffer_1.append("'");
			buffer_1.append(" and trim(");			
			buffer_1.append(tmp_end_day_field_1);buffer_1.append(")||' '||trim(");buffer_1.append(tmp_end_time_field_1);
			buffer_1.append(")>'");buffer_1.append(start_day);buffer_1.append(" ");buffer_1.append(start_time);buffer_1.append("'");
			buffer_1.append(" and trim(");buffer_1.append(tmp_start_day_field);buffer_1.append(") is null ");buffer_1.append(tmp_add_sql);
			
			buffer_1.append(" union all ");
			
			buffer_1.append(" select count(*) as count_cc from ");buffer_1.append(tmp_table_name);
			buffer_1.append(" where ");buffer_1.append(tmp_emp_id_field);buffer_1.append(" = ");buffer_1.append(emp_id);
			buffer_1.append(" and trim(");			
			buffer_1.append(tmp_start_day_field);buffer_1.append(")||' '||trim(");buffer_1.append(tmp_start_time_field);
			buffer_1.append(")<'");buffer_1.append(start_day);buffer_1.append(" ");buffer_1.append(start_time);buffer_1.append("'");
			buffer_1.append(" and trim(");			
			buffer_1.append(tmp_end_day_field);buffer_1.append(")||' '||trim(");buffer_1.append(tmp_end_time_field);
			buffer_1.append(")>'");buffer_1.append(start_day);buffer_1.append(" ");buffer_1.append(start_time);buffer_1.append("'");
			buffer_1.append(" and trim(");buffer_1.append(tmp_start_day_field);buffer_1.append(")  is not null ");buffer_1.append(tmp_add_sql);
			
			// -------------------------------------------------------------------------
		
			buffer_2.append(" select count(*) as count_cc from ");buffer_2.append(tmp_table_name);
			buffer_2.append(" where ");buffer_2.append(tmp_emp_id_field);buffer_2.append(" = ");buffer_2.append(emp_id);
			buffer_2.append(" and trim(");			
			buffer_2.append(tmp_start_day_field_1);buffer_2.append(")||' '||trim(");buffer_2.append(tmp_start_time_field_1);
			buffer_2.append(")<'");buffer_2.append(end_day);buffer_2.append(" ");buffer_2.append(end_time);buffer_2.append("'");
			buffer_2.append(" and trim(");			
			buffer_2.append(tmp_end_day_field_1);buffer_2.append(")||' '||trim(");buffer_2.append(tmp_end_time_field_1);
			buffer_2.append(")>'");buffer_2.append(end_day);buffer_2.append(" ");buffer_2.append(end_time);buffer_2.append("'");
			buffer_2.append(" and trim(");buffer_2.append(tmp_start_day_field);buffer_2.append(") is null ");buffer_2.append(tmp_add_sql);
			
			buffer_2.append(" union all ");

			buffer_2.append(" select count(*) as count_cc from ");buffer_2.append(tmp_table_name);
			buffer_2.append(" where ");buffer_2.append(tmp_emp_id_field);buffer_2.append(" = ");buffer_2.append(emp_id);
			buffer_2.append(" and trim(");			
			buffer_2.append(tmp_start_day_field);buffer_2.append(")||' '||trim(");buffer_2.append(tmp_start_time_field);
			buffer_2.append(")<'");buffer_2.append(end_day);buffer_2.append(" ");buffer_2.append(end_time);buffer_2.append("'");
			buffer_2.append(" and trim(");			
			buffer_2.append(tmp_end_day_field);buffer_2.append(")||' '||trim(");buffer_2.append(tmp_end_time_field);
			buffer_2.append(")>'");buffer_2.append(end_day);buffer_2.append(" ");buffer_2.append(end_time);buffer_2.append("'");
			buffer_2.append(" and trim(");buffer_2.append(tmp_end_day_field);buffer_2.append(") is not null ");buffer_2.append(tmp_add_sql);
			
			// -------------------------------------------------------------------------
		
			buffer_3.append(" select count(*) as count_cc from ");buffer_3.append(tmp_table_name);
			buffer_3.append(" where ");buffer_3.append(tmp_emp_id_field);buffer_3.append(" = ");buffer_3.append(emp_id);
			buffer_3.append(" and trim(");			
			buffer_3.append(tmp_start_day_field_1);buffer_3.append(")||' '||trim(");buffer_3.append(tmp_start_time_field_1);
			buffer_3.append(")>='");buffer_3.append(start_day);buffer_3.append(" ");buffer_3.append(start_time);buffer_3.append("'");
			buffer_3.append(" and trim(");			
			buffer_3.append(tmp_end_day_field_1);buffer_3.append(")||' '||trim(");buffer_3.append(tmp_end_time_field_1);
			buffer_3.append(")<='");buffer_3.append(end_day);buffer_3.append(" ");buffer_3.append(end_time);buffer_3.append("'");
			buffer_3.append(" and trim(");buffer_3.append(tmp_start_day_field);buffer_3.append(") is null ");buffer_3.append(tmp_add_sql);
			
			buffer_3.append(" union all ");

			buffer_3.append(" select count(*) as count_cc from ");buffer_3.append(tmp_table_name);
			buffer_3.append(" where ");buffer_3.append(tmp_emp_id_field);buffer_3.append(" = ");buffer_3.append(emp_id);
			buffer_3.append(" and trim(");			
			buffer_3.append(tmp_start_day_field);buffer_3.append(")||' '||trim(");buffer_3.append(tmp_start_time_field);
			buffer_3.append(")>='");buffer_3.append(start_day);buffer_3.append(" ");buffer_3.append(start_time);buffer_3.append("'");
			buffer_3.append(" and trim(");			
			buffer_3.append(tmp_end_day_field);buffer_3.append(")||' '||trim(");buffer_3.append(tmp_end_time_field);
			buffer_3.append(")<='");buffer_3.append(end_day);buffer_3.append(" ");buffer_3.append(end_time);buffer_3.append("'");
			buffer_3.append(" and trim(");buffer_3.append(tmp_end_day_field);buffer_3.append(") is not null ");buffer_3.append(tmp_add_sql);
		}
		
		buffer_1.append(") x ");
		buffer_2.append(") x ");
		buffer_3.append(") x ");
		
	 	out.println(buffer_1.toString());out.println("<br>");
		out.println(buffer_2.toString());out.println("<br>");	
		out.println(buffer_3.toString());out.println("<br>");
		
//		java.util.Date start_1 = new java.util.Date();

		rs.executeSql(buffer_1.toString());
		if(rs.next()){
			sum_cc = rs.getInt("sum_cc");
		}
		
		if(sum_cc > 0 ){
			out.print("N");
		}else{
			rs.executeSql(buffer_2.toString());
			if(rs.next()){
				sum_cc = rs.getInt("sum_cc");
			}
			
			if(sum_cc > 0) { 
				out.print("N");
			}else {
				rs.executeSql(buffer_3.toString());
				if(rs.next()){
					sum_cc = rs.getInt("sum_cc");
				}
				
				if(sum_cc > 0) out.print("N");
				else out.print("Y");
			}
		}
//		java.util.Date end_1 = new java.util.Date();
//		out.println("<br>TTTT = " + (end_1.getTime()-start_1.getTime()));
%>
