<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="cu" class="weaver.company.CompanyUtil" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CompanyPermissionService" class="weaver.cpcompanyinfo.CompanyPermissionService" scope="page" />
<%
//	if(!cu.canOperate(user,"3"))//不具有入口权限
//	{
//		response.sendRedirect("/notice/noright.jsp");
//		return;
//	}
	
	boolean maintFlag = false;
	if(cu.canOperate(user,"2"))//后台维护权限
	{
		maintFlag = true;
	}
	
	String openNew = Util.null2String(request.getParameter("openNew"));
	String companyname = Util.null2String(request.getParameter("companyname"));
	
	String zrrid="";//得到自然人的id
	if(rs.execute("select id,name from CompanyBusinessService where affixindex=-1")&&rs.next()){
		zrrid=rs.getString("id");
	}
 %>
<jsp:include page="/cpcompanyinfo/CompanyInfoContainer.jsp" />
<jsp:useBean id="cpinfoTransMethod" class="weaver.cpcompanyinfo.CompanyInfoTransMethod" scope="page" />
 
<html>
	<head>
	<script type="text/javascript">
	var docmh="";
	jQuery(document).ready(function(){
	
		$('#searchTX').bind('keyup', function(event){
				   if (event.keyCode=="13"){
				    	queryCompanyType(jQuery('#businesstype01').val(),"2");
				    	this.blur();
				   }
		});
		setBottom();
		jQuery(".ONav").find("li").bind("click",function(){
			jQuery(".ONav").find(".hover").removeClass("hover");
			jQuery(this).find("a").addClass("hover");
			
		});
		
		jQuery('#cantacts').qtip(
		{
		   content: {
		     
		      url: '/newportal/contactslist.jsp' 
		   },
		   position: {
		      target: jQuery(document.body), // Position it via the document body...
		      corner: 'center' // ...at the center of the viewport
		   },
		   show: {
		      when: 'click', // Show it on click
		      solo: true // And hide all other tooltips
		   },
		   hide: false,
		   style: {
		      width: { max: 990 },
		      width:979,
		      height:402,
		      padding: '0px 0px',
		      border: {
		         width: 0,
		         radius: 0,
		         color: '#666666'
		      },
		      name: 'light'
		   },
		   api: {
		      beforeShow: function()
		      {
		         // Fade in the modal "blanket" using the defined show speed
		         jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
		      },
		      beforeHide: function()
		      {
		         // Fade out the modal "blanket" using the defined hide speed
		         jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
		      }
		   }
		});
		
		// Create the modal backdrop on document load so all modal tooltips can use it
		jQuery('<div id="qtip-blanket">')
			.css({
				position: 'absolute',
		      	top: jQuery(document).scrollTop(), // Use document scrollTop so it's on-screen even if the window is scrolled
		      	left: 0,
		      	height: jQuery(document).height()-4, // Span the full document height...
		      	width: '100%', // ...and full width
		
		      	opacity: 0.3, // Make it slightly transparent
		      	backgroundColor: 'black',
		      	zIndex: 5000  // Make sure the zIndex is below 6000 to keep it below tooltips!
		   })
		   .appendTo(document.body) // Append to the document body
		   .hide(); // Hide it initially
			
			//来自于flash中点击注册公司按钮
			if("<%=openNew%>"=="T"){
				beforeNew();
			}
			//if("<=companyname%>" !=""){
				//jQuery("#searchSL").val("t1.COMPANYNAME");
				//jQuery("#searchTX").val("<=companyname%>");
				//queryCompanyType();
			//}
	});
	
	
	/*点击新增时绑定 qitp*/
	function beforeNew(){
		jQuery("#newBtn").qtip(
		{
			content: {
				url: jQuery("#newBtn").attr("rel")
			},
			position: {
				target: jQuery(document.body), // Position it via the document body...
				corner: 'center' // ...at the center of the viewport
			},
			show: {
				when: 'click', // Show it on click
				solo: true, // And hide all other tooltips
				ready:true
			},
			hide: false,
			style: {
				width: { max: 990 },
		        width:492,
			    height:402,
			    padding: '0px 0px',
			    border: {
					width: 0,
			      	radius: 0,
			        color: '#666666'
				},
				name: 'light'
			},
			api: {
				beforeShow: function()
				{
		            // Fade in the modal "blanket" using the defined show speed
		            jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
			    },
				beforeHide: function()
				{
				   // Fade out the modal "blanket" using the defined hide speed
				   jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
				}
			}
		});
	}
	
	
	/*点击下面的超链接--zzl*/
	function beforeNew_conter(type,showvalue){
		jQuery("#a_click").qtip(
		{
			content: {
				url: "ChooseCompanyBottom.jsp?type="+type+"&showvalue="+showvalue
			},
			position: {
				target: jQuery(document.body), // Position it via the document body...
				corner: 'center' // ...at the center of the viewport
			},
			show: {
				when: 'click', // Show it on click
				solo: true, // And hide all other tooltips
				ready:true
			},
			hide: false,
			style: {
				width: { max: 990 },
		        width:492,
			    height:402,
			    padding: '0px 0px',
			    border: {
					width: 0,
			      	radius: 0,
			        color: '#666666'
				},
				name: 'light'
			},
			api: {
				beforeShow: function()
				{
		            // Fade in the modal "blanket" using the defined show speed
		            jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
			    },
				beforeHide: function()
				{
				   // Fade out the modal "blanket" using the defined hide speed
				   jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
				}
			}
		});
	}
	
	/*绑定编辑或者查时，判断时候选中列表，如选中则绑定qtip*/
	function beforeEditorView(btnid,companyid)
	{
		if("editBtn"==btnid){
			var myurl="/cpcompanyinfo/newpage/companymain.jsp?companyid="+companyid;
			window.open(myurl);
//            var myargs = {"companyid" : companyid};
//            var myfeatures = 'dialogHeight:600px; dialogWidth:1000px; status:no;';
//            var result = window.showModalDialog(myurl, myargs, myfeatures);
        }else{
			jQuery("#"+btnid).qtip(
					{
						content: {
							url: jQuery("#"+btnid).attr("rel")+"&companyid="+companyid
						},
						position: {
							target: jQuery(document.body), // Position it via the document body...
							corner: 'center' // ...at the center of the viewport
						},
						show: {
							when: 'click', // Show it on click
							solo: true, // And hide all other tooltips
							ready:true
						},
						hide: false,
						style: {
							width: { max: 990 },
							width:492,
							height:402,
							padding: '0px 0px',
							border: {
								width: 0,
								radius: 0,
								color: '#666666'
							},
							name: 'light'
						},
						api: {
							beforeShow: function()
							{
								// Fade in the modal "blanket" using the defined show speed
								jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
							},
							beforeHide: function()
							{
								// Fade out the modal "blanket" using the defined hide speed
								jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
							}
						}
					});
		}


			
	}
	
	/*列表删除操作*/
	function delMutiList2Info(companyid){
		
			if(confirm("<%=SystemEnv.getHtmlLabelName(30695,user.getLanguage())%>？")){
				var o4params = {
					method:"del",
					companyids:companyid
				};
			
				jQuery.post("/cpcompanyinfo/action/CPInfoOperate.jsp",o4params,function(data){
					reflush2List();
				});
			}
	}
	

	
	/*根据Table页的选项，改变list的条件*/
	function queryCompanyType(businesstype,type)
	{
		if(businesstype=="<%=zrrid%>"){
			 jQuery(".hidetr").hide();
			var docH=docmh;
			var totH=$("#top_div").height();
			//减去10px的padding和margin值
			var tempH=docH-totH-20;
			$("#OBoxW_H").height(tempH+"px");
			$("#frame2list").height((tempH-20)+"px");  
			//删除select的所有项searchSL
			if(type=="1"){
				$("#searchSL").empty();
				$("#searchSL").append("<option value='t1.COMPANYNAME'><%=SystemEnv.getHtmlLabelName(31445,user.getLanguage())%></option>");   
				$("#searchSL").append("<option value='t1.COMPANYENAME'><%=SystemEnv.getHtmlLabelName(27740,user.getLanguage())%></option>");   
				$("#searchSL").append("<option value='t1.COMPANYREGION'><%=SystemEnv.getHtmlLabelName(31077,user.getLanguage())%></option>");
			}  
		}else{
			if(type=="1"){
				$("#searchSL").empty();
				$("#searchSL").append("<option value='t1.COMPANYNAME'><%=SystemEnv.getHtmlLabelName(1976,user.getLanguage())%></option>");   
				$("#searchSL").append("<option value='t1.COMPANYENAME'><%=SystemEnv.getHtmlLabelName(27740,user.getLanguage())%></option>");   
				$("#searchSL").append("<option value='t1.COMPANYREGION'><%=SystemEnv.getHtmlLabelName(31077,user.getLanguage())%></option>");   
				$("#searchSL").append("<option value='t2.CORPORATION'><%=SystemEnv.getHtmlLabelName(23797,user.getLanguage())%></option>");   
				$("#searchSL").append("<option value='t3.GENERALMANAGER'><%=SystemEnv.getHtmlLabelName(20696,user.getLanguage())%></option>");   
				$("#searchSL").append("<option value='t3.THEBOARD'><%=SystemEnv.getHtmlLabelName(30936,user.getLanguage())%></option>");   
				$("#searchSL").append("<option value='t3.BOARDVISITORS'><%=SystemEnv.getHtmlLabelName(31041,user.getLanguage())%></option>");   
			}
			 jQuery(".hidetr").show();
			 var docH=docmh;
			var botH=$("#bottom_top").height();
			var totH=$("#top_div").height();
			//减去10px的padding和margin值
			var tempH=docH-botH-totH-10;
			$("#OBoxW_H").height(tempH+"px");
			$("#frame2list").height((tempH-20)+"px");
			
		}
		 jQuery("#businesstype01").val(businesstype);
		 
		 
			 if(type=="1"){
				  jQuery("#searchTX").val("");
				  jQuery("#chzhzh").attr("checked",false);
				  jQuery("#chzhch").attr("checked",false);
				  jQuery("#chgd").attr("checked",false);
				  jQuery("#chdsh").attr("checked",false);
				  jQuery("#chxgs").attr("checked",false);
				     
			}
			
			var o4chzhzh;
			var o4chzhch;
			var o4chgd;
			var o4chdsh;
			var o4chxgs;
			var o4searchTx="";
			var o4searchSL="";
			if(jQuery("#chzhzh").attr("checked")==true)o4chzhzh="on";
			else o4chzhzh = "none";
			if(jQuery("#chzhch").attr("checked")==true)o4chzhch="on";
			else o4chzhch = "none";
			if(jQuery("#chgd").attr("checked")==true)o4chgd="on";
			else o4chgd = "none";
			if(jQuery("#chdsh").attr("checked")==true)o4chdsh="on";
			else o4chdsh = "none";
			if(jQuery("#chxgs").attr("checked")==true)o4chxgs="on";
			else o4chxgs = "none";
			
			if(jQuery("#searchTX").val()!=""){
				o4searchTx = jQuery("#searchTX").val();
				o4searchSL = jQuery("#searchSL").val();
			}
			jQuery("#frame2list").attr("src","CompanyInfoList.jsp?businesstype="+jQuery("#businesstype01").val()
			+"&o4chzhzh="+o4chzhzh+"&o4chzhch="+o4chzhch+"&o4chgd="+o4chgd+"&o4chdsh="+o4chdsh+"&o4chxgs="+o4chxgs+
			"&o4searchTx="+o4searchTx+"&o4searchSL="+o4searchSL);
	}
	
	/* 刷新companylist.jsp页面已达到，新增，修改，删除后改变记录的目的*/
	function reflush2List(){
		jQuery("#frame2list")[0].contentWindow.reloadListContent();
	}
	
	function openLogView(companyid){
		//jQuery("#frame2list").attr("src","/cpcompanyinfo/CPLog.jsp");
		//window.showModalDialog("/cpcompanyinfo/CPLog.jsp","","dialogWidth=700px;dialogHeight=500px;status=no;help=no;scrollbars=no");
		window.location.href="/cpcompanyinfo/CPLog.jsp?companyid="+companyid;
	}
	
	function callABGroup(){
		jQuery("#callBtn").qtip(
		{
			content: {
				url: "/cpcompanyinfo/CompanyCallABMaint.jsp"
			},
			position: {
				target: jQuery(document.body), // Position it via the document body...
				corner: 'center' // ...at the center of the viewport
			},
			show: {
				when: 'click', // Show it on click
				solo: true, // And hide all other tooltips
				ready:true
			},
			hide: false,
			style: {
				width: { max: 990 },
		        width:490,
			    height:400,
			    padding: '0px 0px',
			    border: {
					width: 0,
			      	radius: 0,
			        color: '#666666'
				},
				name: 'light'
			},
			api: {
				beforeShow: function()
				{
		            // Fade in the modal "blanket" using the defined show speed
		            jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
			    },
				beforeHide: function()
				{
				   // Fade out the modal "blanket" using the defined hide speed
				   jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
				}
			}
		});
		
	}
	
	function setBottom(){
			var docH=$(document).height(); 
			docmh=docH;
			var botH=$("#bottom_top").height();
			var totH=$("#top_div").height();
			//减去10px的padding和margin值
			var tempH=docH-botH-totH-10;
			$("#OBoxW_H").height(tempH+"px");
			$("#frame2list").height((tempH-20)+"px");
	}
