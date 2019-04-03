<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="weaver.general.BaseBean"%>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
BaseBean log = new BaseBean();
	Calendar now = Calendar.getInstance();
	int now_year = now.get(Calendar.YEAR);
	String month=now_year+"-";
	String sql="";
     String qj_id = request.getParameter("id");
	String arr[] = qj_id.split(",");
	StringBuffer sb = new StringBuffer();
	
	

	for(int i=0;i<arr.length;i++){
	String name="";
	String workcode="";
	String time="";
	float hours=0;
	String mon="";
	float month1=0;
	float month2=0;
	float month3=0;
	float month4=0;
	float month5=0;
	float month6=0;
	float month7=0;
	float month8=0;
	float month9=0;
	float month10=0;
	float month11=0;
	float month12=0;
		sql="select workcode,lastname from hrmresource where id="+arr[i];
		rs.executeSql(sql);
		if(rs.next()){
			workcode = Util.null2String(rs.getString("workcode"));
			name = Util.null2String(rs.getString("lastname"));
		}
		sb.append(workcode);
		sb.append("###");
		sb.append(arr[i]);
		sb.append("###");
	    sb.append(name);
		sql="select * from v_jiaban_time where xm="+arr[i];
		rs.executeSql(sql);
		while(rs.next()){
			time = Util.null2String(rs.getString("time"));
			hours = rs.getFloat("hours");
			if(time.equals(month+"01")){
				month1=hours;
			}
			if(time.equals(month+"02")){
				month2=hours;
			}
			if(time.equals(month+"03")){
				month3=hours;
			}
			if(time.equals(month+"04")){
				month4=hours;
			}
			if(time.equals(month+"05")){
				month5=hours;
			}
			if(time.equals(month+"06")){
				month6=hours;
			}
			if(time.equals(month+"07")){
				month7=hours;
			}
			if(time.equals(month+"08")){
				month8=hours;
			}
			if(time.equals(month+"09")){
				month9=hours;
			}
			if(time.equals(month+"10")){
				month10=hours;
			}
			if(time.equals(month+"11")){
				month11=hours;
			}
			if(time.equals(month+"12")){
				month12=hours;
			}
		}
		sb.append("###");
	    sb.append(month1);
		sb.append("###");
	    sb.append(month2);
		sb.append("###");
	    sb.append(month3);
		sb.append("###");
	    sb.append(month4);
		sb.append("###");
	    sb.append(month5);
		sb.append("###");
	    sb.append(month6);
		sb.append("###");
	    sb.append(month7);
		sb.append("###");
	    sb.append(month8);
		sb.append("###");
	    sb.append(month9);
		sb.append("###");
	    sb.append(month10);
		sb.append("###");
	    sb.append(month11);
		sb.append("###");
	    sb.append(month12);
		BigDecimal   b1   =   BigDecimal.valueOf(month1);   
		BigDecimal   b2   =  BigDecimal.valueOf(month2);   
		BigDecimal   b3   =   BigDecimal.valueOf(month3);   
		BigDecimal   b4   =  BigDecimal.valueOf(month4);   
		BigDecimal   b5   =   BigDecimal.valueOf(month5);   
		BigDecimal   b6   =  BigDecimal.valueOf(month6);   
		BigDecimal   b7   =   BigDecimal.valueOf(month7);   
		BigDecimal   b8   =  BigDecimal.valueOf(month8);   
		BigDecimal   b9   =   BigDecimal.valueOf(month9);   
		BigDecimal   b10   =  BigDecimal.valueOf(month10);   
		BigDecimal   b11  =   BigDecimal.valueOf(month11);   
		BigDecimal   b12   =  BigDecimal.valueOf(month12);  
		sb.append("###");
	    sb.append(b1.add(b2).add(b3).setScale(2,  BigDecimal.ROUND_HALF_UP).floatValue());
		sb.append("###");
	    sb.append(b4.add(b5).add(b6).setScale(2,  BigDecimal.ROUND_HALF_UP).floatValue());
		sb.append("###");
	    sb.append(b7.add(b8).add(b9).setScale(2,  BigDecimal.ROUND_HALF_UP).floatValue());
			sb.append("###");
	    sb.append(b10.add(b11).add(b12).setScale(2,  BigDecimal.ROUND_HALF_UP).floatValue());
		sb.append("@@@");
    }
	out.print(sb.toString());
%>