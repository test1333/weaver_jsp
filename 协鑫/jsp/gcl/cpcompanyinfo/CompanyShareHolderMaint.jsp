<%@page import="weaver.cpcompanyinfo.ProTransMethod"%>
<%@page import="weaver.cpcompanyinfo.CompanyInfoTransMethod"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<%
    boolean fromNEWPAGE="newpage".equals(request.getParameter("from"));
    if (fromNEWPAGE) {
%>
<jsp:include page="/cpcompanyinfo/newpage/CompanyInfoContainer2.jsp" />
<%
    }
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs02" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="jspUtil" class="weaver.cpcompanyinfo.JspUtil" scope="page" />
<%@page import="weaver.docs.docs.DocComInfo"%>
<jsp:useBean id="cu" class="weaver.company.CompanyUtil" scope="page" />
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page" />
<jsp:useBean id="CompanyPermissionService" class="weaver.cpcompanyinfo.CompanyPermissionService" scope="page" />
<%
	String companyid = Util.null2String(request.getParameter("companyid"));
	boolean maintFlag = false;
//	if(cu.canOperate(user,"2")||cu.canOperate(companyid,user,"2"))//后台维护权限
    if(CompanyPermissionService.canEditCompany(user,companyid))//后台维护权限
	{
		maintFlag = true;
	}	
	String o4sql = " select * from mytrainaccessoriestype where accessoriesname='lmshare'";
	rs.execute(o4sql);
	String mainId="0";
	String subId="0";
	String secId="0";
	if(rs.next()){
		mainId=rs.getString("mainId");//覆盖默认的0
	 	subId=rs.getString("subId");//覆盖默认的0
	 	secId=rs.getString("secId");//覆盖默认的0c
	}
	//很关键的一个变量，用于判断后续页面是否开发编辑权限
	//0--只有这个公司的查看权限，没有维护权限
	//1--拥有这个公司查看和维护全县
	String showOrUpdate = Util.null2String(request.getParameter("showOrUpdate"));
 %>
