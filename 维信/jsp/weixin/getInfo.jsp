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
     String result="";
	 out.print("333");
	 DataSource ds = (DataSource) StaticObj.getServiceByFullname(("datasource.K3"), DataSource.class); 
		     java.sql.Connection conn = ds.getConnection();
	 try {
		CallableStatement cs=conn.prepareCall("{call P_HR_ATS_CUS_OverTimecheck(?,?,?,?,?)}");
		cs.setString(1,"30007185");
		cs.setString(2,"2017-12-08 00:00:00.000");
		cs.setString(3,"2017-12-08 17:30:00.000");
		cs.setString(4,"2017-12-08 19:00:00.000");
		cs.registerOutParameter(5, Types.VARCHAR);
		cs.execute();
		result=cs.getString(5);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		try {
			
			conn.close();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
	 try {
		conn.close();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	out.print(result);
%>