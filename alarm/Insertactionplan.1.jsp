<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
	StringBuffer dataBuff = new StringBuffer();


	String  actionid  = "";
	String xdfa = "";
	String  famb = "";
	String sjwc = "";
	String  jzrq  = "";
	String  wcbl = "";
	
	
	String val = request.getParameter("val");

	    sql = "select actionid,xdfa,famb,sjwc,jzrq,wcbl from uf_action_plan where alarmid='"+val+"' order by actionid asc";
	    rs.executeSql(sql);       
	    //out.print("sql="+sql);
	    log.writeLog("sql="+sql);   
		while( rs.next() ) {	

		actionid = Util.null2String(rs.getString("actionid"));
		dataBuff.append(actionid);
		dataBuff.append("###");

		xdfa = Util.null2String(rs.getString("xdfa"));
		dataBuff.append(xdfa);
		dataBuff.append("###");

		famb = Util.null2String(rs.getString("famb"));
		dataBuff.append(famb);
		dataBuff.append("###");

		sjwc = Util.null2String(rs.getString("sjwc"));
		dataBuff.append(sjwc);
		dataBuff.append("###");
	
		jzrq = Util.null2String(rs.getString("jzrq"));
   		dataBuff.append(jzrq);
		dataBuff.append("###");
		
		wcbl = Util.null2String(rs.getString("wcbl"));
   		dataBuff.append(wcbl);
		dataBuff.append("@@@");
		

			
		}
		out.print(dataBuff.toString());
	//}	
%>