<link rel="stylesheet" type="text/css" href="/cpcompanyinfo/style/wbox.css" />
<script type="text/javascript" src="js/magnifier.js"></script>
<!--表头浮动层 start-->
<input type="hidden" id="constitutionid_gdh"/>
<input type="hidden" id="method_gdh"/>
<input type="hidden" id="shareid"/>
<input type="hidden" id="isaddversion"/>
<div
	class="<%=fromNEWPAGE?"":"Absolute OHeaderLayer4 Bgfff BorderLMDIVHide" %>" >
	<div class="OHeaderLayerTit FL OHeaderLayerW51 " style="<%=fromNEWPAGE?"display: none":""%>">
		<span id="spanTitle_gdh" class="cBlue FontYahei FS16 PL15 FL"></span>
		<img src="images/O_40.jpg" class="FR MT10 MR10"
			style="cursor: hand;" onclick="javascript:closeMaint4Win();" />
	</div>
	<div   style="padding-left: 10px;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;<%=fromNEWPAGE?"":"float:left;"%>"  >
	
			<div    style="<%=fromNEWPAGE?"":"height: 360px;"%>overflow-x:hidden;overflow-y:auto">
		<table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0"
			cellspacing="0" class="MT5">
			<tr>
				<td height="25">
					<strong><%=SystemEnv.getHtmlLabelName(30944,user.getLanguage()) %>：</strong>
				</td>
				<td colspan="3">
					<input type="text" name="boardshareholder_gdh" id="boardshareholder_gdh"
						class="OInput2" style="width:339px"  />
				</td>
			</tr>
			<tr>
				<td height="25">
					<strong><%=SystemEnv.getHtmlLabelName(30975,user.getLanguage()) %>：</strong>
				</td>
				<td colspan="3">
				
				<BUTTON  class="Clock"  type="button"    onclick="onShowDate_2(document.getElementById('established_gdh'),document.getElementById('endtime'))"></BUTTON>
					<input type="hidden" id="endtime" name="endtime"  />
					<span id="established_gdh">

					</span>
				</td>
			</tr>
		</table>
		<div class="border17 FL PTop10 OHeaderLayerW61 ML33" >
			<ul class="OContRightMsg2 FR">
			<%if(maintFlag){ %>
				<li>
					<a href="javascript:doadd_gd();" id="newDscyBtn" class="hover"><div>
							<div>
								<%=SystemEnv.getHtmlLabelName(1421,user.getLanguage()) %>
							</div>
						</div> </a>
				</li>
				<li>
					<a href="javascript:dodel_gd1();" id="delDscyBtn" class="hover"><div>
							<div>
								<%=SystemEnv.getHtmlLabelName(23777,user.getLanguage()) %>
							</div>
						</div> </a>
				</li>
				<%} %>
			</ul>

			<ul class="ONav FL cBlue">
				<li>
					<a href="#" class="hover">
						<div>
							<div>
								<%=SystemEnv.getHtmlLabelName(31107,user.getLanguage()) %>
							</div>
						</div> </a>
				</li>
					<select id="selectdate01" onchange="javascript:searchzhzhdate(this);" class="OSelect MT3 MLeft8">
					</select>
			</ul>
			<div class="clear"></div>

		</div>
		<div class="FL ML33" style="<%=fromNEWPAGE?"":"height:25px;width:700px;" %>">
		<table width="684" border="0" cellpadding="0" cellspacing="1"
			class="stripe OTable" >
			<tr id="OTable2" class="cBlack">
				<td width="27" align="center">
					<%
						if(!"0".equals(showOrUpdate)){
					 %>
					<input type="checkbox" id="fileid" onclick="selectall_chk(this)"/>
					<%
						}
					 %>
				</td>
				<td width="100" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(27336,user.getLanguage()) %></strong>
				</td>
				<td width="52" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(31001,user.getLanguage()) %></strong>
				</td>
				<td width="99" align="center">
					<strong>法定<%=SystemEnv.getHtmlLabelName(31040,user.getLanguage()) %></strong>
				</td>
				<td width="99" align="center">
					<strong>实际<%=SystemEnv.getHtmlLabelName(31040,user.getLanguage()) %></strong>
				</td>
				<td width="70" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(406,user.getLanguage()) %></strong>
				</td>
				<td width="120" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(31108,user.getLanguage()) %></strong>
				</td>
				<td width="120" align="center">
					<strong>法定<%=SystemEnv.getHtmlLabelName(31109,user.getLanguage()) %>(%)</strong>
				</td>
				<td width="120" align="center">
					<strong>用途</strong>
				</td>
				<td width="0" align="center">
					<!--  <strong><%=SystemEnv.getHtmlLabelName(31110,user.getLanguage()) %></strong>-->
				</td>
			</tr>
		</table>
		<div class="FR" style="height:24px;width:16px;background-color:#eeeeee; margin-top:-26px"></div>
		</div>
		<div class="OContRightScroll FL OHeaderLayerW61 ML33" style="<%=fromNEWPAGE?"":"height:137px;" %>">
			<table id="webTable2gd" width="684" border="0" cellpadding="0" cellspacing="1"
				class="stripe OTable" style="table-layout: fixed;">
			<%
				String sql = "select t2.* from CPSHAREHOLDER t1,CPSHAREOFFICERS t2 where t1.shareid = t2.shareid and t1.companyid = '" + companyid +"'  order by investment desc";
				rs.execute(sql);
				int ix=1;
				while (rs.next()){
				String valuedate = "";
				if(!Util.null2String(rs.getString("aggregatedate")).equals(""))
				valuedate = rs.getString("aggregatedate").substring(0,4);
			 %>	
			 
			 
			
						
						
			 	<tr dbvalue="<%=valuedate%>">
					<td width="27" align="center">
					<%
						if(!"0".equals(showOrUpdate)){
					 %>
						<input type="checkbox" name="checkbox" inWhichPage="gd" onclick="selectone_chk()"/>
					<%
						}
					 %>
					</td>
					<td width="100" style="word-wrap:break-word;" >
						&nbsp;
						<button class="Browser"  onclick="onLicenseDivOpen(this)" type="button"></button>
						&nbsp;&nbsp;
						<span  ><%=rs.getString("officername")%>
						</span>
						<input type="hidden"   value="<%=rs.getString("companyid") %>">
					</td>
					<td width="52" >
						 &nbsp;
						 <select style="width:40px; height:26px;border:0px;">
							<%=jspUtil.getOption("1,2",""+SystemEnv.getHtmlLabelName(30586,user.getLanguage())+","+SystemEnv.getHtmlLabelName(30587,user.getLanguage())+"",rs.getString("isstop")) %>
						</select>
					</td>
					<td width="99" >
					<%
						if(!"0".equals(showOrUpdate)){
					%>
					&nbsp;&nbsp;
					<input type="text"    value="<%=rs.getString("aggregateinvest") %>" style="width:60px; height:20px; line-height:20px;  background-image:none; "   onblur="displayimg(this)" />
					<%
						}else{
							out.println("&nbsp;&nbsp;&nbsp;&nbsp;"+rs.getString("aggregateinvest"));
						}
					%>
							<span>
										<IMG align=absMiddle src='/images/BacoError.gif'  style="display: none;">
							</span>

				</td>
					<td width="99" >
					<%
						if(!"0".equals(showOrUpdate)){
					%>
					&nbsp;&nbsp;
					<input type="text"    value="<%=rs.getString("aggregateinvest_sj") %>" style="width:60px; height:20px; line-height:20px;  background-image:none; "   onblur="displayimg(this)" />
					<%
						}else{
							out.println("&nbsp;&nbsp;&nbsp;&nbsp;"+rs.getString("aggregateinvest_sj"));
						}
					%>
							<span>
										<IMG align=absMiddle src='/images/BacoError.gif'  style="display: none;">
							</span>

				</td>
					<td width="70" >
							&nbsp;
							<button class="Browser"  onclick="onCurrOpen(this)" type="button"></button>
							<span>
							<%
									rs02.execute("select id,currencyname,currencydesc from FnaCurrency  where id = '"+rs.getString("currencyid")+"'");
									if(rs02.next()){
										out.println(rs02.getString("currencyname"));
									}
							 %>
							</span>
							<input type="hidden"  value="<%=rs.getString("currencyid")%>">
							<span>
										<IMG align=absMiddle src='/images/BacoError.gif'  style="display: none;">
							</span>
					</td>
					<td width="120" >
						&nbsp;
						<BUTTON class=Clock   name="date2list"   type="button"  onclick="onShowDate(document.getElementById('get_sapn<%=ix%>'),document.getElementById('get_input<%=ix%>'))"></BUTTON>
						<INPUT  type=hidden  value="<%=rs.getString("aggregatedate") %>"   id=get_input<%=ix%>>
						<SPAN  id=get_sapn<%=ix%>>	
									<%=rs.getString("aggregatedate") %>
						</SPAN>
						
					</td>
					<td width="120">
					&nbsp;&nbsp;
					<%
							if(!"0".equals(showOrUpdate)){
					%>
					<input type="text"   value="<%=rs.getString("investment") %>"   style=" width:74px; height:20px; line-height:20px;   background-image:none; text-align:center;" onblur="displayimg(this)"></input>
					<input type="hidden">
					<%
							}else{
								out.println("&nbsp;&nbsp;&nbsp;&nbsp;"+rs.getString("investment"));
							}
						 %>
					<span>
										<IMG align=absMiddle src='/images/BacoError.gif'  style="display: none;">
					</span>
						
					</td>
                    <td width="120">
                        &nbsp;&nbsp;
                        <%
                            if(!"0".equals(showOrUpdate)){
                        %>
                        <input type="text"   value="<%=rs.getString("yongt") %>"   style=" width:74px; height:20px; line-height:20px;   background-image:none; text-align:center;" />
                        <input type="hidden">
                        <%
                            }else{
                                out.println("&nbsp;&nbsp;&nbsp;&nbsp;"+rs.getString("yongt"));
                            }
                        %>

                    </td>
					<td width="0" >
						<select style=" width:0px; height:0px;border:0px;">
							<%=jspUtil.getOption("1,0",""+SystemEnv.getHtmlLabelName(26523,user.getLanguage())+","+SystemEnv.getHtmlLabelName(23857,user.getLanguage())+"",rs.getString("ishow")) %>
						</select>
					</td>
				</tr>
			<%
			 	ix++;}
			  %>
			</table>
		</div>
		<table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0" cellspacing="0" class="MT5" style="padding-top:5px;">
			<tr>
				<td height="25" vAlign="top">
					<strong><%=SystemEnv.getHtmlLabelName(17616,user.getLanguage()) %>：</strong>
				</td>
				<td colspan="3">
		    		<%if(!CompanyInfoTransMethod.CheckPack("3")){out.println("<span style='color:red'>"+SystemEnv.getHtmlLabelName(31004,user.getLanguage()) +"！</span>");}%>
		    		<div id="licenseAffixUpload"  >
					<input type="hidden" name="affixdoc" id="affixdoc">
						<span> 
							<span id='spanButtonPlaceHolder'></span><!--选取多个文件-->
						</span>
						&nbsp;&nbsp;
						<span style="color: #262626; cursor: hand; TEXT-DECORATION: none;<%if(!CompanyInfoTransMethod.CheckPack("3")){out.println("display: none;");}%>"
							disabled id="btnCancel_upload">
							<span><img src="/js/swfupload/delete.gif" border="0" onClick="oUploader.cancelQueue()"> </span> <span
							style="height: 19px"> <font style="margin: 0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage()) %>
							(<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage()) %>100<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage()) %>)
							</font> <!--清除所有--> </span> </span>
						<div id="divImgsAddContent" style="overflow: auto;">
							<div></div>
							<div class="fieldset flash" id="fsUploadProgress"></div>
							<div id="divStatus"></div>
						</div>
					</div>
					
					<div id="affixcpdosDIV">
						<%
							int userid = user.getUID();
							String affixdoc = "";
							String affixsql = " select shareaffix from CPSHAREHOLDER where companyid = " + companyid;
							rs.execute(affixsql);
							if(rs.next()){
								affixdoc = Util.null2String(rs.getString("shareaffix"));
							}
							String isdoc="";
							if(!"".equals(affixdoc))
							{
								
								DocComInfo dc=new DocComInfo();						
								String []slaves=affixdoc.split(",");
								for(int i=0;i<slaves.length;i++)
								{
									String tempid="asid"+slaves[i];
								
									out.println("<div id='imgfileDiv"+i+"' style='background-color: #F7F7F7;height:20px;padding-left:4px;border: solid 1px #E8E8E8;padding: 4px;margin-bottom: 5px;'>");
								
									String filename="";
									String fileid="";
									rs.execute("select imagefileid,imagefilename from imagefile where imagefileid = "+slaves[i]);
									if(rs.next()){
										filename = rs.getString("imagefilename");
										fileid= rs.getString("imagefileid");
									}
									out.println("<div style='width:80%;float:left;' >");
									String str="<A id='pdflinkid"+i+"' href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1' class='aContent0 FL'>"+filename+"</A>";
									//输出文档主题，提供下载
									out.println(str);
									out.println("</div>");
									
									//out.println("<div style='width:40%;float:left;'>");
									//输出文档创建时间
									//out.println(dc.getDocCreateTime(slaves));
									//out.println("</div>");
									
									
									out.println("<div style='padding-right:0px;float:right;padding-top:0px'>");
									
									//out.println("文档创建着id"+dc.getDocCreaterid(slaves[i]));
									//getDocOwnerid
									
									//if(dc.getDocCreaterid(slaves[i]).equals(userid+""))//当前用户是文档的创建者
									//{		
										//输出删除文档超链接												
										//isdoc = "affixdoc";
										
									//}else
									//{
										//输出下载文档超链接									
									
									out.println("<a href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1'><img src='images/downLoadPic.gif'  title='"+SystemEnv.getHtmlLabelName(22629,user.getLanguage())+"'  ></a>");
									if(!"0".equals(showOrUpdate)){
										out.println("<img src='images/delwk.gif' onclick=delImg(imgfileDiv"+i+","+slaves[i]+") title='"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"'></a>");
									}
									//}
									
									out.println("</div>");					
									out.println("</div>");
								}
							}
									
				
						%>
						</div>
						
						
				</td>
			</tr>
		</table>
		<div class="MT10 FL OHeaderLayerW61 ML17" style="height: 40px">

			<span   class="newLISapn">	
				<a href="javascript:openVersionManage();" class="hover">
							<%=SystemEnv.getHtmlLabelName(19450,user.getLanguage()) %>
				</a>
			</span>	
			<%if(maintFlag){ %>
				<span  class="newLISapn" id="save_H">
					<a id="saveShareHolderBtn" href="javascript:void(0);" class="hover">
								<%=SystemEnv.getHtmlLabelName(31005,user.getLanguage()) %>
					</a>
				</span>	
				<span  class="newLISapn" id="save_Q">
					<a id="saveShareHolderBtnQ" href="javascript:void(0);" class="hover">
								保存
					</a>
				</span>
			<%} %>

		</div>
	</div>
