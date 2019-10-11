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
String lbids = Util.null2String(request.getParameter("lbids"));
Strign lbid[] = lbids.split(",");
String docids = "123";
String flag = "";
String sql = "";
for(String keyid:lbid){
    if("".equals(keyid)){
        continue;
    }
	String pklcid = "";
	String pcno = "";
    String pzfj = "";
    sql = "select pklcid,pcno from v_gns_kjqrpz where id="+keyid;
    rs.executeSql(sql);
    if(rs.next()){
        pklcid = Util.null2String(rs.getString("pklcid"));
        pcno = Util.null2String(rs.getString("pcno"));
    }
    sql = "select distinct CAST(pzfj as varchar(100)) as pzfj from uf_fkzjb where pklcid='"+pklcid+"' and pcno='"+pcno+"'";
    rs.executeSql(sql);
    while(rs.next()){
        pzfj = Util.null2String(rs.getString("pzfj"));
        docids = docids + flag + pzfj;
        flag = ",";
    }
}
out.print(docids);


%>