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
				String change_id = "";
				sql = "INSERT INTO changeInfo (description,content,changeUSER,changeData,productVersionID,ProjID,description1) VALUES ('" + description[i] + "','" + content[i] + "','" + changeUSER[i] + "','" + changeData[i] + "','" + productVersionID[i] + "','" + ProjID[i] + "','" + description[i] + "')";
				RecordSet.executeSql(sql);
				//ȡ�����ID�������ƷĿ������
				sql = "select max(id) as id from changeInfo";
				RecordSet.executeSql(sql);
				if(RecordSet.next()){
					change_id = RecordSet.getString("id");
				}
				sql = "INSERT INTO Productchange (description,content,changeUSER,changeData,productVersionID,ProjID,description1,changeinfo_id,isShow) VALUES ('" + description[i] + "','" + content[i] + "','" + changeUSER[i] + "','" + changeData[i] + "','" + productVersionID[i] + "','" + ProjID[i] + "','" + description[i] + "','"+change_id+"','0')";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "1".equals(isDelete[i])) {//�Ѵ��ڵļ�¼��ɾ����־Ϊ�ǣ�����ɾ������
				sql = "DELETE from changeInfo WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
				//����ƷĿ����������ڱ�Ϊ�߼�ɾ��
				sql = "update Productchange set isShow = '1' where changeinfo_id = '"+ids[i]+"'";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "0".equals(isDelete[i])) {//�Ѵ��ڵļ�¼��ɾ����־Ϊ�񣬽����޸Ĳ���
				sql = "UPDATE changeInfo SET description = '" + description[i] + "',content = '" + content[i] + "',changeUSER = '" + changeUSER[i] + "',changeData = '" + changeData[i] + "' WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
				//ͬʱ���²�ƷĿ�������
				sql = "UPDATE Productchange SET description = '" + description[i] + "',content = '" + content[i] + "',changeUSER = '" + changeUSER[i] + "',changeData = '" + changeData[i] + "' WHERE changeinfo_id = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
			}
		}
	}

	if(ids != null && ids.length > 0){
		response.sendRedirect("ProduceChangeAdd.jsp?productVersionID="+productVersionID[0]+"&ProjID="+ProjID[0]) ;
	}else{
		response.sendRedirect("ProduceChangeAdd.jsp?productVersionID="+productVersionID_1+"&ProjID="+ProjID_1) ;
	}	
%>