</div>
</div>
<!--表头浮动层 end-->
<input type="hidden" id="ratio" value="0"/>
<div id="hiddenTrInDIV" style="display:none">
		<span _calss="show">
			<input type="checkbox" name="checkbox"  inWhichPage="gd" onclick="selectone_chk()"/>
		</span>
		<span _calss="show">
			&nbsp;&nbsp;
			<button class="Browser"  onclick="onLicenseDivOpen(this)" type="button"></button>
			&nbsp;&nbsp;
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
			<input type="hidden">
			
		</span>
		<span _calss="show">
				&nbsp;
			<select style="width:40px; height:26px;border:0px;">
				<option value="2"><%=SystemEnv.getHtmlLabelName(30587,user.getLanguage()) %></option>
				<option value="1"><%=SystemEnv.getHtmlLabelName(30586,user.getLanguage()) %></option>
			</select>
		</span>
		<span _calss="show">
			&nbsp;&nbsp;
			<!-- 投资额 -->
			<input type="text" style="width:60px; height:20px; line-height:20px;  background-image:none; " onblur="displayimg(this)"></input>
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		</span>
	<span _calss="show">
			&nbsp;&nbsp;
			<!-- 投资额 -->
			<input type="text" style="width:60px; height:20px; line-height:20px;  background-image:none; " onblur="displayimg(this)"></input>
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		</span>
		<span _calss="show">
		<%

				String DefaultCurrency=ProTransMethod.getDefaultCurrency();
				if(null!=DefaultCurrency&&DefaultCurrency.indexOf(",")!=-1){
		 %>
					<!-- 货币 -->
					&nbsp;&nbsp;
					<button class="Browser"  onclick="onCurrOpen(this)" type="button" ></button>
					<span>
						<%=DefaultCurrency.split(",")[1] %>
					</span>
					<input type="hidden"   value="<%=DefaultCurrency.split(",")[0] %>">
					<span>
							<IMG align=absMiddle src='/images/BacoError.gif'  style="display: none;">
					</span>
			<%
				}else{
			%>
						<!-- 货币 -->
						&nbsp;&nbsp;
						<button class="Browser"  onclick="onCurrOpen(this)" type="button" ></button>
						<span>
						</span>
						<input type="hidden"   value="">
						<span>
								<IMG align=absMiddle src='/images/BacoError.gif'>
						</span>
			<%
				}
			 %>
		</span>
		<span _calss="show">
		<!-- 投资时间 -->
		&nbsp;&nbsp;
		<BUTTON class=Clock   name="date2list"   type="button"></BUTTON>
		<INPUT  type=hidden>
		<span>
					<IMG align=absMiddle src='/images/BacoError.gif' style="display: none;">
		</span>
		 	
		</span>
		<span _calss="show">
				<!-- 投资比例 -->
				&nbsp;&nbsp;
			<input type="text" style=" width:74px; height:20px; line-height:20px;   background-image:none; text-align:center;"   onblur="displayimg(this)"></input>
			<input type="hidden">
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		</span>
    <span _calss="show">
				<!-- 用途 -->
				&nbsp;&nbsp;
			<input type="text" style=" width:74px; height:20px; line-height:20px;   background-image:none; text-align:center;"   ></input>
			<input type="hidden">
		</span>
		<span _calss="show">
			<select style="margin:-5px; width:0px; height:26px;border:0px;">
				<option value="1"><%=SystemEnv.getHtmlLabelName(26523,user.getLanguage()) %></option>
				<option value="0"><%=SystemEnv.getHtmlLabelName(23857,user.getLanguage()) %></option>
			</select>
		</span>
