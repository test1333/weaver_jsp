<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="weaver.systeminfo.SystemEnv"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs3" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>黑牛云谷费控系统</title>
  <meta name="description" content="port" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" cache="false" />
  <link rel="stylesheet" href="css/plugin.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" />
  
   <script type="text/javascript" src="/js/select/script/jquery-1.8.3.min_wev8.js"></script>	  
  <script type="text/javascript" src="/wui/common/jquery/jquery.min_wev8.js"></script>
  <script type="text/javascript" src="/js/ecology8/lang/weaver_lang_7_wev8.js"></script>
  <script language=javascript src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
  <script language="javascript" type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
  <script  language="javascript" src="/bsdt/js/common.js"></script>
</head>
<body data-spy="scroll" data-target="#header" class="landing" id="home"> 

  <%@ include file="headSeach.jsp"%>
 <%
       	if(user==null){
       		response.sendRedirect("/login/Login.jsp?");
       	}else if(user.getUID()==228989){
			response.sendRedirect("/login/Login.jsp?");
		}
       	int docCount = 0;
       	rs.executeSql("select count(t1.id) as docCount from DocDetail  t1 ,(SELECT  sourceid,MAX(sharelevel) AS sharelevel from ShareinnerDoc where((type=1 and content="+user.getUID()+" and seclevel>=0) or (type=2 and content in (1,1) and seclevel<=45 and seclevelmax>=45)  or (type=3 and content in (22,22) and seclevel<=45 and seclevelmax>=45) or  (type=4 and content in (3212,3612,3812) and seclevel<=45 and seclevelmax>=45) or  (type=5 and content=1 and seclevel<=45 and seclevelmax>=45)) GROUP BY sourceid )  t2  where  ( ( t1.docstatus = 7 and  (sharelevel>1 or (t1.doccreaterid="+user.getUID()+" or t1.ownerid="+user.getUID()+")) ) or t1.docstatus in ('1','2','5')  )  and seccategory!=0 and (ishistory is null or ishistory = 0)  and t1.id=t2.sourceid");
				            if(rs.next()){
				            docCount = rs.getInt("docCount");
				            }


		String openurl = Util.null2String(request.getSession().getAttribute("openurl"));
		if(!"".equals(openurl)){
		%>  
		<script type="text/javascript">
			window.open('<%=openurl%>','_blank');
		</script>
		<%  
			request.getSession().setAttribute("openurl","");
		}

		//包含次账号

		int userid_define=user.getUID(); 
		String accountall=""+userid_define;
		String sql_allaccount=" select id from hrmresource where status<5 and belongto="+userid_define+" ";
		rs.executeSql(sql_allaccount);
		while(rs.next()){
			accountall=accountall+","+rs.getString("id");
	    }
       %>
    
    <!-- .vbox -->
      <section class="vbox">
        <section class="scrollable">
          <div class="slim-scroll wrapper" data-height="auto" data-disable-fade-out="true" data-distance="0">
              
            <div class="row">
              <div class="col-lg-8">
                  
                <div class="row">
                  <div class="col-sm-6">                                                              
                    <section class="panel no-borders">
                      <header class="panel-heading bg-wihte lter no-borders">
                        <div class="clearfix">
                          <a class="pull-left thumb avatar border m-r">
                            <img src="<%=messagerurl %>" class="img-circle">
                          </a>
                          <div class="clear">
                            <div class="h3 m-t-xs m-b-xs"><%=lastname %><i class="icon-circle text-success pull-right text-xs m-t-sm"></i></div>
                            <small class="text-muted"><%=getWeekOfDate(new Date()) %></small>
                          </div>                
                        </div>
                      </header>

					   <div style="height:240px;">
                        
                        <footer class="panel-footer bg-light dk text-center">
