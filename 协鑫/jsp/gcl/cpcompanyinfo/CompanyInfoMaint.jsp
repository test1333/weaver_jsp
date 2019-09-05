<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="weaver.cpcompanyinfo.ProTransMethod"%>
<%@ page import="weaver.fna.maintenance.CurrencyComInfo" %>
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
<jsp:useBean id="pro" class="weaver.cpcompanyinfo.ProManageUtil" scope="page" />
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page" />
<jsp:useBean id="CompanyPermissionService" class="weaver.cpcompanyinfo.CompanyPermissionService" scope="page" />
<%
	String btnid = Util.null2String(request.getParameter("btnid"));
	String companyid = Util.null2String(request
			.getParameter("companyid"));
	/*公司信息*/
	String companyname = ""; //公司名称
	String companyename = ""; //公司英文名称
	String companyaddress = ""; //公司地址
	String archivenum = ""; //全宗号
	String companyregion = ""; //区域	
	String companyregionSpan = "<IMG src='/images/BacoError.gif' align=absMiddle>"; //区域
	String foundingTime = ""; //公司成立时间
	int businesstype = 0; //业务类型	
	String loancard = ""; //贷款卡号
	String companyvestin = ""; //公司归属
	/*营业执照信息*/
	String scopebusiness = "";
	String registercapital = "";
	String corporatdelegate = "";
	String usefulbegindate = "";
	String usefulenddate = "";
	String usefulyear = "";
	String licenseregistnum = "";
	String companytype = "";
	/*章程*/
	String aggregateinvest = "";
	String currencyid = "";
	/*董事会*/
	String generalmanager = "";

//	新增字段：“办公地址”、“状态”字段（正常、注销，默认为“正常”）
	String bgdz_ = "";
	String zt_ = "";
//	其他：“投资总额”、“币种”字段放在“新建公司”界面维护；
	String AGGREGATEINVEST = "";
	String CURRENCYID = "";

	

	if (!companyid.equals("")) {
		String sql = "select t1.*,t3.*,t5.generalmanager,hrmcity. cityname from cpcompanyinfo t1 left join ("
				+ " select t2.companyid,t2.scopebusiness,t2.registercapital,t2.corporatdelegate, "
				+ " t2.usefulbegindate,t2.usefulenddate,t2.usefulyear,t2.licenseregistnum,t2.companytype "
				+ " from CPBUSINESSLICENSE t2 , CPLMLICENSEAFFIX taf where t2.licenseaffixid = taf.licenseaffixid and t2.isdel='T' and taf.licensetype = '1' ) t3 on t1.companyid = t3.companyid"
				+ " left join CPCONSTITUTION t4 on t1.companyid = t4.companyid"
				+ " left join CPBOARDDIRECTORS t5 on t1.companyid = t5.companyid "
				+" left join  hrmcity  on t1.companyregion=hrmcity.id"
				+ " where t1.companyid = " + companyid;
	
	
		rs.execute(sql);
		while (rs.next()) {
			/*公司信息*/
			companyname = Util.null2String(rs.getString("companyname")); //公司名称
			companyename = Util.null2String(rs
					.getString("companyename")); //公司英文名称
			companyaddress = Util.null2String(rs
					.getString("companyaddress")); //公司地址
			archivenum = Util.null2String(rs.getString("archivenum")); //全宗号
			companyregion =Util.null2String(rs.getString("companyregion")); //区域	
			companyregionSpan=Util.null2String(rs.getString("cityname")); //区域	
			foundingTime=Util.null2String(rs.getString("foundingTime")); //公司成立时间
			if("NULL".equals(foundingTime)){
				foundingTime="";
			}
			businesstype = rs.getInt("businesstype"); //业务类型	
			loancard = Util.null2String(rs.getString("loancard")); //贷款卡号
			companyvestin = Util.null2String(rs
					.getString("companyvestin")); //公司归属
			/*营业执照信息*/
			scopebusiness = Util.null2String(rs.getString("scopebusiness")).replace("\n", "");
			registercapital = Util.null2String(rs
					.getString("registercapital"));
			corporatdelegate = Util.null2String(rs
					.getString("corporatdelegate"));
			usefulbegindate = Util.null2String(rs
					.getString("usefulbegindate"));
			usefulenddate = Util.null2String(rs
					.getString("usefulenddate"));
			usefulyear = Util.null2String(rs.getString("usefulyear"));
			licenseregistnum = Util.null2String(rs
					.getString("licenseregistnum"));
			companytype = Util.null2String(rs.getString("companytype"));
			/*章程*/
			aggregateinvest = Util.null2String(rs
					.getString("aggregateinvest"));
			currencyid = Util.null2String(rs.getString("currencyid"));
			/*董事会*/
			generalmanager = Util.null2String(rs
					.getString("generalmanager"));
			bgdz_=Util.null2String(rs.getString("bgdz_"));
			zt_=""+Util.getIntValue( Util.null2String(rs.getString("zt_")),1);
			AGGREGATEINVEST=Util.null2String(rs.getString("AGGREGATEINVEST"));
			CURRENCYID=Util.null2String(rs.getString("CURRENCYID"));
		}
	}
	if(btnid.equals("viewBtn")){
		pro.writeCompanylog("3",companyid,"4",user.getUID()+"",""+SystemEnv.getHtmlLabelName(1361,user.getLanguage()) );
	}
	
	String zrrid="";//得到自然人的id
	String zrrname="";
	if(rs.execute("select id,name from CompanyBusinessService where affixindex=-1")&&rs.next()){
		zrrid=rs.getString("id");
		zrrname=rs.getString("name");
	}

	
