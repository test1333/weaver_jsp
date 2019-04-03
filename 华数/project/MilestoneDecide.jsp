<%@ page language="java" contentType="text/html; charset=GBK" %><jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" /><jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<%
String method = Util.null2String(request.getParameter("method"));
String methods = Util.null2String(request.getParameter("methods"));
String projid=Util.null2String(request.getParameter("projid"));
if(method.equals("decide")){
	
	int stoneorder=Util.getIntValue(request.getParameter("stoneorder"),0);  
	String stonedate=Util.null2String(request.getParameter("stonedate"));      
	 // 1 10  5  15 11 20
	int stoneorderpre=0; 
	RecordSet.executeSql(" select stoneorder from wasu_projstone where projid="+projid+" and  stonedate<='"+stonedate+"' and stonedate is not null and stonedate!='' order by stoneorder desc ");
	if(RecordSet.next()){
		stoneorderpre = RecordSet.getInt("stoneorder");   
	}
	int stoneorderlast=0; 
	String lastdate="";
	RecordSet.executeSql(" select stoneorder,stonedate from wasu_projstone where projid="+projid+" and    stonedate>='"+stonedate+"' order by stoneorder asc ");
	if(RecordSet.next()){
		stoneorderlast = RecordSet.getInt("stoneorder"); 
		lastdate = RecordSet.getString("stonedate");       
	}  
	System.out.println("stoneorderpre:"+stoneorderpre+",stoneorderlast:"+stoneorderlast); 
	if(stoneorder>=stoneorderpre&&(stoneorder<=stoneorderlast||lastdate.equals(""))){ 
		out.print("ok");
	}else{
		out.print("-1");
	} 
}
%>