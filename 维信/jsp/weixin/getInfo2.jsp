<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSetDataSource" %>
<%@ page import="java.sql.*" %>
<%@ page import="weaver.general.StaticObj" %>
<%@ page import="weaver.interfaces.datasource.DataSource" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
     String result = "123";
		DataSource ds = (DataSource) StaticObj.getServiceByFullname(
				("datasource.K3"), DataSource.class);
		java.sql.Connection conn = ds.getConnection();
		CallableStatement cs= null;
		try {
			 cs = conn
					.prepareCall("{call P_HR_ATS_CUS_OverTimeInfo(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "30007185");
			cs.setString(2, "2017-11-30 00:00:00.000");
			cs.setString(3,"2017-11-30 14:03:00.000");
			cs.setString(4, "2017-11-30 23:03:00.000");
			cs.setFloat(5, Float.valueOf("9"));
			cs.setString(6, "30007185");
			cs.setString(7, "2017-11-30 14:03:00.000");
			cs.setString(8, "2017-11-30 00:00:00.000");
			cs.setString(9, "30007185");
			cs.setString(10, "test");
			
			cs.setString(11, "9C45523E-2C24-473C-A592-979CBF2893BD");
			cs.setInt(12, Integer.valueOf("0"));
			cs.setString(13, "C85D931D-5C73-482E-9ECA-44DB722E3402");
			cs.registerOutParameter(14, Types.VARCHAR);
			// cs.registerOutParameter(4, Types.VARCHAR);
			cs.execute();
			 result = cs.getString(14);
		} catch (Exception e) {
			out.print("aaa"+e.getMessage());
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				cs.close();
				conn.close();
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		try {
			cs.close();
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	out.print(result);
%>