<iframe width="420" scrolling="no" height="60" frameborder="0" allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=12&icon=1&num=5&site=12"></iframe>
                  </footer>
                        <%
                        int toDoCount = 0;
                      		rs.executeSql("select count( distinct t1.requestid) as toDoCount from workflow_requestbase t1 left join workflow_currentoperator t2 on t1.requestid=t2.requestid where (t1.deleted <> 1 or t1.deleted is null or t1.deleted = '') and t2.userid in ("+accountall+") and t2.usertype = 0 and (t1.deleted = 0 or t1.deleted is null) and ((t2.isremark = 0 and (t2.takisremark is null or t2.takisremark = 0)) or t2.isremark in ('1', '5', '8', '9', '7')) and (t1.deleted = 0 or t1.deleted is null) and t2.islasttimes = 1 and (nvl(t1.currentstatus, -1) = -1 or (nvl(t1.currentstatus, -1) = 0 and t1.creater in ("+accountall+"))) and t1.workflowid in (select id from workflow_base where (isvalid = '1' or isvalid = '3'))  ");

				            if(rs.next()){
				            toDoCount = rs.getInt("toDoCount");
				            }
				            
				            int serviceCount1 = 0;
                        	rs.executeSql("select count(1) serviceCount1 from uf_fusc where scry="+user.getUID());
				            if(rs.next()){
				           	 serviceCount1 = rs.getInt("serviceCount1");
				            }
                         %>                 
                        
                      <%		//已办
                      			int havaToDoCount = 0;
				            	rs.executeSql("select count(1) havaToDoCount from workflow_requestbase t1 left join workflow_currentoperator t2 on t1.requestid=t2.requestid where (t1.deleted <> 1 or t1.deleted is null or t1.deleted = '') and t2.userid in ("+accountall+") and t2.usertype = 0 and (t1.deleted = 0 or t1.deleted is null) and ((t2.isremark = 0 and t2.takisremark = -2) or t2.isremark in ('2', '4')) and (t1.deleted = 0 or t1.deleted is null) and t2.islasttimes = 1 and (nvl(t1.currentstatus, -1) = -1 or (nvl(t1.currentstatus, -1) = 0 and t1.creater in ("+accountall+"))) and t1.workflowid in (select id from workflow_base where (isvalid = '1' or isvalid = '3')) ");
				            	if(rs.next()){
				            		havaToDoCount = rs.getInt("havaToDoCount");
				            	}
				            //我的会议
				            int toDoWorkCount = 0;
				            String workSql ="select count(1) toDoWorkCount from Meeting t1, Meeting_ShareDetail t2  WHERE ( (t1.id = t2.meetingId) AND  ((t1.meetingStatus in (1, 3) AND t2.userId in ("+user.getUID()+") AND t2.shareLevel in (1,4))  OR (t1.meetingStatus = 0 AND (t1.creater in ("+user.getUID()+")) AND (t2.userId in ("+user.getUID()+")) )  OR (t1.meetingStatus IN (2, 4) AND (t2.userId in ("+user.getUID()+"))))) and t1.repeatType = 0 ";
                        	rs.executeSql(workSql);
				            if(rs.next()){
				           	 toDoWorkCount = rs.getInt("toDoWorkCount");
				            }
                       %> 
					   



					 
				

                      <div class="list-group no-radius alt padder-v">
					  <a class="list-group-item" href="#" onclick="openToDo();" data-toggle="modal">
                          <span class="badge bg-danger"><%=toDoCount %></span>
                          <i class="icon-edit"></i> 
                          待办事宜
                        </a>
				    <a class="list-group-item" href="#" onclick="havaToDo();" data-toggle="modal">
                          <span class="badge bg-info"><%=havaToDoCount %></span>
                          <i class="icon-check"></i> 
                          已办事宜
                        </a>
                        <a class="list-group-item" href="/hrm/search/HrmResourceSearch_frm.jsp" data-toggle="modal" target="_blank"> 
                          <i class="icon-envelope text-primary"></i> 
                          通讯录
                        </a>
						<a class="list-group-item" onclick="myfavourite();" data-toggle="modal">
                          <i class="icon-star text-warning"></i> 
                          收藏夹
                        </a>
                      </div>

					  </div>


                    </section>
                  </div>                   
                  <div class="col-sm-6">
                      <section class="panel">
                      <header class="panel-heading bg-light dker">
                        <ul class="nav nav-tabs nav-justified text-uc">
                          <li class="active"><a href="/bsdt/port.jsp#popular02" data-toggle="tab">待办报账</a></li>
                          <li><a href="/bsdt/port.jsp#comment02" data-toggle="tab">已办报账</a></li>
                          <li class="dk"><a href="/bsdt/port.jsp#recent02" data-toggle="tab">发起报账</a></li>
                        </ul>
                      </header>

                     <div class="panel-body">
                        <div class="tab-content" style="height:240px;">
						
                          <div class="tab-pane active" id="popular02">
                           <%   //待办事宜
				            	rs.executeSql(" select * from (select * from workflow_requestbase t1 left join workflow_currentoperator t2 on t1.requestid=t2.requestid where (t1.deleted <> 1 or t1.deleted is null or t1.deleted = '') and t2.userid in ("+accountall+") and t2.usertype = 0 and (t1.deleted = 0 or t1.deleted is null) and ((t2.isremark = 0 and (t2.takisremark is null or t2.takisremark = 0)) or t2.isremark in ('1', '5', '8', '9', '7')) and (t1.deleted = 0 or t1.deleted is null) and t2.islasttimes = 1 and (nvl(t1.currentstatus, -1) = -1 or (nvl(t1.currentstatus, -1) = 0 and t1.creater in ("+accountall+"))) and t1.workflowid in (select id from workflow_base where (isvalid = '1' or isvalid = '3')) order by t2.receivedate desc, t2.receivetime desc, t1.requestid desc) where rownum<=5 ");
				            	while(rs.next()){
				            		%>	
	                        		<article class="media">
	                              <div class="media-body">                        
	                                <a href="#" onclick="openWorkFolw_define('<%=rs.getInt("requestid") %>','<%=rs.getInt("userid") %>');" data-toggle="modal" class="font-semibold"><%=rs.getString("requestname") %></a> &nbsp;
	                                  <div class="text-xs block m-t-xs"><i class="icon-time"></i> <%=rs.getString("createdate") %>&nbsp;by <%=ResourceComInfo.getLastname(rs.getString("creater")) %></div>
	                              </div>
	                            </article>
	                            <div class="line line-dashed"></div>
	                        		
	                        	<%
	                        	}
	                          %>
							  <div><div class="line"></div><a target="_blank" href="/workflow/request/RequestView.jsp" class="btn btn-white btn-xs pull-right">More</a></div>
                          </div>
                          <div class="tab-pane" id="comment02">
                          
                           <%   //已办事宜
				            	rs.executeSql("select * from (select * from workflow_requestbase t1 left join workflow_currentoperator t2 on t1.requestid=t2.requestid where (t1.deleted <> 1 or t1.deleted is null or t1.deleted = '') and t2.userid in ("+accountall+") and t2.usertype = 0 and (t1.deleted = 0 or t1.deleted is null) and ((t2.isremark = 0 and t2.takisremark = -2) or t2.isremark in ('2', '4')) and (t1.deleted = 0 or t1.deleted is null) and t2.islasttimes = 1 and (nvl(t1.currentstatus, -1) = -1 or (nvl(t1.currentstatus, -1) = 0 and t1.creater in ("+accountall+"))) and t1.workflowid in (select id from workflow_base where (isvalid = '1' or isvalid = '3')) order by t2.receivedate desc, t2.receivetime desc, t1.requestid desc) where rownum<=5 ");
				            	while(rs.next()){
				            		%>	
	                        		<article class="media"><%--
	                              <a class="pull-left thumb-sm m-t-xs">
	                                <img src="images/avatar10.jpg" class="img-circle">
	                              </a>
	                              --%>
								  <div class="media-body">                        
	                                <a href="#" onclick="openWorkFolw_define('<%=rs.getInt("requestid") %>','<%=rs.getInt("userid") %>');" data-toggle="modal" class="font-semibold"><%=rs.getString("requestname") %></a>
	                                  <div class="text-xs block m-t-xs"><i class="icon-time"></i> <%=rs.getString("createdate") %>&nbsp;by <%=ResourceComInfo.getLastname(rs.getString("creater")) %>
									  </div>
	                              </div>
	                            </article>
	                            <div class="line line-dashed"></div>
	                        	<%
	                        	}
	                          %>
							  <div><div class="line"></div><a target="_blank" href="/workflow/request/RequestHandled.jsp" class="btn btn-white btn-xs pull-right">More</a></div>
                          </div>
                          <div class="tab-pane" id="recent02">
                            
                           <%	//我的请求
				            	rs.executeSql("select * from(select *　from workflow_requestbase t1  where t1.creater in ("+accountall+")　and t1.workflowid in　(select id from workflow_base where (isvalid = '1' or isvalid = '3'))　order by t1.requestid desc) where rownum<=5");
				            	while(rs.next()){
				            		%>	
	                        		<article class="media"><%--
	                              <a class="pull-left thumb-sm m-t-xs">
	                                <img src="images/avatar10.jpg" class="img-circle">
	                              </a>
	                              --%><div class="media-body">                        
	                                <a href="#" onclick="openWorkFolw_define('<%=rs.getInt("requestid") %>','<%=rs.getInt("userid") %>');" data-toggle="modal" class="font-semibold"><%=rs.getString("requestname") %></a>
	                                  <div class="text-xs block m-t-xs"><i class="icon-time"></i> <%=rs.getString("createdate") %>&nbsp;by <%=ResourceComInfo.getLastname(rs.getString("creater")) %></div>
	                              </div>
	                            </article>
	                            <div class="line line-dashed"></div>
	                        		
	                        	<%
	                        	}
	                          %>
							  <div><div class="line"></div><a target="_blank" href="/workflow/request/MyRequestView.jsp" class="btn btn-white btn-xs pull-right">More</a></div>
                          </div>
                        </div>
                      </div>
                    </section>
                    
                  </div>
                </div>
              </div>
                
                
