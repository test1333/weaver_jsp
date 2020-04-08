<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String typeid=Util.null2String(request.getParameter("typeid"),"-1");
//String coworkids = "";
//String sql = "select wm_concat(id)  as coworkids from COWORK_ITEMS where typeid='"+typeid+"'";
//rs.execute(sql);
//if(rs.next()){
//	coworkids = Util.null2String(rs.getString("coworkids"));
//}
//if(!"".equals(coworkids)){
//	response.sendRedirect("/spa/cowork/static/index.html#/main/cowork/main?coworkids="+coworkids) ;
//	return;
//}else{
//	response.sendRedirect("/spa/cowork/static/index.html#/main/cowork/main?coworkids=-1");
//	return;
//}

  

	
%>
<script type="text/javascript">
var typeid = "<%=typeid%>";
var coworkids="";
var firstid ="";
var flag = "";
jQuery.ajax({
                    type: "GET",
                    url: "/api/cowork/base/getCoworkList?type=all&labelid=allTab&orderType=important&layout=1&mainid=&pagesize=1000&pageNum=1&name=&typeid="+typeid+"&status=1&jointype=0&principal=&creater=&viewType=0&datetype=0",
                    data: {},
                    dataType: "text",
                    async:false,//同步 true异步
                    success: function(data){
                                data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
								var json = JSON.parse(data);
								var jsonarr=json.coworkList;
								 for(var index=0;index<jsonarr.length;index++){
									 var obj = jsonarr[index];
									 var coworkid=obj.coworkid;
									 if(firstid == ""){
										 firstid = coworkid;
									 }
									 coworkids = coworkids+flag+coworkid;
									 flag=",";

								 }
                            }
                    
                });
if(coworkids !=""){
	window.location.href="/spa/cowork/static/index.html#/main/cowork/main/"+firstid+"?coworkids="+coworkids;
}else{
	window.location.href="/spa/cowork/static/index.html#/main/cowork/main";
}

</script>