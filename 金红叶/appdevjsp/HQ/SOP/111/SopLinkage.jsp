<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.resource.ResourceComInfo"%>
<%@ page import="weaver.hrm.company.SubCompanyComInfo"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String type = request.getParameter("type");
if("0".equals(type)){
	String cateid = request.getParameter("cateid");
	String temp = "";
	String fzr_id = "";
	String fzr_lastname = "";
	String sql_fzr = " select id,lastname from hrmresource where workcode in ( select user1 from uf_it_basedata where type = 'CMOTEAM' and code="+cateid+" ) ";
	rs.executeSql(sql_fzr);
	if(rs.next()){
		fzr_id = Util.null2String(rs.getString("id"));
		fzr_lastname = Util.null2String(rs.getString("lastname"));
	}
	temp = fzr_id+","+fzr_lastname;
    out.clear();
	out.println(temp);

}

if("1".equals(type)){
	String userid = request.getParameter("userid");
	String temp = "";
	String ckr_lastname = "";
	String code = "";
	String zb_id = "";
	String zb_name = "";
	String sql_ckr = " select lastname from hrmresource where id = "+userid+" ";
	rs.executeSql(sql_ckr);
	if(rs.next()){
		ckr_lastname = Util.null2String(rs.getString("lastname"));
	}
	String sql_zb = " select id,code,name from uf_it_basedata where type = 'CMOTEAM' and code in ( select name from uf_it_basedata where type = 'CMOTEAM_USER' "+
					" and code in (select workcode from hrmresource where id = "+userid+") )";
	rs.executeSql(sql_zb);
	if(rs.next()){
		code = Util.null2String(rs.getString("code"));
		zb_id = Util.null2String(rs.getString("id"));
		zb_name = Util.null2String(rs.getString("name"));
	}				

    temp = userid+","+ckr_lastname+","+code+","+zb_name;
    out.clear();
	out.println(temp);
}

if("2".equals(type)){
	String managerid = request.getParameter("managerid");
	String temp = "";
	String subcompanyid = "";
	String subcompanyname = "";
	String sql = " select id,subcompanyname from hrmsubcompany where id in (select subcompanyid1 from hrmresource where id = "+managerid+")";
	rs.executeSql(sql);
	if(rs.next()){
		subcompanyid = Util.null2String(rs.getString("id"));
		subcompanyname = Util.null2String(rs.getString("subcompanyname"));
		temp = subcompanyid+","+subcompanyname;
	}

	out.clear();
	out.println(temp);
}
%>