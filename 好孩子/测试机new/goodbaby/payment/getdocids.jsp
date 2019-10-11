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
String pklcid = Util.null2String(request.getParameter("pklcid"));
String pcno = Util.null2String(request.getParameter("pcno"));
String docids = "";
String flag = "";
String pzfj = "";
String sql = "select distinct CAST(pzfj as varchar(100)) as pzfj from uf_fkzjb where pklcid='"+pklcid+"' and pcno='"+pcno+"'";
rs.executeSql(sql);
while(rs.next()){
    pzfj = Util.null2String(rs.getString("pzfj"));
    docids = docids + flag + pzfj;
    flag = ",";
}
out.print(docids);

%>