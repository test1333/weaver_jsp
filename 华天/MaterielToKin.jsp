<%@ page import="weaver.general.Util" %>
<%@ page import="htkj.materiel.AddMaterielToKin" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
   BaseBean log = new BaseBean();
    String qj_id =  Util.null2String(request.getParameter("id"));
	String lhs =  Util.null2String(request.getParameter("lhs"));
	String lsms =  Util.null2String(request.getParameter("lsms"));
	String checks = Util.null2String(request.getParameter("checks"));
	String arr[] = qj_id.split("###");
	String arr3[] = lsms.split("###");
	StringBuffer sb = new StringBuffer();
	StringBuffer sb1 = new StringBuffer();
	StringBuffer sb2 = new StringBuffer();
	StringBuffer sb3 = new StringBuffer();
	AddMaterielToKin amt = new AddMaterielToKin();
	for(int i=0;i<arr.length;i++){
		int count = amt.hasFParentID(arr[i]);
		if(count == 0){
			sb.append(arr[i]+"  ");
		}
    }
	if(!"".equals(sb.toString())){
		sb.append("\n以上最小分类不存在。\n");
	}
	for(int i=0;i<arr3.length;i++){
		int count = amt.checkzxfl(arr3[i]);
	   if(count > 0){
			sb3.append(arr3[i]+"  ");
		}
    }
	if(!"".equals(sb3.toString())){
		sb3.append("\n以上最小分类+流水码重复。\n");
		sb.append(sb3.toString());
	}
    if(!"false".equals(lhs)&&!"".equals(lhs)){
		String arr1[] = lhs.split("###");
		for(int i=0;i<arr1.length;i++){
			int count = amt.hasLHID(arr1[i]);
			if(count > 0){
				sb1.append(arr1[i]+"  ");
			}
		}
		if(!"".equals(sb1.toString())){
			sb1.append("\n以上料号已存在。");
		}
		sb.append(sb1.toString());
    }
	if(!"false".equals(checks)){
		String arr2[] = checks.split("###");
		for(int i=0;i<arr2.length;i++){
			String check[] = arr2[i].split("##");
			if(check.length>=3){
				int count = amt.checkData(check[0],check[1],check[2]);
				if(count > 0){
					sb2.append("\n第"+(i+1)+"行明细品名、型号、规格组合存在");
				}
			}
		}
		sb.append(sb2.toString());
	}
	out.print(sb.toString());
%>