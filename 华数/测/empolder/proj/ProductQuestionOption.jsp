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
	String[] isDelete = request.getParameterValues("isDelete");//ɾ����ʶ

	String sql = "";
	if(ids != null && ids.length > 0){
		for(int i = 0;i < ids.length ; i++){
			if("-1".equals(ids[i]) && "1".equals(isDelete[i])){//����ӵ��ұ�ɾ���ˣ��������κβ���
				continue;
			}else if("-1".equals(ids[i]) && "0".equals(isDelete[i])){//����ӵ���ɾ����־Ϊ�񣬽�����Ӳ���
				sql = "INSERT INTO produceQuestion (description,statDate,isOK,terms,productVersionID,description1,isShow) VALUES ('" + description[i] + "','" + statDate[i] + "','" + isOK[i] + "','" + terms[i] + "','" + productVersionID[i] + "','" + description[i] + "','0')";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "1".equals(isDelete[i])) {//�Ѵ��ڵļ�¼��ɾ����־Ϊ�ǣ�����ɾ������
				sql = "DELETE from produceQuestion WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "0".equals(isDelete[i])) {//�Ѵ��ڵļ�¼��ɾ����־Ϊ�񣬽����޸Ĳ���
				sql = "UPDATE produceQuestion SET description = '" + description[i] + "',statDate = '" + statDate[i] + "',isOK = '" + isOK[i] + "',terms = '" + terms[i] + "' WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
			}
		}
	}
	response.sendRedirect("ProductAdd.jsp?id="+productVersionID[0]) ;
		
%>