</div>

<!-- 证照弹出层 -->

<div style="clear:both;display:none" id="licenseDiv">
	<div id="wBox" style="top:50px;left:245px;"><!-- 定义层在什么位置上 -->
		<div class="wBox_popup">
    		<table>
    			<tbody>
    				<tr><td class="wBox_tl"/><td class="wBox_b"/><td class="wBox_tr"/></tr>
    				<tr><td class="wBox_b"></td>
    					<td>
		   					<div class="wBox_body">
		       					<table class="wBox_title">
		       						<tr>
		          						<td class="wBox_dragTitle"><div class="wBox_itemTitle"><%=SystemEnv.getHtmlLabelName(31111,user.getLanguage()) %></div></td>
		          						<td width="20px" title="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage()) %>" onclick="javascript:onLicenseDivClose();"><div class="wBox_close"></div></td>
		       						</tr>
		     					</table>
		     					<div class="wBox_content" id="wBoxContent" style="width:400px;height:283px;overflow-y:auto">
		      					<!-- 定义层里面的内容 -->
		     					</div>
		   					</div>
        				</td>
        				<td class="wBox_b"></td></tr>
        			<tr><td class="wBox_bl"></td><td class="wBox_b"></td><td class="wBox_br"></td></tr>
        		</tbody>
        	</table>
   		</div>
	</div>
</div> 
 <!-- 遮罩层 start -->
<div id='wBox_overlay' class='wBox_hide' style="clear:both;"></div>
<!-- 遮罩层 end --> 

