<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util,weaver.docs.docs.CustomFieldManager" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%

	String[] ids = request.getParameterValues("keyID");//����ID
	String[] description = request.getParameterValues("description");// ����
	String[] statDate = request.getParameterValues("statDate");//��ʼʱ��
	String[] isOK = request.getParameterValues("isOK");//�Ƿ���
	String[] terms = request.getParameterValues("terms");//�������
	String[] productVersionID = request.getParameterValues("productVersionID");//��Ʒ��
	String[] ProjID = request.getParameterValues("ProjID");//����ĿID
	String[] isDelete = request.getParameterValues("isDelete");//ɾ����ʶ
	
	String productVersionID_1  = request.getParameter("productVersionID_1");
	String ProjID_1  = request.getParameter("productVersionID_1");

	String sql = "";
	if(ids != null && ids.length > 0){
		for(int i = 0;i < ids.length ; i++){
			if("-1".equals(ids[i]) && "1".equals(isDelete[i])){//����ӵ��ұ�ɾ���ˣ��������κβ���
				continue;
			}else if("-1".equals(ids[i]) && "0".equals(isDelete[i])){//����ӵ���ɾ����־Ϊ�񣬽�����Ӳ���
				String question_id = "";
				sql = "INSERT INTO questionInfo (description,statDate,isOK,terms,productVersionID,ProjID,description1) VALUES ('" + description[i] + "','" + statDate[i] + "','" + isOK[i] + "','" + terms[i] + "','" + productVersionID[i] + "','" + ProjID[i] + "','" + description[i] + "')";
				RecordSet.executeSql(sql);
				//ȡ�����ID�������ƷĿ�������
				sql = "select max(id) as id from questioninfo";
				RecordSet.executeSql(sql);
				if(RecordSet.next()){
				 	 question_id = RecordSet.getString("id");
				}
				sql = "INSERT INTO produceQuestion (description,statDate,isOK,terms,productVersionID,ProjID,description1,questioninfo_id,isShow) VALUES ('" + description[i] + "','" + statDate[i] + "','" + isOK[i] + "','" + terms[i] + "','" + productVersionID[i] + "','" + ProjID[i] + "','" + description[i] + "','"+question_id+"','0')";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "1".equals(isDelete[i])) {//�Ѵ��ڵļ�¼��ɾ����־Ϊ�ǣ�����ɾ������
				sql = "DELETE from questionInfo WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
				//����ƷĿ�����������ڱ�Ϊ�߼�ɾ��
				sql = "update produceQuestion set isShow = '1' where questioninfo_id = '"+ids[i]+"'";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "0".equals(isDelete[i])) {//�Ѵ��ڵļ�¼��ɾ����־Ϊ�񣬽����޸Ĳ���
				sql = "UPDATE questionInfo SET description = '" + description[i] + "',statDate = '" + statDate[i] + "',isOK = '" + isOK[i] + "',terms = '" + terms[i] + "' WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
				//ͬʱ���²�ƷĿ�������
				sql = "UPDATE produceQuestion SET description = '" + description[i] + "',statDate = '" + statDate[i] + "',isOK = '" + isOK[i] + "',terms = '" + terms[i] + "' WHERE questioninfo_id = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
			}
		}
	}

	if(ids != null && ids.length > 0){
		response.sendRedirect("QuestionAdd.jsp?productVersionID="+productVersionID[0]+"&ProjID="+ProjID[0]) ;
	}else{
		response.sendRedirect("QuestionAdd.jsp?productVersionID="+productVersionID_1+"&ProjID="+ProjID_1) ;
	}
		
%>

