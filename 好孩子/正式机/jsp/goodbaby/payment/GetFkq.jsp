<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	String fpid = Util.null2String(request.getParameter("fp"));
	String fqk = "";
	String sql = "select u.FKQ from uf_suppmessForm u join uf_invoice a on u.id=a.gys where a.id = '"+fpid+"'";
	rs.executeSql(sql);
	if(rs.next()){
		fqk = Util.null2String(rs.getString("FKQ"));
		if(fqk.length()<1){
			fqk = "0";
		}
		
	}

	out.print(fqk);

%>