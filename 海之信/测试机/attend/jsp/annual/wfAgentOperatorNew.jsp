<%@ page language="java" contentType="text/html; charset=UTF-8" %>
 <%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.workflow.request.RequestAddShareInfo"%>
<%@page import="weaver.workflow.workflow.WorkflowVersion" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs3" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs4" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs5" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs6" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs7" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RequestCheckUser" class="weaver.workflow.request.RequestCheckUser" scope="page" />
<jsp:useBean id="DocViewer" class="weaver.docs.docs.DocViewer" scope="page" />
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page" />
<jsp:useBean id="wfAgentCondition" class="weaver.workflow.request.wfAgentCondition" scope="page" />

<%
/*
* last modified by cyril on 2008-08-25 for td:9236
* 流程代理的优化

*/
int agentId = 0;
boolean flag = true; 
String method=request.getParameter("method");
String beagenterId2=request.getParameter("beagenterId");
String haveAgentAllRight = request.getParameter("haveAgentAllRight");
String sql = "";
String currentDate=TimeUtil.getCurrentDateString();
String currentTime=(TimeUtil.getCurrentTimeString()).substring(11,19);
String[] value;
String[] value1;
String isCountermandRunning="";
String beaid="";
String aid="";
String wfid="";
char separ = Util.getSeparator();
String Procpara = "";
/*-----------------  流程代理设置 ---[老的代理目前暂时不用]-------------------- */
/*----------- td2551 xwj 20050902 begin ----*/
int isPendThing=Util.getIntValue(request.getParameter("isPendThing"),0);
int usertype = Util.getIntValue(request.getParameter("usertype"), 0);
//e8 新改造后收回代理的逻辑
 if(method.equals("backAgent"))
{
	String agented = Util.null2String(request.getParameter("agented"));
	String agentFlag = Util.null2String(request.getParameter("agentFlag"));
	String agenttype = Util.null2String(request.getParameter("agenttype"));
	isCountermandRunning=Util.null2String(request.getParameter("isCountermandRunning"));
	String agentids = Util.null2String(request.getParameter("agentid"));
	String agentid = "";
	
	System.out.println("====agenttype:"+agenttype);
	//单条代理收回
	if(agenttype.equals("it") || agenttype.equals("mt"))
	{
		if(agenttype.equals("mt")){
			agentids = agentids.substring(0,agentids.length()-1);
		}
		rs7.executeSql("select * from workflow_agent where agentid in (" + agentids+")");
		while(rs7.next()){
			beaid = rs7.getString("beagenterid");
			aid = rs7.getString("agenterid");
			wfid= rs7.getString("workflowid");
			agentid = rs7.getString("agentid");
		 
			try{
				 String sqlconditset="update workflow_agentConditionSet set agenttype = '0' ,backDate='"+currentDate+"',backTime='"+currentTime+"' where agentid ='"+agentid+"'";
				 rs5.executeSql(sqlconditset);
				 
				//设置无效状态

				rs5.executeSql("update workflow_agent set agenttype = '0',backDate='"+currentDate+"',backTime='"+currentTime+"' where agentid = " + agentid);
				//modify by mackjoe at 2005-09-14 创建权限移至新建流程页面处理
				//收回流转中的代理 //对于老数据不做处理, 当一个代理人又是操作者本身时很难区分 TODO
				if("y".equals(isCountermandRunning)){
					rs6.executeSql("select agentuid from workflow_agentConditionSet where agentid in (" + agentid+")  ");
					//将所有收回

				    while(rs6.next()){
				    	aid=Util.getIntValues(rs6.getString("agentuid"));
					 	String updateSQL = "";
					 	String versionsIds =  WorkflowVersion.getAllVersionStringByWFIDs("" + wfid);
					 	sql= "select * from workflow_currentoperator where isremark in ('0','1','5','7','8','9') and userid = " + aid + " and agentorbyagentid = " + beaid + " and agenttype = '2' and workflowid in (" + versionsIds + ")";//td2302 xwj
						//System.out.println("==============================sql="+ sql);
					 	rs1.executeSql(sql);//td2302 xwj
					 	while(rs1.next()){
							int wfcoid = Util.getIntValue(rs1.getString("id"));
					   		String tmprequestid=rs1.getString("requestid");
					   		String tmpisremark=rs1.getString("isremark");
					   		int tmpgroupid=rs1.getInt("groupid");
					   		int currentnodeid = rs1.getInt("nodeid");//流程当前所在节点

					   		int tmpuserid=rs1.getInt("userid");
					  		String tmpusertype=rs1.getString("usertype");
					   		int tmppreisremark=Util.getIntValue(rs1.getString("preisremark"),0);
							int upcoid = 0;
							rs2.execute("select id from workflow_currentoperator where requestid = " + tmprequestid + " and isremark = '2' and userid = " + rs1.getString("agentorbyagentid") + " and agenttype = '1'  and agentorbyagentid = " + tmpuserid+" and usertype=0 and groupid="+tmpgroupid+" and nodeid="+currentnodeid);
							if(rs2.next()){
								upcoid = Util.getIntValue(rs2.getString("id"), 0);
								updateSQL = "update workflow_currentoperator set isremark = '" + tmpisremark + "',preisremark='"+tmppreisremark+"', agenttype ='0', agentorbyagentid = -1  where id = " + upcoid;
								//应该只更新当前节点的代理关系，已经经过的节点不用更新
								rs2.executeSql(updateSQL);  //被代理人重新获得任务
								//失效的代理人删除
								rs2.executeSql("delete workflow_currentoperator where id="+wfcoid);//td2302 xwj
								rs2.executeSql("update workflow_forward set beforwardid = " + upcoid + " where requestid="+tmprequestid+" and beforwardid="+wfcoid);
								rs2.executeSql("update workflow_forward set forwardid = " + upcoid + " where requestid="+tmprequestid+" and forwardid="+wfcoid);
							}
					   		PoppupRemindInfoUtil.updatePoppupRemindInfo(tmpuserid,10,tmpusertype,Util.getIntValue(tmprequestid));
					   		PoppupRemindInfoUtil.updatePoppupRemindInfo(tmpuserid,0,tmpusertype,Util.getIntValue(tmprequestid));
					   		//add by fanggsh 20060519 TD4346 begin 流程代理收回导致操作人查不到流程
					   		rs3.executeSql("select id from workflow_currentoperator where isremark in ('0','1','5','7','8','9') and requestid ="+tmprequestid+" and userid="+tmpuserid+" and usertype="+usertype+" order by id desc ");
					   		if(rs3.next()){
					       		rs2.executeSql("update workflow_currentoperator set islasttimes=1 where requestid=" +tmprequestid + " and userid=" + tmpuserid + " and id = " + rs3.getString("id"));
					   		}
					   		//add by fanggsh 20060519 TD4346 end
		
					   		//回收代理人文档权限

					   		rs2.executeSql("select distinct docid,sharelevel from Workflow_DocShareInfo where requestid="+tmprequestid+" and userid="+aid+" and beAgentid="+beaid);
					   		boolean hasrow=false;
					   		ArrayList docslist=new ArrayList();
					   		ArrayList sharlevellist=new ArrayList();
					   		while(rs2.next()){
					       		hasrow=true;
					       		docslist.add(rs2.getString("docid"));
					       		sharlevellist.add(rs2.getString("sharelevel"));
					   		}
					   		if(hasrow){
					       		rs2.executeSql("delete Workflow_DocShareInfo where requestid="+tmprequestid+" and userid="+aid+" and beAgentid="+beaid);
					   		}
					   		for(int j=0;j<docslist.size();j++){
					       		rs3.executeSql("select Max(sharelevel) sharelevel from Workflow_DocShareInfo where docid="+docslist.get(j)+" and userid="+aid);
					       		if(rs3.next()){
					          		int sharelevel=Util.getIntValue(rs3.getString("sharelevel"),0);
					          		if(sharelevel>0){
					              		rs.executeSql("update DocShare set sharelevel="+sharelevel+" where sharesource=1 and docid="+docslist.get(j)+" and userid="+aid+" and sharelevel>"+sharelevel);
					          		}else{
					              		rs.executeSql("delete DocShare where sharesource=1 and docid="+docslist.get(j)+" and userid="+aid);
					          		}
					       		}else{
					          		rs.executeSql("delete DocShare where sharesource=1 and docid="+docslist.get(j)+" and userid="+aid);
					       		}
					       		//重新赋予被代理人文档权限
					       		rs.executeSql("update DocShare set sharelevel="+sharlevellist.get(j)+" where sharesource=1 and docid="+docslist.get(j)+" and userid="+beaid);
					       		DocViewer.setDocShareByDoc((String)docslist.get(j));
					   		}   
					   		//end by mackjoe
					  	}
				    }
				}
				//通过默认的工作流提醒 
				//TODO
			}catch(Exception e){
				flag = false;
			}
		}
		if(flag){
			response.sendRedirect("/workflow/request/wfAgentGetBackConfirm.jsp?agented="+agented+"&agentFlage="+agentFlag+"&infoKey=3&isclose=1");
			return;  //xwj for td3218 20051201
		}else{
			response.sendRedirect("/workflow/request/wfAgentGetBackConfirm.jsp?agented="+agented+"&agentFlage="+agentFlag+"&infoKey=4&isclose=1");
			return;  //xwj for td3218 20051201
		}
	}
	//全部收回逻辑
	else if(agenttype.equals("pt"))
	{
		isCountermandRunning=request.getParameter("isCountermandRunning");
		beaid=request.getParameter("beaid");
		aid=request.getParameter("aid");
		try{
			//收回流转中的代理 对于老数据不做处理, 当一个代理人又是操作者本身时很难区分
			if("y".equals(isCountermandRunning)){
				rs6.executeSql("select agentuid from workflow_agentConditionSet where bagentuid='"+beaid+"'  and  agentuid='"+aid+"' and agenttype=1 ");
				//将所有收回

				 while(rs6.next()){
			  		aid=Util.getIntValues(rs6.getString("agentuid"));
		 			String updateSQL = "";
		 			rs1.executeSql("select * from workflow_currentoperator where isremark in ('0','1','5','7','8','9')  and userid = " + aid + " and agentorbyagentid = " + beaid + " and agenttype = '2'");//td2302 xwj
				 		while(rs1.next()){
				   			int wfcoid = Util.getIntValue(rs1.getString("id"));
				   			String tmprequestid=rs1.getString("requestid");
				   			String tmpisremark=rs1.getString("isremark");
				   			int tmpgroupid=rs1.getInt("groupid");
				   			int currentnodeid = rs1.getInt("nodeid");//流程当前所在节点

				   			int tmpuserid=rs1.getInt("userid");
				   			String tmpusertype=rs1.getString("usertype");
				   			int tmppreisremark=Util.getIntValue(rs1.getString("preisremark"),0);
							int upcoid = 0;
							rs2.execute("select id from workflow_currentoperator where requestid = " + tmprequestid + " and isremark = '2' and userid = " + rs1.getString("agentorbyagentid") + " and agenttype = '1' and agentorbyagentid = " + tmpuserid +" and usertype=0 and groupid="+tmpgroupid+" and nodeid="+currentnodeid);
							if(rs2.next()){
								upcoid = Util.getIntValue(rs2.getString("id"));
								updateSQL = "update workflow_currentoperator set isremark = '" + tmpisremark + "',preisremark='"+tmppreisremark+"', agenttype ='0', agentorbyagentid = -1  where id="+upcoid;
								//应该只更新当前节点的代理关系，已经经过的节点不用更新
								rs2.executeSql(updateSQL);  //被代理人重新获得任务
								//失效的代理人删除
								rs2.executeSql("delete workflow_currentoperator where id="+wfcoid);//td2302 xwj
								rs2.executeSql("update workflow_forward set beforwardid = " + upcoid + " where requestid="+tmprequestid+" and beforwardid="+wfcoid);
								rs2.executeSql("update workflow_forward set forwardid = " + upcoid + " where requestid="+tmprequestid+" and forwardid="+wfcoid);
							}
					   		PoppupRemindInfoUtil.updatePoppupRemindInfo(tmpuserid,10,tmpusertype,Util.getIntValue(tmprequestid));
					   		PoppupRemindInfoUtil.updatePoppupRemindInfo(tmpuserid,0,tmpusertype,Util.getIntValue(tmprequestid));
					   		//add by fanggsh 20060519 TD4346 begin 流程代理收回导致操作人查不到流程
					   		rs3.executeSql("select id from workflow_currentoperator where requestid ="+tmprequestid+" and userid="+tmpuserid+" and usertype="+usertype+" order by id desc ");
					   		if(rs3.next()){
					       		rs2.executeSql("update workflow_currentoperator set islasttimes=1 where requestid=" +tmprequestid + " and userid=" + tmpuserid + " and id = " + rs3.getString("id"));
					   		}
					   		//add by fanggsh 20060519 TD4346 end
			
					   		//回收代理人文档权限

					   		rs2.executeSql("select distinct docid,sharelevel from Workflow_DocShareInfo where requestid="+tmprequestid+" and userid="+aid+" and beAgentid="+beaid);
					   		boolean hasrow=false;
					   		ArrayList docslist=new ArrayList();
					   		ArrayList sharlevellist=new ArrayList();
					   		while(rs2.next()){
					       		hasrow=true;
					       		docslist.add(rs2.getString("docid"));
					       		sharlevellist.add(rs2.getString("sharelevel"));
					   		}
					   		if(hasrow){
					       		rs2.executeSql("delete Workflow_DocShareInfo where requestid="+tmprequestid+" and userid="+aid+" and beAgentid="+beaid);
					   		}
					   		for(int j=0;j<docslist.size();j++){
					       		rs3.executeSql("select Max(sharelevel) sharelevel from Workflow_DocShareInfo where docid="+docslist.get(j)+" and userid="+aid);
					       		if(rs3.next()){
					          		int sharelevel=Util.getIntValue(rs3.getString("sharelevel"),0);
					          		if(sharelevel>0){
					              		rs.executeSql("update DocShare set sharelevel="+sharelevel+" where sharesource=1 and docid="+docslist.get(j)+" and userid="+aid+" and sharelevel>"+sharelevel);
					          		}else{
					              		rs.executeSql("delete DocShare where sharesource=1 and docid="+docslist.get(j)+" and userid="+aid);
					          		}
					       		}else{
					          		rs.executeSql("delete DocShare where sharesource=1 and docid="+docslist.get(j)+" and userid="+aid);
					       		}
					       		//重新赋予被代理人文档权限
					       		rs.executeSql("update DocShare set sharelevel="+sharlevellist.get(j)+" where sharesource=1 and docid="+docslist.get(j)+" and userid="+beaid);
					       		DocViewer.setDocShareByDoc((String)docslist.get(j));
					   		}   
					   		//end by mackjoe
				  		}
		 		}
			}
			 
			//设置无效状态

		 wfAgentCondition.SetbackAgent(""+beaid,""+aid);
			
		//通过默认的工作流提醒 
		//TODO
		}catch(Exception e){
			flag = false;
		}
		if(flag){
			response.sendRedirect("/workflow/request/wfAgentGetBackConfirm.jsp?agented="+agented+"&agentFlage="+agentFlag+"&infoKey=3&isclose=1");
			return;  //xwj for td3218 20051201
		}else{
			response.sendRedirect("/workflow/request/wfAgentGetBackConfirm.jsp?agented="+agented+"&agentFlage="+agentFlag+"&infoKey=4&isclose=1");
			return;  //xwj for td3218 20051201
		}
	}
}
//e8 改造新增流程代理逻辑
else if(method.equals("addAgent")){
String beagenterIdAll=Util.fromScreen(request.getParameter("beagenterId"),user.getLanguage());
int Belongtoid=0;
String[] arr2 = null;
ArrayList<String> userlist = new ArrayList();
if(!"".equals(beagenterIdAll)){
arr2 = beagenterIdAll.split(",");
for(int i=0;i<arr2.length;i++){
Belongtoid = Util.getIntValue(arr2[i]);
userlist.add(Belongtoid + "");
}
}
for(int k=0;k<userlist.size();k++){
	int j=k+1;
	  int beagenterId = Util.getIntValue((String)userlist.get(k),0);
    int agenterId = Util.getIntValue(request.getParameter("agenterId"),0);
    String beginDate = Util.fromScreen(request.getParameter("beginDate"),user.getLanguage());
    String beginTime = Util.fromScreen(request.getParameter("beginTime"),user.getLanguage());
    String endDate = Util.fromScreen(request.getParameter("endDate"),user.getLanguage());
    String endTime = Util.fromScreen(request.getParameter("endTime"),user.getLanguage());
    String agentrange = Util.fromScreen(request.getParameter("agentrange"),user.getLanguage());
    String rangetype = Util.fromScreen(request.getParameter("rangetype"),user.getLanguage());
    int isCreateAgenter=Util.getIntValue(request.getParameter("isCreateAgenter"),0);
    int isProxyDeal=Util.getIntValue(request.getParameter("isProxyDeal"),0);
    String overlapAgenttype = Util.fromScreen(request.getParameter("overlapAgenttype"),user.getLanguage());
    String overlapagentstrid = Util.fromScreen(request.getParameter("overlapagentstrid"),user.getLanguage());
    String source=Util.null2String(request.getParameter("source"));//来源【由于目前代理添加业务统一整合到java文件，方便其他地方重用。不同来源返回地址不一样】

    //标示【流程代理时，有重复范围记录特殊处理 1、从新保存的代理设置中去除重复设置内容 2、以新保存的代理设置替换已有重复的代理设置】

    if(!overlapAgenttype.equals("")){
    	if(overlapAgenttype.equals("1")){//从新保存的代理设置中去除重复设置内容
        String agentretu=wfAgentCondition.agentadd(""+beagenterId,""+agenterId,beginDate,beginTime,endDate,endTime,agentrange,rangetype,""+isCreateAgenter,""+isProxyDeal,""+isPendThing,usertype,user,"1","");  
    	if(agentretu.equals("1")){
    	    	 response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=1");
    	         return;  //xwj for td3218 20051201
    	     }else if(agentretu.equals("2")){//流程不能重复被代理，请收回后再代理！
    	    	 	response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=5");
    	            return;
    	     }else if(agentretu.equals("3")){//代理失败出现异常
    	    	 response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=2");
    		     return;  //xwj for td3218 20051201
    		 }else if(j==userlist.size()){//代理成功
    			// System.out.println("--sucess---------");     
    			 //response.sendRedirect("/workflow/request/wfAgentCDBackConfirm1.jsp?infoKey=1&isclose=1");
    			// return;  //xwj for td3218 20051201
    				%> 
    	    	       <script language=javascript >
    				    try
    				    {
    				    	var dialog =parent.getDialog(window);
    						var parentWin = parent.getParentWindow(window);
    						parentWin.location.href="/workflow/request/wfAgentAdd.jsp?isclose=1";
    						//parentWin.closeDialog();
    						dialog.close();
    					}
    					catch(e)
    					{
    					}
    					</script>
    	    		<% 
    			
    		 }
    	 }else{
    	 
    		 //以新保存的代理设置替换已有重复的代理设置
    		 //首先将重复的代理给收回来，然后再重新代理{指收回重复}
    		 rs4.executeSql("select workflowid,agentid,bagentuid from workflow_agentConditionSet where agentid in("+overlapagentstrid+") and agenttype='1' ");
    		 while(rs4.next()){
    			 String workflowidold=Util.null2String(rs4.getString("workflowid"));
    			 String agentidold=Util.null2String(rs4.getString("agentid"));
    		 	 String bagentuidold=Util.null2String(rs4.getString("bagentuid"));
    		 	 wfAgentCondition.Agent_to_recover(bagentuidold,workflowidold,agentidold,"agentrecoverold",""+agenterId);//收回代理
    		 }	
    		 
    		 //添加代理
			 String agentretu=wfAgentCondition.agentadd(""+beagenterId,""+agenterId,beginDate,beginTime,endDate,endTime,agentrange,rangetype,""+isCreateAgenter,""+isProxyDeal,""+isPendThing,usertype,user,"2","");
			 
			 if(agentretu.equals("1")){
			    	 response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=1");
			         return;  //xwj for td3218 20051201
			  }else if(agentretu.equals("2")){//流程不能重复被代理，请收回后再代理！
			    	 	response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=5");
			            return;
			  }else if(agentretu.equals("3")){//代理失败出现异常
			    	 response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=2");
	    		     return;  //xwj for td3218 20051201
	    	  }else if(j==userlist.size()){
    			 //	response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=1&isclose=1");
    			// return;  //xwj for td3218 20051201
				 
	    			%> 
	     	       <script language=javascript >
	 			    try
	 			    {
	 			    	var dialog =parent.getDialog(window);
	 					var parentWin = parent.getParentWindow(window);
	 					parentWin.location.href="/workflow/request/wfAgentAdd.jsp?isclose=1";
	 					//parentWin.closeDialog();
	 					dialog.close();
	 				}
	 				catch(e)
	 				{
	 				}
	 				</script>
	     			 
	     		<% 
    			
	    	 }
    	 }
    }else{
    	//添加代理设置
    	String agentretu=wfAgentCondition.agentadd(""+beagenterId,""+agenterId,beginDate,beginTime,endDate,endTime,agentrange,rangetype,""+isCreateAgenter,""+isProxyDeal,""+isPendThing,usertype,user,"3","");
			
	     if(agentretu.equals("1")){
	    	 response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=1");
	         return;  //xwj for td3218 20051201
	     }else if(agentretu.equals("2")){//流程不能重复被代理，请收回后再代理！
	    	 	response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=5");
	            return;
	     }else if(agentretu.equals("3")){//代理失败出现异常
	    	 response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=2");
		     return;  //xwj for td3218 20051201
		 }else  if(j==userlist.size()){//代理成功
			 response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=1&isclose=1");
    			 return;  //xwj for td3218 20051201		 
		 }	 
    }
} 
}else if(method.equals("editAgent")){//编辑代理日期时间
    int agentid = Util.getIntValue(request.getParameter("agentid"),0); 
    int beagenterId = Util.getIntValue(request.getParameter("beagenterId"),0);
    int agenttype = Util.getIntValue(request.getParameter("agenttype"),0);
    int agenterId = Util.getIntValue(request.getParameter("agenterId"),0);
    String beginDate = Util.fromScreen(request.getParameter("beginDate"),user.getLanguage());
    String beginTime = Util.fromScreen(request.getParameter("beginTime"),user.getLanguage());
    String endDate = Util.fromScreen(request.getParameter("endDate"),user.getLanguage());
    String endTime = Util.fromScreen(request.getParameter("endTime"),user.getLanguage());
    String workflowid = Util.fromScreen(request.getParameter("workflowid"),user.getLanguage());
    String overlapAgenttype = Util.fromScreen(request.getParameter("overlapAgenttype"),user.getLanguage());
    String overlapagentstrid = Util.fromScreen(request.getParameter("overlapagentstrid"),user.getLanguage());
  
   
    try{
    	  if(!overlapAgenttype.equals("")){
   		  	   if(overlapAgenttype.equals("1")){//从新保存的代理设置中去除重复设置内容
    		          //编辑代理日期 既然之前已经存在，本次修改日期之后过滤掉哪么就可以不用处理。编辑本身就是单条的流程
    		          response.sendRedirect("wfAgentEditCondition.jsp?infoKey=3&agentid="+agentid);
    		          return;  //xwj for td3218 20051201
    		 	}else{
    		 		if(agenttype==0){
    		 			wfAgentCondition.SetUpdateagent(beginDate,beginTime,endDate,endTime,""+agentid,overlapagentstrid,""+beagenterId,workflowid,user);
    		 		    //response.sendRedirect("wfAgentEditCondition.jsp?infoKey=4&agentid="+agentid);
    		 		}else{
	   		    		 //以新保存的代理设置替换已有重复的代理设置
	   		    		 //首先将重复的代理给收回来，然后再重新代理
	   		    		 rs4.executeSql("select workflowid,agentid,bagentuid from workflow_agentConditionSet where agentid in("+overlapagentstrid+") and agenttype='1' ");
	   		    		 while(rs4.next()){
	   		    			 String workflowidold=Util.null2String(rs4.getString("workflowid"));
	   		    			 String agentidold=Util.null2String(rs4.getString("agentid"));
	   		    		 	 String bagentuidold=Util.null2String(rs4.getString("bagentuid"));
	   		    		     wfAgentCondition.Agent_to_recover(bagentuidold,workflowidold,agentidold,"editAgent_cf",""+agenterId);//收回代理
	   		    		 }	
	   		    		 //根据新的代理日期重新代理
	   	    	         wfAgentCondition.again_agent_wf(""+beagenterId,workflowid,beginDate,beginTime,endDate,endTime,user,"editAgent",""+agentid);
		 		    
    		 		}  
    		 	}
    	  } else{
    	    	String retustr=wfAgentCondition.getAgentType(""+agentid);
    	    	if(retustr.equals("1")){//代理中[代理中的流程，需要将代理中的先收回 然后再重新代理一下]
    	    		//收回代理操作	
    	         	wfAgentCondition.Agent_to_recover(""+beagenterId,workflowid,""+agentid,"editrecover",""+agenterId);
    	    		//根据新的代理日期重新代理
    	             wfAgentCondition.again_agent_wf(""+beagenterId,workflowid,beginDate,beginTime,endDate,endTime,user,"editAgentNew",""+agentid);
    	    	
    	    	}else if(retustr.equals("3")){//未开始
    	    		String iseditstartdate="0";
    	    	    String iseditstarttime="0";
    	    	    String iseditenddate="0";
    	    	    String iseditendtime="0";
    	    	    if(beginDate.equals("")){
    	    	    	beginDate="1900-01-01";
    	    	    	iseditstartdate="1";
    	    	    }
    	    	    if(beginTime.equals("")){
    	    	    	beginTime="00:00";
    	    	    	iseditstarttime="1";
    	    	    }
    	    	    if(endDate.equals("")){
    	    	    	endDate="2099-12-31";
    	    	    	iseditenddate="1";
    	    	    }
    	    	    if(endTime.equals("")){
    	    	    	endTime="23:59";
    	    	    	iseditendtime="1";
    	    	    }
    	    	    
    	    		//修改主代理数据

    	    		String editString = "update workflow_agent set " + "beginDate='"
    				+ beginDate + "'," + "beginTime='" + beginTime + "',"
    				+ "endDate='" + endDate + "'," + "endTime='" + endTime + "'"
    				+ "	,iseditstartdate='"+iseditstartdate+"',iseditstarttime='"+iseditstarttime+"',iseditenddate='"+iseditenddate+"',iseditendtime='"+iseditendtime+"'  where agentId=" + agentid;
    				rs1.executeSql(editString);
    				
    				//修改代理明细
    				String editString2 = "update workflow_agentConditionSet set "
    						+ "beginDate='" + beginDate + "'," + "beginTime='" + beginTime
    						+ "'," + "endDate='" + endDate + "'," + "endTime='" + endTime
    						+ "'" + "where agentId=" + agentid;
    				rs1.executeSql(editString2);
    	    	}else {//2已结束

    	    		 
    	    		wfAgentCondition.SetWorkflowAgent(""+agentid,beginDate,beginTime,endDate,endTime,""+beagenterId,""+workflowid,user);
    	    		//收回代理操作	
    	    	}
    	  }
    }
    catch(Exception e){
        flag = false;
    }
    
    if(flag){
    	if(!overlapAgenttype.equals("")){
    		%>
     	 <script language=javascript >
		 try
		    {
		    	var dialog =parent.getDialog(window);
				var parentWin = parent.getParentWindow(window);
				parentWin.location.href="/workflow/request/wfAgentEditCondition.jsp?infoKey=4";
				//parentWin.closeDialog();
				dialog.close();
			}
			catch(e)
			{
			}
		</script>
    		<%
    	}else{
    		 response.sendRedirect("wfAgentEditCondition.jsp?infoKey=1");
    	     return;  //xwj for td3218 20051201
    	}
     
    }else{
        response.sendRedirect("wfAgentEditCondition.jsp?infoKey=2");
        return;  //xwj for td3218 20051201
    }
}
 
%>


<%! //老数据

public boolean isOldData(String requestid){
RecordSet RecordSetOld = new RecordSet();
boolean isOldWf_ = false;
RecordSetOld.executeSql("select nodeid from workflow_currentoperator where requestid = " + requestid);
while(RecordSetOld.next()){
	if(RecordSetOld.getString("nodeid") == null || "".equals(RecordSetOld.getString("nodeid")) || "-1".equals(RecordSetOld.getString("nodeid"))){
			isOldWf_ = true;
	}
}
return isOldWf_;
}

%>