<%
	String querySql = " select fw.id,fw.fwmc,fw.fwlj from uf_fusc sc "
		 +" left join uf_ser_services fw on sc.fwsx=fw.id "
		 +" where sc.scry="+user.getUID()+" order by sc.id ";
	rs.executeSql(querySql);
	String fuwuchooseids = "";
	int tempid = 0;
	while(rs.next()){
		if(tempid == 0){
			fuwuchooseids = rs.getString("id");
			tempid= 1;
		}else{
			fuwuchooseids += ","+rs.getString("id");
		}
	}

%>
                
              <div class="col-lg-4">


<SECTION class="panel"><HEADER class="panel-heading">常用报账     
</HEADER><SECTION class="panel-body slim-scroll" 
data-height="312px">
<div style="height:288px;">
<div class="row">

<div class="col-sm-4 m-b-sm">
<div class="fuwu2-link center"><a href="/fna/report/expense/FnaExpenseResource.jsp" target="_blank" data-toggle="modal"><SPAN class="icon-stack icon-2x">
<I class="icon-circle text-success icon-stack-base"></I>
<I class="icon-edit-sign icon-light"></I></SPAN>                                   
<H5 class="m-b-xs">个人收支分析</H5></a></div></div>

<div class="col-sm-4 m-b-sm">
<div class="fuwu2-link center"><a href="/cowork/coworkview.jsp" target="_blank" data-toggle="modal"><SPAN class="icon-stack icon-2x"><I class="icon-circle text-success icon-stack-base"></I><I 
class="icon-edit-sign icon-light"></I></SPAN>                                   
<H5 class="m-b-xs">报账协作专区</H5></a></div></div>

