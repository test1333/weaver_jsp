<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String sql = "";
String belongDate = request.getParameter("belongDate");//归属日期
//String xjlxbm = request.getParameter("xjlxbm");//休假类型编码
String emp_code = request.getParameter("emp_code");//员工工号
String year = belongDate.substring(0,4);

if(belongDate.length()>0&&emp_code.length()>0){	
	sql = " select * from V_HRJBLJTOTAL_PIVOT where ygh='"+emp_code+"' and year='"+year+"' ";
	rs.executeSql(sql);
	if(rs.next()){
		String month1 = Util.null2String(rs.getString("month1"));
		if("".equals(month1)){
			month1 = "0.0";
		}
		String month2 = Util.null2String(rs.getString("month2"));
		if("".equals(month2)){
			month2 = "0.0";
		}
		String month3 = Util.null2String(rs.getString("month3"));
		if("".equals(month3)){
			month3 = "0.0";
		}
		String month4 = Util.null2String(rs.getString("month4"));
		if("".equals(month4)){
			month4 = "0.0";
		}
		String month5 = Util.null2String(rs.getString("month5"));
		if("".equals(month5)){
			month5 = "0.0";
		}
		String month6 = Util.null2String(rs.getString("month6"));
		if("".equals(month6)){
			month6 = "0.0";
		}
		String month7 = Util.null2String(rs.getString("month7"));
		if("".equals(month7)){
			month7 = "0.0";
		}
		String month8 = Util.null2String(rs.getString("month8"));
		if("".equals(month8)){
			month8 = "0.0";
		}
		String month9 = Util.null2String(rs.getString("month9"));
		if("".equals(month9)){
			month9 = "0.0";
		}
		String month10 = Util.null2String(rs.getString("month10"));
		if("".equals(month10)){
			month10 = "0.0";
		}
		String month11 = Util.null2String(rs.getString("month11"));
		if("".equals(month11)){
			month11 = "0.0";
		}
		String month12 = Util.null2String(rs.getString("month12"));
		if("".equals(month12)){
			month2 = "0.0";
		}

		json.append("{");
		json.append("month1:").append("'").append(month1).append("'").append(",");
		json.append("month2:").append("'").append(month2).append("'").append(",");
		json.append("month3:").append("'").append(month3).append("'").append(",");
		json.append("month4:").append("'").append(month4).append("'").append(",");
		json.append("month5:").append("'").append(month5).append("'").append(",");
		json.append("month6:").append("'").append(month6).append("'").append(",");
		json.append("month7:").append("'").append(month7).append("'").append(",");
		json.append("month8:").append("'").append(month8).append("'").append(",");
		json.append("month9:").append("'").append(month9).append("'").append(",");
		json.append("month10:").append("'").append(month10).append("'").append(",");
		json.append("month11:").append("'").append(month11).append("'").append(",");
		json.append("month12:").append("'").append(month12).append("'");
		json.append("}");
	}
	
	
}
out.println(json.toString());

%>

