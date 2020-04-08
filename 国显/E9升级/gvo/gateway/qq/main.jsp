<!DOCTYPE HTML>
	<%@ page language="java" contentType="text/html; charset=UTF-8"%>
	<%@include file="jsp/mainCode.jsp" %>
	<%@ page import="weaver.systeminfo.setting.HrmUserSettingComInfo" %>
	<%@ page import="java.sql.Timestamp" %> 
	<%@ include file="/docs/common.jsp" %>
	<jsp:useBean id="VotingManager" class="weaver.voting.VotingManager" scope="page" />
	<jsp:useBean id="signRs" class="weaver.conn.RecordSet" scope="page"/>
	<jsp:useBean id="rspop" class="weaver.conn.RecordSet" scope="page"/>
	<jsp:useBean id="rspopuser" class="weaver.conn.RecordSet" scope="page"/>
	<jsp:useBean id="HrmScheduleDiffUtil" class="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil" scope="page" />
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8;" />
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10">
		<meta http-equiv="X-UA-Compatible" content="IE=10" >
		<title>企业办公平台</title>
		<link rel="stylesheet" type="text/css" href="common/css/slide.css?v=20190627" />
		<link rel="stylesheet" type="text/css" href="common/css/fx.css?v=20190929" />
		<link rel="stylesheet" type="text/css" href="common/css/gdt-style.css?v=20190926" />
		<link rel="stylesheet" type="text/css" href="index.css?v=20190929" />
		<link rel="stylesheet" type="text/css" href="paging.css?v=20190929" />
		<link rel="stylesheet" type="text/css" href="common/css/style.css?v=20190627">
		<script type="text/javascript" src="common/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="common/js/jquery.js"></script>
		<script type="text/javascript" src="common/js/slider.js"></script>
		<script language="javascript" type="text/javascript" src="/js/init_wev8.js"></script>
		<script language=javascript src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
		<script type="text/javascript" src="/js/ecology8/lang/weaver_lang_<%=user.getLanguage()%>_wev8.js"></script>
		<script type="text/javascript">
			if (!String.prototype.trim) {
				String.prototype.trim = function() {
					return this.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
				};
			}
		</script>
		<style type="text/css" media="screen">
			body,html{
				height:100%;
			}
			#EmployeeHelp .info{
				position: absolute;
			    top: 85%;
			    text-align: center;
			    margin-left: 0px;
			    font-size: 11px;
			    color: rgb(255,255,255);
			    width: 100%;
			    font-weight: bold;
			}
			#continar{
				position: absolute;top:50%;
				left: 50%;
				margin-top: -283px;
				margin-left:-583px;
			}
			html, body {
    margin:0;
    padding:0;
    font-family: 'Arial', '微软雅黑';
    font-size: 0.9em;
    text-align: center;
    background-color:#fff;
}

input, select {
    font-size:0.9em;
}



h4 {
    font-size:1.1em;
    text-decoration:none;
    font-weight:normal;
    color:#23A4FF;
}

a {
    color:rgb(50,255,255)
}

#container {
    width: 100%;
    height: 100%;
    margin:0 auto;
    position:relative;
}

#left-container, 
#right-container, 
#center-container {
    height:100%;
    position:absolute;
    top:0;
}

#left-container, #right-container {
    width:200px;
    color:#686c70;
    text-align: left;
    overflow: auto;
    background-color:#fff;
    background-repeat:no-repeat;
    border-bottom:1px solid #ddd;
}

#left-container {
    left:0;
    background-image:url('col2.png');
    background-position:center right;
    border-left:1px solid #ddd;
    
}

#right-container {
    right:0;
    background-image:url('col1.png');
    background-position:center left;
    border-right:1px solid #ddd;
}

#right-container h4{
    text-indent:8px;
}

#center-container {
    width:100%;
    left:0px;
    background-color:#fff;
    color:#ccc;
}

.text {
    margin: 7px;
}

#inner-details {
    font-size:0.8em;
    list-style:none;
    margin:7px;
}

#log {
    position:absolute;
    top:10px;
    font-size:1.0em;
    font-weight:bold;
    color:#23A4FF;
}


#infovis {
    position:relative;
    width:100%;
    height:100%;
    margin:auto;
    overflow:hidden;
}

