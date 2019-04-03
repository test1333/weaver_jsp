<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
   // BaseBean log = new BaseBean();
    StringBuffer sb = new StringBuffer();
    String dqny = request.getParameter("dqny");
	String status = request.getParameter("status");
	String userid = request.getParameter("userid");
	String checkbmzg = Util.null2String(request.getParameter("checkbmzg"));
	int count=0;
	String sql="";
	if("0".equals(status)){
		if(!"".equals(checkbmzg)){
			sql="select count(1) as count from uf_month_check where   khny='"+dqny+"' and bmzg='"+checkbmzg+"'  group by gh having count(id)>1";
			rs.executeSql(sql);
			if(rs.next()){
			count = rs.getInt("count");
			}
			if(count >0){
		      sb.append("存在工号重复，请检查。\n");
			}
		}
	}else{
     sql ="  select count(1) as count from  uf_month_check a where  bmzg='"+userid+"' and khny='"+dqny+"'  and jxdj=0 and exists(select 1 from uf_month_check b where bmzg='"+userid+"' and khny='"+dqny+"'  and jxdj=1 and  nvl(a.jxfs,0)<=nvl(b.jxfs,0))";
    rs.executeSql(sql);
	if(rs.next()){
		count = rs.getInt("count");
	}
	if(count >0){
		sb.append("等级为A的人员考核分小于等于等级为B的，请检查。\n");
	}
	float je= 0;
	float jeall= 0;
	sql="select sum(nvl(jxje,0)) as je from  uf_month_check a where bmzg='"+userid+"' and khny='"+dqny+"'";
	 rs.executeSql(sql);
	 if(rs.next()){
     	 je= rs.getFloat("je");
	 }
	 sql="select count(1)*150 as jeall from  uf_month_check a where bmzg='"+userid+"' and khny='"+dqny+"'";
	 rs.executeSql(sql);
	 if(rs.next()){
     	 jeall= rs.getFloat("jeall");
	 }
	 if(je>jeall){
		 sb.append("考核人员考核总金额大于人数*150的设定,请检查。\n");
	 }
	 sql="select count(1) as count from  uf_month_check where bmzg='"+userid+"' and khny='"+dqny+"' and (nvl(jxje,0)<0 or nvl(jxje,0)>300)";
	 count = 0;
	 rs.executeSql(sql);
	 if(rs.next()){
     	count = rs.getInt("count");
	 }
	if(count >0){
		sb.append("存在考核人员金额不在0~300之间,请检查。\n");
	}
	sql=" select count(1) as count from uf_month_check a where bmzg='"+userid+"' and khny='"+dqny+"' and exists(select 1 from uf_month_check b where  bmzg='"+userid+"' and khny='"+dqny+"' and a.jxfs=b.jxfs and a.jxje<>b.jxje)";
	 count = 0;
	 rs.executeSql(sql);
	 if(rs.next()){
     	count = rs.getInt("count");
	 }
	 if(count >0){
		sb.append("存在考核分数相同但金额不相同的情况请检查,请检查。\n");
	 }
	

	sql=" select count(1) as count from uf_month_check where bmzg='"+userid+"' and khny='"+dqny+"' and (jxfs is null or jxdj is null or jxje is null)";
	 count = 0;
	 rs.executeSql(sql);
	 if(rs.next()){
     	count = rs.getInt("count");
	 }
	 if(count >0){
		sb.append("存在绩效分数或绩效等级或绩效金额为空的情况,请检查。\n");
	 }
	}

	sql="select count(1) as count from uf_month_check a where bmzg='"+userid+"' and khny='"+dqny+"' and exists(select 1 from uf_month_check b where  bmzg='"+userid+"' and khny='"+dqny+"' and a.jxfs<b.jxfs and a.jxje>=b.jxje)";
	 count = 0;
	 rs.executeSql(sql);
	 if(rs.next()){
     	count = rs.getInt("count");
	 }
	 if(count >0){
		sb.append("存在考核分数低但金额大于等于分数高的记录的情况，请检查。\n");
	 }

	 sql="select count(1) as count from uf_month_check a where bmzg='"+userid+"' and khny='"+dqny+"' ";
	 int allcount=0;
	 rs.executeSql(sql);
	 if(rs.next()){
     	allcount = rs.getInt("count");
	 }
	  sql="select count(1) as count from uf_month_check a where bmzg='"+userid+"' and khny='"+dqny+"'  and jxdj='0'";
	 int acount=0;
	 rs.executeSql(sql);
	 if(rs.next()){
     	acount = rs.getInt("count");
	 }
	 if(((float)acount/allcount)>0.5){
		 sb.append("绩效等级为A的人数大于50%,请检查\n");
	 }
	 sql="select count(1) as count from uf_month_check a where bmzg='"+userid+"' and khny='"+dqny+"' and (bzsm='' or bzsm is null)";
	 count = 0;
	 rs.executeSql(sql);
	 if(rs.next()){
     	count = rs.getInt("count");
	 }
	 if(count >0){
		sb.append("存在备注说明为空的情况，请检查。\n");
	 }
	out.print(sb.toString());

%>