<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	String emp_id= Util.null2String(request.getParameter("emp_id"));
	String card_id = Util.null2String(request.getParameter("card_id"));;
	StringBuffer buff = new StringBuffer();
		
	String sql = "select id,lastname,workcode,decode(status,0,'1',1,'1',2,'1',3,'1','2') as stauts_1 from hrmresource "
		        +"where certificatenum='"+card_id+"'";
	if(!"".equals(emp_id)){
		sql = sql + " and id<>"+emp_id;
	}
	rs.executeSql(sql);
	buff.append("存在重复身份证号(");buff.append(card_id);buff.append(")：[");
	int flag_x = 0 ;
	while(rs.next()){
		flag_x++;
		String tmp_id = Util.null2String(rs.getString("id"));
		String tmp_name = Util.null2String(rs.getString("lastname"));
		String tmp_code = Util.null2String(rs.getString("workcode"));
		String tmp_stauts_1 = Util.null2String(rs.getString("stauts_1"));
		
		if(flag_x>1){
			buff.append(" # ");
		}
		
		buff.append("姓名:");buff.append(tmp_name);
		buff.append(",工号:");buff.append(tmp_code);
		buff.append(",目前员工状态:");
		
		if("1".equals(tmp_stauts_1)){
	//		buff.append("姓名:<a href=\"/hrm/resource/HrmResourceBase.jsp?id=");buff.append(tmp_id);buff.append("\" target=\"_blank\">");buff.append(tmp_name);
	//		buff.append("</a>,工号:");buff.append(tmp_code);
	//		buff.append(",目前员工状态:");
			buff.append("有效");
		}else{
			
			buff.append("无效");
		}
	}
	if(flag_x > 0){
		buff.append("]");
	}else{
		buff = new StringBuffer();
		buff.append("");
	}	
//	out.print(sql);
	out.print(buff.toString());
%>
