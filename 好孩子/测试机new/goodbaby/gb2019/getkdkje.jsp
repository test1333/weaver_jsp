<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
BaseBean log = new BaseBean();
String type = Util.null2String(request.getParameter("type"));//交通工具类型
String pmje = Util.null2String(request.getParameter("pmje"));//票面金额
String ryfjf = Util.null2String(request.getParameter("ryfjf"));//燃油附件费
String sl = Util.null2String(request.getParameter("sl"));//燃油附件费
String result = "";
String sql = "";
if("".equals(sl)){
	sl = "0.00";
	sql = "select sl from uf_slwh where zt='0' and jtgj='"+type+"'";
	rs.execute(sql);
	if(rs.next()){
		sl = Util.null2String(rs.getString("sl"));
	}
}
if("0".equals(type)){
	sql="select cast(("+pmje+"+"+ryfjf+")/(1+"+sl+")*"+sl+" as numeric(10,2)) as kdkje ";
	rs.execute(sql);
	if(rs.next()){
		result = Util.null2String(rs.getString("kdkje"));
	}
}else if("2".equals(type)){
	sql="select cast("+pmje+"/(1+"+sl+")*"+sl+" as numeric(10,2)) as kdkje ";
	rs.execute(sql);
	if(rs.next()){
		result = Util.null2String(rs.getString("kdkje"));
	}
}else if("3".equals(type)){
	sql="select cast("+pmje+"/(1+"+sl+")*"+sl+" as numeric(10,2)) as kdkje ";
	rs.execute(sql);
	if(rs.next()){
		result = Util.null2String(rs.getString("kdkje"));
	}
}else{
	result = "0.00";
}
out.print(result);
%>