%>
<script type="text/javascript">

	var zrrid="<%=zrrid%>";
	var businesstype="<%=businesstype%>";
	var zrrname01="<%=SystemEnv.getHtmlLabelName(31445,user.getLanguage())%>&nbsp;:";
	var zrrname02="<%=SystemEnv.getHtmlLabelName(1976,user.getLanguage())%>&nbsp;:";
	var gsname="<%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%>";
	var zrrname="<%=zrrname%>";
	function checkzrr(obj){
		if(zrrid!=""&&zrrid==obj.value){
			//说明切换到了自然人
		    jQuery(".hidetr_n").hide();
		    if("<%=btnid%>"=="newBtn"){
		   		 jQuery("#zrrname").html(zrrname01);
		   		  jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31448,user.getLanguage())%>");
		    }
		 //   gsname="<%=SystemEnv.getHtmlLabelName(31445,user.getLanguage())%>";
		}else{
			//说明选择的不是自然人
			 jQuery(".hidetr_n").show();
			 jQuery(".hidetr_n[needHide]").hide();
			 if("<%=btnid%>"=="newBtn"){
				 jQuery("#zrrname").html(zrrname02);
				 jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31049,user.getLanguage())%>");
			 }
		}
	}
	jQuery(document).ready(function(){

		if("<%=btnid%>"=="newBtn")
		{
			jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31049,user.getLanguage())%>");
			jQuery("#method").val("add");
            jQuery("#btnInfoSave").attr("href","javascript:saveCompanyInfo();");
		}
		if("<%=btnid%>"=="editBtn")
		{
			
			jQuery("#method").val("edit");
			jQuery("#btnInfoSave").attr("href","javascript:saveCompanyInfo();");
			if(businesstype==zrrid){
				//gsname="<%=SystemEnv.getHtmlLabelName(31445,user.getLanguage())%>";
				 jQuery(".hidetr_n").hide();
		   		 jQuery("#zrrname01").html(zrrname);
		   		 jQuery("#businesstype").hide();
		   		 jQuery("#zrrname").html(zrrname01);
		   		 jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31446,user.getLanguage())%>");
			}else{
				jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31050,user.getLanguage())%>");
			}
		}
		if("<%=btnid%>"=="viewBtn")
		{
		
			jQuery(".OInput2").removeClass("OInput2").addClass("OInput3").focus(function(){this.blur();});
			jQuery(".OSelect").removeClass("OSelect").addClass("OSelect2").focus(function(){this.blur();});
			jQuery("#companyaddress").addClass("OInput4");
			jQuery("#btndiv").css("display","none");
			jQuery("#city_sel").hide();
			if(businesstype==zrrid){
				//gsname="<%=SystemEnv.getHtmlLabelName(31445,user.getLanguage())%>";
				 jQuery(".hidetr_n").hide();
		   		 jQuery("#businesstype").hide();
		   		  jQuery("#zrrname01").html(zrrname);
		   		 jQuery("#zrrname").html(zrrname01);
		   		 jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31447,user.getLanguage())%>");
			}else{
				 jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31051,user.getLanguage())%>");
			}
		}
		
		init_info();//调用公司资料初始化方法
		
		
		if("<%=btnid%>"=="newBtn"){
			displayimg(jQuery("#archivenum01"),1);
			displayimg(jQuery("#companyname"),1);
			if("<%=foundingTime%>"==""){
				jQuery("#foundingTime_zc").html("<img src='images/O_44.jpg'  absMiddle='absMiddle'  iswarn='warning'/>");
			}
		}else if("<%=btnid%>"=="editBtn"){
			displayimg(jQuery("#archivenum01"),2);
			displayimg(jQuery("#companyname"),2);
			displayimg(jQuery("#companyaddress"),2);
			displayimg(jQuery("#bgdz_"),2);
			displayimg(jQuery("#aggregateinvest_zc"),2);
			displayimg(jQuery("#currencyid_zc"),2);
			if("<%=foundingTime%>"==""){
				jQuery("#foundingTime_zc").html("<img src='images/O_44.jpg'  absMiddle='absMiddle'  iswarn='warning'/>");
			}
		}else{
			displayimg(jQuery("#archivenum01"),1);
			displayimg(jQuery("#companyname"),1);
			displayimg(jQuery("#companyaddress"),1);
			displayimg(jQuery("#bgdz_"),1);
			displayimg(jQuery("#aggregateinvest_zc"),1);
			displayimg(jQuery("#currencyid_zc"),1);
			jQuery("#foundingbtn").hide();
		}
		
	});
	
	function ishavedLMcompany(methodval){
		//methodval
		var o4params = {
			method:"haved",
			methodval:methodval,
			companyid:"<%=companyid%>",
			archivenum:encodeURI(jQuery("#archivenum01").val()),
			companyname:encodeURI(jQuery("#companyname").val())
		};
		jQuery.post("/cpcompanyinfo/action/CPInfoOperate.jsp",o4params,function(data){
			//alert(jQuery.trim(data));
			jQuery("#btnInfoSave").attr("href","javascript:saveCompanyInfo();");
			if(jQuery.trim(data)=="lmboth"){
				alert("<%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%>:["+jQuery("#archivenum01").val()+"]  <%=SystemEnv.getHtmlLabelName(31052,user.getLanguage())%>"+gsname+"：["+jQuery("#companyname").val()+"] <%=SystemEnv.getHtmlLabelName(31053,user.getLanguage())%>！");
				jQuery("#ishaved").val("false");
			}
			else if(jQuery.trim(data)=="lmnum"){
				alert("<%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%>：["+jQuery("#archivenum01").val()+"] <%=SystemEnv.getHtmlLabelName(31053,user.getLanguage())%>！");
				jQuery("#ishaved").val("false");
			}
			else if(jQuery.trim(data)=="lmname"){
				alert(""+gsname+"：["+jQuery("#companyname").val()+"] <%=SystemEnv.getHtmlLabelName(31053,user.getLanguage())%>！");
				jQuery("#ishaved").val("false");
			}
			else {
				jQuery("#ishaved").val("true");
			}
		});
	}
	
	/*保存公司资料*/
	function saveCompanyInfo()
	{
		jQuery("#btnInfoSave").attr("href","javascript:void(0);");	//不让保存重复点击
		if(jQuery("#companyvestin").val()==""){
					alert("<%=SystemEnv.getHtmlLabelName(31054,user.getLanguage())%>！");
		}else if(jQuery("#businesstype").val()==""){
					alert("<%=SystemEnv.getHtmlLabelName(31055,user.getLanguage())%>！");
		}
		if(checkForm()){
			
			if(jQuery("#ishaved").val()=="false"){
				alert("<%=SystemEnv.getHtmlLabelName(31056,user.getLanguage())%>");
				jQuery("#btnInfoSave").attr("href","javascript:saveCompanyInfo();");
			}else{
				var o4params = {
					method:jQuery("#method").val(),
					companyid:"<%=companyid%>",
					archivenum:encodeURI(jQuery("#archivenum01").val()),
					companyregion:encodeURI(jQuery("#companyregion").val()),
					companyvestin:jQuery("#companyvestin").val(),
					companyname:encodeURI(jQuery("#companyname").val()),
					companyename:encodeURI(jQuery("#companyename").val()),
					companyaddress:encodeURI(jQuery("#companyaddress").val()),
					bgdz_:encodeURI(jQuery("#bgdz_").val()),
					zt_:encodeURI(jQuery("#zt_").val()),
					aggregateinvest_zc:encodeURI(jQuery("#aggregateinvest_zc").val()),
					currencyid_zc:encodeURI(jQuery("#currencyid_zc").val()),
					businesstype:jQuery("#businesstype").val(),
					loancard:encodeURI(jQuery("#loancard").val()),
					foundingTime:encodeURI(jQuery("#foundingTime").val())
				};
				jQuery.post("/cpcompanyinfo/action/CPInfoOperate.jsp",o4params,function(data){
                    if("<%=fromNEWPAGE %>"=="true"){
                        alert("保存完成!");
                        window.location.href=window.location.href;
                    }else{
                        closeMaint4Win("<%=btnid%>");
                        reflush2List();
                    }

				});
			}
		}
		else
		{
			alert("<%=SystemEnv.getHtmlLabelName(15859,user.getLanguage())%>");
			jQuery("#btnInfoSave").attr("href","javascript:saveCompanyInfo();");
		}
	}
	/*验证表单方法*/
	function checkForm(){
		var ischecked = false;
		var iszrr=false;
		if(zrrid!=""&&zrrid==jQuery("#businesstype").val()){
			iszrr=true;
		}
//        alert((iszrr ||!jQuery.trim(jQuery("#currencyid_zc").val())==""));
		if(!jQuery.trim(jQuery("#archivenum01").val())=="" && !jQuery.trim(jQuery("#companyname").val())==""&& !jQuery.trim(jQuery("#companyregion").val())==""&&(iszrr || !jQuery.trim(jQuery("#foundingTime").val())=="")
				&&(iszrr ||!jQuery.trim(jQuery("#companyaddress").val())=="")&&(iszrr ||!jQuery.trim(jQuery("#bgdz_").val())=="")
				&&(iszrr ||!jQuery.trim(jQuery("#aggregateinvest_zc").val())=="")&&(iszrr ||!jQuery.trim(jQuery("#currencyid_zc").val())=="")
		){
			ischecked = true;
		}
		return ischecked;
	}
	
	/* 关闭 qtip */
	function closeMaint4Win(btnid)
	{
		jQuery("#"+btnid).qtip("hide");
		jQuery("#"+btnid).qtip("destroy")
	}
	
	/* 公司资料 编辑、查看 初始化获得数据 */
	function init_info(){
		/*公司信息*/
		jQuery("#companyname").val("<%=companyname%>");
		jQuery("#companyename").val("<%=companyename%>");
		jQuery("#companyaddress").val("<%=companyaddress%>");
		jQuery("#archivenum01").val("<%=archivenum%>"); 
		jQuery("#companyregion").val("<%=companyregion%>"); 
		jQuery("#companyregionSpan").html("<%=companyregionSpan%>"); 
		jQuery("#foundingTime").val("<%=foundingTime%>"); 
		jQuery("#foundingTime_zc").html("<%=foundingTime%>"); 
		
		
		jQuery("#businesstype").val("<%=businesstype%>"); 
		jQuery("#loancard").val("<%=loancard%>");
		jQuery("#companyvestin").val("<%=companyvestin%>");
		/*营业执照信息*/
		jQuery("#scopebusiness").val("<%=scopebusiness%>");
		jQuery("#registercapital").val("<%=registercapital%>");
		jQuery("#corporatdelegate").val("<%=corporatdelegate%>");
		jQuery("#usefulbegindate").val("<%=usefulbegindate%>");
		jQuery("#usefulenddate").val("<%=usefulenddate%>");
		jQuery("#usefulyear").val("<%=usefulyear%>");
		jQuery("#licenseregistnum").val("<%=licenseregistnum%>");
		jQuery("#companytype").val("<%=companytype%>");
		/*章程*/
		jQuery("#aggregateinvest").val("<%=aggregateinvest%>");
		jQuery("#currencyid").val("<%=currencyid%>");
		/*董事会*/
		jQuery("#generalmanager").val("<%=generalmanager%>");

		jQuery("#bgdz_").val("<%=bgdz_ %>");
		jQuery("#zt_").val("<%=zt_ %>");
		jQuery("#aggregateinvest_zc").val("<%=AGGREGATEINVEST %>");
		<%--jQuery("#currencyid_zc").val("<%=CURRENCYID %>");--%>

	}
	
	function displayimg(obj,type){
		if(type&&type=="2"){
				//如果type有值,说明来源于Load加载
				//如果type等于2，说明来源于编辑加载
				if(jQuery.trim(jQuery(obj).val())!=""){
					jQuery(obj).parent().find("img").css("display","none");
				}else{
					jQuery(obj).parent().find("img").css("display","");
				}
		
		}else{
				if(jQuery.trim(jQuery(obj).val())!=""){
					jQuery(obj).parent().find("img").css("display","none");
					if(jQuery(obj).attr("id")=="companyname"||jQuery(obj).attr("id")=="archivenum01"){
						if(jQuery("#method").val()=="add"||jQuery("#method").val()=="edit"){
							ishavedLMcompany(jQuery("#method").val());
						}
					}
				}else{
					jQuery(obj).parent().find("img").css("display","");
				}
		}
	}

	/*打开币种DIV*/
	function onCurrOpen(obj){
		var tempid= window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/CurrencyBrowser.jsp");
		if(tempid){
			if(tempid.name){
//				jQuery(obj).next().html(tempid.name);
//				jQuery(obj).next().next().val(tempid.id);
//				jQuery(obj).next().next().next().css("display","none");
                jQuery("#currencyid_zcspan").html(tempid.name);
                jQuery("#currencyid_zc").val(tempid.id);
                jQuery("#currencyid_zcimg").hide();
			}else{
//				jQuery(obj).next().html("");
//				jQuery(obj).next().next().val("");
//				jQuery(obj).next().next().next().css("display","");
                jQuery("#currencyid_zcspan").html("");
                jQuery("#currencyid_zc").val("");
                jQuery("#currencyid_zcimg").show();
			}

		}else{

		}
		//alert(tempid.id);
		//alert(tempid.name);
	}
	
