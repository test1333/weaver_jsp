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
  <title>办事门户</title>
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
  <!--[if lt IE 9]>
    <script src="js/ie/respond.min.js" cache="false"></script>
    <script src="js/ie/html5.js" cache="false"></script>
    <script src="js/ie/excanvas.js" cache="false"></script>
    <script src="js/ie/fix.js" cache="false"></script>
  <![endif]-->
</head>
<body data-spy="scroll" data-target="#header" class="landing" id="home">

  


  <%@ include file="headSeach.jsp"%>
 <%
       	if(user==null){
       		response.sendRedirect("/bsdt/login.jsp");
       	}else if(user.getUID()==228989){
			response.sendRedirect("/bsdt/login.jsp");
		}

		//String hostStr = request.getHeader("host");
		//String reqUrl = request.getRequestURI();
		//if("oa.tongji.edu.cn".equals(hostStr)){
			//response.sendRedirect("http://service.tongji.edu.cn/bsdt/port.jsp");
			//return;
		//}

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
                          <a href="#" class="pull-left thumb avatar border m-r">
                            <img src="<%=messagerurl %>" class="img-circle">
                          </a>
                          <div class="clear">
                            <div class="h3 m-t-xs m-b-xs"><%=lastname %>.下午好 <i class="icon-circle text-success pull-right text-xs m-t-sm"></i></div>
                            <small class="text-muted"><%=getWeekOfDate(new Date()) %></small>
                          </div>                
                        </div>
                      </header>

					   <div style="height:370px;">
                        
                        <footer class="panel-footer bg-light dk text-center">
                    <div class="row pull-out">
                    <a href="/docs/search/DocCommonContent.jsp?offical=&officalType=-1" target="_blank">
                      <div class="col-xs-4 bg-info">
                        <div class="padder-v">
                          <span class="m-b-xs h4 block"><%=docCount %></span>
                          <small class="text-muted">流程文档</small>
                        </div>
                      </div>
                      </a>
					  <a href="/workflow/request/RequestView.jsp" target="_blank">   
                      <div class="col-xs-4 bg-warning">
                        <div class="padder-v">
                        <%
                        int toDoCount = 0;
                      		rs.executeSql("select count( distinct t1.requestid) as toDoCount from workflow_requestbase t1,workflow_currentoperator t2  where  (t1.deleted <> 1 or t1.deleted is null or t1.deleted='') and t1.requestid = t2.requestid and t2.userid = "+user.getUID()+" and t2.usertype=0 and  (t1.deleted=0 or t1.deleted is null)   and ((t2.isremark=0 and (t2.takisremark is null or t2.takisremark=0 )) or t2.isremark in('1','5','8','9','7'))  and (t1.deleted=0 or t1.deleted is null) and t2.islasttimes=1 and (nvl(t1.currentstatus,-1) = -1 or (nvl(t1.currentstatus,-1)=0 and t1.creater in ("+user.getUID()+")))   and t1.workflowid in (select id from workflow_base where   (isvalid='1' or isvalid='3') )  ");

				            if(rs.next()){
				            toDoCount = rs.getInt("toDoCount");
				            }
				            
				            int serviceCount1 = 0;
                        	rs.executeSql("select count(1) serviceCount1 from uf_fusc where scry="+user.getUID());
				            if(rs.next()){
				           	 serviceCount1 = rs.getInt("serviceCount1");
				            }
                         %>
                          <span class="m-b-xs h4 block"><%=toDoCount %></span>
                          <small class="text-muted">待办事宜</small>
                        </div>
                      </div>
					  </a>
                      
                    <a href="/bsdt/scfuwu.jsp" target="_blank">                      
                      <div class="col-xs-4 bg-success">
                        <div class="padder-v">
                          <span class="m-b-xs h4 block"><%=serviceCount1 %></span>
                          <small class="text-muted">常用服务</small>
                        </div>
                      </div>
                       </a>                     
                    </div>
                  </footer>
                        
                    
                   <!---/ <section class="panel no-borders hbox">
                      <aside class="bg-info dker r-l text-center v-middle">
                        <div class="wrapper">
                          <i class="icon-sun icon-4x"></i>
						  <h5>今天天气</h5>
                        </div>
                      </aside>
                      <aside class="bg-info text-center v-middle">
                        <div class="wrapper text-center">
                          <p class="h1">32°</p>
                          <span>Partial sunshine</span>
                        </div>
                      </aside>
                    </section> /-->
                      <%		//已办
                      			int havaToDoCount = 0;
				            	rs.executeSql("select count(1) havaToDoCount from workflow_requestbase r inner join hrmresource h on r.creater=h.id left join workflow_currentoperator c on c. requestid=r.requestid   and c.islasttimes=1 where c.isremark in (4) and c.userid='"+user.getUID()+"'");
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
					<!--  <a class="list-group-item" href="#modal" data-toggle="modal">
                          <span class="badge bg-success">25</span>
                          <i class="icon-comment text-info"></i> 
                          消息中心  -->
                        </a>
					<!-- 	<a class="list-group-item" href="#" onclick="openToDo();" data-toggle="modal">
                          <span class="badge bg-danger"><%=toDoCount %></span>
                          <i class="icon-edit"></i> 
                          我的待办事宜  -->
                        </a>
						<!-- <a class="list-group-item" href="#" onclick="havaToDo();" data-toggle="modal">
                          <span class="badge bg-info"><%=havaToDoCount %></span>
                          <i class="icon-check"></i> 
                          我的已办事宜  -->
                        </a>
                        <a class="list-group-item" href="http://oa.tongji.edu.cn/hrm/search/HrmResourceSearch.jsp?_fromURL=HrmResourceSearch&fromHrmTab=1" target="_blank" data-toggle="modal">
                          <i class="icon-envelope text-primary"></i> 
                          通讯录
                        </a>
                     <!--   <a class="list-group-item" href="#"  onclick="openMetting();"  data-toggle="modal">
                          <span class="badge bg-light"><%=toDoWorkCount %></span>
                          <i class="icon-time text-success"></i> 
                          我的会议  -->
                        </a>
                      <!--  <a class="list-group-item" href="#modal" data-toggle="modal">
                          <span class="badge bg-light">16</span>
                          <i class="icon-star text-warning"></i> 
                          常用服务收藏夹
                        </a> -->
                      </div>

					  </div>


                    </section>
                  </div>





                    
                  <div class="col-sm-6">
                      <section class="panel">
                      <header class="panel-heading bg-light dker">
                        <ul class="nav nav-tabs nav-justified text-uc">
                          <li class="active"><a href="#popular02" data-toggle="tab">待办事宜</a></li>
                          <li><a href="#comment02" data-toggle="tab">已办事项</a></li>
                          <li class="dk"><a href="#recent02" data-toggle="tab">办结事项</a></li>
                        </ul>
                      </header>

                     <div class="panel-body">
                        <div class="tab-content" style="height:370px;">
						
                          <div class="tab-pane active" id="popular02">
                           <%   //待办事宜
				            	rs.executeSql("select r.requestid,r.requestname,r.createdate,r.creater from (     select my_table.*, rownum as my_rownum from (    select tableA.*,rownum  as oracle_rownum from (   select  distinct  t1.requestid,t1.requestmark,t1.createdate, t1.createtime,t1.creater, t1.creatertype, t1.workflowid, t1.requestname, t1.requestnamenew, t1.status,t1.requestlevel,t1.currentnodeid,t2.viewtype,t2.userid,t2.receivedate,t2.receivetime,t2.isremark,t2.nodeid,t2.agentorbyagentid,t2.agenttype,t2.isprocessed   from workflow_requestbase t1,workflow_currentoperator t2  where  (t1.deleted <> 1 or t1.deleted is null or t1.deleted='') and t1.requestid = t2.requestid and t2.userid = "+user.getUID()+" and t2.usertype=0 and  (t1.deleted=0 or t1.deleted is null)   and ((t2.isremark=0 and (t2.takisremark is null or t2.takisremark=0 )) or t2.isremark in('1','5','8','9','7'))  and (t1.deleted=0 or t1.deleted is null) and t2.islasttimes=1 and (nvl(t1.currentstatus,-1) = -1 or (nvl(t1.currentstatus,-1)=0 and t1.creater in ("+user.getUID()+")))   and t1.workflowid in (select id from workflow_base where   (isvalid='1' or isvalid='3') ) order by t2.receivedate desc,t2.receivetime desc,t1.requestid desc) tableA  ) my_table where oracle_rownum < 6 and oracle_rownum>0) r  ");
				            	while(rs.next()){
				            		
				            		%>	
	                        		<article class="media"><%--
	                              <a class="pull-left thumb-sm m-t-xs">
	                                <img src="images/avatar10.jpg" class="img-circle">
	                              </a>
	                              --%><div class="media-body">                        
	                                <a href="#" onclick="openWorkFolw('<%=rs.getInt("requestid") %>');" data-toggle="modal" class="font-semibold"><%=rs.getString("requestname") %></a>
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
				            	rs.executeSql("select r.requestid,r.requestname,r.createdate,r.creater from (     select my_table.*, rownum as my_rownum from (    select tableA.*,rownum  as oracle_rownum from (   select  distinct  t1.requestid,t1.requestmark,t1.createdate, t1.createtime,t1.creater, t1.creatertype, t1.workflowid, t1.requestname, t1.requestnamenew, t1.status,t1.requestlevel,t1.currentnodeid,t2.viewtype,t2.userid,t2.receivedate,t2.receivetime,t2.isremark,t2.nodeid,t2.agentorbyagentid,t2.agenttype,t2.isprocessed , (case  WHEN t2.operatedate IS NULL  THEN t2.receivedate ELSE t2.operatedate END) operatedate , (case  WHEN t2.operatetime IS NULL  THEN t2.receivetime ELSE t2.operatetime END) operatetime   from workflow_requestbase t1,workflow_currentoperator t2  where  (t1.deleted <> 1 or t1.deleted is null or t1.deleted='') and t1.requestid = t2.requestid and t2.userid = "+user.getUID()+" and t2.usertype=0 and  (t1.deleted=0 or t1.deleted is null)   and (t2.isremark in('2','4') or (t2.isremark=0 and t2.takisremark =-2)) and (t1.deleted=0 or t1.deleted is null) and t2.islasttimes=1 and (t2.isremark ='2' or (t2.isremark=0 and t2.takisremark =-2)) and t2.iscomplete=0  and (nvl(t1.currentstatus,-1) = -1 or (nvl(t1.currentstatus,-1)=0 and t1.creater in ("+user.getUID()+")))   and t1.workflowid in (select id from workflow_base where   (isvalid='1' or isvalid='3') ) order by operatedate desc,operatetime desc,t1.requestid desc) tableA  ) my_table where oracle_rownum < 6 and oracle_rownum>0) r");
				            	while(rs.next()){
				            		%>	
	                        		<article class="media"><%--
	                              <a class="pull-left thumb-sm m-t-xs">
	                                <img src="images/avatar10.jpg" class="img-circle">
	                              </a>
	                              --%><div class="media-body">                        
	                                <a href="#" onclick="openWorkFolw('<%=rs.getInt("requestid") %>');" data-toggle="modal" class="font-semibold"><%=rs.getString("requestname") %></a>
	                                  <div class="text-xs block m-t-xs"><i class="icon-time"></i> <%=rs.getString("createdate") %>&nbsp;by <%=ResourceComInfo.getLastname(rs.getString("creater")) %></div>
	                              </div>
	                            </article>
	                            <div class="line line-dashed"></div>
	                        	<%
	                        	}
	                          %>
							  <div><div class="line"></div><a target="_blank" href="/workflow/search/WFSearchTemp.jsp?wftypes=&officalType=-1&complete=2&viewType=2&viewScope=done&offical=&method=all&viewcondition=1" class="btn btn-white btn-xs pull-right">More</a></div>
                          </div>
                          <div class="tab-pane" id="recent02">
                            
                           <%	//办结事宜
				            	rs.executeSql("select r.requestid,r.requestname,r.createdate,r.creater from (     select my_table.*, rownum as my_rownum from (    select tableA.*,rownum  as oracle_rownum from (   select  distinct  t1.requestid,t1.requestmark,t1.createdate, t1.createtime,t1.creater, t1.creatertype, t1.workflowid, t1.requestname, t1.requestnamenew, t1.status,t1.requestlevel,t1.currentnodeid,t2.viewtype,t2.userid,t2.receivedate,t2.receivetime,t2.isremark,t2.nodeid,t2.agentorbyagentid,t2.agenttype,t2.isprocessed , (case  WHEN t2.operatedate IS NULL  THEN t2.receivedate ELSE t2.operatedate END) operatedate , (case  WHEN t2.operatetime IS NULL  THEN t2.receivetime ELSE t2.operatetime END) operatetime   from workflow_requestbase t1,workflow_currentoperator t2  where  (t1.deleted <> 1 or t1.deleted is null or t1.deleted='') and t1.requestid = t2.requestid and t2.userid = "+user.getUID()+" and t2.usertype=0 and  (t1.deleted=0 or t1.deleted is null)   and (t2.isremark in('2','4') or (t2.isremark=0 and t2.takisremark =-2)) and (t1.deleted=0 or t1.deleted is null) and t2.islasttimes=1 and t2.iscomplete=1 and t1.currentnodetype = 3  and (nvl(t1.currentstatus,-1) = -1 or (nvl(t1.currentstatus,-1)=0 and t1.creater in ("+user.getUID()+")))   and t1.workflowid in (select id from workflow_base where   (isvalid='1' or isvalid='3') ) order by operatedate desc,operatetime desc,t1.requestid desc) tableA  ) my_table where oracle_rownum < 6 and oracle_rownum>0) r  ");
				            	while(rs.next()){
				            		%>	
	                        		<article class="media"><%--
	                              <a class="pull-left thumb-sm m-t-xs">
	                                <img src="images/avatar10.jpg" class="img-circle">
	                              </a>
	                              --%><div class="media-body">                        
	                                <a href="#" onclick="openWorkFolw('<%=rs.getInt("requestid") %>');" data-toggle="modal" class="font-semibold"><%=rs.getString("requestname") %></a>
	                                  <div class="text-xs block m-t-xs"><i class="icon-time"></i> <%=rs.getString("createdate") %>&nbsp;by <%=ResourceComInfo.getLastname(rs.getString("creater")) %></div>
	                              </div>
	                            </article>
	                            <div class="line line-dashed"></div>
	                        		
	                        	<%
	                        	}
	                          %>
							  <div><div class="line"></div><a target="_blank" href="/workflow/search/WFSearchTemp.jsp?wftypes=&officalType=-1&complete=2&viewType=2&viewScope=done&offical=&method=all&viewcondition=2" class="btn btn-white btn-xs pull-right">More</a></div>
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
                  
              
<script type="text/javascript" src="/js/jquery.table_wev8.js"></script>
<script language="javascript" type="text/javascript" src="/js/init_wev8.js"></script>
<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
<script type="text/javascript" src="/js/jquery-autocomplete/jquery.autocomplete_wev8.js"></script>
<script type="text/javascript" src="/js/jquery-autocomplete/browser_wev8.js"></script>  
<script type="text/javascript" src="/js/messagejs/highslide/highslide-full_wev8.js"></script>
<script type="text/javascript" src="/js/workflow/wfbrow_wev8.js"></script>
<script src="/wui/common/jquery/plugin/Listener_wev8.js" type="text/javascript"></script>
<script src="/js/workflow/VCEventHandle_wev8.js" type="text/javascript"></script>


<input  type="hidden" name="field15141" id="field15141" value="<%=fuwuchooseids%>" onchange="saveanddisfu()"/>
<input type="hidden" name="f_weaver_belongto_userid" value=""/>
<input type="hidden" name="f_weaver_belongto_usertype" value=""/>
<script language="javascript"> 
 	var chromeOnPropListener = null;
	function loadListener(){
		if(chromeOnPropListener==null){
			chromeOnPropListener = new Listener();
		}else{
			chromeOnPropListener.stop();
		}
		chromeOnPropListener.load("[_listener][_listener!='']");
		chromeOnPropListener.start(500,"_listener");
	}


	jQuery("#field15141").bindPropertyChange(function(){
         
		var fuwuids = jQuery("#field15141").val();
		if(fuwuids!=""){
			jQuery.ajax({
				url : "/bsdt/saveandgetfuwu.jsp",
				type : "post",
				async : false,
				processData : false,
				data : "fuwuids="+fuwuids,
				dataType : "html",
				success: function do4Success(msg){ 
					jQuery("#cjfudivid").html(msg.trim());
				}
			});
		}
	});
 
 
</script>






                <section class="panel">
                  <header class="panel-heading">                    
                    常用服务
                      <a href="#" class="btn btn-white btn-xs pull-right" onclick="onShowBrowser2('15141','/systeminfo/BrowserMain.jsp?url=/interface/MultiCommonBrowser.jsp?type=browser.ser_fusx','','162',jQuery($GetEle('field15141')).attr('viewtype'));;">
						<i class="icon-cog"></i>设置
					  </a>
                  </header>


				 



                  <section class="panel-body slim-scroll" data-height="370px"> 

				   <div style="height:370px;">
                      <div class="row" id="cjfudivid">

<%
	rs.beforFirst();
	while(rs.next()){
		String fwmc = rs.getString("fwmc");
		String fwlj = rs.getString("fwlj");
 
%>
                          <div class="col-sm-4 m-b-sm"> 
                              <div class="fuwu2-link center">
                                  <a href="#modal" onclick= "showService('<%=rs.getString("id")%>');" data-toggle="modal">
                                      <span class="icon-stack icon-2x">
                                      <i class="icon-circle text-success icon-stack-base"></i>
                                      <i class="icon-edit-sign icon-light"></i>
                                      </span>
                                  <h5 class="m-b-xs"><%=fwmc%></h5>
                                   </a>
                              </div>   
                          </div>
<%
	}
%>
                             
   


                        </div>
						 </div>
                  </section>

				 






                </section>


              </div>
            </div>
              
              
              
   <%@ include file="recommend.jsp"%>                 
              
              
              
           
              
            <div class="row">
			<div class="col-lg-12 wrapper">
                
                <div class="panel-header center m-b">
                    <h4 class="text-uc">推荐的动态信息</h4>
                    <!-- 
                    <p>您可以将更多的应用动态信息添加到此区域展示</p>
                     -->
                </div>
              <div class="col-lg-6">                
                <section class="panel">
                  <header class="panel-heading panel-title">                    
                    校级文件
                   <span><a target='_blank' href="/docs/search/DocSearchTab.jsp?urlType=16&eid=281&tabid=2&date2during=0" class="btn btn-white btn-xs pull-right">More</a></span> 
					
                  </header>
                  <section class="panel-body slim-scroll" data-height="300px">
                    <%
                           String schoolSql ="select r.id,r.docsubject,r.doclastmoddate,r.ownerid,nvl((select sum(readcount) from docReadTag where userType =1 and docid=r.id and userid="+user.getUID()+"),0) as readCount,"+user.getUID()+" as currentuserid,1 as currentusertype from (     select my_table.*, rownum as my_rownum from (    select tableA.*,rownum  as oracle_rownum from (   select t1.id,t1.seccategory,t1.doclastmoddate,t1.doclastmodtime,t1.docsubject,t1.docextendname,t1.doccreaterid,t2.sharelevel,ownerid,t1.usertype,doccreatedate,doccreatetime,replaydoccount,accessorycount,sumReadCount,docstatus,sumMark from DocDetail  t1 ,(SELECT  sourceid,MAX(sharelevel) AS sharelevel from ShareinnerDoc where((type=1 and content="+user.getUID()+" and seclevel>=0) or (type=2 and content in (1,1) and seclevel<=45 and seclevelmax>=45)  or (type=3 and content in (22,22) and seclevel<=45 and seclevelmax>=45) or  (type=4 and content in (3212,3612,3812) and seclevel<=45 and seclevelmax>=45) or  (type=5 and content=1 and seclevel<=45 and seclevelmax>=45)) GROUP BY sourceid )  t2  where  ( ( t1.docstatus = 7 and  (sharelevel>1 or (t1.doccreaterid="+user.getUID()+" or t1.ownerid="+user.getUID()+")) ) or t1.docstatus in ('1','2','5')  )  and  (isreply!=1 or isreply is null)  and seccategory!=0 and (ishistory is null or ishistory = 0)  and t1.id=t2.sourceid    and exists (select id from docseccategory where id = t1.seccategory and id in (63))  order by doclastmoddate desc,doclastmodtime desc,t1.id desc) tableA  ) my_table where oracle_rownum < 7 and oracle_rownum>0) r  ";
                          	rs.executeSql(schoolSql);
                          	while(rs.next()){
                    	 %>
						 

                    <article class="media">
                      <div class="pull-left">
                        <span class="icon-stack icon-1x">
                          <i class="icon-circle text-info icon-stack-base"></i>
                          <i class="icon-file icon-light"></i>
                        </span>
                      </div>

                      <div class="media-body">
                        <a href="#" data-toggle="modal" onclick="openDoc('<%=rs.getInt("id") %>');" class="h5"><%=rs.getString("docsubject") %></a>
                        <small class="block"><em class="text-xs"><i class="icon-time"></i><%=rs.getString("doclastmoddate") %></em> <span class="label label-info"><%=ResourceComInfo.getLastname(rs.getString("ownerid")) %></span></small>
                      </div>
                    </article>
                     <div class="line pull-in"></div>
                    <%} %>
                  </section>
                </section>


                <section class="panel">
                  <header class="panel-heading panel-title">                    
                    部门文件
                   <span><a target='_blank' href="/docs/search/DocSearchTab.jsp?urlType=16&eid=281&tabid=3&date2during=0" class="btn btn-white btn-xs pull-right">More</a></span> 
                  </header>
                  <section class="panel-body slim-scroll"  data-height="300px">
                  
                    <%
                          	String departSql ="select r.id,r.docsubject,r.doclastmoddate,r.ownerid,nvl((select sum(readcount) from docReadTag where userType =1 and docid=r.id and userid="+user.getUID()+"),0) as readCount,"+user.getUID()+" as currentuserid,1 as currentusertype from (     select my_table.*, rownum as my_rownum from (    select tableA.*,rownum  as oracle_rownum from (   select t1.id,t1.seccategory,t1.doclastmoddate,t1.doclastmodtime,t1.docsubject,t1.docextendname,t1.doccreaterid,t2.sharelevel,ownerid,t1.usertype,doccreatedate,doccreatetime,replaydoccount,accessorycount,sumReadCount,docstatus,sumMark from DocDetail  t1 ,(SELECT  sourceid,MAX(sharelevel) AS sharelevel from ShareinnerDoc where((type=1 and content="+user.getUID()+" and seclevel>=0) or (type=2 and content in (1,1) and seclevel<=45 and seclevelmax>=45)  or (type=3 and content in (22,22) and seclevel<=45 and seclevelmax>=45) or  (type=4 and content in (3212,3612,3812) and seclevel<=45 and seclevelmax>=45) or  (type=5 and content=1 and seclevel<=45 and seclevelmax>=45)) GROUP BY sourceid )  t2  where  ( ( t1.docstatus = 7 and  (sharelevel>1 or (t1.doccreaterid="+user.getUID()+" or t1.ownerid="+user.getUID()+")) ) or t1.docstatus in ('1','2','5')  )  and  (isreply!=1 or isreply is null)  and seccategory!=0 and (ishistory is null or ishistory = 0)  and t1.id=t2.sourceid    and exists (select id from docseccategory where id = t1.seccategory and id in (161))  order by doclastmoddate desc,doclastmodtime desc,t1.id desc) tableA  ) my_table where oracle_rownum < 7 and oracle_rownum>0) r  ";
                          rs.executeSql(departSql);
                        	while(rs.next()){
                        		
                        		%>
                    <article class="media">
                      <div class="pull-left">
                        <span class="icon-stack icon-1x">
                          <i class="icon-circle text-success icon-stack-base"></i>
                          <i class="icon-file icon-light"></i>
                        </span>
                      </div>
                      <div class="media-body">                        
                        <a href="#" onclick="openDoc('<%=rs.getInt("id") %>');" data-toggle="modal" class="h5"><%=rs.getString("docsubject") %></a>
                       <small class="block"><em class="text-xs"><i class="icon-time"></i><%=rs.getString("doclastmoddate") %></em> <span class="label label-info"><%=ResourceComInfo.getLastname(rs.getString("ownerid")) %></span></small>
                      </div>
                    </article>
                    <div class="line pull-in"></div>
                    <%} %>
                  </section>
                </section>

                <section class="panel">
                  <header class="panel-heading panel-title">
					<!--				
                    <ul class="nav nav-pills pull-right">
                      <li>
                        <a href="#" class="panel-toggle text-muted"><i class="icon-caret-down text-active"></i><i class="icon-caret-up text"></i></a>
                      </li>
                    </ul>
					-->
                    年鉴与规章  <span class="badge bg-info"></span>
					<a target='_blank' href="/docs/search/DocSearchTab.jsp?urlType=16&eid=281&tabid=5&date2during=0" class="btn btn-white btn-xs pull-right">More</a>                    
                  </header>
                  <section class="panel-body slim-scroll" data-height="300px">
                  
                    <%
                          	String departSql2 ="select r.id,r.docsubject,r.doclastmoddate,r.ownerid,nvl((select sum(readcount) from docReadTag where userType =1 and docid=r.id and userid="+user.getUID()+"),0) as readCount,"+user.getUID()+" as currentuserid,1 as currentusertype from (     select my_table.*, rownum as my_rownum from (    select tableA.*,rownum  as oracle_rownum from (   select t1.id,t1.seccategory,t1.doclastmoddate,t1.doclastmodtime,t1.docsubject,t1.docextendname,t1.doccreaterid,t2.sharelevel,ownerid,t1.usertype,doccreatedate,doccreatetime,replaydoccount,accessorycount,sumReadCount,docstatus,sumMark from DocDetail  t1 ,(SELECT  sourceid,MAX(sharelevel) AS sharelevel from ShareinnerDoc where((type=1 and content="+user.getUID()+" and seclevel>=0) or (type=2 and content in (1,1) and seclevel<=45 and seclevelmax>=45)  or (type=3 and content in (22,22) and seclevel<=45 and seclevelmax>=45) or  (type=4 and content in (3212,3612,3812) and seclevel<=45 and seclevelmax>=45) or  (type=5 and content=1 and seclevel<=45 and seclevelmax>=45)) GROUP BY sourceid )  t2  where  ( ( t1.docstatus = 7 and  (sharelevel>1 or (t1.doccreaterid="+user.getUID()+" or t1.ownerid="+user.getUID()+")) ) or t1.docstatus in ('1','2','5')  )  and  (isreply!=1 or isreply is null)  and seccategory!=0 and (ishistory is null or ishistory = 0)  and t1.id=t2.sourceid    and exists (select id from docseccategory where id = t1.seccategory and id in (341))  order by doclastmoddate desc,doclastmodtime desc,t1.id desc) tableA  ) my_table where oracle_rownum < 7 and oracle_rownum>0) r  ";
                          rs.executeSql(departSql2);
                        	while(rs.next()){
                        		
                        		%>
                    <article class="media">
                      <div class="pull-left">
                        <span class="icon-stack icon-1x">
                          <i class="icon-circle text-danger icon-stack-base"></i>
                          <i class="icon-file icon-light"></i>
                        </span>
                      </div>
                      <div class="media-body">                        
                        <a href="#" onclick="openDoc('<%=rs.getInt("id") %>');" data-toggle="modal" class="h5"><%=rs.getString("docsubject") %></a>
                       <small class="block"><em class="text-xs"><i class="icon-time"></i><%=rs.getString("doclastmoddate") %></em> <span class="label label-info"><%=ResourceComInfo.getLastname(rs.getString("ownerid")) %></span></small>
                      </div>
                    </article>
                    <div class="line pull-in"></div>
                    <%} %>
                  </section>
                </section>

              </div>


              <div class="col-lg-6">                
                <section class="panel">
                  <header class="panel-heading panel-title">                    
                    通知公告 <span class="badge bg-danger"></span>
					<a target='_blank' href="/docs/search/DocSearchTab.jsp?urlType=16&eid=401&tabid=1&date2during=0" class="btn btn-white btn-xs pull-right">More</a>
                  </header>
                  <section class="panel-body slim-scroll" data-height="300px">
                  <%rs.executeSql("select r.id,r.docsubject,r.doclastmoddate,r.ownerid,nvl((select sum(readcount) from docReadTag where userType =1 and docid=r.id and userid="+user.getUID()+"),0) as readCount,"+user.getUID()+" as currentuserid,1 as currentusertype from (     select my_table.*, rownum as my_rownum from (    select tableA.*,rownum  as oracle_rownum from (   select t1.id,t1.seccategory,t1.doclastmoddate,t1.doclastmodtime,t1.docsubject,t1.docextendname,t1.doccreaterid,t2.sharelevel,ownerid,t1.usertype,doccreatedate,doccreatetime,replaydoccount,accessorycount,sumReadCount,docstatus,sumMark from DocDetail  t1 ,(SELECT  sourceid,MAX(sharelevel) AS sharelevel from ShareinnerDoc where((type=1 and content="+user.getUID()+" and seclevel>=0) or (type=2 and content in (1,1) and seclevel<=45 and seclevelmax>=45)  or (type=3 and content in (22,22) and seclevel<=45 and seclevelmax>=45) or  (type=4 and content in (3212,3612,3812) and seclevel<=45 and seclevelmax>=45) or  (type=5 and content=1 and seclevel<=45 and seclevelmax>=45)) GROUP BY sourceid )  t2  where  ( ( t1.docstatus = 7 and  (sharelevel>1 or (t1.doccreaterid="+user.getUID()+" or t1.ownerid="+user.getUID()+")) ) or t1.docstatus in ('1','2','5')  )  and  (isreply!=1 or isreply is null)  and seccategory!=0 and (ishistory is null or ishistory = 0)  and t1.id=t2.sourceid    and exists (select id from docseccategory where id = t1.seccategory and id in (61))  order by doclastmoddate desc,doclastmodtime desc,t1.id desc) tableA  ) my_table where oracle_rownum < 7 and oracle_rownum>0) r  ");
				      while(rs.next()){
				      	
				    	 %>	
                    <article class="media">
                      <div class="pull-left">
                        <span class="icon-stack icon-1x">
                          <i class="icon-circle text-primary icon-stack-base"></i>
                          <i class="icon-file icon-light"></i>
                        </span>
                      </div>
                      <div class="media-body">
                        <a href="#" data-toggle="modal" onclick="openDoc('<%=rs.getInt("id") %>');" class="h5"><%=rs.getString("docsubject") %></a>
                        <small class="block"><em class="text-xs"><i class="icon-time"></i><%=rs.getString("doclastmoddate") %></em> <span class="label label-info"><%=ResourceComInfo.getLastname(rs.getString("ownerid")) %></span></small>
                      </div>
                    </article>
                     <div class="line pull-in"></div>
                    <%} %>
                  </section>
                </section>


                <section class="panel">
                  <header class="panel-heading panel-title">
				  <!--
                    <ul class="nav nav-pills pull-right">
                      <li>
                        <a href="#" class="panel-toggle text-muted"><i class="icon-caret-down text-active"></i><i class="icon-caret-up text"></i></a>
                      </li>
                    </ul>
					-->
                    信息简报<span class="badge bg-info"></span>
					<a target='_blank' href="/docs/search/DocSearchTab.jsp?urlType=16&eid=281&tabid=4&date2during=0" class="btn btn-white btn-xs pull-right">More</a>
                  </header>
				  <section class="panel-body slim-scroll" data-height="300px">
                     <%rs.executeSql("select r.id,r.docsubject,r.doclastmoddate,r.ownerid,nvl((select sum(readcount) from docReadTag where userType =1 and docid=r.id and userid="+user.getUID()+"),0) as readCount,"+user.getUID()+" as currentuserid,1 as currentusertype from (     select my_table.*, rownum as my_rownum from (    select tableA.*,rownum  as oracle_rownum from (   select t1.id,t1.seccategory,t1.doclastmoddate,t1.doclastmodtime,t1.docsubject,t1.docextendname,t1.doccreaterid,t2.sharelevel,ownerid,t1.usertype,doccreatedate,doccreatetime,replaydoccount,accessorycount,sumReadCount,docstatus,sumMark from DocDetail  t1 ,(SELECT  sourceid,MAX(sharelevel) AS sharelevel from ShareinnerDoc where((type=1 and content="+user.getUID()+" and seclevel>=0) or (type=2 and content in (1,1) and seclevel<=45 and seclevelmax>=45)  or (type=3 and content in (22,22) and seclevel<=45 and seclevelmax>=45) or  (type=4 and content in (3212,3612,3812) and seclevel<=45 and seclevelmax>=45) or  (type=5 and content=1 and seclevel<=45 and seclevelmax>=45)) GROUP BY sourceid )  t2  where  ( ( t1.docstatus = 7 and  (sharelevel>1 or (t1.doccreaterid="+user.getUID()+" or t1.ownerid="+user.getUID()+")) ) or t1.docstatus in ('1','2','5')  )  and  (isreply!=1 or isreply is null)  and seccategory!=0 and (ishistory is null or ishistory = 0)  and t1.id=t2.sourceid    and exists (select id from docseccategory where id = t1.seccategory and id in (62))  order by doclastmoddate desc,doclastmodtime desc,t1.id desc) tableA  ) my_table where oracle_rownum < 7 and oracle_rownum>0) r  ");
				      while(rs.next()){
				      	
				    	 %>	
                    <article class="media">
                      <div class="pull-left">
                        <span class="icon-stack icon-1x">
                          <i class="icon-circle text-warning icon-stack-base"></i>
                          <i class="icon-file icon-light"></i>
                        </span>
                      </div>
                      <div class="media-body">
                        <a href="#" data-toggle="modal" onclick="openDoc('<%=rs.getInt("id") %>');" class="h5"><%=rs.getString("docsubject") %></a>
                        <small class="block"><em class="text-xs"><i class="icon-time"></i><%=rs.getString("doclastmoddate") %></em> <span class="label label-info"><%=ResourceComInfo.getLastname(rs.getString("ownerid")) %></span></small>
                      </div>
                    </article>
                     <div class="line pull-in"></div>
                    <%} %>
                  </section>
                </section>

                <section class="panel">
                  <header class="panel-heading panel-title">
					<!--				
                    <ul class="nav nav-pills pull-right">
                      <li>
                        <a href="#" class="panel-toggle text-muted"><i class="icon-caret-down text-active"></i><i class="icon-caret-up text"></i></a>
                      </li>
                    </ul>
					-->
                    出访公示  <span class="badge bg-info"></span>
					<a target='_blank' href="/docs/search/DocSearchTab.jsp?urlType=16&eid=401&tabid=2&date2during=0" class="btn btn-white btn-xs pull-right">More</a>                    
                  </header>
                  <section class="panel-body slim-scroll" data-height="300px">
                    <%
                          	String departSql3 ="select r.id,r.docsubject,r.doclastmoddate,r.ownerid,nvl((select sum(readcount) from docReadTag where userType =1 and docid=r.id and userid="+user.getUID()+"),0) as readCount,"+user.getUID()+" as currentuserid,1 as currentusertype from (     select my_table.*, rownum as my_rownum from (    select tableA.*,rownum  as oracle_rownum from (   select t1.id,t1.seccategory,t1.doclastmoddate,t1.doclastmodtime,t1.docsubject,t1.docextendname,t1.doccreaterid,t2.sharelevel,ownerid,t1.usertype,doccreatedate,doccreatetime,replaydoccount,accessorycount,sumReadCount,docstatus,sumMark from DocDetail  t1 ,(SELECT  sourceid,MAX(sharelevel) AS sharelevel from ShareinnerDoc where((type=1 and content="+user.getUID()+" and seclevel>=0) or (type=2 and content in (1,1) and seclevel<=45 and seclevelmax>=45)  or (type=3 and content in (22,22) and seclevel<=45 and seclevelmax>=45) or  (type=4 and content in (3212,3612,3812) and seclevel<=45 and seclevelmax>=45) or  (type=5 and content=1 and seclevel<=45 and seclevelmax>=45)) GROUP BY sourceid )  t2  where  ( ( t1.docstatus = 7 and  (sharelevel>1 or (t1.doccreaterid="+user.getUID()+" or t1.ownerid="+user.getUID()+")) ) or t1.docstatus in ('1','2','5')  )  and  (isreply!=1 or isreply is null)  and seccategory!=0 and (ishistory is null or ishistory = 0)  and t1.id=t2.sourceid    and exists (select id from docseccategory where id = t1.seccategory and id in (921))  order by doclastmoddate desc,doclastmodtime desc,t1.id desc) tableA  ) my_table where oracle_rownum < 7 and oracle_rownum>0) r";
                          rs.executeSql(departSql3);
                        	while(rs.next()){
                        		
                        		%>
                    <article class="media">
                      <div class="pull-left">
                        <span class="icon-stack icon-1x">
                          <i class="icon-circle text-muted icon-stack-base"></i>
                          <i class="icon-file icon-light"></i>
                        </span>
                      </div>
                      <div class="media-body">                        
                        <a href="#" onclick="openDoc('<%=rs.getInt("id") %>');" data-toggle="modal" class="h5"><%=rs.getString("docsubject") %></a>
                       <small class="block"><em class="text-xs"><i class="icon-time"></i><%=rs.getString("doclastmoddate") %></em> <span class="label label-info"><%=ResourceComInfo.getLastname(rs.getString("ownerid")) %></span></small>
                      </div>
                    </article>
                    <div class="line pull-in"></div>
                    <%} %>
                  </section>
                </section>
              </div>
                

                
			  </div>
            </div>
              
              
              
              
              
              
              
              
              
              <!-- .底部的系统链接 -->
          <div class="row wrapper">
            <div class="col-lg-12 m-t">
                
                <section class="panel bg-light">
                  
                      
                    <div class="m-t m-l m-r m-b">

				<div class="row the-icons">  
                    
                  <%
											rs2.executeSql("select *  from uf_mhlj order by xh");
											while(rs2.next()){
												String ljdz=rs2.getString("ljdz");
												String ljtb=rs2.getString("ljtb");
												rs3.executeSql("select selectname from workflow_selectitem where fieldid='15082' and selectvalue='"+ljtb+"' ");
												if(rs3.next()){
													ljtb=rs3.getString("selectname");
												}
												String ljmz=rs2.getString("ljmz");										

                  %>
                  	<div class="col-sm-2"><a href="<%=ljdz%>" target="_blank" class="bg-white m5"><i class="<%=ljtb%>"></i><%=ljmz%></a></div>
                  <%
											}
                  %>
                   <!-- 
                      <div class="col-sm-2"><a href="http://oa.tongji.edu.cn" target="_blank" class="bg-white m5"><i class="icon-bullseye"></i> 协同办公系统</a></div>
                    
                      <div class="col-sm-2"><a href="http://mail.tongji.edu.cn" target="_blank" class="bg-white  m5"><i class="icon-adjust"></i> 邮件系统</a></div>
                    
                      <div class="col-sm-2"><a href="http://rs.tongji.edu.cn/epstar/" target="_blank" class="bg-white  m5"><i class="icon-calendar-empty"></i> 人事系统</a></div>
                    
                      <div class="col-sm-2"><a href="http://cwc.tongji.edu.cn/WFManager/index2.jsp" target="_blank" class="bg-white  m5"><i class="icon-file-text"></i> 财务系统</a></div>
                    
                      <div class="col-sm-2"><a href="http://211.tongji.edu.cn/" target="_blank" class="bg-white  m5"><i class="icon-anchor"></i> 专项经费系统</a></div>
                    
                      <div class="col-sm-2"><a href="http://ky.tongji.edu.cn/epstar/login/index.jsp" target="_blank" class="bg-white  m5"><i class="icon-hand-right"></i> 科研系统 </a></div>
                    
                    <div class="col-sm-2"><a href="http://4m3.tongji.edu.cn/" target="_blank" class="bg-white  m5"><i class="icon-signout"></i> 一体化教务系统</a></div>
                    
                      <div class="col-sm-2"><a href="http://zcc.tongji.edu.cn" target="_blank" class="bg-white  m5"><i class="icon-signout"></i> 资产住房系统</a></div>
                    
                     <div class="col-sm-2"><a href="http://czb.tongji.edu.cn/index_cg.jsp" target="_blank" class="bg-white  m5"><i class="icon-anchor"></i> 采购系统</a></div>
                    
                      <div class="col-sm-2"><a href="http://shbc.tongji.edu.cn" target="_blank" class="bg-white  m5"><i class="icon-hand-right"></i> 设备系统 </a></div>
                    
                      <div class="col-sm-2"><a href="http://www.lib.tongji.edu.cn/site/tongji/index.html" target="_blank" class="bg-white  m5"><i class="icon-signout"></i> 图书馆</a></div>
                    
                    <div class="col-sm-2"><a href="http://www.tongji.edu.cn/archives/" target="_blank" class="bg-white  m5"><i class="icon-signout"></i> 档案馆</a></div>
                    -->
                    
                  </div>
				  
				  </div>
                </section>
                                        
                </div>
				</div>
              <!--/ .底部的相关系统链接 -->
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              <footer class="footer bg-black pull-out m-t-xl">
                  <p>同济大学 版权所有. 上海市四平路1239号  E-mail:servicecenter@tongji.edu.cn 沪ICP备10014176号</p>
              </footer>              

              
          </div>
        </section>
        
      </section>
    <!-- /.vbox -->
    
    
    
    
    
    
    
    
      
    <!-- .modal -->  
   <div id="modal" class="modal fade" >
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title" ><span id="fwmcTitleId">校园网二级域名及外网IP地址申请</span></h4>
        </div>
        <div class="modal-body">
          <section class="panel">
               <div class="table-responsive">
                  <table class="table table-striped text-sm  m-b-sm">
                    <tbody>
                      <tr>
                        <th>服务名称</th>
                        <td id="fwmcid"></td>
                        <td width="10"></td>
                        <th>事项编号</th>
                        <td id="sxbhid"></td>
                      </tr>
                        <tr>
                        <th>事项简称</th>
                        <td id="sxjcid"></td>
                        <td width="10"></td>
                        <th>承诺期限</th>
                        <td id="cnqxid"></td>
                      </tr>
                      <tr>
                        <th>受理地址</th>
                        <td id="sldzid"></td>
                        <td width="10"></td>
                        <th>事务负责人</th>
                        <td id="swfzrid"></td>
                      </tr>
                        <tr>
                        <th>咨询电话</th>
                        <td id="zxdhid"></td>
                        <td width="10"></td>
                        <th>监督电话</th>
                        <td id="jddhid"></td>
                      </tr>
                      <tr>
                        <th>部门类型</th>
                        <td id="bmlxid"></td>
                        <td width="10"></td>
                        <th>服务类型</th>
                        <td id="fwlxid"></td>
                      </tr>
                        <tr>
                        <th>流程图</th>
                        <td colspan="4" id="lctid">
                        </td>
                      </tr>                        
                      <tr>
                        <th>相关资料</th>
                        <td colspan="4" id="xgzlid">
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              <div class="line"></div>
              <div class="modal-body" id="sxsmid">
              </div>
          </section>
        </div>
        <div class="modal-footer">
        	<input type="hidden" id="fwljid" />
          <button type="button" class="btn btn-info" id="submitid" onclick="submitWf();" >立即申请</button>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div> <!-- /.modal -->
  
  
  

  
  
  
  
  <!-- Bootstrap -->
  <script src="js/bootstrap.js"></script>
  <!-- App -->
  <script src="js/app.js"></script>
  <script src="js/app.plugin.js"></script>
  <script src="js/app.data.js"></script>
  <script src="js/slimscroll/jquery.slimscroll.min.js" cache="false"></script>
  <script src="js/libs/moment.min.js"></script>
  <script src="js/charts/easypiechart/jquery.easy-pie-chart.js"></script>
  
  
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