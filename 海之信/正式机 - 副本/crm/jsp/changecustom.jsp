<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_detail" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
	String sql=" select w.tablename,b.fieldname,b.fieldhtmltype,b.fielddbtype,b.detailtable from workflow_billfield  b "+
               " join workflow_bill w on b.billid=w.id "+
               " where b.fielddbtype in('browser.Custom','browser.dsfgs','browser.uf_custom_return','browser.unSureCustom','browser.sureCustom','browser.hebingCustom','browser.sureModifyCustom','browser.sureGYS') and b.fieldhtmltype=3 ";
	String tablename="";
	String detailtable="";
	String changetable = "";
	String fieldname = "";
	String sql_detail="";
	rs.executeSql(sql); 
	while(rs.next()){
	tablename = Util.null2String(rs.getString("tablename"));
	detailtable = Util.null2String(rs.getString("detailtable"));
	changetable=tablename;
	if(!"".equals(detailtable)){
		changetable = detailtable;
	}
	fieldname = Util.null2String(rs.getString("fieldname"));
	sql_detail ="update "+changetable+" set "+fieldname+" = b.newid from "+changetable+" a left join checkcustom b on a."+fieldname+"=b.oldid where a."+fieldname+" in (select oldid from checkcustom)";
    log.writeLog("客户变更sql_detail:"+sql_detail);
	rs_detail.executeSql(sql_detail); 
	} 
	out.print("处理成功");

%>