</script>
<!--表头浮动层 start-->
<input type="hidden" id="method" />
<input type="hidden" id="ishaved" value="true"/>
<div class="<%=fromNEWPAGE?"":"Absolute OHeaderLayer3 Bgfff BorderLMDIVHide" %>" >
	<div class="OHeaderLayerTit FL OHeaderLayerW3 " style="<%=fromNEWPAGE?"display: none":""%>">
		<span id="spanTitle" class="cBlue FontYahei FS16 PL15 FL"></span>
		<img src="images/O_40.jpg" class="FR MT10 MR10" style="cursor: hand;"
			onclick="javascript:closeMaint4Win('<%=btnid%>');" />
	</div>
	<div class="FL"  style="<%=fromNEWPAGE?"padding-right: 10px;":"height: 360px;"%>overflow-x:hidden;overflow-y:auto;padding-left: 10px">
		<table width="440" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0"
			cellspacing="0" class="MT5"   style="table-layout: fixed;">
			<colgroup>
					<col width="70px">
					<col width="*">
					<col width="60px">
					<col width="*">
			</colgroup>
			<tr>
				<td height="25" >
					<strong><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%>：</strong>
				</td>
				<td>
					<input type="text" id="archivenum01" class="OInput2 BoxW120" onblur="displayimg(this)"  maxlength="20" />
					<img src="images/O_44.jpg" class="ML5" style="margin-bottom: -3px;" />
				</td>
				<td>
					<strong><%=SystemEnv.getHtmlLabelName(28100,user.getLanguage())%>：</strong>
				</td>
				<td>
					  <BUTTON class="browser Browser"  onclick="onShowLocationID()" type="button"  id="city_sel"></BUTTON>
					  <span  id="companyregionSpan"></span>
					  <input type=hidden  name="companyregion" id="companyregion">
				
				</td>
			</tr>
			<tr>
				
				<td>
					<!-- 自然人 -->
					<strong><%=SystemEnv.getHtmlLabelName(125906,user.getLanguage())%>： </strong>
				</td>
				<td>
					<span id="zrrname01"></span>
					<select class="OSelect" style="width: 122px;" id="businesstype"  onchange="checkzrr(this)">
						<%
								String	 sql="select * from CompanyBusinessService  where affixindex !=-1 and id in("+CompanyPermissionService.getCaneditGlgsIds(user)+") order by affixindex";
								rs.execute(sql);
								while(rs.next()){
								String c_name=rs.getString("name");
								String c_id=rs.getString("id");
					  %>
							<option value="<%=c_id%>">
								<%=c_name %>
							</option>
						<%
							}
						 %>
						 
						 <%
								sql="select * from CompanyBusinessService  where affixindex =-1 ";
								rs.execute(sql);
								while(rs.next()){
								String c_name=rs.getString("name");
								String c_id=rs.getString("id");
								if(zrrid.equals(c_id)&&!btnid.equals("newBtn")&&!(businesstype+"").equals(c_id)){
									continue;
								}
					  %>
							<option value="<%=c_id%>">
								<%=c_name %>
							</option>
						<%
							}
						 %>
					</select>
					
				</td>
				
				<td height="25"  class="hidetr_n">
					<strong><%=SystemEnv.getHtmlLabelName(125907,user.getLanguage())%>：</strong>
				</td>
				<td  class="hidetr_n">
					<select name="companyvestin" id="companyvestin" class="OSelect"
						style="width: 122px;">
						
					<%
							 sql="select * from   Companyattributable  order by affixindex ";
							rs.execute(sql);
							while(rs.next()){
							String c_name=rs.getString("name");
							String c_id=rs.getString("id");
						%>
								<option value="<%=c_id%>">
									<%=c_name %>
								</option>
						<%
							}
						 %>
					</select>
				</td>
				
			</tr>
			<tr >
				<td height="25">
					<strong  id="zrrname"><%=SystemEnv.getHtmlLabelName(1976,user.getLanguage())%>：</strong>
				</td>
				<td colspan="3">
					<input type="text" name="companyname" id="companyname"
						class="OInput2" style="width: 339px" onblur="displayimg(this)"  maxlength="40" />
					<img src="images/O_44.jpg" class="ML5" style="margin-bottom: -3px;" />
				</td>
			</tr>
			<tr style="display: none;" >
				<td height="25">
					<strong><%=SystemEnv.getHtmlLabelName(23204,user.getLanguage())%>：</strong>
				</td>
				<td colspan="3">
					<input type="text" name="companyename" id="companyename"
						class="OInput2" style="width: 339px" maxlength="40" />
				</td>
			</tr>
			<tr  class="hidetr_n">
				<td valign="top">
					<strong>注册地址：</strong>
				</td>
				<td colspan="3" height="38">
					<textarea name="companyaddress" onblur="displayimg(this)"
						class="OInput2 BoxWAuto BoxHeight30" id="companyaddress" style="width: 90%;float: left;"></textarea>
					<span id="companyaddress_span" style="float: left;">
						<img src="images/O_44.jpg"   absMiddle="absMiddle"  iswarn='warning'/>
					</span>
				</td>
			</tr>
			<tr  class="hidetr_n">
				<td valign="top">
					<strong>办公地址：</strong>
				</td>
				<td colspan="3" height="38">
						<textarea name="bgdz_" onblur="displayimg(this)"
								  class="OInput2 BoxWAuto BoxHeight30" id="bgdz_" style="width: 90%;float: left;"></textarea>
					<span id="bgdz_span" style="float: left;">
						<img src="images/O_44.jpg"   absMiddle="absMiddle"  iswarn='warning'/>
					</span>

				</td>
			</tr>
			<tr  class="hidetr_n">
				<td>
					<strong>状态：</strong>
				</td>
				<td colspan="3" height="25">
					<select name="zt_" id="zt_" class="OSelect">
						<option value="1">正常</option>
						<option value="2">注销</option>
					</select>
				</td>
			</tr>
			<tr  class="hidetr_n">
				<td>
					<strong><%=SystemEnv.getHtmlLabelName(30975,user.getLanguage())%>：</strong>
				</td>
				<td width="154" height="25" >
					<BUTTON  class="Clock"  id=foundingbtn   type="button"    onclick="onShowDate('foundingTime_zc','foundingTime')"></BUTTON>
					<input type="hidden" id="foundingTime" name="foundingTime"/>
					<span id="foundingTime_zc">
					<img src="images/O_44.jpg"   absMiddle="absMiddle"  iswarn='warning'/>
					</span>
				</td>

				<td style="display: none;">
					<strong><%=SystemEnv.getHtmlLabelName(30976,user.getLanguage())%>：</strong>
				</td>
				<td width="154" height="25" style="display: none;">
					<input type="text" name="companytype" id="companytype"
						   onfocus="this.blur();" class="OInput3 BoxW120" />
				</td>
			</tr>
			<tr  class="hidetr_n" style="display: none;" needHide>
				<td valign="top" height="30">
					<strong><%=SystemEnv.getHtmlLabelName(31031,user.getLanguage())%>：</strong>
				</td>
				<td colspan="3" height="40">
					<textarea name="scopebusiness" class="OInput4 BoxWAuto BoxHeight40"
						onfocus="this.blur();" id="scopebusiness"></textarea>
				</td>
			</tr>
			<tr  class="hidetr_n" style="display: none;" needHide>
				<td height="25">
					<strong><%=SystemEnv.getHtmlLabelName(20668,user.getLanguage())%>：</strong>
				</td>
				<td>
					<input type="text" name="registercapital" id="registercapital"
						onfocus="this.blur();" class="OInput3 BoxW120" />
				</td>
				<td>
					<strong><%=SystemEnv.getHtmlLabelName(31038,user.getLanguage())%>：</strong>
				</td>
				<td>
					<input type="text" name="aggregateinvest" id="aggregateinvest"
						onfocus="this.blur();" class="OInput3 BoxW120" />
				</td>
			</tr>
			<tr  class="hidetr_n" style="display: none;" needHide>
				<td height="25">
					<strong><%=SystemEnv.getHtmlLabelName(20656,user.getLanguage())%>：</strong>
				</td>
				<td>
					<input type="text" name="corporatdelegate" id="corporatdelegate"
						onfocus="this.blur();" class="OInput3 BoxW120" />
				</td>
				<td>
					<strong><%=SystemEnv.getHtmlLabelName(20696,user.getLanguage())%>：</strong>
				</td>
				<td>
					<input type="text" name="generalmanager" id="generalmanager"
						onfocus="this.blur();" class="OInput3 BoxW120" />
				</td>
			</tr>
			<%--其他：“投资总额”、“币种”字段放在“新建公司”界面维护；--%>
			<tr class="hidetr_n" >
				<td  valign="top" height="25">
					<strong><%=SystemEnv.getHtmlLabelName(31038,user.getLanguage())%>：</strong>
				</td>
				<td>
					<input type="text" name="aggregateinvest_zc" id="aggregateinvest_zc"
						   class="OInput2"  onblur="displayimg(this)"/>
						<span>
								<img src="images/O_44.jpg"   absMiddle="absMiddle"  iswarn='warning'   id="aggregateinvest_zcimg"/>
						</span>
				</td>
				<td>
					<strong><%=SystemEnv.getHtmlLabelName(406,user.getLanguage()) %></strong>
				</td>
				<td style="text-align: left;">
					<%
						String currencyname="";
						if(!"".equals(CURRENCYID)){
							currencyname= CurrencyComInfo.getCurrencyname(CURRENCYID);
						}else{
							String DefaultCurrency=ProTransMethod.getDefaultCurrency();
							CURRENCYID=DefaultCurrency.split(",")[0];
							currencyname=DefaultCurrency.split(",")[1];
						}

						if(!"".equals(currencyname)){
					%>
					<button class="Browser"  onclick="onCurrOpen(this)" type="button" <%=btnid.equals("viewBtn")?"style='display:none;'":"" %> ></button>
                    <span   id="currencyid_zcspan" >
								<%=currencyname %>
						</span>
					<input type="hidden" name="currencyid_zc"  id="currencyid_zc"  value="<%=CURRENCYID %>">
					<img src="images/O_44.jpg"  class="ML5" style="margin-bottom: -3px;display: none;"  iswarn='warning'     id="currencyid_zcimg"/>
					<%
					}else{
					%>
					<button class="Browser"  onclick="onCurrOpen(this)" type="button" <%=btnid.equals("viewBtn")?"style='display:none;'":"" %>/>
						<span   id="currencyid_zcspan" >
						</span>
					<input type="hidden" name="currencyid_zc"  id="currencyid_zc"  value="">
					<img src="images/O_44.jpg"  class="ML5" style="margin-bottom: -3px;"  iswarn='warning'   id="currencyid_zcimg"/>
					<%
						}
					%>

				</td>
			</tr>
            <tr class="hidetr_n" style="display: none;" needHide >
                <%--tagtag--%>
                <td height="25" >
                    <strong><%=SystemEnv.getHtmlLabelName(31060,user.getLanguage())%>：</strong>
                </td>
                <td colspan="3">
                    <input type="text" name="loancard" id="loancard" class="OInput2"
                           style="width: 339px"   maxlength="40" />
                </td>
            </tr>
		</table>
		<div class="border17 FL PTop10 OHeaderLayerW4 ML15 hidetr_n"  style="width:440px;display:none;" needHide>
			
			<ul class="ONav FL cBlue">
				<li>
					<a href="#" class="hover">
						<div>
							<div>
								<%=SystemEnv.getHtmlLabelName(31039,user.getLanguage())%>
							</div>
						</div> </a>
				</li>
			</ul>
			<div class="clear"></div>

		</div>
		<div class="FL ML15 hidetr_n"  style="height:25px;width:440px;display:none;" needHide >
		<table width="430" border="0" cellpadding="0" cellspacing="1"  class="stripe OTable">
			<tr id="OTable2" class="cBlack">
				<td width="50%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(27336,user.getLanguage())%></strong>
				</td>
				<td width="30%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(31040,user.getLanguage())%></strong>
				</td>
				<td width="20%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(31109,user.getLanguage())%></strong>
				</td>
			</tr>
		</table>
		<div class="FR" style="height:24px;width:16px;background-color:#eeeeee; margin-top:-26px"></div>
		</div>
		<div class="OContRightScroll FL  ML15 hidetr_n" style="height:54px;width:440px;display: none;" needHide>
			<table width="430 border="0" cellpadding="0" cellspacing="1"
				class="stripe OTable">
				<%
					 sql = "select t2.* from CPSHAREHOLDER t1,CPSHAREOFFICERS t2 where t1.shareid = t2.shareid and t1.companyid = '" + companyid+"'";
					rs.execute(sql);
					while (rs.next()){
				 %>
				<tr>
					<td width="50%" align="center">
						<%=Util.null2String(rs.getString("officername")) %>
					</td>
					<td width="30%" align="center">
						<%=Util.null2String(rs.getString("aggregateinvest")) %>
					</td>
					<td width="20%" align="center">
						<%=Util.null2String(rs.getString("investment")) %>
					</td>
				</tr>
				<%
				}
				 %>
			</table>
		</div>
		<table width="460" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0"
