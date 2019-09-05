<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="gcl.doc.workflow.MessageRevoke" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.conn.RecordSetDataSource" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
	RecordSetDataSource rsd = new RecordSetDataSource("ehr");
	if(rsd == null){
		out.print("123");
		
	}else{
		String psnstate = "";
		String sql = "select psnstate from ec_psninfo where psncode='171554'";
		rsd.execute(sql);
		if(rsd.next()){
			psnstate = Util.null2String(rsd.getString("psnstate"));
		}
		out.print("123:"+psnstate);
	}
%>