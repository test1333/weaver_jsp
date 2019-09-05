<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="weaver.company.CompanyUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>

<jsp:include page="/cpcompanyinfo/CompanyInfoContainer.jsp" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="cpinfoTransMethod" class="weaver.cpcompanyinfo.CompanyInfoTransMethod" scope="page" />
<%
	String companyid = Util.null2String(request.getParameter("companyid"));
	
	//很关键的一个变量，用于判断后续页面是否开发编辑权限
	//0--只有这个公司的查看权限，没有维护权限
	//1--拥有这个公司查看和维护全县
	String showOrUpdate = Util.null2String(request.getParameter("showOrUpdate"));

	if("".equals(showOrUpdate)){
			//showOrUpdate="",很有可能是从flash里面点击[公司资料]按钮进入的，所以在此要更新一次判断权限
			 String userManager="";
			 CompanyUtil cu=new CompanyUtil();
			 if(!cu.canOperate(user,"2")){
				//得到当前用户管辖那几个公司
				    userManager=cu.canOperateCOM(user,"2");
			  }else{
					userManager="ALL";
			  }
			 showOrUpdate="0";
			 if("ALL".equals(userManager)){
				//说明有所有公司的维护权限
				showOrUpdate="1";
			 } else if((","+userManager+",").lastIndexOf(","+companyid+",")!=-1){
				//说明有该公司的维护权限
				showOrUpdate="1";
			 }
	
	}
	
	/* 公司基本表*/
	String companyname = "";
	String archivenum = "";
	
	
	
	String sqlinfo = "select * from CPCOMPANYINFO where companyid = " + companyid;
	rs.execute(sqlinfo);
	if(rs.next()){
		companyname = rs.getString("COMPANYNAME");
		archivenum = rs.getString("ARCHIVENUM");
	}
	
	
 %>