cellspacing="0" class="PTop5 " <%=fromNEWPAGE?"":"style='margin-left: 15px;'"%>>
			<tr class="hidetr_n" style="display: none;" needHide>
				<td valign="top" height="25">
					<strong><%=SystemEnv.getHtmlLabelName(31058,user.getLanguage())%>：</strong>
				</td>
				<%
				String dshcysql = " select t1.officename from CPBOARDOFFICER t1,CPBOARDDIRECTORS t2 where t1.directorsid = t2.directorsid and t2.companyid= '"+companyid+"'"; 
				String dshcy = "";
				rs.execute(dshcysql);
				while(rs.next()){
					dshcy+=rs.getString("officename")+",";
				}
				if(!"".equals(dshcy)){
					dshcy=dshcy.substring(0, dshcy.length()-1);
				}
				%>
				<td colspan="3" height="48">
					<textarea name="officename" class="OInput4 BoxWAuto BoxHeight40"
						onfocus="this.blur();" id="officename"><%=dshcy %></textarea>
				</td>
			</tr>
			<tr class="hidetr_n" style="display: none;" needHide>
				<td height="25">
					<strong><%=SystemEnv.getHtmlLabelName(31059,user.getLanguage())%>：</strong>
				</td>
				<td colspan="3">
					<input type="text" name="usefulbegindate" id="usefulbegindate"
						onfocus="this.blur();" class="OInput3 BoxW90" />
					<%=SystemEnv.getHtmlLabelName(15322,user.getLanguage())%>
					<input type="text" name="usefulenddate" id="usefulenddate"
						onfocus="this.blur();" class="OInput3 BoxW90" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<strong><%=SystemEnv.getHtmlLabelName(358,user.getLanguage())%>：</strong>
					<input type="text" name="usefulyear" id="usefulyear"
						onfocus="this.blur();" class="OInput3 BoxW30" />
					<strong><%=SystemEnv.getHtmlLabelName(26577,user.getLanguage())%></strong>
				</td>
			</tr>
				<tr class="hidetr_n" style="display: none;" needHide>
				<td colspan="4" height="25">
					<span class="FL"><strong><%=SystemEnv.getHtmlLabelName(23798,user.getLanguage())%>：</strong></span>
					<input type="text" name="licenseregistnum" id="licenseregistnum" onfocus="this.blur();" class="OInput3 FL" style="width: 257px" />
				</td>
			</tr>
			<tr>
				<td colspan="4" height="25" <%=fromNEWPAGE?"style='border:0px;'":"" %> >
					<div class="MT10 FL OHeaderLayerW4 " style="height: 40px"  id="btndiv">
									<span class="newLISapn" id="save_H">
										<a id="btnInfoSave" href="javascript:void(0);" class="hover">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</a>
									</span>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>
<!--表头浮动层 end-->

<script type="text/javascript">
	function  onShowLocationID(){
		var tempid= window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/web/broswer/CityBrowser.jsp");
		if(tempid){
			if(tempid.id!=0){
					$("#companyregionSpan").html(tempid.name);
					$("#companyregion").val(tempid.id);
			}else{
					$("#companyregionSpan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
					$("#companyregion").val("");
			}
		}else{
			$("#companyregionSpan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
			$("#companyregion").val("");
		}
		
		
	}
    jQuery(function(){
        checkzrr(jQuery("#businesstype")[0]);
    });
</script>