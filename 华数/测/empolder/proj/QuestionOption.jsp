<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util,weaver.docs.docs.CustomFieldManager" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%

	String[] ids = request.getParameterValues("keyID");//主键ID
	String[] description = request.getParameterValues("description");// 描述
	String[] statDate = request.getParameterValues("statDate");//开始时间
	String[] isOK = request.getParameterValues("isOK");//是否解决
	String[] terms = request.getParameterValues("terms");//解决方法
	String[] productVersionID = request.getParameterValues("productVersionID");//产品线
	String[] ProjID = request.getParameterValues("ProjID");//子项目ID
	String[] isDelete = request.getParameterValues("isDelete");//删除标识
	
	String productVersionID_1  = request.getParameter("productVersionID_1");
	String ProjID_1  = request.getParameter("productVersionID_1");

	String sql = "";
	if(ids != null && ids.length > 0){
		for(int i = 0;i < ids.length ; i++){
			if("-1".equals(ids[i]) && "1".equals(isDelete[i])){//新添加的且被删除了，不进行任何操作
				continue;
			}else if("-1".equals(ids[i]) && "0".equals(isDelete[i])){//新添加的且删除标志为否，进行添加操作
				String question_id = "";
				sql = "INSERT INTO questionInfo (description,statDate,isOK,terms,productVersionID,ProjID,description1) VALUES ('" + description[i] + "','" + statDate[i] + "','" + isOK[i] + "','" + terms[i] + "','" + productVersionID[i] + "','" + ProjID[i] + "','" + description[i] + "')";
				RecordSet.executeSql(sql);
				//取出最大ID，插入产品目标问题表
				sql = "select max(id) as id from questioninfo";
				RecordSet.executeSql(sql);
				if(RecordSet.next()){
				 	 question_id = RecordSet.getString("id");
				}
				sql = "INSERT INTO produceQuestion (description,statDate,isOK,terms,productVersionID,ProjID,description1,questioninfo_id,isShow) VALUES ('" + description[i] + "','" + statDate[i] + "','" + isOK[i] + "','" + terms[i] + "','" + productVersionID[i] + "','" + ProjID[i] + "','" + description[i] + "','"+question_id+"','0')";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "1".equals(isDelete[i])) {//已存在的记录且删除标志为是，进行删除操作
				sql = "DELETE from questionInfo WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
				//将产品目标问题表的属于变为逻辑删除
				sql = "update produceQuestion set isShow = '1' where questioninfo_id = '"+ids[i]+"'";
				RecordSet.executeSql(sql);
			}else if(!"-1".equals(ids[i]) && "0".equals(isDelete[i])) {//已存在的记录且删除标志为否，进行修改操作
				sql = "UPDATE questionInfo SET description = '" + description[i] + "',statDate = '" + statDate[i] + "',isOK = '" + isOK[i] + "',terms = '" + terms[i] + "' WHERE ID = '" + ids[i] + "'";
				RecordSet.executeSql(sql);
				//同时更新产品目标问题表
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