<div class="col-sm-4 m-b-sm">
<div class="fuwu2-link center"><a href="http://www.ctrip.com" target="_blank"
data-toggle="modal"><SPAN class="icon-stack icon-2x"><I class="icon-circle text-success icon-stack-base"></I><I 
class="icon-edit-sign icon-light"></I></SPAN>                                   
<H5 class="m-b-xs">携程查票</H5></a></div></div>

<div class="col-sm-4 m-b-sm">
<div class="fuwu2-link center"><a href="/docs/search/DocSearchTab.jsp?urlType=16&eid=141&tabid=1&date2during=0" target="_blank"
data-toggle="modal"><SPAN class="icon-stack icon-2x"><I class="icon-circle text-success icon-stack-base"></I><I 
class="icon-edit-sign icon-light"></I></SPAN>                                   
<H5 class="m-b-xs">财务规章制度</H5></a></div></div>

<div class="col-sm-4 m-b-sm">
<div class="fuwu2-link center"><a href="/docs/search/DocSearchTab.jsp?urlType=16&eid=141&tabid=2&date2during=0" target="_blank"
data-toggle="modal"><SPAN class="icon-stack icon-2x"><I class="icon-circle text-success icon-stack-base"></I><I 
class="icon-edit-sign icon-light"></I></SPAN>                                   
<H5 class="m-b-xs">合同相关制度</H5></a></div></div>

<div class="col-sm-4 m-b-sm">
<div class="fuwu2-link center"><a href="/docs/search/DocSearchTab.jsp?urlType=16&eid=141&tabid=4&date2during=0" target="_blank"
data-toggle="modal"><SPAN class="icon-stack icon-2x"><I class="icon-circle text-success icon-stack-base"></I><I 
class="icon-edit-sign icon-light"></I></SPAN>                                   
<H5 class="m-b-xs">报账帮助手册</H5></a></div></div>

</div></div></SECTION></SECTION></div></div>

 <!-- 网上报账管理 -->
<DIV class="row bg-light dker wrapper"">
<DIV class="col-lg-12 m-t">
<SECTION class="panel text-center bg-white">
<DIV class="panel-body">
<H4 class="text-uc">我的个性化报账桌面</H4>
<DIV class="m-t m-l m-r m-b">

