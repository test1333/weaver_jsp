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
	String[] content = request.getParameterValues("content");//�������
	String[] changeUSER = request.getParameterValues("changeUSER");//�����
	String[] changeData = request.getParameterValues("changeData");//���ʱ��
	String[] productVersionID = request.getParameterValues("productVersionID");//��Ʒ��
	String[] isDelete = request.getParameterValues("isDelete");//ɾ����ʶ

	String sql = "";
	if(ids != null && ids.length > 0){
		for(int i = 0;i < ids.length ; i++){
			if("-1".equals(ids[i]) && "1".equals(isDelete[i])){//����ӵ��ұ�ɾ���ˣ��������κβ���
				continue;
			}else if("-1".equals(ids[i]) && "0".equals(isDelete[i])){//����ӵ���ɾ����־Ϊ�񣬽�����Ӳ���
				sql = "INSERT INTO Productchange (description,content,changeUSER,changeData,productVersionID,description1,isShow) VALUES ('" + description[i] + "','" + content[i] + "','" + changeUSER[i] + "','" + changeData[i] + "','" + productVersionID[i] + "','" + description[i] + "','0')";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "1".equals(isDelete[i])) {//�Ѵ��ڵļ�¼��ɾ����־Ϊ�ǣ�����ɾ������
				sql = "DELETE from Productchange WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "0".equals(isDelete[i])) {//�Ѵ��ڵļ�¼��ɾ����־Ϊ�񣬽����޸Ĳ���
				sql = "UPDATE Productchange SET description = '" + description[i] + "',content = '" + content[i] + "',changeUSER = '" + changeUSER[i] + "',changeData = '" + changeData[i] + "' WHERE id = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
			}
		}
	}

	response.sendRedirect("ProductAdd.jsp?id="+productVersionID[0]) ;
		
%>

