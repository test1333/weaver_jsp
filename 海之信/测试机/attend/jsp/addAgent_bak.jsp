<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.workflow.request.RequestAddShareInfo"%>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="wfAgentCondition" class="weaver.workflow.request.wfAgentCondition" scope="page" />
<%
    //Shaw start
    String sql = "";
    String empid = request.getParameter("userid");
    String requestid = request.getParameter("requestid");
    out.print("requestid="+requestid);
    String agentFirst = request.getParameter("agentFirst");
    String agentSecond = request.getParameter("agentSecond");
    String status = request.getParameter("status");
    String tmp_agent = "";
    int num_SetFirst = 0;
    int num_SetSecond = 0;
    Boolean isAgentFirst = false;
    Boolean isAgentSecond = false;

    sql = " select count(*) as num_Set from Workflow_Agent where agenttype = 1 and beagenterId ="+agentFirst;
    res.executeSql(sql);
    if(res.next()){
        num_SetFirst = res.getInt("num_Set");
        out.print("num_SetFirst="+num_SetFirst);
        if(num_SetFirst>0) {
            isAgentFirst = true;
        }
    }

    sql = " select count(*) as num_Set from Workflow_Agent where agenttype = 1 and beagenterId ="+agentSecond;
    res.executeSql(sql);
    if(res.next()){
        num_SetSecond = res.getInt("num_Set");
        out.print("num_SetSecond="+num_SetSecond);
        if(num_SetSecond>0) {
            isAgentSecond = true;
        }
    }

    if(!isAgentFirst){
        tmp_agent = agentFirst; 
    }else{
        if(!isAgentSecond){
            tmp_agent = agentSecond; 
        }else{
            tmp_agent = "";
        }
    }

    //添加代理设置
    String agentretu=wfAgentCondition.agentadd(empid,tmp_agent,"1900-01-01","00:00","2099-12-31","23:59","0","","1","1","1",0,user,"1","");
    if(agentretu.equals("1")){
        response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=1");
        return;  //xwj for td3218 20051201
    }else if(agentretu.equals("2")){//流程不能重复被代理，请收回后再代理！
        response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=5");
        return;
    }else if(agentretu.equals("3")){//代理失败出现异常
        response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=2");
        return;  //xwj for td3218 20051201
    }else{//代理成功
        response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=1&isclose=1");
        return;  //xwj for td3218 20051201      
    }   
    //shaw over
   
    String overlapAgenttype = Util.fromScreen(request.getParameter("overlapAgenttype"),user.getLanguage());
    String overlapagentstrid = Util.fromScreen(request.getParameter("overlapagentstrid"),user.getLanguage());
    String source=Util.null2String(request.getParameter("source"));//来源【由于目前代理添加业务统一整合到java文件，方便其他地方重用。不同来源返回地址不一样】

    //标示【流程代理时，有重复范围记录特殊处理 1、从新保存的代理设置中去除重复设置内容 2、以新保存的代理设置替换已有重复的代理设置】

    if(!overlapAgenttype.equals("")){
    	if(overlapAgenttype.equals("1")){//从新保存的代理设置中去除重复设置内容
        /*String agentretu=wfAgentCondition.agentadd(""+beagenterId,""+agenterId,beginDate,beginTime,endDate,endTime,agentrange,rangetype,""+isCreateAgenter,""+isProxyDeal,""+isPendThing,usertype,user,"1",""); */ 
        String agentretu=wfAgentCondition.agentadd(empid,tmp_agent,"1900-01-01","00:00","2099-12-31","23:59","0","","1","1","1",0,user,"1","");
    	if(agentretu.equals("1")){
    	    	 response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=1");
    	         return;  //xwj for td3218 20051201
    	     }else if(agentretu.equals("2")){//流程不能重复被代理，请收回后再代理！
    	    	 	response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=5");
    	            return;
    	     }else if(agentretu.equals("3")){//代理失败出现异常
    	    	 response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=2");
    		     return;  //xwj for td3218 20051201
    		 }else{//代理成功
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
    		 res.executeSql("select workflowid,agentid,bagentuid from workflow_agentConditionSet where agentid in("+overlapagentstrid+") and agenttype='1' ");
    		 while(res.next()){
    			 String workflowidold=Util.null2String(res.getString("workflowid"));
    			 String agentidold=Util.null2String(res.getString("agentid"));
    		 	 String bagentuidold=Util.null2String(res.getString("bagentuid"));
    		 	 wfAgentCondition.Agent_to_recover(bagentuidold,workflowidold,agentidold,"agentrecoverold",""+tmp_agent);//收回代理
    		 }	
    		 
    		 //添加代理
			 //String agentretu=wfAgentCondition.agentadd(""+beagenterId,""+agenterId,beginDate,beginTime,endDate,endTime,agentrange,rangetype,""+isCreateAgenter,""+isProxyDeal,""+isPendThing,usertype,user,"2","");
            String agentretu=wfAgentCondition.agentadd(empid,tmp_agent,"1900-01-01","00:00","2099-12-31","23:59","0","","1","1","1",0,user,"1","");
			 if(agentretu.equals("1")){
			    	 response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=1");
			         return;  //xwj for td3218 20051201
			  }else if(agentretu.equals("2")){//流程不能重复被代理，请收回后再代理！
			    	 	response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=5");
			            return;
			  }else if(agentretu.equals("3")){//代理失败出现异常
			    	 response.sendRedirect("/workflow/request/wfAgentCDBackConfirm.jsp?infoKey=2");
	    		     return;  //xwj for td3218 20051201
	    	  }else{
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
    	//String agentretu=wfAgentCondition.agentadd(""+beagenterId,""+agenterId,beginDate,beginTime,endDate,endTime,agentrange,rangetype,""+isCreateAgenter,""+isProxyDeal,""+isPendThing,usertype,user,"3","");
		String agentretu=wfAgentCondition.agentadd(empid,tmp_agent,"1900-01-01","00:00","2099-12-31","23:59","0","","1","1","1",0,user,"1","");
	     if(agentretu.equals("1")){
	    	 response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=1");
	         return;  //xwj for td3218 20051201
	     }else if(agentretu.equals("2")){//流程不能重复被代理，请收回后再代理！
	    	 	response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=5");
	            return;
	     }else if(agentretu.equals("3")){//代理失败出现异常
	    	 response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=2");
		     return;  //xwj for td3218 20051201
		 }else{//代理成功
			 response.sendRedirect("/workflow/request/wfAgentAdd.jsp?infoKey=1&isclose=1");
    			 return;  //xwj for td3218 20051201		 
		 }	 
    }
%>