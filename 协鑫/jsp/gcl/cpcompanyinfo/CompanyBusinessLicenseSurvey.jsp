<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<jsp:include page="/cpcompanyinfo/CompanyInfoContainer.jsp" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="cu" class="weaver.company.CompanyUtil" scope="page" />
<jsp:useBean id="CompanyPermissionService" class="weaver.cpcompanyinfo.CompanyPermissionService" scope="page" />
<script type="text/javascript" src="/cpcompanyinfo/test/ddpowerzoomer.js"></script>
<%
    boolean fromNEWPAGE="newpage".equals(request.getParameter("from"));
%>
<%
	//<script src="/cpcompanyinfo/test/js/jqzoom.pack.1.0.1.js" type="text/javascript"></script>
	//<link rel="stylesheet" href="/cpcompanyinfo/test/css/jqzoom.css" type="text/css">
	//<script src="/cpcompanyinfo/test/js/jquery-1.3.2.min.js" type="text/javascript"></script>
	String companyid = request.getParameter("companyid");
	String companyname = request.getParameter("companyname");
	
	String archivenum = request.getParameter("archivenum");
	boolean maintFlag = false;
//	if(cu.canOperate(user,"2")||cu.canOperate(companyid,user,"2"))//��̨ά��Ȩ��
	if(CompanyPermissionService.canEditCompany(user,companyid))//��̨ά��Ȩ��
	{
		maintFlag = true;
	}
	//�ܹؼ���һ�������������жϺ���ҳ���Ƿ񿪷��༭Ȩ��
	//0--ֻ�������˾�Ĳ鿴Ȩ�ޣ�û��ά��Ȩ��
	//1--ӵ�������˾�鿴��ά��ȫ��
	String showOrUpdate =Util.null2String(request.getParameter("showOrUpdate"));
	//�������������ÿһ���û����Եģ������ڴ������������Ե�����ɾ����û����

%>

