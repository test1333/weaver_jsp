
<%@page import="weaver.crm.customer.CustomerShareUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="weaver.cowork.CoworkDiscussVO"%>
<%@page import="weaver.systeminfo.setting.HrmUserSettingComInfo"%>
<%@page import="weaver.systeminfo.setting.HrmUserSettingHandler" %>
<%@page import="weaver.systeminfo.setting.HrmUserSetting" %>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.general.TimeUtil"%>
<%@page import="weaver.cowork.CoworkShareManager"%>
<%@page import="weaver.email.MailCommonUtils"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.io.*" %>
<%@ page import="weaver.Constants" %>
<%@ page import="weaver.domain.workplan.WorkPlan" %>
<%@ page import="weaver.WorkPlan.WorkPlanHandler" %>
<%@ page import="weaver.WorkPlan.WorkPlanLogMan" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="weaver.cowork.CoworkDAO" %>
<jsp:useBean id="cs" class="weaver.conn.ConnStatement" scope="page" />

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetTrans" class="weaver.conn.RecordSetTrans" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="CoworkDao" class="weaver.cowork.CoworkDAO" scope="page"/>
<jsp:useBean id="workPlanService" class="weaver.WorkPlan.WorkPlanService" scope="page"/>
<jsp:useBean id="CoTypeComInfo" class="weaver.cowork.CoTypeComInfo" scope="page" />
<jsp:useBean id="csm" class="weaver.cowork.CoworkShareManager" scope="page" />
<jsp:useBean id="CoworkService" class="weaver.cowork.CoworkService" scope="page" />
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page" />

<%
 
FileUpload fu = new FileUpload(request);
String operation = Util.fromScreen(fu.getParameter("method"),user.getLanguage());
String name = Util.fromScreen(fu.getParameter("name"),user.getLanguage()).trim();
String id = Util.null2String(fu.getParameter("id"));   
String loca = Util.null2String(fu.getParameter("loca"));   
String coworkid = Util.null2String(fu.getParameter("coworkid"));
String userid = user.getUID()+"";

//new BaseBean().writeLog(name+"--"+operation);
 
if(operation.equals("addname")){ //添加昵称
	String date = MailCommonUtils.getTodaySendDate();
	String sql="insert into nickname(userid,name,registtime) values"+
	"("+userid+",'"+name+"','"+date+"')";
	RecordSet.execute(sql);
	sql = "select id from nickname where userid = ?";
	RecordSet.executeQuery(sql,userid);
	while(RecordSet.next()){
		id = RecordSet.getString("id");
	}
	sql="insert into nicknameLog(operator,name,edittime,nicknameid,etype) values"+
	"("+userid+",'"+name+"','"+date+"',"+id+",1)";
	RecordSet.execute(sql);
	
	String url = "";
	if("1".equals(loca)){
		url="/cowork/coworkview.jsp";
	}else if("2".equals(loca)){
		url="/cowork/CoworkRelatedFrame.jsp";
	}else if("3".equals(loca)){
		url="/ cowork/CoworkMineFrame.jsp";
	}else if("4".equals(loca)){
		url="/cowork/CoworkCollectFrame.jsp";
	}else if("5".equals(loca)){
		url="/cowork/coworkview.jsp?jointype=5";
	}else if("6".equals(loca)){
		url="/cowork/coworkview.jsp?menuType=contentApproval";
	}else if("7".equals(loca)){
		url="/cowork/CoworkApplyFrame.jsp";
	}else if("8".equals(loca)){
		url="/cowork/coworkview.jsp?menuType=themeMonitor";
	}else if("9".equals(loca)){
		url="/cowork/coworkview.jsp?menuType=contentMonitor";
	}else if("10".equals(loca)){
		url="/cowork/coworkview.jsp?menuType=commetMonitor";
	}else if("11".equals(loca)){
		url="/cowork/CoworkCotypeApproveFrame.jsp";
	}else if("12".equals(loca)){
		url="/cowork/nickname/CoworkNicknameList.jsp";
	}else if("13".equals(loca)){
		url="/cowork/ViewCoWork.jsp?id="+coworkid;
	}else if("14".equals(loca)){
		url="/cowork/CoworkTabFrame.jsp";
	}else if("15".equals(loca)){
		url="/cowork/CoworkHrmViewFrame.jsp?searchHrmid="+userid;
	}else if("99".equals(loca)){
		url="/gvo/cowork/co-portal.jsp";
	}
 out.print("<script>window.parent.location.href='"+url+"'</script>");

}
else if(operation.equals("checkname")){//检查昵称是否已存在
	String sql = "select * from nickname where name = ?";
	RecordSet.executeQuery(sql,name);
	boolean isexist = false;
	String table = new BaseBean().getPropValue("CoworkNickname", "table");
	 
	if(RecordSet.next()){
		isexist = true;
	}
	new BaseBean().writeLog(isexist);
	 if(isexist){
			out.println("1");		     	       
		}else{			
			//检查敏感词	
			sql = "select type,content from "+table+" where enabled=0 ";
			RecordSet.execute(sql);
			boolean hasmingan = false;
			String hasminganname = "";
			while(RecordSet.next()){
				String type = RecordSet.getString("type");
				String content = RecordSet.getString("content");
				if("1".equals(type)){
					if(name.indexOf(content)!=-1){
						hasmingan = true;
						hasminganname = content;
					    	break;
					}
				}
			}
			if(hasmingan){
				//out.println("3"); 
				out.println("您注册的昵称中包含不合法内容【"+hasminganname+"】，请您修改！");
			}else{
				out.println("2");
			}	
		}
	 return;
}else if(operation.equals("editname")){
	String date = MailCommonUtils.getTodaySendDate();
	String sql="insert into nicknameLog(operator,name,edittime,nicknameid,etype) values"+
	"("+userid+",'"+name+"','"+date+"',"+id+",2)";
	RecordSet.execute(sql);
	sql = "update nickname set name = ? where id = ?";
	RecordSet.executeUpdate(sql,name,id);
	//out.print("<script>window.parent.location.reload();</script>");
	out.println("<script>window.parent.MainCallback();</script>");
}
%>