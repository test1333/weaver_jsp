<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<%@ page import="shukun.jy.GetNMYJNum"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
	SimpleDateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
	String nowDate = dateFormate.format(new Date());
	String yjgy =Util.null2String(request.getParameter("yjgy"));
	String yjnr =Util.null2String(request.getParameter("yjnr"));
	GetNMYJNum gnn = new GetNMYJNum();
	String yjbh = "NMYJ"+nowDate.substring(0,4)+gnn.getFlowNumYear(nowDate.substring(0,4),"NMYJ",4);
	String billid = "";
	String result = "0";
	String sql = "insert into uf_Opinion(yjgy,yjnr,modedatacreater,formmodeid,modedatacreatertype,modedatacreatedate,yjbh,tjfs,cnqk,zxqk,txrq) values('"+yjgy+"','"+yjnr+"','1','56','0','"+nowDate+"','"+yjbh+"','1','0','0','"+nowDate+"')";
	rs.executeSql(sql);
	sql = "select id from uf_Opinion where yjbh='"+yjbh+"'";
	rs.executeSql(sql);
	if(rs.next()){
		billid  = Util.null2String(rs.getString("id"));
	}
	if(!"".equals(billid)){
		ModeRightInfo ModeRightInfo = new ModeRightInfo();
		ModeRightInfo.setNewRight(true);
		ModeRightInfo.editModeDataShare(1,56,Integer.valueOf(billid));
		result = "1";

	}
	response.sendRedirect("/shukun/addNmOpinion.jsp?isrsut="+result);





%>