<html>
	<head>
		<script type="text/javascript">
	
	jQuery(document).ready(function(){
		jQuery('#searchTX').bind('keyup', function(event){
				   if (event.keyCode=="13"){
				    	searchLicense1();
				    	this.blur();
				   }
		});
				
		setBottom();
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
		   
	});
	
	/*�������ʱ�� qitp*/
	function beforeNew(){
		jQuery("#newBtn").qtip(
		{
		
			content: {
				url:( jQuery("#newBtn").attr("rel"))+"&companyid=<%=companyid%>"
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
		        width:943,
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
				beforeHide: function()
				{
				   // Fade out the modal "blanket" using the defined hide speed
				   jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
				}
			}
		});
	
	}
	
	/*�󶨱༭���߲�ʱ���ж�ʱ��ѡ���б���ѡ�����qtip*/
	function beforeEditorView(btnid,id,showOrUpdate)
	{	
			/*��ȡiframe��companylist.jsp��ѡ�е�checkbox�ļ�¼���ݿ�ID*/
				
				jQuery("#"+btnid).qtip(
				{
					content: {
						url: jQuery("#"+btnid).attr("rel")+"&companyid=<%=companyid%>&licenseid="+id+"&showOrUpdate="+showOrUpdate
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
				        width:943,
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
						beforeHide: function()
						{
						   // Fade out the modal "blanket" using the defined hide speed
						   jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
						}
					}
				});
			
	
	}
	
	/*�б�ɾ������*/
	function delMutiList2Info(licenseids){
		
			if(confirm("<%=SystemEnv.getHtmlLabelName(30695,user.getLanguage())%>��")){
				var o4params = {
					method:"del",
					licenseids:licenseids+"",
					companyid:"<%=companyid%>"
				};
				jQuery.post("/cpcompanyinfo/action/CPLicenseOperate.jsp",o4params,function(data){
					reflush2List();
				});
			}else
			{
				return;			
			}
	
	}
	
	/* ˢ��licenselist.jspҳ���Ѵﵽ���������޸ģ�ɾ����ı��¼��Ŀ��*/
	function reflush2List(){
//		jQuery("#frame2list")[0].contentWindow.reloadListContent();
        window.location.href=window.location.href;
	}
	
	function searchLicense1(){
		var o4searchTX="";
		var o4searchSL = "";
		if(jQuery("#searchTX").val()!=""){
			o4searchTX=jQuery("#searchTX").val();
			o4searchSL = jQuery("#searchSL").val();
		}
		jQuery("#frame2list").attr("src","CompanyBusinessLicenseList.jsp?companyid=<%=companyid%>&o4searchTX="+o4searchTX+"&o4searchSL="+o4searchSL+"&showOrUpdate=<%=showOrUpdate%>");
	}
	function setBottom(){
			var docH=$(document).height(); 
			var tempH=docH-80;
			$("#listcontent").height(tempH);
			$("#frame2list").height(tempH);
			
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
	<body>
		<!--ͷ�� end-->
		<!--���� start-->
		<div class="OBoxW ">
			<div class="FL OBoxW">
				<ul style="width: 300px; float: right">
					<!-- <li class="FontYahei liBtnStyle">
						<a id="cantacts" href="#"><img src="images/k_03.png"
								class="png" />ͨѶ¼</a>
					</li>
					<li class="FontYahei liBtnStyle">
						<img src="images/k_02.png" class="png" />
						��������
					</li>
					<li class="FontYahei liBtnStyle">
						<img src="images/k_01.png" class="png" />
						֪ʶ�Ż�
					</li>
					<div class="clear"></div>
					 -->
				</ul>
			</div>
			<div class="FL BoxWAuto OBoxWBg1 ">
				<div class="border19 " <%=fromNEWPAGE?"style='display:none;'":"" %> >
					<ul class="ONavSubnav PTop10 cBlue FL PB3">
						<span class="cBlue FontYahei FS16 PL15" id=_companyname><%=companyname%></span>
						<span class="cBlack1 FontYahei FS13 PL10"><%=archivenum%></span>
					</ul>
					<!--�� start-->
					<div class="PTop5 FR PR10">
						<ul class="ONavSubnav cBlack FR MT3">
							<li returerel="">
								<a
									href="javascript:window.location.href='/cpcompanyinfo/CompanyManageMain.jsp?companyid=<%=companyid%>&showOrUpdate=<%=showOrUpdate%>&archivenum=<%=archivenum%>';"
									class="hover"><div>
										<div>
											<%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%>
										</div>
									</div> </a>
							</li>
						</ul>
					</div>
					<!--�� end-->
					<div class="clear"></div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<!--���� end -->
		<!--��Ҫ���� start-->
		<div class="OBoxW PTop5">
			<div class="OBoxTit">
				<span class="FontYahei cWhite PL20 PTop5 FL"><%=SystemEnv.getHtmlLabelName(31034,user.getLanguage())%>��</span>
						<span class="FL PT3 PLeft5">
					<select class="OSelect" id="searchSL">
						<%--<option value="t1.CORPORATION"><%=SystemEnv.getHtmlLabelName(23797,user.getLanguage())%></option>--%>
						<%--<option value="t1.REGISTERADDRESS"><%=SystemEnv.getHtmlLabelName(31133,user.getLanguage())%></option>--%>
						<option value="t1.DATEINSSUE"><%=SystemEnv.getHtmlLabelName(27319,user.getLanguage())%></option>
						<option value="t1.ANNUALINSPECTION"><%=SystemEnv.getHtmlLabelName(31030,user.getLanguage())%></option>
						<option value="t1.DEPARTINSSUE"><%=SystemEnv.getHtmlLabelName(125912,user.getLanguage())%></option>
					</select> </span>
					<span
					class="FL PT3 PLeft5"><input name="input" type="text" id="searchTX"
						class="OInput BoxW110" value="" /> </span>
				<span class="FontYahei cWhite PL20 PTop5 FL"
					style="padding-top: 3px;">
					<ul class="OBtnUl FL cBlack6">
						<li>
							<em><i><a href="javascript:searchLicense1()"><%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%></a> </i> </em>
						</li>
					</ul> </span>
				<ul class="OContRightMsg cBlack FR MT5" style="margin-right: 10px">
					<li   style="display: none;">
						<a id="viewBtn" href="javascript:beforeEditorView('viewBtn');"
							rel="CompanyBusinessLicenseMaint.jsp?btnid=viewBtn&companyid=<%=companyid%>"
							class="hover"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(367,user.getLanguage())%>
								</div>
							</div> </a>
					</li>
					
					
					
					<%if(maintFlag){ %>
					<li>
						<a id="newBtn" href="javascript:beforeNew();"
							rel="CompanyBusinessLicenseMaint.jsp?btnid=newBtn&companyid=<%=companyid%>"
							class="hover"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(1421,user.getLanguage())%>
								</div>
							</div> </a>
					</li>
					<%} %>
					
					
					<li   style="display: none;">
						<a id="editBtn" href="javascript:beforeEditorView('editBtn');"
							rel="CompanyBusinessLicenseMaint.jsp?btnid=editBtn&companyid=<%=companyid%>"
							class="hover"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(103,user.getLanguage())%>
								</div>
							</div> </a>
					</li>
				<li   style="display: none;">
						<a id="delBtn" href="javascript:delMutiList2Info();" class="hover"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%>
								</div>
							</div> </a>
					</li>
					
					
					
					
					<!-- <li>
						<a href="javascript:void(0);" class="hover"><div>
								<div>
									����
								</div>
							</div> </a>
					</li>
					<li>
						<a href="javascript:void(0);" class="hover"><div>
								<div>
									��־
								</div>
							</div> </a>
					</li> -->
				</ul>
			</div>
			<div id="listcontent"  >
				<iframe id="frame2list"
					src="CompanyBusinessLicenseList.jsp?companyid=<%=companyid%>&showOrUpdate=<%=showOrUpdate %>"
					width="100%" height="auto" frameborder=no  scrolling="no">

				</iframe>
			</div>


			<!--��Ҫ���� end-->
		</div>
	</body>
</html>