<script type="text/javascript">
	jQuery(document).ready(function(){
		var o4params = {
			method:"get",
			companyid:"<%=companyid%>"
		}
		
		jQuery.post("/cpcompanyinfo/action/CPShareHolderOperate.jsp",o4params,function(data){
			var gdh_add = data[0];
			jQuery("#method_gdh").val(gdh_add);
			if(gdh_add=="add"){
				jQuery("#spanTitle_gdh").html("<%=SystemEnv.getHtmlLabelName(31112,user.getLanguage()) %>");
				<%if("0".equals(showOrUpdate)){%>jQuery("#spanTitle_gdh").html("<%=SystemEnv.getHtmlLabelName(31147,user.getLanguage()) %>");<%}%>
				jQuery(":text[id$='_gdh']").val("");		//清空文本框文
				jQuery(".OSelect").val("1");	//选择框复原
			}else{
				//编辑股东会
				jQuery("#spanTitle_gdh").html("<%=SystemEnv.getHtmlLabelName(31113,user.getLanguage()) %>");
				<%if("0".equals(showOrUpdate)){%>jQuery("#spanTitle_gdh").html("<%=SystemEnv.getHtmlLabelName(31147,user.getLanguage()) %>");
					jQuery(".Browser").hide();
				<%}%>
				jQuery("#shareid").val(data[1]["shareid"]);
				jQuery("#boardshareholder_gdh").val(data[1]["boardshareholder"]);
				jQuery("#established_gdh").html(data[1]["established"]);
				jQuery("#endtime").val(data[1]["established"]);
				jQuery("#affixdoc").val(data[1]["shareaffix"]);
//				displayimg(jQuery("#boardshareholder_gdh"));
			}
		},"json");
		
		//保存按钮指向保存方法
		jQuery("#saveShareHolderBtn").attr("href","javascript:saveDate();");
		jQuery("#saveShareHolderBtnQ").attr("href","javascript:saveDate(2);");

		var now = new Date();
		var currentYear = now.getFullYear();
		var selectdateoptions = '';

        selectdateoptions+= "<option value=''>"+"全部"+"</option>";
		for(xx=0;xx<=currentYear-1990;xx++){
			selectdateoptions+= "<option value='"+(currentYear-xx)+"'>"+(currentYear-xx)+"</option>";
		}
		jQuery("#selectdate01").html(selectdateoptions);
		
		<%
		
			if("0".equals(showOrUpdate)){
		%>
				jQuery(".Clock").hide();
				jQuery(".OInput2").removeClass("OInput2").addClass("OInput3").focus(function(){this.blur();});
				jQuery("select").attr("disabled","disabled");  
				jQuery("#save_H").hide();
				jQuery("#save_Q").hide();
				jQuery("#webTable2gd").attr("disabled","disabled");
				jQuery("#licenseAffixUpload").hide();
		<%
			}
		%>
        searchzhzhdate(document.getElementById("selectdate01") );
	});
	
	function searchzhzhdate(o4this){
		var obj = jQuery("#webTable2gd").find("tr");
        var dateval=jQuery(o4this).val();
		for(i=0;i<obj.size();i++){
			
			if(dateval==jQuery(obj[i]).attr("dbvalue")||dateval=="") {
                jQuery(obj[i]).show();
            } else{
                jQuery(obj[i]).hide();
            }

		}
	}
	
	function checkratio(o4this){
		if(jQuery(o4this).val()!=""){
			if(jQuery(o4this).val() != jQuery(o4this).parent().find("input[type='hidden']").val()){
				if(parseInt(jQuery(o4this).val())+parseInt(jQuery("#ratio").val())<=100)
				{
					jQuery("#ratio").val(parseInt(jQuery(o4this).val())+parseInt(jQuery("#ratio").val()));
				}else{
					alert("<%=SystemEnv.getHtmlLabelName(31114,user.getLanguage()) %>");
					jQuery(o4this).val("");
				}
			
				jQuery(o4this).parent().find("input[type='hidden']").val(jQuery(o4this).val());
			}
		}
	}
	
	function checkdate(o4this){
		if(jQuery(o4this).val()!=""){
			if(jQuery(o4this).val() != jQuery(o4this).parent().find("input[type='hidden']").val()){
				if(!checkDate2(jQuery("#endtime").val(),jQuery(o4this).val())){
					jQuery(o4this).val("");
				}
				jQuery(o4this).parent().find("input[type='hidden']").val(jQuery(o4this).val());
			}
		}
		
	}
	/**

	判断时间大小
	
	sdate1: 开始时间
	
	edate2: 结束时间
	
	return: true/false
	
	**/
    function checkDate2(sdate1,edate2)
    {
       if(sdate1!=""&&edate2!="")
       { //输入不为空时；
           // 对字符串进行处理
           // 以 - / 或 空格 为分隔符, 将日期字符串分割为数组
          var date1 = sdate1.split("-");
          var date2 = edate2.split("-");
           // 创建 Date 对象
           var myDate1 = new Date(date1[0],date1[1],date1[2]);
           var myDate2 = new Date(date2[0],date2[1],date2[2]);
           
           // 对日起进行比较
           if (myDate1 <= myDate2)
           {
                return true;
           }else
           {
             alert ("<%=SystemEnv.getHtmlLabelName(31115,user.getLanguage()) %>！");
             return false;
           }
       }
       else
       {
             return true;
       }
     }

	
	function displayimg(obj){
		if(jQuery.trim(jQuery(obj).val())!=""){
			jQuery(obj).parent().find("img").css("display","none");
		}else{
			jQuery(obj).parent().find("img").css("display","");
		}
	}
	/*打开选择公司DIV*/
	function onLicenseDivOpen(obj){
		var tempid= window.showModalDialog("ChooseCompanyList.jsp?companyid=<%=companyid%>");
		if(tempid){
			if(tempid.id=="0"){
				jQuery(obj).next().html("<IMG align=absMiddle src='/images/BacoError.gif'>");
				jQuery(obj).next().next().val("");
			}else{
				jQuery(obj).next().html(jQuery.trim(tempid.name));
				jQuery(obj).next().next().val(jQuery.trim(tempid.id));
			}
		}
	}
	
	/*打开币种DIV*/
	function onCurrOpen(obj){
		var tempid= window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/CurrencyBrowser.jsp");
		if(tempid){
			if(tempid.name){
				jQuery(obj).next().html(tempid.name);
				jQuery(obj).next().next().val(tempid.id);
//				jQuery(obj).parent().find("img").css("display","none");
			}else{
				jQuery(obj).next().html("");
				jQuery(obj).next().next().val("");
//				jQuery(obj).parent().find("img").css("display","");
			}
		}else{
			
		}
		//alert(tempid.id);
		//alert(tempid.name);
	}
	

	function clickLicenseName2List(companyid,companyname,input2id,input2name){
		jQuery("#"+input2id).val(companyid);
		jQuery("#"+input2name).val(companyname);
		onLicenseDivClose();
	}
	
	/*保存 股东会*/
	function saveShareHolder() 
	{
		jQuery("#saveShareHolderBtn").attr("href","javascript:void(0);");	//不让保存重复点击
		jQuery("#saveShareHolderBtn").find('div').find('div').html("<%=SystemEnv.getHtmlLabelName(31116,user.getLanguage()) %>...");
		jQuery("#saveShareHolderBtnQ").attr("href","javascript:void(0);");	//不让保存重复点击
		jQuery("#saveShareHolderBtnQ").find('div').find('div').html("<%=SystemEnv.getHtmlLabelName(31116,user.getLanguage()) %>...");
		//jQuery("#spanTitle_gdh").html("正在运算该公司与集团架构内其他公司的A-B公司关系，请耐心等待。").css("font-size","14");
		//jQuery("#spanTitle_gdh").parent().find("img").css("display","none");
		var trsize2gd = jQuery("#webTable2gd tr").length;
		var Alist2gd = new Array();
		
		jQuery('#webTable2gd tr').each(function (i) { 
			var Blist2gd = new Array();
			var gdname="";//股东名称
			var gdid="";//股东id
			var isstop="";//是否终止
			var aggregateinvest="";//投资额
			var aggregateinvest_sj="";//实际投资额
			var currencyid="";//币种
			var aggregatedate="";//投资时间
			var investment="";//投资比列
			var ishow="";//是否连线
			var yongt="";//用途
			jQuery(this).children('td').each(function (j){
				
				if(j==1){
						gdname=jQuery(this).find("span").html();
						gdid=jQuery(this).find("input").val();
				}else if(j==2){
						isstop=jQuery(this).find("select").val();
				}else if(j==3){
						aggregateinvest=jQuery(this).find("input").val();
				}else if(j==4){
					aggregateinvest_sj=jQuery(this).find("input").val();
				}else if(j==5){
						currencyid=jQuery(this).find("input").val();
				}else if(j==6){
						aggregatedate=jQuery(this).find("input").val();
				}else if(j==7){
						investment=jQuery(this).find("input").val();
				}else if(j==8){
                    yongt=jQuery(this).find("input").val();
                }else if(j==9){
						ishow=jQuery(this).find("select").val();
				}
			});
			Blist2gd[0] = "";
			Blist2gd[1] = gdname;
			Blist2gd[2] = gdid;
			Blist2gd[3] = isstop;
			Blist2gd[4] = aggregateinvest;
			Blist2gd[5] = aggregateinvest_sj;
			Blist2gd[6] = currencyid;
			Blist2gd[7] = aggregatedate;
			Blist2gd[8] = investment;
			Blist2gd[9] = yongt;
			Blist2gd[10] = ishow;
			
            Alist2gd[i] = Blist2gd;
               
           });
           //组装json数组字符串
            var strjsonArr="";
			if(Alist2gd.length>0){
			strjsonArr="{";
			for(var x=0;x<trsize2gd;x++){
				/* if(Alist2gd[x][7]){
					investment_s+=parseFloat(Alist2gd[x][7]);
				} */
				strjsonArr+="'tr"+x+"':{";
				//股东名称
					strjsonArr+="'officername':'"+$.trim(Alist2gd[x][1])+"',";
				//股东id
				strjsonArr+="'companyid2share':'"+Alist2gd[x][2]+"',";
				//是否终止
				strjsonArr+="'isstop':'"+Alist2gd[x][3]+"',";
				//投资额
				strjsonArr+="'aggregateinvest':'"+Alist2gd[x][4]+"',";
				//实际投资额
				strjsonArr+="'aggregateinvest_sj':'"+Alist2gd[x][5]+"',";
				//币种
				strjsonArr+="'currencyid':'"+Alist2gd[x][6]+"',";
				//投资时间
				strjsonArr+="'aggregatedate':'"+Alist2gd[x][7]+"',";
				//投资比列
				strjsonArr+="'investment':'"+Alist2gd[x][8]+"',";
                //用途
				strjsonArr+="'yongt':'"+Alist2gd[x][9]+"',";
				//是否连线
				strjsonArr+="'ishow':'"+Alist2gd[x][10]+"'";
				if(x==trsize2gd-1)strjsonArr+="}";
				else strjsonArr+="},";
			}
			strjsonArr+="}";
		}
		
		var o4params = {
			method:jQuery("#method_gdh").val(),
			isaddversion:jQuery("#isaddversion").val(),
			companyid:"<%=companyid%>",
			shareid:jQuery("#shareid").val(),
			boardshareholder:encodeURI(jQuery("#boardshareholder_gdh").val()),
			established:encodeURI(jQuery("#endtime").val()),
			data:encodeURI(strjsonArr),
			affixdoc:encodeURI(jQuery("#affixdoc").val()),
			versionnum:encodeURI(jQuery("#versionnum").val()),
			versionname:encodeURI(jQuery("#versionname").val()),
			versionmemo:encodeURI(jQuery("#versionmemo").val()),
			versionaffix:"",
			date2Version:encodeURI(jQuery("#versionTime").val())
		}

		jQuery.post("/cpcompanyinfo/action/CPShareHolderOperate.jsp",o4params,function(data){
					if(jQuery.trim(data)!="0"){
							alert(data);
					}

            if("<%=fromNEWPAGE %>"=="true"){
                alert("保存完成!");
                window.location.href=window.location.href;
            }else{
                closeMaint4Win();
            }
					
		}); 
	}
	
	/*验证是否通过、通过后方保存*/
	function checkForm(typepage){
		var ischecked = true;
	
//		if(jQuery.trim(jQuery("#boardshareholder_gdh").val())=="" ||jQuery.trim(jQuery("#endtime").val())==""){
//				ischecked = false;
//		}
		jQuery("#webTable2gd").find("img[align='absMiddle']").each(function (){
			if(!$(this).is(":hidden")){
				ischecked=false;
			}
		})
		return ischecked;
	}
	
	/* 关闭 已打开的面板 */
	function closeMaint4Win()
	{
		jQuery("a[typepage='gd']").qtip('hide');
		jQuery("a[typepage='gd']").qtip('destroy');
		//回调刷新界面数据
		refsh();
	}

	//全部选择操作，复选框
	function selectall_chk(Tcheck){
	   if(Tcheck.checked==true){
	      $("input[type=checkbox][name='checkbox']").each(function(){
				 $(this).attr("checked",true);
		  });
	   }else{
		  $("input[type=checkbox][name='checkbox']").each(function(){
				 $(this).attr("checked",false);
		  });
	   }
	}
	 
	//选中其中的一个
	function selectone_chk(){
	    jQuery("#fileid").attr("checked",false); 
	}
	/*增加一行tr*/
	function doadd_gd(){
		var trhrml="<tr height=30px>";
		jQuery("#hiddenTrInDIV").find("span[_calss='show']").each(function(i){
						
						var temp=jQuery(this).html();
						if(i==0){
							trhrml+="<td width=\"27\" align=\"center\">";
						}else if(i==1){
							trhrml+="<td width=\"100\" style=\"word-wrap:break-word;\" >";
						}else if(i==2){
							trhrml+="<td width=\"52\" >";
						}else if(i==3){
							trhrml+="<td width=\"99\" >";
						}else if(i==4){
							trhrml+="<td width=\"99\" >";
						}else if(i==5){
							trhrml+="<td  width=\"70\" >";
						}else if(i==6){
							trhrml+="<td width=\"120\" >";
						}
						else if(i==7){
							trhrml+="<td width=\"120\" >";
						}else if(i==8){
                            trhrml+="<td width=\"120\" >";
                        }
						else if(i==9){
							trhrml+="<td width=\"0\" >";
						}
						trhrml+=temp;
						trhrml+="</td>";
		})
		trhrml+="</tr>";
		//alert(trhrml);
		jQuery("#webTable2gd").append(trhrml);
		jQuery("#webTable2gd").find("tr").find("td").find("button[name='date2list']").each(function(){
				$(this).attr("name","");//给name赋值，防止下次循环又找到他
				$(this).click(function (){
						//gettheDate这个方法只接受普通对象，不能把jquery对象传进去
						onShowDate_2($(this).next().next()[0],$(this).next()[0]);
				})
		});
		
	
	}
	/*删除一行或多行*/
	function dodel_gd1(){
		var _temp=0;
		jQuery('#webTable2gd tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox]").attr("checked")==true){
				_temp++;
			}
		});
		if(_temp<=0){
				alert("<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage()) %>!");
		}else {
					var truth4Told = window.confirm("<%=SystemEnv.getHtmlLabelName(30695,user.getLanguage()) %>?"); 
					if(truth4Told){
							jQuery('#webTable2gd tr').each(function(){
							if(jQuery(this).children('td').find("input[type=checkbox]").attr("checked")==true){
								jQuery(this).remove();
							}
						});
					}else{
					
					}
		}
	}

	function saveDate(obj){
		jQuery("#saveShareHolderBtn").attr("href","javascript:void(0);");	//不让保存重复点击
		jQuery("#saveShareHolderBtnQ").attr("href","javascript:void(0);");	//不让保存重复点击
		if(checkForm()){
		
			//验证百分比
		    var investment_s=0;
		    var trsize2gd = jQuery("#webTable2gd tr").length;
		    var Alist2gd = new Array();
		    jQuery('#webTable2gd tr').each(function (i) {
		    	var Blist2gd = new Array(); 
				var investment="";//投资比列
				jQuery(this).children('td').each(function (j){
						 if(j==7){
							investment=jQuery(this).find("input").val();
						}
				});
				Blist2gd[0] = investment;
          		Alist2gd[i] = Blist2gd;
           });
            var strjsonArr="";
			if(Alist2gd.length>0){
			for(var x=0;x<trsize2gd;x++){
				if(Alist2gd[x][0]){
					investment_s+=parseFloat(Alist2gd[x][0]);
				}
			}
		}
		
		if(investment_s>100){
					alert("<%=SystemEnv.getHtmlLabelName(31117,user.getLanguage()) %>"+investment_s);
					jQuery("#saveShareHolderBtn").attr("href","javascript:saveDate();");	//不让保存重复点击
					jQuery("#saveShareHolderBtnQ").attr("href","javascript:saveDate(2);");	//不让保存重复点击
					return;
		}
		if(investment_s < parseFloat("100")){
			if( window.confirm("<%=SystemEnv.getHtmlLabelName(31118,user.getLanguage()) %>："+investment_s+"，<%=SystemEnv.getHtmlLabelName(31119,user.getLanguage()) %>？")){
					jQuery("#saveShareHolderBtn").attr("href","javascript:saveDate();");	//不让保存重复点击
					jQuery("#saveShareHolderBtnQ").attr("href","javascript:saveDate(2);");	//不让保存重复点击
					return;
			}
		}
		
			if (obj==undefined||obj!=2) {
				onversionAddDivOpen();
			} else {
				var truth4Told = true;
				if(truth4Told){
					StartUploadAll();
					checkuploadcomplet();
				}else{
					jQuery("#saveShareHolderBtn").attr("href","javascript:saveDate();");	//恢复保存按钮
					jQuery("#saveShareHolderBtnQ").attr("href","javascript:saveDate(2);");	//恢复保存按钮
				}
			}
		}
		else
		{
			alert("<%=SystemEnv.getHtmlLabelName(15859,user.getLanguage()) %>");
			jQuery("#saveShareHolderBtn").attr("href","javascript:saveDate();");	//恢复保存按钮
			jQuery("#saveShareHolderBtnQ").attr("href","javascript:saveDate(2);");	//恢复保存按钮
		}
	} 
	
	
	/*打开版本管理页面*/
	function openVersionManage(){
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","125px").css("left","260px");
		jQuery("#wBoxContent").css("width","476px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(19450,user.getLanguage()) %>");
		jQuery("#wBoxContent").load("/cpcompanyinfo/CompanyVersionManage.jsp?shareid="+jQuery("#shareid").val()+"&oneMoudel=share&showOrUpdate=<%=showOrUpdate%>");
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
	}
	
	/*打开版本新增DIV*/
	function onversionAddDivOpen(){
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","125px").css("left","400px");
		jQuery("#wBoxContent").css("width","335px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31011,user.getLanguage()) %>");
		jQuery("#wBoxContent").load("CompanyVersionMaint.jsp?shareid="+jQuery("#shareid").val()+"&oneMoudel=share&companyid=<%=companyid%>");
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
	}
	
	/*关闭选择证照DIV*/
	function onLicenseDivClose() {
		jQuery("#wBox_overlay").removeClass("wBox_overlayBG").addClass("wBox_hide");
		jQuery("#licenseDiv").css("display","none");
		jQuery("#saveShareHolderBtn").attr("href","javascript:saveDate();");	//恢复保存按钮
		jQuery("#saveShareHolderBtnQ").attr("href","javascript:saveDate(2);");	//恢复保存按钮
	}
	
	function onLicenseDivCloseNoSave() {
		jQuery("#wBox_overlay").removeClass("wBox_overlayBG").addClass("wBox_hide");
		jQuery("#licenseDiv").css("display","none");
	} 
	/*版本方法 开始*/
	
	
	function saveversionDate(){
		jQuery("#isaddversion").val("add");
		StartUploadAll();
		checkuploadcomplet();
	}
	
	function editversionDate(versionid){
		o4params ={
		method:"editversion",
		versionid:versionid,
		versionnum:encodeURI(jQuery("#versionnum").val()),
		versionname:encodeURI(jQuery("#versionname").val()),
		versionmemo:encodeURI(jQuery("#versionmemo").val()),
		versionaffix:"",
		date2Version:encodeURI(jQuery("#versionTime").val())
		};
		jQuery.post("/cpcompanyinfo/action/CPShareHolderOperate.jsp",o4params,function(){
			alert("<%=SystemEnv.getHtmlLabelName(31120,user.getLanguage()) %>!");
			//closeMaint4Win();		
		});
	}
	
	/*删除一行或多行*/
	function dodel_gd(){
		var versionids="";
		var _versionnum="";
		jQuery('#webTable2version tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true){
				versionids += jQuery(this).attr("versionid")+",";
				_versionnum+= jQuery(this).attr("_versionnum")+",";
			}
		});
		if(versionids.length == 0){
			alert("<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage()) %>！");
			return;
		}
		var truthBeTold = window.confirm("<%=SystemEnv.getHtmlLabelName(31013,user.getLanguage()) %>？"); 
		if (truthBeTold) { 
			jQuery('#webTable2version tr').each(function(){
				if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true)
				{
					jQuery(this).remove();
				}
			});
			var o4params={method:"delVersion",versionids:versionids,_versionnum:_versionnum}
			jQuery.post("/cpcompanyinfo/action/CPShareHolderOperate.jsp",o4params,function(){
				
			});
			
		}
	}
	
	function delImg(imgfileDiv,docid){
		var affix123doc = jQuery("#affixdoc").val().split(",");
		var tempdocid = "";
		for(i=0;i<affix123doc.length-1;i++){
			if(affix123doc[i]!=docid){
				tempdocid+=affix123doc[i]+",";
			}
		}
		jQuery("#affixdoc").val(tempdocid);
		jQuery(imgfileDiv).css("display","none");
		jQuery("#source").find("img").attr("src","images/nopic.jpg");
		jQuery("#_s2uiContent").css("display","none");
	}
	
	function viewVersion(){
		var versionids="";
		jQuery('#webTable2version tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true)
			{
				versionids += jQuery(this).attr("versionid")+",";
			}
		});
		if(versionids.length == 0){
				alert("<%=SystemEnv.getHtmlLabelName(31017,user.getLanguage()) %>！");
		}else  if(versionids.split(",").length>2){
			alert("<%=SystemEnv.getHtmlLabelName(31014,user.getLanguage()) %>！");
		}else{
			var o4params = {method:"viewVersion",versionids:versionids}
			jQuery.post("/cpcompanyinfo/action/CPShareHolderOperate.jsp",o4params,function(data){
				jQuery("#shareid").val(data[0]["shareid"]);
				jQuery("#boardshareholder_gdh").val(data[0]["boardshareholder"]);
				jQuery("#established_gdh").html(data[0]["established"]);
				jQuery("#endtime").val(data[0]["established"]);
				
				
				jQuery("#newDscyBtn").css("display","none");
				jQuery("#delDscyBtn").css("display","none");
				jQuery("#webTable2gd").html("");
				jQuery("#spanTitle_gdh").html("<%=SystemEnv.getHtmlLabelName(31121,user.getLanguage()) %>["+data[1]+"]");
				jQuery("#saveShareHolderBtn").attr("href","javascript:nosaveAgain();");	//恢复保存按钮
				jQuery("#saveShareHolderBtnQ").attr("href","javascript:nosaveAgain(2);");	//恢复保存按钮
				jQuery.post("/cpcompanyinfo/action/CPShareHolderOperate.jsp",{method:"viewOffersVersion",versionnum:data[1],shareid:data[0]["shareid"]},function(data1){
					jQuery("#webTable2gd").html(jQuery.trim(data1));
				});
				
				var imgid4db = data[0]["imgid"].split("|");
				var imgname4db = data[0]["imgname"].split("|");
				if(jQuery("#affixcpdosDIV").find("div").length/3>0){
					jQuery("#affixcpdosDIV").html("");
				}
				var html4doc="";
				for(i=0;i<imgid4db.length - 1;i++){
					html4doc += "<div id='imgfileDiv"+i+"' style='background-color: #F7F7F7;width:291px;height:20px;padding-left:4px;border: solid 1px #E8E8E8;padding: 4px;margin-bottom: 5px;'>";
					html4doc+="<div style='width:80%;float:left;' >";
					html4doc+="<A id='pdflinkid"+i+"' href='/weaver/weaver.file.FileDownload?fileid="+imgid4db[i]+"&download=1' class='aContent0 FL'>"+imgname4db[i]+"</A>";
					html4doc+="</div>";
					html4doc+="<div style='padding-right:0px;float:right;padding-top:0px'>";
					html4doc+="<a href='/weaver/weaver.file.FileDownload?fileid="+imgid4db[i]+"&download=1'><img src='images/downLoadPic.gif'  title='<%=SystemEnv.getHtmlLabelName(22629,user.getLanguage()) %>'  ></a>";
					html4doc+="</div>";
					html4doc+="</div>";
				}
				
				jQuery(".Clock").hide();
				jQuery(".OInput2").removeClass("OInput2").addClass("OInput3").focus(function(){this.blur();});
				jQuery("select").attr("disabled","disabled");  
				jQuery("#save_H").hide();
				jQuery("#save_Q").hide();
				jQuery("#webTable2gd").attr("disabled","disabled");
				jQuery("#licenseAffixUpload").hide();
				
				jQuery("#affixcpdosDIV").html(html4doc);
				onLicenseDivCloseNoSave();
			},"json");
		}
	}
	
	function nosaveAgain(){
		alert("<%=SystemEnv.getHtmlLabelName(31016,user.getLanguage()) %>！")
	}
	
	function getVersion(){
		var versionids="";
		jQuery('#webTable2version tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true)
			{
				versionids += jQuery(this).attr("versionid")+",";
			}
		});
		if(versionids.split(",").length>2 || versionids.length == 0){
			alert("<%=SystemEnv.getHtmlLabelName(31017,user.getLanguage()) %>！");
		}else{
			jQuery("#wBoxContent").html("");
			jQuery("#wBox").css("top","125px").css("left","400px");
			jQuery("#wBoxContent").css("width","335px").css("height","225px");
			jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31018,user.getLanguage()) %>");
			jQuery("#wBoxContent").load("CompanyVersionMaint.jsp?versionids="+versionids+"&oneMoudel=share&companyid=<%=companyid%>");
			jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
			jQuery("#licenseDiv").css("display","");
			
		}
	}
	
	/*版本方法 结束*/
	
	
	/*flash上传需要的方法*/
	function StartUploadAll() {  
        eval("SWFUpload.instances.SWFUpload_0.startUpload()");
        // files_queued当前上传队列中存在的文件数量        
        eval("upfilesnum+=SWFUpload.instances.SWFUpload_0.getStats().files_queued"); 
	}
	function checkuploadcomplet(){	
	    if(upfilesnum>0){    	
	        setTimeout("checkuploadcomplet()",1000);       	
	    }else{
	       saveShareHolder();
	    }
	}
	function flashChecker() {
		var hasFlash = 0; //是否安装了flash
		var flashVersion = 0; //flash版本
		var isIE = /*@cc_on!@*/0; //是否IE浏览器
		if (isIE) {
			var swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
			if (swf) {
				hasFlash = 1;
				VSwf = swf.GetVariable("$version");
				flashVersion = parseInt(VSwf.split(" ")[1].split(",")[0]);
			}
		} else {
			if (navigator.plugins && navigator.plugins.length > 0) {
				var swf = navigator.plugins["Shockwave Flash"];
				if (swf) {
					hasFlash = 1;
					var words = swf.description.split(" ");
					for ( var i = 0; i < words.length; ++i) {
						if (isNaN(parseInt(words[i])))
							continue;
						flashVersion = parseInt(words[i]);
					}
				}
			}
		}
		return {
			f :hasFlash,
			v :flashVersion
		};
	}
	/*上传空间判断是否安装了flash控件*/
	var fls = flashChecker();
	var flashversion = 0;
	if (fls.f)
		flashversion = fls.v;
	if (flashversion < 9)
		document.getElementById("fsUploadProgress").innerHTML = "<br>&nbsp;&nbsp;附件上传的功能需要你的机器支持Flash9及其以上的版本，请从下面选择安装方式:<br><br><a target='_blank' href='http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=shockwaveFlash'>&nbsp;&nbsp;在线安装<a>	<br><br><a href='/resource/install_flash9_player.exe' target='_blank'>&nbsp;&nbsp;下载安装包</a>";	
	
