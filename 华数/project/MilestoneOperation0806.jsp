<%@ page language="java" contentType="text/html; charset=GBK" %><%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" /><jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<%
char flag = 2;
String ProcPara = "";

String method = Util.null2String(request.getParameter("method"));
String projid=Util.null2String(request.getParameter("projid"));
if(method.equals("add"))
{
	String stoneorder=Util.null2String(request.getParameter("stoneorder"));
	String stonename=Util.null2String(request.getParameter("stonename"));
	String stonedate=Util.null2String(request.getParameter("stonedate"));
	 
	RecordSet.executeSql("insert into wasu_projstone(projid,stoneorder,stonename,stonedate) values("+projid+","+stoneorder+",'"+stonename+"','"+stonedate+"')");
    
	response.sendRedirect("/project/Milestonelist.jsp?projid="+projid);
	return;
}

if(method.equals("decide")){ 
	
	int stoneorder=Util.getIntValue(request.getParameter("stoneorder"),0);  
	String stonedate=Util.null2String(request.getParameter("stonedate"));      
	 
	int stoneorderpre=0; 
	RecordSet.executeSql(" select stoneorder from wasu_projstone where  stonedate<='"+stonedate+"' order by stoneorder desc ");
	if(RecordSet.next()){
		stoneorderpre = RecordSet.getInt("stoneorder");   
	}
	int stoneorderlast=0; 
	RecordSet.executeSql(" select stoneorder from wasu_projstone where  stonedate>='"+stonedate+"' order by stoneorder asc ");
	if(RecordSet.next()){
		stoneorderlast = RecordSet.getInt("stoneorder");    
	}
	if(stoneorder>stoneorderpre&&stoneorderlast<stoneorderlast){
		out.print("");
		return;
	}
	
    
	response.sendRedirect("/project/Milestonelist.jsp?projid="+projid); 
	return;
}


String stoneids[]=request.getParameterValues("stoneids");  
if(method.equals("delete")){

	if(stoneids != null)
	{
		for(int i=0;i<stoneids.length;i++)
		{
			ProcPara = stoneids[i]; 
            if (!ProcPara.equals("")) {
                RecordSet.executeSql(" update wasu_projstone set stonestatus=1 where id="+ProcPara); 
            }  
		}
	} 
	response.sendRedirect("/project/Milestonelist.jsp?projid="+projid);
	return;
}
if(method.equals("edit"))
{   
    String id=Util.null2String(request.getParameter("id"));
    String stoneorder=Util.null2String(request.getParameter("stoneorder"));
	String stonename=Util.null2String(request.getParameter("stonename"));
	String stonedate=Util.null2String(request.getParameter("stonedate"));   
	 
	System.out.println(" update wasu_projstone set stoneorder="+stoneorder+",stonename='"+stonename+"',stonedate='"+stonedate+"' where id="+id);
	RecordSet.executeSql(" update wasu_projstone set stoneorder="+stoneorder+",stonename='"+stonename+"',stonedate='"+stonedate+"' where id="+id); 
	response.sendRedirect("/project/Milestonelist.jsp?projid="+projid);
	return;
}
%>