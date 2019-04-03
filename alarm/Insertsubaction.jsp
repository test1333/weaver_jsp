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


	String  subitem  = "";
	String xdfajd = "";
	String  jdjz = "";
	String jzrq = "";
	String  wcrq  = "";
	String  wcbl = "";
	
	
	String val = request.getParameter("val");

	    sql = "select a.subitem,a.xdfajd,a.jdjz,a.jzrq as cc,a.wcrq as dd,a.wcbl from uf_sub_action a,uf_action_plan b where a.alarmid = b.alarmid and a.actionid = b.actionid and b.id ='"+val+"' order by a.subitem asc";
	    rs.executeSql(sql);       
	    //out.print("sql="+sql);
	    log.writeLog("sql="+sql);   
		while( rs.next() ) {	

		subitem = Util.null2String(rs.getString("subitem"));
		dataBuff.append(subitem);
		dataBuff.append("###");

		xdfajd = Util.null2String(rs.getString("xdfajd"));
		dataBuff.append(xdfajd);
		dataBuff.append("###");

		jdjz = Util.null2String(rs.getString("jdjz"));
		dataBuff.append(jdjz);
		dataBuff.append("###");

		jzrq = Util.null2String(rs.getString("cc"));
		dataBuff.append(jzrq);
		dataBuff.append("###");
	
		wcrq = Util.null2String(rs.getString("dd"));
   		dataBuff.append(wcrq);
		dataBuff.append("###");
		
		wcbl = Util.null2String(rs.getString("wcbl"));
   		dataBuff.append(wcbl);
		dataBuff.append("@@@");
		

			
		}
		out.print(dataBuff.toString());
	//}	
%>