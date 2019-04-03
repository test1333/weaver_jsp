<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="MeetingRoomComInfo" class="weaver.meeting.Maint.MeetingRoomComInfo" scope="page" />
<jsp:useBean id="MeetingUtil" class="weaver.meeting.MeetingUtil" scope="page" />

<%
char flag = 2;
String ProcPara = "";

String method = Util.null2String(request.getParameter("method"));
String projid=Util.null2String(request.getParameter("projid"));
if(method.equals("add"))
{
	String stoneid=Util.null2String(request.getParameter("stoneid"));
	String attentorder=Util.null2o(request.getParameter("attentorder"));
	String attentcontent=Util.null2String(request.getParameter("attentcontent"));
	String attentreason=Util.null2String(request.getParameter("attentreason"));  
	 
	RecordSet.executeSql("insert into wasu_projAttention(projid,stoneid,attentorder,attentcontent,attentreason) values("+projid+","+stoneid+","+attentorder+",'"+attentcontent+"','"+attentreason+"')");
    
	response.sendRedirect("/project/ProjAttentionlist.jsp?projid="+projid);
	return;
}

String stoneids[]=request.getParameterValues("attentionids");  
if(method.equals("delete")){

	if(stoneids != null)
	{
		for(int i=0;i<stoneids.length;i++)
		{
			ProcPara = stoneids[i]; 
            if (!ProcPara.equals("")) { 
                RecordSet.executeSql(" delete from wasu_projAttention where id="+ProcPara);  
            }  
		}
	}  
	response.sendRedirect("/project/ProjAttentionlist.jsp?projid="+projid);
	return;
}

if(method.equals("edit"))
{    
	String id=Util.null2String(request.getParameter("id")); 
	String stoneid=Util.null2String(request.getParameter("stoneid"));
	String attentorder=Util.null2o(request.getParameter("attentorder"));
	String attentcontent=Util.null2String(request.getParameter("attentcontent"));
	String attentreason=Util.null2String(request.getParameter("attentreason"));  
	 
	RecordSet.executeSql(" update wasu_projAttention set stoneid="+stoneid+",attentorder="+attentorder+",attentcontent='"+attentcontent+"',attentreason='"+attentreason+"' where id="+id); 
	response.sendRedirect("/project/ProjAttentionlist.jsp?projid="+projid); 
	return;
}

%>
