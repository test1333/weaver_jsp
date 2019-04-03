<%@ page language="java" contentType="text/html; charset=utf-8" %><%@ page import="java.util.*" %><%@ page import="weaver.general.Util" %><jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
  
String method = Util.null2String(request.getParameter("method"));
StringBuffer json = new StringBuffer();
json.append("{");
if(method.equals("getOptionsByFirstType"))
{
	String gs = Util.null2String(request.getParameter("gs"));
	String firsttype = Util.null2String(request.getParameter("firsttype"));
	//System.out.println("firsttype1:"+firsttype);
	//System.out.println("firsttype gbk:"+new String(firsttype.getBytes(),"GBK"));
	//System.out.println("firsttype utf:"+new String(firsttype.getBytes(),"UTF-8"));
	String lxlzwhformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "lxlzwh"));  
    rs.executeSql("select * From formtable_main_"+lxlzwhformid+"_dt2 where firsttype='"+firsttype+"'  and ssgs='"+gs+"' order by lbmc asc ");
	String doptions="<option value=-1></option>";
    while(rs.next()){
    	doptions+="<option value='"+rs.getString("lbzm")+"'>"+rs.getString("lbmc")+"</option>";
	}
	json.append("\"doptions\":\""+doptions+"\"");
}
json.append("}");
out.print(json.toString());
%>
 