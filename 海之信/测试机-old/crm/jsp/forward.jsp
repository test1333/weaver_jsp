<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ page import="weaver.general.Util"%>
<%@ page import="seahonor.action.custom.EditCustom"%>
<%@ page import="seahonor.action.custom.EditContact"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>	
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	
	String typex = Util.null2String(request.getParameter("typex"));
	String resArr[] = typex.split(",");
	String type="";
	String xgid="";
	String xgseq="";
	String requestid="";
    if(resArr.length > 0) {
		type = resArr[0];
	}
		
	if(resArr.length > 1) {
		xgid = resArr[1];
	}
	
	if(resArr.length > 2) {
		xgseq = resArr[2];
	}
	if(resArr.length > 3) {
		requestid = resArr[3];
	}
	int userid  = user.getUID();
    String falg="0";
	
	 if("editcustom".equals(type)){
       EditCustom ec= new EditCustom();
	   String billid1=ec.getID(xgid,xgseq);
	   String cur_node = "";
		String sql =  "select nodeid from workflow_currentoperator where id"
			+" in(select max(id) from workflow_currentoperator where isremark in(0,2,4) and requestid="+requestid+")" ;
		RecordSet.executeSql(sql);
		if(RecordSet.next()) {
		cur_node = Util.null2String(RecordSet.getString("nodeid"));
		}
		if(requestid.length() > 1){
			sql =  "select nodeid from workflow_currentoperator where id in("
			+"select max(id) from workflow_currentoperator where isremark in(0,2) and requestid="+requestid + " and  userid =" + userid+")";
		
			RecordSet.executeSql(sql);
			if(RecordSet.next()) {
				String tmp_nodeID = Util.null2String(RecordSet.getString("nodeid"));
				if(tmp_nodeID.equals(cur_node)){
					falg = "1";
				}else{
					falg = "0";
				}		   	
			}
		}else{
			falg = "1";
		}
		if("1".equals(falg)){
		 response.sendRedirect("/formmode/view/AddFormMode.jsp?mainid=0&modeId=172&formId=-298&type=2&Id=768&billid="+billid1);  
		}else{
		 response.sendRedirect("/formmode/view/AddFormMode.jsp?mainid=0&modeId=172&formId=-298&type=0&Id=768&billid="+billid1);  	
		}
	}

	if("editcontact".equals(type)){
       EditContact ec= new EditContact();
	   String billid1=ec.getID(xgid,xgseq);
	   String cur_node = "";
		String sql =  "select nodeid from workflow_currentoperator where id"
			+" in(select max(id) from workflow_currentoperator where isremark in(0,2,4) and requestid="+requestid+")" ;
		RecordSet.executeSql(sql);
		if(RecordSet.next()) {
		cur_node = Util.null2String(RecordSet.getString("nodeid"));
		}
		if(requestid.length() > 1){
			sql =  "select nodeid from workflow_currentoperator where id in("
			+"select max(id) from workflow_currentoperator where isremark in(0,2) and requestid="+requestid + " and  userid =" + userid+")";
		
			RecordSet.executeSql(sql);
			if(RecordSet.next()) {
				String tmp_nodeID = Util.null2String(RecordSet.getString("nodeid"));
				if(tmp_nodeID.equals(cur_node)){
					falg = "1";
				}else{
					falg = "0";
				}		   	
			}
		}else{
			falg = "1";
		}
		if("1".equals(falg)){
		 response.sendRedirect("/formmode/view/AddFormMode.jsp?mainid=0&modeId=173&formId=-299&type=2&Id=771&billid="+billid1);  
		}else{
		 response.sendRedirect("/formmode/view/AddFormMode.jsp?mainid=0&modeId=173&formId=-299&type=0&Id=771&billid="+billid1);  	
		}
	}
	

%>