</script>

<script language="javascript">


var upfilesnum=0;//计数器
var oUploader;//一个SWFUpload 实例
var mode="add";//当期模式

var settings = {   
	
	flash_url : "/js/swfupload/swfupload.swf",     
	upload_url: "/cpcompanyinfo/action/uploaderOperate.jsp",
	post_params: {
                "mainId": <%=mainId%>,
                "subId":<%=subId%>,
                "secId":<%=secId%>
            },
	file_size_limit :"100MB",							//单个文件大小
	file_types : "*.*;", 	//过滤文件类型
	file_types_description : "All Files",					//描述，会添加在类型前面
	file_upload_limit : "50",							//一次性上传几个文件
	file_queue_limit : "0",								
	//customSettings属性是一个空的JavaScript对象，它被用来存储跟SWFUpload实例相关联的数据。
	//它的内容可以使用设置对象中的custom_settings属性来初始化
	custom_settings : {
		progressTarget : "fsUploadProgress",
		cancelButtonId : "btnCancel_upload"
	},
	debug: false,
	
	button_image_url : "/js/swfupload/add.png",	// Relative to the SWF file
	button_placeholder_id : "spanButtonPlaceHolder",
	
	button_width: 100,//“上传"按钮的宽度
	button_height: <%if(!CompanyInfoTransMethod.CheckPack("3")){out.println("0");}else{out.println("18");}%>,//“上传”按钮的高度
	button_text : '<span class="button">'+"上传"+'</span>',//“上传”按钮的文字
	button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
	button_text_top_padding: 0,//“上传"按钮的top_padding
	button_text_left_padding: 18,//“上传"按钮的left_padding
		
	button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
	button_cursor: SWFUpload.CURSOR.HAND,//“上传"按钮的鼠标悬浮样式
	
	file_queued_handler : fileQueued,
	file_queue_error_handler : fileQueueError,
	
	file_dialog_complete_handler : function(){	//设置事件回调函数,file_dialog_complete_handler为类对象的属性		
		//让按钮失效
		//document.getElementById("btnCancel_upload").disabled = true;
		//alert("按钮细小");
		//fileDialogComplete				
	},
	//设置事件回调函数,upload_start_handler为类对象的属性,在文件往服务端上传之前触发此事件，可以在这里完成上传前的最后验证以及其他你需要的操作，例如添加、修改、删除post数据等。
	//在完成最后的操作以后，如果函数返回false，那么这个上传不会被启动，并且触发uploadError事件（code为ERROR_CODE_FILE_VALIDATION_FAILED），
	//如果返回true或者无返回，那么将正式启动上传
	upload_start_handler : uploadStart,	
	upload_progress_handler : uploadProgress,//设置事件回调函数,upload_progress_handler为类对象的属性
	upload_error_handler : uploadError,//设置事件回调函数,upload_error_handler为类对象的属性
	queue_complete_handler : queueComplete,//设置事件回调函数,queue_complete_handler为类对象的属性

	//文件上传成功，调用下面的方法
	upload_success_handler : function (file, server_data) {	//设置事件回调函数,upload_success_handler为类对象的属性
		if(mode=="add"){
			var imageid=server_data.replace(/(^\s*)|(\s*$)/g, "");			
			//得到文档id,得到文件的名字	
			document.getElementById("affixdoc").value+=imageid+",";
		}

	},	
	//文件上传成功，调用下面的方法			
	upload_complete_handler : function(){	
		upfilesnum=upfilesnum-1;//计数器减减
	}
	
};	
function queueComplete(numFilesUploaded) {
	var status = document.getElementById("divStatus");
	status.innerHTML = numFilesUploaded + " file" + (numFilesUploaded === 1 ? "" : "s") + " uploaded.";
}
try{
	oUploader = new SWFUpload(settings);//返回:一个SWFUpload 实例
	
} catch(e){alert(e)}

</script>