<html>
	<head>
		<script type="text/javascript">
			jQuery(document).ready(function(){
				$('#searchAffix').bind('keyup', function(event){
				   if (event.keyCode=="13"){
				    	searchaffix();
				    	this.blur();
				   }
				});
				
				setBottom();
			//jQuery("#id").width(jQuery(window).width());jQuery(window).resize(function(){jQuery("#id").width(jQuery(window).width());})
			//var allwidth=jQuery(window).width();
			//var MW=$("#MainCont").width(allwidth); 
		
		//	var LW=$("#BContLeft").width("50%"); 
			//var RW=$("#BContRight").width((allwidth/2)-10); 
			
			//alert($("#MainCont").width()+"--"+$("#BContLeft").width()+"--"+$("#BContRight").width());
			
			jQuery(".ONav").find("li").bind("click",function(){
				jQuery(".ONav").find(".hover").removeClass("hover");
				jQuery(this).find("a").addClass("hover");
				
			});
			/*通讯录*/
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
		   
		   
			
			
			
			var obj = jQuery("#pagegxList").find("li");
			var divsize = obj.size(); //数据条数
			
			var perpage = 5;	//每页条数
			var sumpage = Math.ceil(divsize/perpage);	//总页数	
			var i = 1;  //默认第一页
			obj.hide();
			obj.slice(0,perpage).show();
			//上一页
			$("#prevpage").click(function(){		
				--i;
				if(i<=0)
				{
					i = 1;
					return false;
				}
				obj.hide();
				obj.slice(i*perpage-perpage,i*perpage).show();	
			});
			//下一页
			$("#nextpage").click(function(){	
				if(i>=sumpage)
				{
					i = sumpage;
					return false;
				}
				obj.hide();
				obj.slice(i*perpage,i*perpage+perpage).show();
				++i;
			});
			
		});
		
		/*打开章程面板*/
		function open2zc(){
			jQuery("a[typepage='zc']").qtip(
			{
				content: {
					url: jQuery("a[typepage='zc']").attr("businessref")
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
	            		SWFUpload.movieCount=0;
	            		jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
		    		},
		    		onShow:function(){
		    			//alert(1);
		    		},
					beforeHide: function()
					{
			   			// Fade out the modal "blanket" using the defined hide speed
			   			jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
					}
				}
			});
		}
		
		/*打开董事会面板*/
		function open2dsh(){
			jQuery("a[typepage='dsh']").qtip(
			{
				content: {
					url: jQuery("a[typepage='dsh']").attr("businessref")
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
	        		width:692,
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
	            		SWFUpload.movieCount=0;
	            		jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
		    		},
		    		onShow:function(){
		    			//alert(1);
		    		},
					beforeHide: function()
					{
			   			// Fade out the modal "blanket" using the defined hide speed
			   			jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
					}
				}
			});
		}
		
		
		/*打开股东面板*/
		function open2gd(){
			jQuery("a[typepage='gd']").qtip(
			{
				content: {
					url: jQuery("a[typepage='gd']").attr("businessref")
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
	        		width:762,
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
	            		SWFUpload.movieCount=0;
	            		jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
		    		},
		    		onShow:function(){
		    			//alert(1);
		    		},
					beforeHide: function()
					{
			   			// Fade out the modal "blanket" using the defined hide speed
			   			jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
					}
				}
			});
		}
	
	//后半部分操作
	function searchaffix(){
		if(jQuery("#searchAffix").val()==""){
			alert("<%=SystemEnv.getHtmlLabelName(31087,user.getLanguage())%>！");
		}else{
			var affixurl = jQuery("#searchImg").attr("businessref")+"&searchaffix="+jQuery("#searchAffix").val()
			jQuery("#searchImg").qtip(
			{
				content: {
					url: affixurl
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
	        		width:540,
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
	            		//SWFUpload.movieCount=0;
	            		jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
		    		},
		    		onShow:function(){
		    			//alert(1);
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
	
	function openAffixSearch(whichBtn,whichMethod){
		var affixUrl;
		if(whichMethod=="add"){
			affixUrl=jQuery("#affix2SAdd").attr("refUrl")+"&moudel="+jQuery("#affix2SAdd").attr("urlMoudel")+"&btn="+whichBtn;
		}else if(whichMethod=="edit"){
			affixUrl=jQuery("#affix2SEdit").attr("refUrl")+"&moudel="+jQuery("#affix2SEdit").attr("urlMoudel")+"&btn="+whichBtn;
		}
		jQuery("#"+whichBtn).qtip(
			{
				content: {
					url: affixUrl
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
	        		width:540,
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
	            		//SWFUpload.movieCount=0;
	            		jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
		    		},
		    		onShow:function(){
		    			//alert(1);
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
	function beforeEditorView(whichBtn,whichMethod)
	{	
		/*获取iframe中companylist.jsp中选中的checkbox的记录数据库ID*/
		var requestids = jQuery("#frame2list")[0].contentWindow.getrequestids();	
		if(requestids==null||requestids=="")
		{
			alert("<%=SystemEnv.getHtmlLabelName(31017,user.getLanguage())%>！")
		}
		else
		{
			if(requestids.split(',').length>2){
				alert("<%=SystemEnv.getHtmlLabelName(31014,user.getLanguage())%>！");
			}
			else{
				var affixUrl;
				if(whichMethod=="add"){
					affixUrl=jQuery("#affix2SAdd").attr("refUrl")+"&moudel="+jQuery("#affix2SAdd").attr("urlMoudel")+"&btn="+whichBtn;
				}else if(whichMethod=="edit"){
					affixUrl=jQuery("#affix2SEdit").attr("refUrl")+"&moudel="+jQuery("#affix2SEdit").attr("urlMoudel")+"&btn="+whichBtn+"&searchid="+requestids.split(',')[0];
				}
				jQuery("#"+whichBtn).qtip(
				{
					content: {
						url: affixUrl
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
		        		width:540,
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
		            		//SWFUpload.movieCount=0;
		            		jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
			    		},
			    		onShow:function(){
			    			//alert(1);
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
	}
	
	function f1(whichBtn,whichMethod,o4thisid) {   
        var affixUrl;
        var requestids = jQuery("#frame2list")[0].contentWindow.getrequestids();
		if(whichMethod=="add"){
			affixUrl=jQuery("#affix2SAdd").attr("refUrl")+"&moudel="+jQuery("#affix2SAdd").attr("urlMoudel")+"&btn="+whichBtn;
		}else if(whichMethod=="edit"){
			affixUrl=jQuery("#affix2SEdit").attr("refUrl")+"&moudel="+jQuery("#affix2SEdit").attr("urlMoudel")+"&btn="+whichBtn+"&searchid="+o4thisid;
		}
		jQuery("#"+whichBtn).qtip(
		{
			content: {
				url: affixUrl
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
        		width:540,
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
            		//SWFUpload.movieCount=0;
            		jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
	    		},
	    		onShow:function(){
	    			//alert(1);
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
				url: "ChooseCompanyBottom.jsp?type="+type+"&showvalue="+showvalue+"&companyid=<%=companyid%>"
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
	
	function changeMethod(whichMoudel){
		jQuery("a[urlMoudel]").attr("urlMoudel",whichMoudel);
		jQuery("#frame2list").attr("src","CompanyAffixMainList.jsp?companyid=<%=companyid %>&moudel="+whichMoudel);
	}
	
	function moreMethod(){
		jQuery("#frame2list").attr("src","CompanyAffixMainList1.jsp?companyid=<%=companyid %>&moudel="+jQuery("#moreBtn").attr("urlMoudel"));
	}
	
	/*列表删除操作*/
	function delAffixSearch(){
		var requestids = jQuery("#frame2list")[0].contentWindow.getrequestids();
		if(requestids==null||requestids=="")
		{
			alert("<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage())%>！")
		}
		else
		{
			if(confirm("<%=SystemEnv.getHtmlLabelName(30695,user.getLanguage())%>？")){
				var o4params = {
					method:"del",
					affsearchids:requestids
				};
				
				jQuery.post("/cpcompanyinfo/action/CPManageOperate.jsp",o4params,function(data){
					reflush2List();
				});
			}else
			{
				return;			
			}
		}
	}
	/* 刷新companyaffixMainlist.jsp页面已达到，新增，修改，删除后改变记录的目的*/
	function reflush2List(){
			jQuery("#frame2list")[0].src=jQuery("#frame2list")[0].src;
		//jQuery("#frame2list")[0].contentWindow.reloadListContent();
	}
	
	function setBottom(){
			var docH=$(document).height(); 
			var botH=$("#bottom_top").height();
			var totH=$("#top_div").height();
			//减去10px的padding和margin值
			var tempH=docH-botH-totH-10-5;
			$("#OBoxW_H").height(tempH+"px");
			$("#BContLeft").height((tempH-30)+"px");
			$("#BContRight").height((tempH-30)+"px");
			$("#frame2list").height((tempH-20)+"px");
			$("#set_H").height(($("#BContRight").height()-250)+"px");
			$("#frame2list").height(($("#BContRight").height()-250)+"px");
			
			<%
				if("0".equals(showOrUpdate)){
			%>
					
					if(""==$("#Constitution").html()){
							$("#Constitution").parent().attr("href","javascript:alert('章程还没有创建！')");
					 }
					 if(""==$("#ShareHolder").html()){
							$("#ShareHolder").parent().attr("href","javascript:alert('股东还没有创建！')");
					 }
					 if(""==$("#BoardDirectors").html()){
							$("#BoardDirectors").parent().attr("href","javascript:alert('董事会还没有创建！')");
					 }
			<%	
				}
			%>
			
			
			
	}
	//刷新数据
	 function refsh(){
				var o4params = {
					method:"refsh",
					companyid:"<%=companyid%>"
				};
				jQuery.post("/cpcompanyinfo/action/CPManageOperate.jsp",o4params,function(data){
							jQuery("#License").html(data[0]);
							jQuery("#Constitution").html(data[1]);
							jQuery("#ShareHolder").html(data[2]);
							jQuery("#BoardDirectors").html(data[3]);
							 jQuery("#pagegxList").html("").html(data[4]);
							 jQuery("#_fr").html("").html(data[5]);
							 jQuery("#_ds").html("").html(data[6]);
							 jQuery("#_gd").html("").html(data[7]);
							var obj = jQuery("#pagegxList").find("li");
							var divsize = obj.size(); //数据条数
							var perpage = 5;	//每页条数
							var sumpage = Math.ceil(divsize/perpage);	//总页数	
							var i = 1;  //默认第一页
							obj.hide();
							obj.slice(0,perpage).show();
							//上一页
							$("#prevpage").click(function(){		
								--i;
								if(i<=0)
								{
									i = 1;
									return false;
								}
								obj.hide();
								obj.slice(i*perpage-perpage,i*perpage).show();	
							});
							//下一页
							$("#nextpage").click(function(){	
								if(i>=sumpage)
								{
									i = sumpage;
									return false;
								}
								obj.hide();
								obj.slice(i*perpage,i*perpage+perpage).show();
								++i;
							});
			
				},"json");
	} 
</script>

<style type="text/css">
		.MLeft20{
				margin-left: 20px;
		}
</style>
<!--[if lte IE 6]>
<script type="text/javascript" src="js/DD_belatedPNG_0.0.7a.js"></script>

<script>

DD_belatedPNG.fix('.png,.png:hover');

</script>
<![endif]-->
	</head>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
	<body>
		<!--头部 end-->
		<!--导航 start-->
		<div class="OBoxW "    id="top_div">
			<div class="FL OBoxW">
				<ul style="width: 300px; float: right">
				<!-- 	<li class="FontYahei liBtnStyle">
						<a id="cantacts" href="#"><img src="images/k_03.png"
								class="png" />通讯录</a>
					</li>
					<li class="FontYahei liBtnStyle">
						<img src="images/k_02.png" class="png" />
						网上助手
					</li>
					<li class="FontYahei liBtnStyle">
						<img src="images/k_01.png" class="png" />
						知识门户
					</li> -->
					<div class="clear"></div>
				</ul>
			</div>
			<div class="FL BoxWAuto OBoxWBg1 ">
				<div class="border19 ">
					<ul class="ONavSubnav PTop10 cBlue FL PB3">
						<span class="cBlue FontYahei FS16 PL15"><%= companyname%></span>
						<span class="cBlack1 FontYahei FS13 PL10"><%= archivenum%></span>
					</ul>
					<!--表单 start-->
					<div class="PTop5 FR PR10">
						<ul class="ONavSubnav cBlack FR MT3">
							<li returerel="">
								<a
									href="javascript:window.location.href='/cpcompanyinfo/CompanyInfoSurvey.jsp';"
									class="hover"><div>
										<div>
											<%=SystemEnv.getHtmlLabelName(31088,user.getLanguage())%>
										</div>
									</div> </a>
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
		
		
		
		<%
			List list = cpinfoTransMethod.setStale(companyid);
		 %>
		<!--主要内容 start-->
		<div class="BBoxW PTop5"    id="OBoxW_H">
			<div class="BContLeft "   id="BContLeft">
				<ul class="FL">
					<li>
						<a
							href="javascript:window.location.href='/cpcompanyinfo/CompanyBusinessLicenseSurvey.jsp?companyid=<%=companyid%>&companyname=<%= companyname%>&archivenum=<%= archivenum%>&showOrUpdate=<%=showOrUpdate %>';"><span
							class="cBlue FontYahei FS16"><%=SystemEnv.getHtmlLabelName(30958,user.getLanguage())%></span>
						<p class="cBlack4 PTop10"  id="License">
								<!-- 公司证照 -->
								<%=SystemEnv.getHtmlLabelName(30942,user.getLanguage())%><%=list.get(2) %><%=SystemEnv.getHtmlLabelName(30943,user.getLanguage())%>
							</p>
						</a>
					</li>
					<li>
						<a href="javascript:open2zc()" typepage="zc"
							businessref="/cpcompanyinfo/CompanyConstitutionMaint.jsp?companyid=<%=companyid%>&companyname=<%=companyname%>&showOrUpdate=<%=showOrUpdate %>" rwidth="590" refheight="550"  ><span
							class="cBlue FontYahei FS16"><%=SystemEnv.getHtmlLabelName(30941,user.getLanguage())%></span>
							<!-- 章程 -->
						<p class="cBlack4 PTop10"  id="Constitution">
							<%if(!list.get(5).toString().split("/")[0].equals("0")){ %>
								<%=list.get(5).toString().split("/")[0] %><%=SystemEnv.getHtmlLabelName(125,user.getLanguage())%></br><%=list.get(5).toString().split("/")[1] %><%=SystemEnv.getHtmlLabelName(567,user.getLanguage())%>
								<%} %>
							</p>
						</a>
					</li>
					<li>
						<a href="javascript:open2gd()" typepage="gd"
							businessref="/cpcompanyinfo/CompanyShareHolderMaint.jsp?companyid=<%=companyid%>&showOrUpdate=<%=showOrUpdate %>" rwidth="590" refheight="330"  ><span
							class="cBlue FontYahei FS16"><%=SystemEnv.getHtmlLabelName(28421,user.getLanguage())%></span>
						<p class="cBlack4 PTop10"  id="ShareHolder">
								<%if(!list.get(6).toString().split("/")[0].equals("0")){ %>
								<%=list.get(6).toString().split("/")[0] %><%=SystemEnv.getHtmlLabelName(125,user.getLanguage())%></br><%=list.get(6).toString().split("/")[1] %><%=SystemEnv.getHtmlLabelName(567,user.getLanguage())%>
								<%} %>
							</p>
						</a>
					</li>
					
					<li>
						<a href="javascript:open2dsh()" typepage="dsh"
							businessref="/cpcompanyinfo/CompanyBoardDirectorsMaint.jsp?companyid=<%=companyid%>&companyname=<%=companyname%>&showOrUpdate=<%=showOrUpdate %>"  rwidth="590" refheight="400"><span
							class="cBlue FontYahei FS16"><%=SystemEnv.getHtmlLabelName(30936,user.getLanguage())%></span>
						<p class="cBlack4 PTop10" id="BoardDirectors">
								<%if(!list.get(7).toString().split("/")[0].equals("0")){ %>
								<%=list.get(7).toString().split("/")[0] %><%=SystemEnv.getHtmlLabelName(125,user.getLanguage())%></br><%=list.get(7).toString().split("/")[1] %><%=SystemEnv.getHtmlLabelName(567,user.getLanguage())%>
								<%} %>
							</p>
						</a>
					</li>
				

				</ul>
			</div>
			<div class="BContRight"  id="BContRight">
				<div class="BContRightTitW FL">
					<div class="border17">
						<div class=" border18 BBoxWBg  BoxHeight27">
							<span class="FR MR10"><img id="prevpage" style="cursor:hand" src="images/O_23.jpg" />&nbsp;&nbsp;<img
									 id="nextpage" src="images/O_24.jpg" style="cursor:hand"/>
							</span>
							<img src="images/O_22.png" class="png MLeft10 FL MT8" />
							<span class="cBlue PLeft5 FL"><%=SystemEnv.getHtmlLabelName(31089,user.getLanguage())%></span>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<div class="clear"></div>




				<div class="border19">
					<ul class="BContRightList" style="height:140px;overflow: auto;" id="pagegxList">
						<%String upsql = "select * from CPCOMPANYUPGRADE where companyid="+companyid+" order by CREATEDATETIME desc"; 
							rs.execute(upsql);
							while (rs.next()){
						%>
						<li><span class="FR"><%=rs.getString("CREATEDATETIME") %></span><%=rs.getString("discription") %></li>
						<%} %>
					</ul>
				</div>
				<div class="BContRightTitW FL MT3">
					<div class="border19 BBoxWBg  BoxHeight27 ">
						<div class=" Relative BoxW430">
							<span class="FL" style="margin-left:8px">&nbsp;</span>
							<img src="images/O_22.png" class="png  FL MT8" />
							<span class="cBlue PLeft5 FL"><%=SystemEnv.getHtmlLabelName(31757,user.getLanguage())%></span>
							
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<div class="BContRightTitW FL MT3">
					<div class="border19 BBoxWBg  BoxHeight27 ">
						<div class=" Relative BoxW430">
								<span class="FL" style="margin-left:8px">&nbsp;</span>
								<%=SystemEnv.getHtmlLabelName(31034,user.getLanguage())%>
								<input type="text" name="searchAffix" id="searchAffix"
								class="BInput2 BoxW410 FR MR10 MT3" style="height: 21px; line-height:21px;" />
							<img src="images/BI_16.jpg" id="searchImg" class="Absolute" onclick="javascript:searchaffix();"
								style="right: 15px; top: 8px; cursor:hand;" businessref="/cpcompanyinfo/CompanyAffixFileDown.jsp?companyid=<%=companyid%>"/>
						</div>
						<div class="clear"></div>
					</div>
				</div>
				
				
				<div class="BContRightTitW FL MT3">
					<div class="border17" >
						<div class=" BoxHeight27 BBoxWBg"  >
						
						<%
								if("1".equals(showOrUpdate)){
						 %>
							<ul class="BContRightMsg2 FR PR10 MT5">
							
							
								<li>
								
									<a id="affix2SAdd" href="javascript:openAffixSearch('affix2SAdd','add');" class="hover" refUrl="/cpcompanyinfo/CompanyAffixSearch.jsp?method=add&companyid=<%=companyid %>" urlMoudel="search"><div>
											<div>
												<%=SystemEnv.getHtmlLabelName(1421,user.getLanguage())%>
											</div>
										</div>
									</a>
								</li>
								<li style="display:none">
									<a id="affix2SEdit" href="javascript:beforeEditorView('affix2SEdit','edit');" class="hover" refUrl="/cpcompanyinfo/CompanyAffixSearch.jsp?method=edit&companyid=<%=companyid %>" urlMoudel="search"><div>
											<div>
												<%=SystemEnv.getHtmlLabelName(103,user.getLanguage())%>
											</div>
										</div>
									</a>
								</li>
								<li>
									<a href="javascript:delAffixSearch();" class="hover"><div>
											<div>
												<%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%>
											</div>
										</div>
									</a>
								</li>
							
							</ul>
							<%
								}
						 %>
						
									
											<span class="MLeft13 FL"><%=SystemEnv.getHtmlLabelName(30959,user.getLanguage())%></span>
										
								
								
							
							
							<div class="clear"></div>
						</div>
					</div>
				</div>

				<div class=" FL BContRightTitW"  >
					<div class="border19 OContHiddenScroll"  id="set_H"   style="overflow-y:auto ;overflow-x:no " >
						<iframe id="frame2list" src="CompanyAffixMainList.jsp?companyid=<%=companyid %>&moudel=search" width="100%" height="99%" frameborder=no  scrolling="no">
				
						</iframe>
						<div class="clear"></div>
					</div>
				</div>
			</div>
		</div>
		<!--主要内容 end-->
		
		
		<!-- 底部 start -->
		<div class="Ofoot FL BoxWAuto"  id="bottom_top">
				<div class="OBottomMessage">
					<table width="100%">
						<tr align="center">
							<td width="170"  id="a_click"  onclick="beforeNew_conter(1,3)" style="cursor: pointer;">
								<img src="images/O_22.png" />
								<%=SystemEnv.getHtmlLabelName(31079,user.getLanguage())%>
								<span style="color: #FF0000"><%=list.get(2) %></span>
							</td>
							<td width="170" onclick="beforeNew_conter(1,5)" style="cursor: pointer;">
								<img src="images/O_22.png" />
								<!-- 即将年检证照 -->
								<%=SystemEnv.getHtmlLabelName(31080,user.getLanguage())%>
								<span style="color: #FF0000"><%=list.get(4) %></span>
							</td>
							<td width="170" onclick="beforeNew_conter(1,1)" style="cursor: pointer;">
								<img src="images/O_22.png" />
								<!-- 本月变更法人 -->
								<%=SystemEnv.getHtmlLabelName(31081,user.getLanguage())%>
								<span style="color: #FF0000"  id="_fr"><%=list.get(0) %></span>
							</td>
							<td width="170" onclick="beforeNew_conter(1,2)" style="cursor: pointer;">
								<img src="images/O_22.png" />
								<%=SystemEnv.getHtmlLabelName(31082,user.getLanguage())%>
								<span style="color: #FF0000" id="_ds"><%=list.get(1) %></span>
							</td>
							<td width="170" onclick="beforeNew_conter(1,4)" style="cursor: pointer;">
								<img src="images/O_22.png" />
								<%=SystemEnv.getHtmlLabelName(31083,user.getLanguage())%>
								<span style="color: #FF0000" id="_gd"><%=list.get(3) %></span>
							</td>
							<td width="170">
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 底部 end -->
	</body>
</html>