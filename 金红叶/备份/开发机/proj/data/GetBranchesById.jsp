<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.resource.ResourceComInfo"%>
<%@ page import="weaver.hrm.company.SubCompanyComInfo"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>

<%
String peopleIds = request.getParameter("peopleId");
//System.out.println("===============:"+peopleIds);
String id[] = peopleIds.split(",");
ResourceComInfo rs = new ResourceComInfo();
String branches = "";
SubCompanyComInfo sc = new SubCompanyComInfo();
String string = "";
for(int i=0; i<id.length;i++){ 
   String branchId = rs.getSubCompanyID(id[i]);
   //System.out.println("branchId++++++:"+branchId);
   String branchName = sc.getSubCompanyname(branchId);
   //System.out.println("+++++branchName++++++++"+branchName);;
  /* branches += "<span class='e8_showNameClass'>" +
			   "<a href='/hrm/company/HrmSubCompanyDsp.jsp?id="+branchId+"' target='_blank' title="+branchName+">"+branchName+"</a>" +
			   "<span id="+branchId+" class='e8_delClass' style='visibility: hidden; opacity: 1;'>x</span>" +
			   "</span>";*/
 
     //jsonObject.add(branchId,branchName);
     if(i==0){
      string += branchId+","+branchName;
     }else{
      string += ","+branchId+","+branchName; 
      }         			   			   
}
out.clear();
out.println(string);
%>