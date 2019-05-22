<%@page language="java" contentType="application/x-msdownload" pageEncoding="UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.io.*"%>
<%@ page import="goodbaby.pz.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
BaseBean log = new BaseBean();
GetGNSTableName gg = new GetGNSTableName();
String yjcbzx = Util.null2String(request.getParameter("yjcbzx"));
String begindate = Util.null2String(request.getParameter("begindate"));
String enddate = Util.null2String(request.getParameter("enddate"));
String scr = Util.null2String(request.getParameter("scr"));
String tablename = gg.getTableName("RKD");
String rqids = "";
String flag = "";
int count = 0;
String sql = "select a.requestid from "+tablename+" a,workflow_requestbase b "+
"where a.requestid=b.requestid and a.cgdl='1' and b.currentnodetype=3 and (select yjcbzx from uf_cbzx where id=a.cbzx) = '"+yjcbzx+"' and b.lastoperatedate<='"+enddate+"' and b.lastoperatedate>='"+begindate+"'";
rs.executeSql(sql);
while(rs.next()){
	rqids = rqids+flag+Util.null2String(rs.getString("requestid"));
	flag = ",";
}
CreateFWRkdXML crx = new CreateFWRkdXML();
String xmlString =crx.CreateXML(begindate,enddate,yjcbzx,scr,rqids);
response.reset();
out.clear();  
//response.setContentType("application/x-download"); 
response.setContentType("application/x-msdownload");
String filedisplay = begindate.substring(0,4)+begindate.substring(5,7)+"服务类入库财务凭证.xml";  
filedisplay = URLEncoder.encode(filedisplay,"UTF-8");  
response.addHeader("Content-Disposition","attachment;filename=" + filedisplay);  
response.setCharacterEncoding("UTF-8");
response.getOutputStream().write(xmlString.getBytes("UTF-8"));
//response.getOutputStream().write("aaaaaa".getBytes("UTF-8"));
response.getOutputStream().flush();
out.clear();  
out = pageContext.pushBody();  
	//要加以下两句话，否则会报错  
	//java.lang.IllegalStateException: getOutputStream() has already been called for //this response    
	//out.clear();  
	//out = pageContext.pushBody();  

%>