/*TOOLTIPS*/
.tip {
    color: #111;
    width: 139px;
    background-color: white;
    border:1px solid #ccc;
    -moz-box-shadow:#555 2px 2px 8px;
    -webkit-box-shadow:#555 2px 2px 8px;
    -o-box-shadow:#555 2px 2px 8px;
    box-shadow:#555 2px 2px 8px;
    opacity:0.9;
    filter:alpha(opacity=90);
    font-size:10px;
    font-family:Verdana, Geneva, Arial, Helvetica, sans-serif;
    padding:7px;
}
		</style>
	</head>
	<body >
		<input type = "hidden" value = "<%=userid %>" id = "userid">
		<div id = "background" style = "display:none"><%=background%></div>
		<input type = "hidden" value = "<%=imageSrc %>" id = "backgroundImage">
		<div class="container" id ="contentUpdate" style = "min-height: 620px;position: relative;" >
			<!-- 顶部工具栏 -->
			<div class="header" style = "">
				<div class="rightContent"  style = "">
                	<div id="logoArea" style = "" ></div>
	                <div id="toolbar" >
	                    <div id="searchContent"><jsp:include page="search.jsp"></jsp:include></div>
                	</div>
                	<div id="btnContent">
                		<ul class="btns">
                			<a href = "#"><li id = "skinPeeler"></li></a>
                			<!-- 多语言的按钮 -->
                			<!-- <a href = "#"><li id="language" class="language<%=user.getLanguage()%>"></li></a>-->
                			<a href = "/wui/main.jsp" target="_blank"><li id = "oaMain" ></li></a>
                			<a href = "#" id = "Logout"><li id = "signOut" ></li></a>
                		</ul>
                		<!--左上角提示-->
                		<ul class="btns" style = "margin-top:5px;margin-left: 0px;">
                			<li class = "skinPeeler_tips" style = "width:30px;margin-left: 8px;display: none;">
                				<div style= "border:1px solid #666;color:#000;background-color: rgb(255,255,255);text-align:center" ><%=SystemEnv.getHtmlLabelName(128976,user.getLanguage())%></div>
                			</li>
                			<li class = "language_tips" style = "width:60px;margin-left:35px ;display: none;">
                				<div style= "border:1px solid #666;color:#000;background-color: rgb(255,255,255);text-align: center" ><%=SystemEnv.getHtmlLabelName(-20127,user.getLanguage())%></div>
                			</li>
                			<!-- 多语言开启需要调整样式 -->
                			<!--<li class = "oaMain_tips" style = "width:55px;margin-left:85px ;display: none;">-->
							<li class = "oaMain_tips" style = "width:50px;margin-left:42px ;display: none;">
                				<div style= "border:1px solid #666;color:#000;background-color: rgb(255,255,255);text-align: center" ><%=SystemEnv.getHtmlLabelName(-20111,user.getLanguage())%></div>
                			</li>
                			<li  class = "signOut_tips" style = "width:30px;float:right;margin-right:5px;display: none;">
                				<div style= "border:1px solid #666;color:#000;background-color: rgb(255,255,255);text-align: center" ><%=SystemEnv.getHtmlLabelName(1205,user.getLanguage())%></div>
                			</li>
                		</ul>
					</div>
				</div>
			</div>
			<div class="content" id = "content" style = "height:calc(100% - 100px);position:relative;position:fixed;top:80px;">

				<div id="continar" >
					<div id="itemContent" >
						<!-- 换肤 -->
						<div class = "skinPeeler" >
							<div style = " width:95%; height:50px;"><div class= "skinPeelerClose"><%=SystemEnv.getHtmlLabelName(309 ,user.getLanguage())%></div></div>
							<div class="tree" id="fenye"></div>
			        		<div class="fenye" >
						        <div class="fenye_list">
						            <ul id="fenye_list"></ul>
						            <a class="page"><%= SystemEnv.getHtmlLabelNames("19083,30642",user.getLanguage())%>：<span id="page"></span><%=SystemEnv.getHtmlLabelName(30642 ,user.getLanguage())%></a>
						       	</div>
			        		</div>
						</div>
						<!-- 系统的导航菜单 -->
						<div class="row ">
							<div id="Navigation">
								<div id="Navigationheader">
									<div id="Navcenternav">
										<ul id= "NavtwoLevelMenu">
											<li class = "NavValue">
												<%=SystemEnv.getHtmlLabelName(381972 ,user.getLanguage())%>
											</li>
											<div class="clear">&nbsp;</div>
										</ul>
									</div>
									<div id="tab-left" ></div>  
	            					<div id="tab-right" style = "right:10px"><%=SystemEnv.getHtmlLabelName(309 ,user.getLanguage())%></div>
									<div class="clear"> &nbsp;</div>
								</div>
								<div id="Navcentercontent" >
									<% 
										for (int i=0;i<navDivContent.length();i++ ) {
											JSONObject navDivContentValue = navDivContent.getJSONObject(i);
									%>
										<div class = "NavDivContent">
											<a href = '<%=navDivContentValue.get("url")%>' target="_blank">
												<div class = "NavDivLogo" style = '<%=navDivContentValue.get("imageSrc") %>'>
												</div>
												<div class = "NavDivTitle">
													<%=navDivContentValue.get("name")%>
												</div>
											</a>
										</div>
									<% }%>
									
								</div>

							</div>
							<div class="clear" style = "clear: both">&nbsp;</div>
						</div>
						<div class="row Layout" >
							<!--新闻 -->
							<div class="item addUpdate modelNew  " id="workCenter" >
								<div class = "news"><%=SystemEnv.getHtmlLabelName(316,user.getLanguage())%>
								</div>
								<div class="mod18" style = "width:100%;height:100%;margin-left: 0.3%;border-radius: 10px 10px 0px 0px;position: relative;">
									<span id="prev" class="btn prev" style = "position: absolute;width:15px;height:25px;z-index: 98;top:85%;left: 10px;background-image:url('common/img/left.png');background-size: 100% 100%"></span>
									<span id="next" class="btn next" style = "position: absolute;width:15px;height:25px;z-index: 98;top:85%;left: 95%;background-image:url('common/img/right.png');background-size: 100% 100%"></span>
									<span id="prevTop" class="btn prev" style = "display:none"></span>
									<span id="nextTop" class="btn next" style = "display:none"></span>
									<div id="picBox" class="picBox" style = "border-radius: 10px 10px 0px 0px;">
										<ul class="cf" style = "width:100%">
											<%
												for (int i=0;i<SowingMap_v2.length();i++ ) {
													JSONObject SowingMap_v2Value = SowingMap_v2.getJSONObject(i);
											%>
												<li>
													<a href = "<%=SowingMap_v2Value.get("url") %>" target = "_blank" class = "cf_a" >
														<img src = "/weaver/weaver.file.FileDownload?fileid=<%=SowingMap_v2Value.get("imagefileid") %>"/>
													</a>
												</li>
											<%}%>
										</ul>
									</div>
									<div id="listBox" class="listBox" style = "border-radius: 0px 0px 10px 10px">
										<ul class="cf">
											<%
												for (int i=0;i<SowingMap_v2.length();i++ ) {
													JSONObject SowingMap_v2Value = SowingMap_v2.getJSONObject(i);
											%>
												<li>
													<i class="arr2"></i>
													<img src="/weaver/weaver.file.FileDownload?fileid=<%=SowingMap_v2Value.get("imagefileid") %>"/>
												</li>

											<%}%>
										</ul>
									</div>
									<div class="clear"></div>
								</div>
							</div>
		                    <!-- 新闻咨询 -->
	                        <div class="item dynamic1 open addUpdate ie8-border-radius model" id="gzzd" >
	                       		<div class = "newsTitle" style = "height:20%">
	                       			<span><%=SystemEnv.getHtmlLabelName(-20112 ,user.getLanguage())%></span>
	                       			<a href = "<%=companyNews %>" target = "_blank">
	                       				<span><%=SystemEnv.getHtmlLabelName(131654 ,user.getLanguage())%></span>
	                       			</a>
	                       			<div class="clear" style = "clear: both">&nbsp;</div>
	                       		</div>
	                       		<div class="clear" style = "clear: both">&nbsp;</div>
	                       		<div class = "newsContent" style = "height:70%">
	                       			<ul style = "height:100%;">
	                       				<% 
                                            for (int i=0;i<companynewsList.size();i++ ) {
                                                Map companynewsItem = (Map)companynewsList.get(i);
                                        %>
                                         		<li style = "height:17.5%">
                                                    <a href="/docs/docs/DocDsp.jsp?id=<%=companynewsItem.get("docid") %>" onclick="hideUnread(<%=companynewsItem.get("docid")%>)" target="_blank">
                                                        <%=companynewsItem.get("docsubject") %>
                                                    </a>
                                                </li>
                                        <%
                                            }
                                        %>	
	                       			</ul>
	                       		</div>
	                        </div>
	                        <!-- 我的待办-->
	                        <a href = "<%=todo %>" target="_blank">
	                        	<div class="addUpdate model" id="_hotnews">
	                        		<div class = "_hotnewsLogo" id = "hotnewsLogo"><%=lcNumber%></div>
	            	                        		<div class= "_hotnewsTitle" >
	                        			<%=SystemEnv.getHtmlLabelName(381970 ,user.getLanguage())%>
	                        		</div>
	                        	</div>
	                        </a>
	                        <!-- 系统导航 -->
	                        <div class="item addUpdate model" id="_noticenews" style="cursor: default;" url="">
	                        	<div class= "_hotnewsTitle model">
	                        		<%=SystemEnv.getHtmlLabelName(381972 ,user.getLanguage())%>
	                        	</div>
	                        </div>
	                        <!-- 新建流程 -->
	                       <div class="item dynamic1 open addUpdate model" id="tz" >
	                          	<div class= "_hotnewsTitle"><%=SystemEnv.getHtmlLabelName(16392 ,user.getLanguage())%></div>
	                        </div>
	                        
	                        <!-- 通知公告 -->
	                        <div class="item dynamic1 open addUpdate model" id="qywh" >
	                         	<div class = "noticeTitle" style = "height:20%">
	                       			<span><%=SystemEnv.getHtmlLabelName(22818 ,user.getLanguage())%></span>
	                       			<a href = "<%=noticeSum %>" target="_blank">
	                       				<span><%=SystemEnv.getHtmlLabelName(131654 ,user.getLanguage())%></span>
	                       			</a>
	                       			<div class="clear" style = "clear: both">&nbsp;</div>
	                       		</div>
	                       		<div class="clear" style = "clear: both">&nbsp;</div>
	                       		<div class = "noticeContent" style = "height:70%">
	                       			<ul style = "height:100%;">
										<% 
                                            for (int i=0;i<noticeBulletinList.size();i++ ) {
                                                Map noticeBulletinItem = (Map)noticeBulletinList.get(i);
                                        %>
                                         		<li style = "height:17.5%">
                                                    <a href="/docs/docs/DocDsp.jsp?id=<%=noticeBulletinItem.get("docid") %>" onclick="hideUnread(<%=noticeBulletinItem.get("docid")%>)" target="_blank">
                                                        <%=noticeBulletinItem.get("docsubject") %>
                                                    </a>
                                                </li>
                                        <%
                                            }
                                        %>	
	                       				
	                       			</ul>
	                       		</div>
	                        </div>
	                        <!--会议中心 -->
	                        <a href = "<%=metting%>" target = "_blank">
	                        	<div class="item addUpdate model" id="zszx" style="cursor: default;">
	                          		<div class= "_hotnewsTitle"><%=SystemEnv.getHtmlLabelName(382135 ,user.getLanguage())%></div>
	                        	</div>
	                        </a>
						</div>
						<div class="clear" style = "clear: both">&nbsp;</div>

						<!-- 新建流程菜单 -->
						<div class="row">
							<div id="wfcenter">
								<div id="wfcenterheader">
									<div id="wfcenternav">
										<ul id= "twoLevelMenu" >
											<li class = "createRequest">
												<div class = "value createNew clickStyle" style = "font-size: 18px;font-weight: bold;" >
													OA&nbsp;<%=SystemEnv.getHtmlLabelName(22244,user.getLanguage())%>
												</div>
											</li> 
											<li class = "">
												<div class = "value ECRequest">EC&nbsp;<%=SystemEnv.getHtmlLabelName(22244,user.getLanguage())%></div>
											</li>
											<div class="clear">&nbsp;</div>
										</ul>
										
									</div>
									<a  href = "" target = "_target">
										<div id="tab-left" ><%=SystemEnv.getHtmlLabelName(131654,user.getLanguage())%></div>
									</a>  
	            					<div id="tab-right">>></div>
									<div class="close" id = "close"><%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%></div>
									<div class="clear"> &nbsp;</div>
								</div>
								<!-- 新建流程 -->
								<div id="wfcentercontent" class = "dd" style = "margin-top:0px">
									<ul style = "width:100%">
										<% 
                                            for (int i=0;i<OALC.length();i++ ) {
                                                JSONObject OALCValue = OALC.getJSONObject(i);
                                        %>
                                         		<li class = "ecli" style = "" >
                                                    <a href="/workflow/request/AddRequest.jsp?workflowid=<%=OALCValue.get("wfid")%>" target="_blank"   style = width:100%;display:block;border:1px '>
                                                        <%=OALCValue.get("workflowname") %>
                                                    </a>
                                                </li>
                                        <%
                                            }
                                        %>	
										
									</ul>
								</div>

								<!-- EC流程 -->
								<div id="wfcentercontent" class= "aa" style = "margin-top:0px" >
									<ul style = "width:100%">
										<% 
                                            for (int i=0;i<ECLC.length();i++ ) {
                                                JSONObject ECLCValue = ECLC.getJSONObject(i);
                                        %>
                                         		<li class = "ecli" style = "" id = ecli>
                                                    <a href="/gvo/gateway/jsp/sendKsbbUrl.jsp?wid=<%=ECLCValue.get("wfid")%>" target="_blank" style = width:100%;display:block;border:1px '>
                                                        <%=ECLCValue.get("workflowname") %>
                                                    </a>
                                                </li>
                                        <%
                                            }
                                        %>	
										
									</ul>

								</div>
							</div>
							<div class="clear" style = "clear: both">&nbsp;</div>
						</div>

						<div class="row  footerRow layoutlast" >
							<div class="item modelLast" id="zsxt" url="">
		                        <!-- 知识门户 --><!-- 调整成KM/SOP知识管理系统 -->
		                        <a href = "<%=knowledge %>" target="_blank">
		                        	<div class="item open addUpdate_top" id="rcap" style="height: 30%;">
		                         		<div class= "_hotnewsTitle" style="top: 20%;margin-left: 6%;"><%=SystemEnv.getHtmlLabelName(-20109,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(-20107,user.getLanguage())%></div>
		                        	</div>
		                    	</a>
		                        <!-- 制度门户-最新文件 -->
		                        <div class="item dynamic1 open addUpdate_buttom" id="_companynews" style="height: 70%;">
		                         	<div class = "regulationsTitle" style = "height:20%">
		                       			<span><%=SystemEnv.getHtmlLabelNames("30902,18493",user.getLanguage())%></span>
		                       			<a href = "<%=regulationsBulletinMore %>" target="_blank">
		                       				<span><%=SystemEnv.getHtmlLabelName(131654 ,user.getLanguage())%></span>
		                       			</a>
		                       			<div class="clear" style = "clear: both">&nbsp;</div>
		                       		</div>
		                       		<div class = "regulationsContent" style = "height:80%">
											<%
											for (int i=0;i<regulationsBulletin.length();i++ ) {
												JSONObject regulationsBulletin_value = regulationsBulletin.getJSONObject(i);
											%>     
	                                        	<ul style = "height:19.5%;width:100%;">
	                                         		<li>
	                                         			<% 
                                         					if(regulationsBulletin_value.get("regultionsFileStatus").equals("新增")){
                                     					%>
                                     							<%=SystemEnv.getHtmlLabelName(-20708,user.getLanguage())%>
                                     					<%
	                                         				}else if(regulationsBulletin_value.get("regultionsFileStatus").equals("更新")){
                                         				%>
                                         						<%=SystemEnv.getHtmlLabelName(-20709,user.getLanguage())%>
                                         				<%
	                                         				}else if(regulationsBulletin_value.get("regultionsFileStatus").equals("废除")){
                                         				%>
                                         						<%=SystemEnv.getHtmlLabelName(-20710,user.getLanguage())%>
                                         				<%
	                                         				}else{
	                                         			%>	
	                                         					<%=regulationsBulletin_value.get("regultionsFileStatus")%>
                                         				<%
	                                         				}
	                                         			%>
	                                                </li>	
	                                         		<li>
	                                         			<% 
                                         					if(!regulationsBulletin_value.get("regultionsFileNos").equals("")){
                                     					%>
                                     							<%=regulationsBulletin_value.get("regultionsFileNos")%>-<%=regulationsBulletin_value.get("regultionsFileName")%>
                                     					<%
	                                         				}else{
                                         				%>
                                         						<%=regulationsBulletin_value.get("regultionsFileName")%>
                                         				<%
	                                         				}
	                                         			%>	
	                                                </li>	 
                                               </ul>
											<%}%>
		                       		</div>
								</div>
		                   </div>
		                   
		                   	<%--
	                        <!-- 制度门户 -->
	                        <a href = "<%=system %>" target = "_blank">
		                        <div class="item dynamic1 open addUpdate modelLast" id="_companynews" >
		                            <div class= "_hotnewsTitle">规章制度</div>
								</div>
							</a>
	                        <!-- 知识门户 --><!-- 调整成KM/SOP知识管理系统 -->
	                        <a href = "<%=knowledge %>" target="_blank">
	                        	<div class="item dynamic1 open addUpdate modelLast" id="rcap" >
	                         		<div class= "_hotnewsTitle" style="top:60%">KM/SOP</br>知识管理系统</div>
	                        	</div>
	                    	</a>
	                    	--%>
	
	                         <!-- 质量通告 -->
	                        <div class="item addUpdate modelLast " id="Notice" url="">
	                         	<div class = "qualityTitle" style = "height:20%">
	                       			<span><%=SystemEnv.getHtmlLabelName(-20108,user.getLanguage())%></span>
	                       			<a href = "<%=qualityBulletin %>" target="_blank">
	                       				<span><%=SystemEnv.getHtmlLabelName(131654,user.getLanguage())%></span>
	                       			</a>
	                       			<div class="clear" style = "clear: both">&nbsp;</div>
	                       		</div>
	                       		<div class="clear" style = "clear: both">&nbsp;</div>
	                       		<div class = "qualityContent" style = "height:70%">
	                       			<ul  style ="height:100%">
	                       			<%
	                       				//是否是维信诺科技
                       					if(isKvi==true){
		                       			//从OA取数据
                                            for (int i=0;i<qualityBulletinListOA.size();i++ ) {
                                                Map qualityBulletinItem = (Map)qualityBulletinListOA.get(i);
                                    %>
                                         		<li style = "height:17.5%">
                                                    <a href="/docs/docs/DocDsp.jsp?id=<%=qualityBulletinItem.get("docid") %>" onclick="hideUnread(<%=qualityBulletinItem.get("docid")%>)" target="_blank">
                                                        <%=qualityBulletinItem.get("docsubject") %>
                                                    </a>
                                                </li>
                                    <%
                                           }                      					
                       					}else{
                                    	//从知识管理系统取数据	
											for (int i=0;i<qualityBulletinListDCM.length();i++ ) {
												JSONObject qualityBulletinItem = qualityBulletinListDCM.getJSONObject(i);
									%>     
                                     			<li style = "height:17.5%">
                                                	<a href="/gvo/ps/sendDocContentUrl.jsp?url=<%=KnowledgeSystemLink%>/OAProcess/OAProcessFileECM.ashx&fileid=<%=qualityBulletinItem.get("qualityBulletinFileID") %>" onclick="hideUnread(<%=qualityBulletinItem.get("qualityBulletinFileID")%>)" target="_blank">
                                                    	<%=qualityBulletinItem.get("qualityBulletinFileName") %>
                                                	</a>
                                            	</li>
									<%
											}
										}
									%>
	                       			</ul>
	                       		</div>
	                        </div>
	                        <!-- 企业文化 -->
	                        <div class="item addUpdate modelLast" id="xtdh" url="">
	                         	<div class = "cultureTitle" style="height:20%">
	                       			<span><%=SystemEnv.getHtmlLabelName(-17158,user.getLanguage())%></span>
	                       			<a href = "<%=corporateCultureMore %>" target='_blank'>
	                       				<span><%=SystemEnv.getHtmlLabelName(131654,user.getLanguage())%></span>
	                       			</a>
	                       			<div class="clear" style = "clear: both">&nbsp;</div>
	                       		</div>
	                       		<div class="clear" style = "clear: both">&nbsp;</div>
	                       		<%if("1".equals(isCultureMX) && isKvi == false ){ %> 
		                       		<div class = "newCultureContent" style = "height:70%">
		                       			<ul  style ="height:100%">
		                       			<%
	                                            for (int i=0;i<newCultureList.size();i++ ) {
	                                                Map newCultureItem = (Map)newCultureList.get(i);
	                                    %>
	                                         		<li style = "height:17.5%">
	                                                    <a href="/docs/docs/DocDsp.jsp?id=<%=newCultureItem.get("docid") %>" onclick="hideUnread(<%=newCultureItem.get("docid")%>)" target="_blank">
	                                                        <%=newCultureItem.get("docsubject") %>
	                                                    </a>
	                                                </li>
	                                    <%
	                                           }    
										%>
		                       			</ul>
		                       		</div>
	                       		<%} else {%>
		                       		<div class = "cultureContent" style = "height:calc(100% - 40px)">
		                       			<div></div>
		                       			<div id = "corporateCulture" style = "height:100%" >
			                       			<%=corporateCulture%>
		    							</div>
		                       		</div>
  								<%} %>
	                        </div>
	                        <!-- <div class="clear" style = "clear: both">&nbsp;</div>-->
	                        <!-- 员工自助 -->
	                        <!-- <a href = "<%=employeeHelp %>" target="_blank">
		                        	 员工自助 
		                        <div class="item addUpdate modelLast" id="EmployeeHelp" url="">
		                         	<div class= "_hotnewsTitle"><%=SystemEnv.getHtmlLabelName(-20110,user.getLanguage())%></div>
		                         	<div class = "info">(敬请期待)</div>
		                        </div>
	                        </a> -->
	                        
	                        <!-- 员工指南 -->
	                        <div class="item addUpdate modelLast " id="NewGuide" url="">
	                         	<div class = "newGuideTitle" style = "height:20%">
	                       			<span><%=SystemEnv.getHtmlLabelName(-23862,user.getLanguage())%></span>
	                       			<a href = "<%=newGuideMore %>" target="_blank">
	                       				<span><%=SystemEnv.getHtmlLabelName(131654,user.getLanguage())%></span>
	                       			</a>
	                       			<div class="clear" style = "clear: both">&nbsp;</div>
	                       		</div>
	                       		<div class="clear" style = "clear: both">&nbsp;</div>
	                       		<div class = "newGuideContent" style = "height:70%">
	                       			<ul  style ="height:100%">
	                       			<%
                                            for (int i=0;i<newGuideList.size();i++ ) {
                                                Map newGuideItem = (Map)newGuideList.get(i);
                                    %>
                                         		<li style = "height:17.5%">
                                                    <a href="/docs/docs/DocDsp.jsp?id=<%=newGuideItem.get("docid") %>" onclick="hideUnread(<%=newGuideItem.get("docid")%>)" target="_blank">
                                                        <%=newGuideItem.get("docsubject") %>
                                                    </a>
                                                </li>
                                    <%
                                           }    
									%>
	                       			</ul>
	                       		</div>
	                        </div>
	                        <!--  <div class="clear" style = "clear: both">&nbsp;</div>-->
	                    </div>
					</div>
				</div>
				<!-- 侧边栏 -->
				<div class="side-bar"> 
				    <a href="#" class="icon-android" >
				        <div class="chat-tips" style = "background-color: #666;border-radius: 5px;">
                            <div>
                            	<div style = "font-size: 12px;color:rgb(255,255,255);width:90px;">Android</div>
                            	<img style="width:100px;height:100px;margin-top:15px" src="/gvo/gateway/common/img/Android.png?v=20190827" alt="">
                            </div>
                            <div style= "margin-top:15px">
                            	<div style = "font-size: 12px;color:rgb(255,255,255);width:90px">IOS</div>
                            	<img style="width:100px;height:100px;margin-top:15px;" src="/gvo/gateway/common/img/iOS.png?v=20190827" alt="">
                            </div>
                        </div>

				    </a> 
				   <!--  <a href="#" class="icon-ios" >
					    <div class="chat-tips" style="top:10px;background-color: #666;border-radius: 5px;">
						    <i></i>
						    <div>
                            	<div style = "font-size: 12px;color:rgb(255,255,255);width:100px;text-align: center;">企业微信号</div>
                            	<img style="width:100px;height:100px;margin-top:15px" src="/gvo/gateway/common/img/publicAddress.png" alt="">
                            </div>
					    </div>
				    </a>  -->
				    <a  href="<%=employeeHelp %>" class="icon-phone" target="_bank"></a>
				    <!-- <a  href="/docs/search/DocSearchTab.jsp?urlType=16&eid=2649&tabid=4&date2during=0 " class="icon-phone" target="_bank"></a> --> 
				    <a   class="icon-qq" target="_bank"></a> 
				  
				</div>
			</div>
			<div class="footer" style = "color: #484343;font-size: 0.9rem">
				版权所有 ©：维信诺公司 &nbsp;&nbsp;&nbsp;&nbsp;京 ICP 备 14033467 号 -1 京公网安备 110108002920号
			</div>			
		</div>
		<script type="text/javascript" src="common/js/quick_links.js"></script>
		<script type="text/javascript" src="common/js/common.js"></script>
		<script type="text/javascript" src="common/js/jquery.cxslide.min.js"></script>
		<script type="text/javascript" src="main.js"></script>
		<script type="text/javascript">
			jQuery(document).ready(function(){
				
				setLayout();
				// alert(jQuery("#Navcentercontent").width());

				hideMe();//隐藏新建流程
				jQuery("#wfcenter").css('z-index','-99');
				jQuery("#wfcenter").hide();
				if(jQuery("#backgroundImage").val().length > 0){
					jQuery("#contentUpdate").css('background','url('+jQuery("#backgroundImage").val()+') no-repeat');
					jQuery("#contentUpdate").css('background-size','100% 100%');
				}else{
					jQuery("#contentUpdate").css('background','url(common/img/background.png) no-repeat');
					jQuery("#contentUpdate").css('background-size','100% 100%');
				};

				//切换语言
				var lang;
				$("#language").on("click", function() {
					if(<%=user.getLanguage()%>==7){
						lang = 8;
					}else{
						lang = 7;
					}
					$.post("/gvo/gateway/jsp/changelang.jsp?lang="+lang,function(){
						document.location.reload();
					});
				});				
				
				jQuery("#slide_fade").cxSlide({events:"mouseover",type:"fade",speed:300});
				//新建流程二级菜单划过事件
				jQuery(".value").mouseover(function(){
					jQuery(this).css('font-size','20px');
				})
				jQuery(".value").mouseleave(function(){
					jQuery(this).css('font-size','18px');
				})	
				
				
				//系统导航划过事件
				var timer;
				jQuery("#_noticenews").hover(function(){
	                timer=setTimeout(function(){
	                	jQuery("#Navigation").slideDown(500);
	                },750);
	        	},function(){
	        		if(timer) {
	        			clearTimeout(timer);
	        		} 
               	});

				//系统导航点击事件 弹出下拉框  防止冒泡事件
		    	function stopPropagation(e) {
		            var ev = e || window.event;
		            if (ev.stopPropagation) {
		                ev.stopPropagation();
		            }else if (window.event) {
		                window.event.cancelBubble = true;//兼容IE
		            }
		        }
		        $("#_noticenews").click(function (e) {
		            $("#Navigation").slideDown(500);
		            stopPropagation(e);
		        });
		        $(document).bind('click', function () {
		            $("#Navigation").slideUp(500);
		        });
		        $("#Navigation").click(function (e) {
		            stopPropagation(e);
		        });
				//关闭按钮
				jQuery("#Navigationheader #tab-right").click(function(){
					$("#Navigation").slideUp(500);
				});


				$("#tz").click(function (e) {
		        	jQuery("#wfcenter").css('z-index','99');
	                jQuery("#wfcenter").slideDown(500);
					jQuery(".createNew").click();
		            stopPropagation(e);
		        });
		        $(document).bind('click', function () {
		            jQuery("#wfcenter").css('z-index','-99');
	      			jQuery("#wfcenter").hide();
		        });
		        $("#wfcenter").click(function (e) {
		            stopPropagation(e);
		        });


				//新建流程导航
             	jQuery("#tz").hover(function(){
	                timer=setTimeout(function(){
	                	jQuery("#wfcenter").css('z-index','99');
	                	jQuery("#wfcenter").slideDown(500);
						jQuery(".createNew").click();
					},750);
	        	},function(){
	        		if(timer) {
	        			clearTimeout(timer);
	        		} 
               	});		

				
				jQuery(document).bind("click",function(e){
	  　　　　　　  var target  = jQuery(e.target);
	  　　　　　  　if(target.closest("#wfcenter").length == 0){
	      　　　　　　   jQuery("#wfcenter").css('z-index','-99');
	      				jQuery("#wfcenter").hide();
	 　　　　　　     }　　　　
 　　　　　　		})

				function hideMe(){
					jQuery(".aa").hide(500);
					jQuery(".dd").hide(500);
				}
				

				//新建流程子菜单(标签栏的样式控制)
				jQuery(".value").click(function(){
					jQuery(".value").removeClass('clickStyle');
					jQuery(this).addClass('clickStyle');
				});
				
				//新建流程菜单
				jQuery(".createNew").click(function(){
					jQuery(".aa").hide(500);
					jQuery(".dd").show(500);
					jQuery("#wfcenterheader a").attr("href",'/workflow/request/RequestType.jsp');

				});
				jQuery(".ECRequest").click(function(){
					jQuery(".dd").hide(500);
					jQuery(".aa").show(500);
					jQuery("#wfcenterheader a").attr("href",'/gvo/sendFor/sendNewOtherCreateWF.jsp');

				});


			
				jQuery("#close").click(function(){
					jQuery("#wfcenter").css('z-index','-99');
	      			jQuery("#wfcenter").hide();
				});

				jQuery("#skinPeeler").click(function(){
					jQuery(".skinPeeler").fadeIn(500);
				});

				jQuery(".skinPeelerClose").click(function(){
					jQuery(".skinPeeler").fadeOut(500);
				});
				
				jQuery(".skinPeelerClose").click(function(){
					jQuery(".skinPeeler").fadeOut(500);
				});

				//流程省略号隐藏颜色改变
				jQuery("#ecli").mouseover(function(){
					jQuery(this).addClass('aaa');
					
					jQuery(this).removeClass('bbb');
				})
				jQuery("#ecli").mouseleave(function(){
					
					jQuery(this).removeClass('aaa');
					jQuery(this).addClass('bbb');
				})


				//左上角划过提示
				jQuery("#skinPeeler").hover(function(){
					jQuery(".skinPeeler_tips").css('display','block');
				},function(){
					jQuery(".skinPeeler_tips").css('display','none');
				});

				jQuery("#language").hover(function(){
					jQuery(".language_tips").css('display','block');
				},function(){
					jQuery(".language_tips").css('display','none');
				});

				
				jQuery("#oaMain").hover(function(){
					jQuery(".oaMain_tips").css('display','block');
				},function(){
					jQuery(".oaMain_tips").css('display','none');
				});
				
				jQuery("#signOut").hover(function(){
					jQuery(".signOut_tips").css('display','block');
				},function(){
					jQuery(".signOut_tips").css('display','none');
				});


				//getNumCount();//获取待办数量
				//设置新轮播
				var lengli = $(".mod18 .picBox .cf li").length;		//li的个数	
				$(".mod18 .picBox .cf").css('width',($("#picBox").width()+10)*lengli+"px"); //设置轮播图ul的宽度
				$(".mod18 .picBox li").css('width',($("#picBox").width()+10)+"px");//设置轮播图li的宽度
				
				$("#listBox .cf").css('width',($("#picBox").width()+25)*lengli+"px");//设置缩略图ul的宽度
				$("#listBox .cf").css('margin-left',"-5px");
				$("#listBox .cf li").css('width',($("#picBox").width()/3+0.7)+"px");//设置缩略图li的宽度
				
				$(".cf li:first").addClass("on");

				
				// //轮播图url为空的时候阻止跳转
				$(".cf_a").click(function(){
					var url = (this).href;
					if(url.substr(url.length-3,3) === "###"){
					 	return false;
					 }
				})

				//设置logo比例
				var logoWidth = $("#logoArea").height()*4.8864;
				$("#logoArea").width(logoWidth+"px");
					
			});
		       	var fensi = JSON.parse(jQuery("#background").html())
				var now_fensi=[];
		        freshen();
    	
    			function freshen(){
		           	var card_num=fensi.length;//卡片的个数
		        	var ye_num=Math.ceil(card_num/15);  // 总页数，向上取整，页数，每页15个  
		        	jQuery("#page").html(ye_num);
		        	updata(ye_num,1);//初始化
			        jQuery("#ye1").addClass("index");
				}
	    		
	    		function updata(ye_num,now_ye){
		    		now_fensi=[];//清空数组
		    		jQuery("#fenye_list").empty();//清空分页ul
					jQuery("#fenye").empty();//清空card
					var prev=now_ye-1;
					var next=now_ye+1;
					if(now_ye==1) prev=now_ye;
					if(now_ye==ye_num) next=ye_num;
					var ht="<li><a onclick='javascript:updata("+ye_num+","+prev+");' class='fensiprev'>"+"<%=SystemEnv.getHtmlLabelName(1258,user.getLanguage())%>"+"</a></li><li><a onclick='javascript:updata("+ye_num+","+next+");' class='fensinext'>"+"<%=SystemEnv.getHtmlLabelName(1259,user.getLanguage())%>"+"</a></li>";
					
					jQuery("#fenye_list").append(ht);//添加上下页按钮
					if(ye_num<5){
						for(i=1;i<ye_num+1;i++){
							var html="<li><a onclick="+"javascript:updata("+ye_num+","+i+");"+" class='ye'>"+i+"</a></li>";
							if(now_ye==i){
								html="<li><a onclick="+"javascript:updata("+ye_num+","+i+");"+" class='ye index'>"+i+"</a></li>";
							}
							jQuery(".fensinext").parents('li').before(html);
						}
					}else if(ye_num>=5){
						for(i=1;i<ye_num+1;i++){
							var html="<li><a onclick="+"javascript:updata("+ye_num+","+i+");"+" class='ye'>"+i+"</a></li>";
							if(now_ye<4 && i<=5){
								if(now_ye==i){
									html="<li><a onclick="+"javascript:updata("+ye_num+","+i+");"+" class='ye index'>"+i+"</a></li>";
								}
								jQuery(".fensinext").parents('li').before(html);
							}
							if(now_ye>3 && now_ye<=(ye_num-2)){
								if(i<=(now_ye+2) && i>=(now_ye-2)){
									if(now_ye==i){
										html="<li><a onclick="+"javascript:updata("+ye_num+","+i+");"+" class='ye index'>"+i+"</a></li>";
									}
									jQuery(".fensinext").parents('li').before(html);
								}
							}
							if(now_ye==(ye_num-1)){
								if(i>(ye_num-5)){
									if(now_ye==i){
										html="<li><a onclick="+"javascript:updata("+ye_num+","+i+");"+" class='ye index'>"+i+"</a></li>";
									}
									jQuery(".fensinext").parents('li').before(html);
								}
							}else if(now_ye==ye_num){
								if(i>(ye_num-5)){
									if(now_ye==i){
										html="<li><a onclick="+"javascript:updata("+ye_num+","+i+");"+" class='ye index'>"+i+"</a></li>";
									}
									jQuery(".fensinext").parents('li').before(html);
								}
							}
							
						}
					}
					for(i=0;i<fensi.length;i++){//将此时的25个数据压到now_fensi里
						var x=now_ye-1;
						if(i==0){
							i=i+x*15;
						}
						if(i<now_ye*15 && now_ye<2){
							now_fensi.push(fensi[i]);
						}else if(i>x*15 && i<=now_ye*15 && now_ye>1){
							now_fensi.push(fensi[i]);
						}
						
					}
					for(i=0;i<now_fensi.length;i++){//添加card到页面
				    	var html="<div id="+"card"+i+" class='small_card setBackground'><img src = "+now_fensi[i].imagefileid+" width='100' height='100%'' margin-left='20%'' /><label>"+
				    		now_fensi[i].bjtpmc+"</label></div>";
				    	jQuery("#fenye").append(html);
			    	}
			    	jQuery(".setBackground").click(function(){
			    		var backgroundSrc = jQuery(this).children('img').attr('src');
						jQuery("#contentUpdate").css('background','url('+backgroundSrc+') no-repeat');
						jQuery("#contentUpdate").css('background-size','100% 100%');
						setBackground(backgroundSrc);
					});
			 	}
			//}
			function setBackground (backgroundSrc) {
		        var userid = jQuery("#userid").val();
		        var setBackground = {
		            url: '/gvo/gateway/jsp/setBcakground.jsp?userid='+userid+'&backgroundSrc='+backgroundSrc,
		            type: 'post',
		            async: 'false',
		            success: function (data) {}
		        }
		        jQuery.ajax(setBackground);
		    }

		    //
		    function getNumCount(){
		    	var count = "";//待办数目
			    $.ajax({
			  		type: "POST",
			  		url: "jsp/wfTabFrameCount.jsp",
			  		data:"json",
					success:function(data){
						if(!!data)
						{
							var __data = jQuery.trim(data)
							if(__data != "")
							{
								var _dataJson = JSON.parse(__data);
								count=_dataJson.flowAll;//全部待办数目
								if(Number(count) > 99){
									count = "99+";
									jQuery(".addUpdate #hotnewsLogo").html(count);
					
								}else{
								
									jQuery(".addUpdate #hotnewsLogo").html(count);

								}
								//alert(count);
								// $("#fnNumSpn").text("("+_dataJson.flowNew+")");//未读
								// $("#frNumSpn").text("("+_dataJson.flowResponse+")");//反馈
								// $("#foNumSpn").text("("+_dataJson.flowOut+")");//超时
								// $("#fsNumSpn").text("("+_dataJson.flowSup+")");//被督办
							}
						}
					}
				});

			}

			function setLayout(){
				var width = document.documentElement.clientWidth;//浏览器宽度
				var height = document.documentElement.clientHeight;//浏览器高度
				//alert(height);
				
				if(Number(height) < 738){
					height = 738;
				}

				if(Number(width) < 1519){
					width = 1519;
				}
				var widthMain = -(width*0.77)/2
				var heightMain = (height*0.4);



				jQuery("#itemContent").width(width*0.77);
				jQuery(".rightContent").width(width*0.77);//顶部工具栏
				jQuery("#continar").css('margin-left',widthMain);
				jQuery("#itemContent").height('467px');
				jQuery(".Layout").height(heightMain);
				jQuery(".layoutlast").height(heightMain/2);

				// jQuery(".content").css('top',height*0.13);

				jQuery(".model").height("49%");
				jQuery(".modelHalf").height("50%");
				jQuery(".modelNew").height("100%");
				jQuery(".modelLast").height("100%");

				//根据历览器
				if(Number(height) > 900){
					jQuery("#continar").css('top','40%');
				}

				//企业的文化高度
				var lineHeight = jQuery("#corporateCulture").height()*0.18;
				jQuery("#corporateCulture").css('line-height',lineHeight+"px");

				//轮播图
				var slide_fadeHeight = jQuery("#slide_fade").height();
				jQuery(".slide_fade .list li").css('height',slide_fadeHeight*0.75);
			}

	</script>
	<script src="common/js/jqueryPhoto.js" type="text/javascript"></script>

	<!--网上调查问卷-->
	<SCRIPT LANGUAGE="javascript">
		var voteids = "";//网上调查的id
		var voteshows = "";//网上调查是否弹出
		var votefores = "";//网上调查---> 强制调查
	</SCRIPT>
	<%
	    HrmUserSettingComInfo userSetting=new HrmUserSettingComInfo();
	    String belongtoshow = userSetting.getBelongtoshowByUserId(user.getUID()+""); 
		String belongtoids = user.getBelongtoids();
		String account_type = user.getAccount_type();
		boolean isSys=true;
		RecordSet.executeSql("select 1 from hrmresource where id="+user.getUID());
		if(RecordSet.next()){
			isSys=false;
		}		
		
		Date votingnewdate = new Date() ;
		long votingdatetime = votingnewdate.getTime() ;
		Timestamp votingtimestamp = new Timestamp(votingdatetime) ;
		String votingCurrentDate = (votingtimestamp.toString()).substring(0,4) + "-" + (votingtimestamp.toString()).substring(5,7) + "-" +(votingtimestamp.toString()).substring(8,10);
		String votingCurrentTime = (votingtimestamp.toString()).substring(11,13) + ":" + (votingtimestamp.toString()).substring(14,16);
		String votingsql="";

		if(false && belongtoshow.equals("1")&&account_type.equals("0")&&!belongtoids.equals("")){
			belongtoids +=","+user.getUID();
			votingsql="select distinct t1.id,t1.autoshowvote,t1.forcevote from voting t1 where t1.status=1 "+ 
        " and (t1.beginDate<'"+votingCurrentDate+"' or (t1.beginDate='"+votingCurrentDate+"' and (t1.beginTime is null or t1.beginTime='' or t1.beginTime<='"+votingCurrentTime+"'))) "; 
			votingsql +=" and (";
			String[] votingshareids=Util.TokenizerString2(belongtoids,",");
			for(int i=0;i<votingshareids.length;i++){
				User tmptUser=VotingManager.getUser(Util.getIntValue(votingshareids[i]));
				String seclevel=tmptUser.getSeclevel();
				int subcompany1=tmptUser.getUserSubCompany1();
				int department=tmptUser.getUserDepartment();
				String  jobtitles=tmptUser.getJobtitle();
	     		String tmptsubcompanyid=subcompany1+"";
				String tmptdepartment=department+"";
				RecordSet.executeSql("select subcompanyid,departmentid from HrmResourceVirtual where resourceid="+tmptUser.getUID());
				while(RecordSet.next()){
					tmptsubcompanyid +=","+Util.null2String(RecordSet.getString("subcompanyid"));
					tmptdepartment +=","+Util.null2String(RecordSet.getString("departmentid"));
				}
		
				if(i==0){
					votingsql += " ( id not in (select votingid from VotingRemark where resourceid="+tmptUser.getUID()+")" +
					" and id in(select votingid from VotingShare t"+i+" where ((sharetype=1 and resourceid="+tmptUser.getUID()+") or (sharetype=2 and subcompanyid in("+tmptsubcompanyid+") and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) or (sharetype=3 and departmentid in("+tmptdepartment+") and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) or (sharetype=5 and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) or (sharetype=6 and ( (joblevel=0 and jobtitles='"+jobtitles+"' ) or (joblevel=1 and jobtitles='"+jobtitles+"' and jobsubcompany in("+tmptsubcompanyid+")) or (joblevel=2 and jobtitles='"+jobtitles+"' and jobdepartment in("+tmptdepartment+") )) ) or (sharetype=4 and exists(select 1 from HrmRoleMembers where roleid=t"+i+".roleid and rolelevel>=t"+i+".rolelevel and resourceid="+tmptUser.getUID()+") and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) )) )";	
				} else {
					votingsql += " or ( id not in (select votingid from VotingRemark where resourceid="+tmptUser.getUID()+")" +
					" and id in(select votingid from VotingShare t"+i+" where ((sharetype=1 and resourceid="+tmptUser.getUID()+") or (sharetype=2 and subcompanyid in("+tmptsubcompanyid+") and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) or (sharetype=3 and departmentid in("+tmptdepartment+") and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) or (sharetype=5 and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+"))  or (sharetype=6 and ( (joblevel=0 and jobtitles='"+jobtitles+"' ) or (joblevel=1 and jobtitles='"+jobtitles+"' and jobsubcompany in("+tmptsubcompanyid+")) or (joblevel=2 and jobtitles='"+jobtitles+"' and jobdepartment in("+tmptdepartment+") )) ) or (sharetype=4 and exists(select 1 from HrmRoleMembers where roleid=t"+i+".roleid and rolelevel>=t"+i+".rolelevel and resourceid="+tmptUser.getUID()+") and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) )) )";	
				}
			}
			votingsql +=")";
		}else{
			String seclevel=user.getSeclevel();
			int subcompany1=user.getUserSubCompany1();
			int department=user.getUserDepartment();
			String  jobtitles=user.getJobtitle();
			  		
			String tmptsubcompanyid=subcompany1+"";
			String tmptdepartment=department+"";
			RecordSet.executeSql("select subcompanyid,departmentid from HrmResourceVirtual where resourceid="+user.getUID());
			while(RecordSet.next()){
				tmptsubcompanyid +=","+Util.null2String(RecordSet.getString("subcompanyid"));
				tmptdepartment +=","+Util.null2String(RecordSet.getString("departmentid"));
			}
			votingsql="select distinct t1.id,t1.autoshowvote,t1.forcevote from voting t1 where t1.status=1 "+
	" and t1.id not in (select distinct votingid from VotingRemark where resourceid ="+user.getUID()+")"+
	" and (t1.beginDate<'"+votingCurrentDate+"' or (t1.beginDate='"+votingCurrentDate+"' and (t1.beginTime is null or t1.beginTime='' or t1.beginTime<='"+votingCurrentTime+"')))"+
	" and t1.id in(select votingid from VotingShare t where ((sharetype=1 and resourceid="+user.getUID()+") or (sharetype=2 and subcompanyid in("+tmptsubcompanyid+") and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) or (sharetype=3 and departmentid in("+tmptdepartment+") and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) or (sharetype=5 and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+"))  or (sharetype=6 and ( (joblevel=0 and jobtitles='"+jobtitles+"' ) or (joblevel=1 and jobtitles='"+jobtitles+"' and jobsubcompany in("+tmptsubcompanyid+")) or (joblevel=2 and jobtitles='"+jobtitles+"' and jobdepartment in("+tmptdepartment+") )) )  or (sharetype=4 and exists(select 1 from HrmRoleMembers where roleid=t.roleid and rolelevel>=t.rolelevel and resourceid="+user.getUID()+") and seclevel<="+seclevel+" and (seclevelmax is null or seclevelmax>="+seclevel+")) ))"; 
		}
		if(isSys){
			votingsql +=" and 1=2";
		}
		//signRs.writeLog("###abc:"+votingsql);
		signRs.executeSql(votingsql);
		while(signRs.next()){ 
			String votingid = signRs.getString("id");
			String voteshow = signRs.getString("autoshowvote"); 
			String forcevote = signRs.getString("forcevote"); 
		%>
		<script language=javascript>  
	   		if(voteids == ""){
		      	voteids = '<%=votingid%>';
		      	voteshows = '<%=voteshow%>';
		      	forcevotes = '<%=forcevote%>';
	   		}else{
		      	voteids =voteids + "," +  '<%=votingid%>';
		      	voteshows =voteshows + "," +  '<%=voteshow%>';
		      	forcevotes =forcevotes + "," +  '<%=forcevote%>';
	   		}
		</script> 
	<%}%> 
	<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
	<script language=javascript>  
	showVote();
	function showVote(){
	    if(voteids !=""){
			var arr = voteids.split(",");
		    var autoshowarr = voteshows.split(",");
		    var forcevotearr = forcevotes.split(",");
			for(i=0;i<arr.length;i++){
			    //判断是否弹出调查
			    if(autoshowarr[i] !='' || forcevotearr[i] !=''){//弹出
				    var diag_vote = new Dialog();
					diag_vote.Width = 900;
					diag_vote.Height = 500;
					diag_vote.Title = "<%=SystemEnv.getHtmlLabelName(17599,user.getLanguage())%>";
					diag_vote.URL = "/voting/VotingPoll.jsp?votingid="+arr[i];
					if(forcevotearr[i] !=''){//强制调查
						diag_vote.ShowCloseButton=false; 
					}
					diag_vote.show();
				}
			 }
		}
	}
	</script>
	<!--网上调查结束-->







	<!--文档弹出窗口-- 开始-->
	<% 
		Date newdate = new Date() ;
		long datetime = newdate.getTime() ;
		Timestamp timestamp = new Timestamp(datetime) ;
		String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
		String docsid = "";
		String pop_width = "";
		String pop_hight = "";
		String is_popnum = "";
		String pop_type = "";
		String popupsql ="";
		String pop_num ="";
		String checktype="select docid,pop_type,pop_hight,pop_width,is_popnum, pop_num from DocDetail  t1, "+tables+"  t2,DocPopUpInfo t3 where t1.id=t2.sourceid and t1.id = t3.docid and t1.docstatus in ('1','2','5') and (t1.ishistory is null or t1.ishistory = 0) and (t3.pop_startdate <= '"+CurrentDate+"' and t3.pop_enddate >= '"+CurrentDate+"') ";
		rspop.executeSql(checktype);
		while(rspop.next()){
			pop_type=Util.null2String(rspop.getString("pop_type"));
			docsid = Util.null2String(rspop.getString("docid"));
		    pop_hight =Util.null2String(rspop.getString("pop_hight"));
		    pop_width = Util.null2String(rspop.getString("pop_width"));
		    is_popnum = Util.null2String(rspop.getString("is_popnum"));
			pop_num = Util.null2String(rspop.getString("pop_num"));
			if("".equals(pop_hight)) pop_hight = "500";
		    if("".equals(pop_width)) pop_width = "600";
			if(pop_type.equals("1")||pop_type.equals("")){
			  	popupsql = "select 1 from DocDetail  t1, "+tables+"  t2,DocPopUpInfo t3 where t1.id=t2.sourceid and t1.id = t3.docid and (t1.ishistory is null or t1.ishistory = 0) and (t3.pop_startdate <= '"+CurrentDate+"' and t3.pop_enddate >= '"+CurrentDate+"') and pop_num > is_popnum and docid="+docsid;
			  	RecordSet.executeSql(popupsql); 
			  	if(RecordSet.next()){
				   RecordSet.executeSql("update DocPopUpInfo set is_popnum = "+(Util.getIntValue(is_popnum,0)+1)+" where docid = "+docsid);
				%>
					<script language=javascript> 
				  	var is_popnum = <%=is_popnum%>;
				  	var docsid = <%=docsid%>;
				  	var pop_hight = <%=pop_hight%>;
				  	var pop_width = <%=pop_width%>;
				  	var docid_num = docsid +"_"+ is_popnum;
				  	window.open("/docs/docs/DocDsp.jsp?popnum="+docid_num,"","height="+pop_hight+",width="+pop_width+",scrollbars,resizable=yes,status=yes,Minimize=yes,Maximize=yes");
					</script> 
				<%
	        	}
			}else {
	      		rspopuser.executeSql("select * from DocPopUpUser where userid="+user.getUID()+" and docid="+docsid);
				if(rspopuser.next()){
				  	is_popnum = Util.null2String(rspopuser.getString("haspopnum"));
				  	if(Util.getIntValue(is_popnum,0) <Util.getIntValue(pop_num,0)){
					 	RecordSet.executeSql("update DocPopUpUser set haspopnum = "+(Util.getIntValue(is_popnum,0)+1)+" where docid = "+docsid+" and userid="+user.getUID());
				%>
				<script language=javascript> 
				  	var is_popnum = <%=is_popnum%>;
				  	var docsid = <%=docsid%>;
				  	var pop_hight = <%=pop_hight%>;
				  	var pop_width = <%=pop_width%>;
				  	var docid_num = docsid +"_"+ is_popnum;
				  	window.open("/docs/docs/DocDsp.jsp?popnum="+docid_num,"","height="+pop_hight+",width="+pop_width+",scrollbars,resizable=yes,status=yes,Minimize=yes,Maximize=yes");
				</script> 
				<%      
	        }
			}else{
			  	if(Util.getIntValue(pop_num,0)>0){
			   		RecordSet.executeSql("insert into DocPopUpUser(userid,docid,haspopnum) values ("+user.getUID()+","+docsid+",1 )");	
			%>
			<script language=javascript> 
			  	var is_popnum = <%=is_popnum%>;
			  	var docsid = <%=docsid%>;
			  	var pop_hight = <%=pop_hight%>;
			 	var pop_width = <%=pop_width%>;
			 	var docid_num = docsid +"_0";
			  	window.open("/docs/docs/DocDsp.jsp?popnum="+docid_num,"","height="+pop_hight+",width="+pop_width+",scrollbars,resizable=yes,status=yes,Minimize=yes,Maximize=yes");
			</script> 
		<%}}}}%>
	</body>
</html>

