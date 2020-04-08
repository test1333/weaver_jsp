<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
int userid=user.getUID();
String loca=Util.null2String(request.getParameter("loca"),"1");
String sql = "select name from nickname where userid = "+userid;
rs.executeQuery(sql);
boolean hasnickname = false;
if(rs.getCounts()>0){
 hasnickname = true;
}

if(!hasnickname) {
  response.sendRedirect("/cowork/nickname/coworknicknameview.jsp?loca="+loca) ;
   return ;
}else{
	String url="";
	if("1".equals(loca)){
		url="/spa/cowork/static/index.html#/main/cowork/main";//协作交流
	}else if("2".equals(loca)){
		url="/spa/cowork/static/index.html#/main/cowork/relateMe";//与我相关
	}else if("3".equals(loca)){
		url="/spa/cowork/static/index.html#/main/cowork/mine";//我的帖子
	}else if("4".equals(loca)){
		url="/spa/cowork/static/index.html#/main/cowork/collect";//收藏的帖子
	}else if("5".equals(loca)){
		url="/spa/cowork/static/index.html#/main/cowork/itemApproval";//主题审批
	}else if("6".equals(loca)){
		url="/spa/cowork/static/index.html#/main/cowork/discussApproval";//内容审批
	}else if("7".equals(loca)){
		url="/spa/cowork/static/index.html#/main/cowork/apply";//协作申请
	}else if("8".equals(loca)){
		url="/spa/cowork/static/index.html#/main/cowork/itemMonitor";//主题监控
	}else if("9".equals(loca)){
		url="/spa/cowork/static/index.html#/main/cowork/discussMonitor";//内容监控
	}else if("10".equals(loca)){
		url="/spa/cowork/index.html#/main/cowork/commentMonitor";//评论监控
	}
	 response.sendRedirect(url);
}


	
%>