<DIV class="col-sm-3">
<DIV class=" aborder bg-white padder-v center m5"><A href="/interface/Entrance.jsp?id=oatest" target="_blank" 
data-toggle="modal"><SPAN class="icon-stack icon-2x"><I class="icon-circle text-info icon-stack-base"></I><I 
class="icon-edit-sign"></I></SPAN></A>                             
<B class="badge bg-light pull-in up"><I class="icon-plus"></I></B>             
<H5 class="m-b-xs padder">登录办公平台(OA系统)</H5>						 
<DIV class="line"></DIV>
</DIV></DIV>

<DIV class="col-sm-3">
<DIV class=" aborder bg-white padder-v center m5"><A  href="/workflow/request/AddRequest.jsp?workflowid=442&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank" 
data-toggle="modal"><SPAN class="icon-stack icon-2x"><I class="icon-circle text-info icon-stack-base"></I><I 
class="icon-edit-sign"></I></SPAN></A>                             
<B class="badge bg-light pull-in up"><I class="icon-plus"></I></B>                        
<H5 class="m-b-xs padder">出差申请流程</H5>
<DIV class="line"></DIV>
</DIV></DIV>

<DIV class="col-sm-3">
<DIV class=" aborder bg-white padder-v center m5"><A href="/workflow/request/AddRequest.jsp?workflowid=44&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank" data-toggle="modal"><SPAN class="icon-stack icon-2x"><I class="icon-circle text-info icon-stack-base"></I><I 
class="icon-edit-sign"></I></SPAN></A>                             
<B class="badge bg-light pull-in up"><I class="icon-plus"></I></B>             
<H5 class="m-b-xs padder">个人借款申请</H5>							 
<DIV class="line"></DIV>
</DIV></DIV>

<DIV class="col-sm-3">
<DIV class=" aborder bg-white padder-v center m5"><A href="/workflow/request/AddRequest.jsp?workflowid=163&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank" data-toggle="modal"><SPAN class="icon-stack icon-2x"><I class="icon-circle text-info icon-stack-base"></I><I 
class="icon-edit-sign"></I></SPAN></A>                             
<B class="badge bg-light pull-in up"><I class="icon-plus"></I></B>             
<H5 class="m-b-xs padder">费用报销流程</H5>							 
<DIV class="line"></DIV>
</DIV></DIV>

</DIV></DIV></SECTION></DIV></DIV>

              
        </section>
        
      </section>
  
</body>
<%!
 public static String getWeekOfDate(Date dt) {
 		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;
        return sdf.format(dt) +" "+ weekDays[w];
    }
 %>
 </html>
<script type="text/javascript">

  function myfavourite(){
  var title = "";
  var url = "";
  title = "收藏夹";
  url="/favourite/MyFavourite.jsp";
    
  diag_vote = new window.top.Dialog();
  diag_vote.currentWindow = window;
  diag_vote.Width = 650;
  diag_vote.Height = 500;
  diag_vote.maxiumnable = true;
  diag_vote.Modal = true;
  diag_vote.Title = title;
  diag_vote.URL = url;
  diag_vote.show();

  }

	function openWorkFolw_define(requestid,userid){
		var url = "/workflow/request/ViewRequest.jsp?requestid="+requestid+"&f_weaver_belongto_userid="+userid+"&f_weaver_belongto_usertype=0&isovertime=0";
		//alert("url="+url);	
		openWin(url);
	}	

  	function openWin(url){
		 checkUserIsNull();
		 var width = screen.availWidth-10 ;
		    var height = screen.availHeight-50 ;
		    var szFeatures = "top=0," ;
	 	    szFeatures +="left=0," ;
		    szFeatures +="width="+width+"," ;
		    szFeatures +="height="+height+"," ;
		    szFeatures +="directories=no," ;
		    szFeatures +="status=yes,toolbar=no,location=no," ;
		    szFeatures +="menubar=no," ;
		    szFeatures +="scrollbars=yes," ;
		    szFeatures +="resizable=yes" ; //channelmode
		    var open_url=window.open(url,"",szFeatures) ;

		var loop = setInterval(function() { 
		    //alert("open_url="+open_url);  
    		if(open_url.closed==true) {    
        		clearInterval(loop);    
        		//alert(0); 
        		window.location.reload();

    		}    
		}, 1000);
	}


</script>