</script>
		<!--[if lte IE 6]>
<script type="text/javascript" src="js/DD_belatedPNG_0.0.7a.js"></script>

<script>

DD_belatedPNG.fix('.png,.png:hover');

</script>
<![endif]-->
	</head>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
	<input type="hidden" id="businesstype01" value=""/>
	<body id="bd_H" style="height: 100%">
		
		<!--导航 start-->
		<div class="OBoxW "   id="top_div">
			<div class="  OBoxWBg"  >
				<ul class="ONav FL cBlue">
					<li>
						<a href="javascript:queryCompanyType('','1');" class="hover"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(31067,user.getLanguage())%>
								</div>
							</div> </a>
					</li>
					<%
							String sql="select * from CompanyBusinessService  where affixindex !=-1 and id in("+CompanyPermissionService.getCanviewGlgsIdsAll(user)+") order by affixindex";
							rs.execute(sql);
							while(rs.next()){
							String c_name=rs.getString("name");
							String c_id=rs.getString("id");
					%>
								<li>
									<a href="javascript:queryCompanyType('<%=c_id%>','1');">
										<div>
											<div>
												<%=c_name %>
											</div>
											</div>
									 </a>
									</li>
					<%		
							}
					 %>
					 
					 <%
					 		//确保自然人总是在最后一个tab页
							 sql="select * from CompanyBusinessService  where affixindex =-1 ";
							rs.execute(sql);
							while(rs.next()){
							String c_name=rs.getString("name");
							String c_id=rs.getString("id");
					%>
								<li>
									<a href="javascript:queryCompanyType('<%=c_id%>','1');">
										<div>
											<div>
												<%=c_name %>
											</div>
											</div>
									 </a>
									</li>
					<%		
							}
					 %>
					
					<div class="clear"></div>
				</ul>

			
			</div>
			<div class="clear"></div>
			<div style="height: 2px;background-color: blue;">&nbsp;</div>
			
			
			
			
			<div class="FL BoxWAuto OBoxWBg hidetr">
				<div class="border16 ">
					<ul class="ONavSubnav PTop5 cBlue FL PB4">
						<span style="width: 90px;" class="FL FontYahei PLeft5"><input
								id="chzhzh" type="checkbox" onclick="javascript:queryCompanyType(jQuery('#businesstype01').val(),'3');" style="margin-top: 3px" /> <span
							style="margin: 0px"><%=SystemEnv.getHtmlLabelName(31758,user.getLanguage())%></span> </span>
						<span style="width: 90px;" class="FL FontYahei PLeft5"><input
								id="chgd" type="checkbox" onclick="javascript:queryCompanyType(jQuery('#businesstype01').val(),'3');" style="margin-top: 3px" /> 
								<span><%=SystemEnv.getHtmlLabelName(31759,user.getLanguage())%></span>
						</span>
						<span style="width: 100px;" class="FL FontYahei PLeft5"><input
								id="chdsh" type="checkbox" onclick="javascript:queryCompanyType(jQuery('#businesstype01').val(),'3');" style="margin-top: 3px" /> 
								<span><%=SystemEnv.getHtmlLabelName(31070,user.getLanguage())%></span>
						</span>
						<span style="width: 90px;" class="FL FontYahei PLeft5"><input
								id="chzhch" type="checkbox" onclick="javascript:queryCompanyType(jQuery('#businesstype01').val(),'3');" style="margin-top: 3px" /> 
								<span><%=SystemEnv.getHtmlLabelName(31071,user.getLanguage())%></span>
						</span>
						<span style="width: 90px;" class="FL FontYahei PLeft5"><input
								id="chxgs" type="checkbox" onclick="javascript:queryCompanyType(jQuery('#businesstype01').val(),'3');" style="margin-top: 3px" />
								 <span><%=SystemEnv.getHtmlLabelName(31072,user.getLanguage())%></span>
						</span>
					</ul>
					<!--表单 start-->
					<div class="PTop5 FR PR10">
						<ul class="FR OSubnavMsg">
							<li>
								<img src="images/O_37.jpg" class="PR5" />
								<%=SystemEnv.getHtmlLabelName(31074,user.getLanguage())%>
							</li>
							<li>
								<img src="images/O_39.jpg" class="PR5" />
								<%=SystemEnv.getHtmlLabelName(31075,user.getLanguage())%>
							</li>
							<li>
								<img src="images/O_38.jpg" class="PR5" />
								<%=SystemEnv.getHtmlLabelName(31076,user.getLanguage())%>
							</li>
						</ul>

					</div>
					<!--表单 end-->
					<div class="clear"></div>
				</div>
			</div>
			
			<div class="clear"></div>
			
		</div>
		<!--导航 end -->
		
		
		<!--主要内容 start-->
		<div class="OBoxW"   id="OBoxW_H">
			<div class="OBoxTit" >
				<!-- 关键字搜索 -->
				<span class="FontYahei cWhite PL20 PTop5 FL" style="display: none;"><%=SystemEnv.getHtmlLabelName(31034,user.getLanguage())%>：</span>
						<span class="FL PT3 PLeft5" style="display: none;">
					<select class="OSelectse" id="searchSL">
						<option value="t1.COMPANYNAME"><%=SystemEnv.getHtmlLabelName(1976,user.getLanguage())%></option>
						<option value="t1.COMPANYENAME"><%=SystemEnv.getHtmlLabelName(27740,user.getLanguage())%></option>
						<option value="t1.COMPANYREGION"><%=SystemEnv.getHtmlLabelName(31077,user.getLanguage())%></option>
						<option value="t2.CORPORATION"><%=SystemEnv.getHtmlLabelName(23797,user.getLanguage())%></option>
						<option value="t3.GENERALMANAGER"><%=SystemEnv.getHtmlLabelName(20696,user.getLanguage())%></option>
						<option value="t3.THEBOARD"><%=SystemEnv.getHtmlLabelName(30936,user.getLanguage())%></option>
						<option value="t3.BOARDVISITORS"><%=SystemEnv.getHtmlLabelName(31041,user.getLanguage())%></option>
					</select> 
					</span>
					
						<span
					class="FL PT3 PLeft5" style="display: none;"><input name="input" type="text" id="searchTX"
						class="OInput BoxW110" value="" /> </span>
						
				<span class="FontYahei cWhite PL20 PTop5 FL"
					style="padding-top: 3px;display: none;">
					<ul class="OBtnUl FL cBlack6" style="display: none;">
						<li>
							<em><i><a href="javascript:queryCompanyType(jQuery('#businesstype01').val(),'2');">
							<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%></a> </i> </em>
						</li>
					</ul> </span>
				<ul class="OContRightMsg cBlack FR MT5"  style="margin-right: 20px">
					
					<li   style="display: none;">
						<a id="viewBtn" href="javascript:beforeEditorView('viewBtn');"
							rel="CompanyInfoMaint.jsp?btnid=viewBtn" class="hover"><div>
								<div>
									<!-- 查看 -->
									<%=SystemEnv.getHtmlLabelName(367,user.getLanguage())%>
								</div>
							</div> </a>
					</li>
					
					<%if(true||maintFlag){ %>
					<li>
						<a id="newBtn" href="javascript:beforeNew();" rel="CompanyInfoMaint.jsp?btnid=newBtn"
							class="hover"><div>
								<div>
									<!-- 新增 -->
									<%=SystemEnv.getHtmlLabelName(1421,user.getLanguage())%>
								</div>
							</div> </a>
					</li>
					<%} %>
					
					
					<li   style="display: none;">
						<a id="editBtn" href="javascript:beforeEditorView('editBtn');"
							rel="CompanyInfoMaint.jsp?btnid=editBtn" class="hover"><div>
								<div>
									<!-- 修改 -->
									<%=SystemEnv.getHtmlLabelName(103,user.getLanguage())%>
								</div>
							</div> </a>
					</li>
					
					
					<li   style="display: none;">
						<a id="delBtn" href="javascript:delMutiList2Info();" class="hover"><div>
								<div>
									<!-- 删除 -->
									<%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%>
								</div>
							</div> </a>
					</li>
					
					<li  style="display: none;">
						<a href="javascript:openLogView();" class="hover"><div>
								<div>
									<!-- 日志 -->
									<%=SystemEnv.getHtmlLabelName(83,user.getLanguage())%>
								</div>
							</div> </a>
					</li> 
				</ul>
			</div>
			<div id="listcontent" class=" OScrollHeight4 MT5 "   >
				<iframe id="frame2list" src="CompanyInfoList.jsp"  width="100%"     frameborder=no   ></iframe>
			</div>
		</div>
		<!--主要内容 end-->
		<div style="clear: both;"></div>
		<!-- 底部菜单 start -->
		  <%
				List list = cpinfoTransMethod.setStale();
			 %>
			<div class="Ofoot  BoxWAuto hidetr"  id="bottom_top">
							<div class="OBottomMessage">
									<table width="100%">
									<tr align="center">
										<td width="170"  id="a_click"  onclick="beforeNew_conter(0,3)"  style="cursor: pointer;">
											<img src="images/O_22.png"   />
											<%=SystemEnv.getHtmlLabelName(31079,user.getLanguage())%>
											<span style="color: #FF0000"><%=list.get(2) %></span>
										</td>
										<td width="170" onclick="beforeNew_conter(0,5)" style="cursor: pointer;">
											<img src="images/O_22.png"  />
											<%=SystemEnv.getHtmlLabelName(31080,user.getLanguage())%>
											<span style="color: #FF0000"><%=list.get(4) %></span>
										</td>
										<td width="170" onclick="beforeNew_conter(0,1)" style="cursor: pointer;">
											<img src="images/O_22.png"  />
											<%=SystemEnv.getHtmlLabelName(31081,user.getLanguage())%>
											<span style="color: #FF0000"><%=list.get(0) %></span>
										</td>
										<td width="170" onclick="beforeNew_conter(0,2)" style="cursor: pointer;">
											<img src="images/O_22.png"  />
											<%=SystemEnv.getHtmlLabelName(31082,user.getLanguage())%>
											<span style="color: #FF0000"><%=list.get(1) %></span>
										</td>
										<td width="170" onclick="beforeNew_conter(0,4)" style="cursor: pointer;">
											<img src="images/O_22.png"  />
											<%=SystemEnv.getHtmlLabelName(31083,user.getLanguage())%>
											<span style="color: #FF0000"><%=list.get(3) %></span>
											
										</td>
										<td width="170">
											&nbsp;
										</td>
									</tr>
								</table>
							</div>
			</div>
			<!-- 底部菜单 end -->
				
	</body>
</html>