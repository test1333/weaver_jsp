<%@page import="weaver.cpcompanyinfo.ProTransMethod"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="java.net.URLDecoder"%>
<%@page import="weaver.cpcompanyinfo.CompanyInfoTransMethod"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<%@page import="weaver.docs.docs.DocComInfo"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs02" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CompanyPermissionService" class="weaver.cpcompanyinfo.CompanyPermissionService" scope="page" />
<style>
  .dest{   
    width: 399px;   
    height: 321px;   
    border: solid #ccc 1px;   
    overflow: hidden;   
    /**这个地方在IE6,7下很贱，如果不把它设置为relative， 则在它里面的对象的relative无效**/   
    position: relative;   
    z-index: 9999;
    background:#fff;
  }   
  fieldset { border:0;}

</style> 
<%


	int userid = user.getUID();
	  Random rnd = new Random();
	int sjdata=rnd.nextInt(100);
	String myfrom = Util.null2String(request.getParameter("myfrom"));
//	System.out.println("myfrom:"+myfrom);
	String btnid = Util.null2String(request.getParameter("btnid"));
	String companyid = Util.null2String(request .getParameter("companyid"));
	rs.execute("SELECT * FROM CPCOMPANYINFO  where companyid="+companyid);		
	String companyname ="";
	if(rs.next()){
			companyname=rs.getString("companyname");
	}	
	boolean maintFlag = false;
    if(CompanyPermissionService.canEditCompany(user,companyid))//后台维护权限
	{
		maintFlag = true;
	}


	String licenseid = Util.null2String(request
			.getParameter("licenseid"));
	/*公司证照*/
	String registeraddress = "";
	String corporation = "";
	String recordnum = "";
	String usefulbegindate = "";
	String usefulenddate = "";
	String usefulyear = "";
	String dateinssue = "";
	String licensestatu = "";
	String annualinspection = "";
	String departinssue = "";
	String scopebusiness = "";
	String registercapital = "";
	String paiclupcapital = "";
	String currencyid = "";
	String currencyname="";
	String corporatdelegate = "";
	String licenseregistnum = "";
	String memo = "";
	String companytype = "";
	String licensename = "";
	String licensetype = "";
	int licenseaffixid = 0;
	String affixdoc = "";
	String imgid = "";
	String imgname = "";
	
	String requestid = "";
	String requestname = "";	
	String requestaffixid = "";
	
	String ispdf = "";

	if (!licenseid.equals("")) {
		String sql = " select * from CPBUSINESSLICENSE t1,CPLMLICENSEAFFIX t2 where t1.licenseaffixid = t2.licenseaffixid and t1.licenseid = "
				+ licenseid;
		rs.execute(sql);
		//System.out.println("查出证照的基本信息"+sql);
		if (rs.next()) {
			registeraddress = Util.null2String(rs
					.getString("registeraddress"));
			corporation = Util.null2String(rs.getString("corporation"));
			recordnum = Util.null2String(rs.getString("recordnum"));
			usefulbegindate = Util.null2String(rs
					.getString("usefulbegindate"));
			usefulenddate = Util.null2String(rs
					.getString("usefulenddate"));
			usefulyear = Util.null2String(rs.getString("usefulyear"));
			dateinssue = Util.null2String(rs.getString("dateinssue"));
			licensestatu = Util.null2String(rs
					.getString("licensestatu"));
			annualinspection = Util.null2String(rs
					.getString("annualinspection"));
			departinssue = Util.null2String(rs
					.getString("departinssue"));
			scopebusiness = Util.null2String(rs
					.getString("scopebusiness"));
			registercapital = Util.null2String(rs
					.getString("registercapital"));
			paiclupcapital = Util.null2String(rs
					.getString("paiclupcapital"));
			currencyid = Util.null2String(rs.getString("currencyid"));
			corporatdelegate = Util.null2String(rs
					.getString("corporatdelegate"));
			licenseregistnum = Util.null2String(rs
					.getString("licenseregistnum"));
			memo = Util.null2String(rs.getString("memo"));
			companytype = Util.null2String(rs.getString("companytype"));
			licensename = Util.null2String(rs.getString("licensename"));
			licensetype = Util.null2String(rs.getString("licensetype"));
			licenseaffixid = rs.getInt("licenseaffixid");
			affixdoc = Util.null2String(rs.getString("affixdoc"));
			
			requestid = Util.null2String(rs.getString("requestid"));
			requestname = Util.null2String(rs.getString("requestname"));
			requestaffixid = Util.null2String(rs.getString("requestaffixid"));
			
			rs02.execute("select id,currencyname,currencydesc from FnaCurrency  where id = '"+currencyid+"'");
			if(rs02.next()){
				currencyname=Util.null2String(rs02.getString("currencyname"));
			}
			
		}
		if("implicenseBtn".equalsIgnoreCase(myfrom)){
		    recordnum="";
		}
		String affixdoctemp = "";
		if(!"".equals(affixdoc) && affixdoc != null) {affixdoctemp = affixdoc.substring(0,affixdoc.length()-1);}
		//System.out.println("affixdoctemp=="+affixdoctemp);
		String[] affixdoctemparr = affixdoctemp.split(",");
		rs.execute("select * from imagefile where imagefileid='"+affixdoctemparr[0]+"'");
		if(rs.next()){
			imgid=rs.getString("imagefileid");
			imgname = rs.getString("imagefilename");
			if(imgname.substring(imgname.lastIndexOf("."),imgname.length()).toLowerCase().equalsIgnoreCase(".pdf")){
				ispdf = "1";
			}else if(imgname.substring(imgname.lastIndexOf("."),imgname.length()).toLowerCase().equalsIgnoreCase(".jpg")
				|| imgname.substring(imgname.lastIndexOf("."),imgname.length()).toLowerCase().equalsIgnoreCase(".bmp")
				|| imgname.substring(imgname.lastIndexOf("."),imgname.length()).toLowerCase().equalsIgnoreCase(".jpeg")
				|| imgname.substring(imgname.lastIndexOf("."),imgname.length()).toLowerCase().equalsIgnoreCase(".png")
				){
					ispdf ="0";
				}else{
					ispdf ="2";
				}
			
		}
	}
	
	String o4sql = " select * from mytrainaccessoriestype where accessoriesname='lmlicense'";
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

<div id="test" style="display:none"></div>
<script type="text/javascript">
	
	
	/* function dozoom(obj){
	
	if(obj.complete){
		//$(".jqzoom").jqzoom();
	}
		//	
	} */
	jQuery(document).ready(function(){
	//alert($(".jqzoom").length)
	/* setTimeout(function(){
		if(jQuery.browser.msie) {
			//如果是ie,就调用一下window对象的某个属性，用于控制放大镜的兼容问题
			window.screenX;
		}
		$(".jqzoom").jqzoom();
	},10)
	 */

	
		
		if("<%=btnid%>"=="newBtn")
		{
			jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31021,user.getLanguage())%>");
			jQuery("#method").val("add");
            jQuery("#saveLicenseBtn").attr("href","javascript:saveDate();");
            jQuery("#saveLicenseBtnQ").attr("href","javascript:saveDate(2);");
		}
		if("<%=btnid%>"=="editBtn")
		{
            var myfrom='<%=myfrom %>';
            if(myfrom=="implicenseBtn"){
                jQuery("#spanTitle").html("引用证照");
            }else{
                jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31023,user.getLanguage())%>");
            }

            jQuery("#method").val("edit");
			jQuery("#saveLicenseBtn").attr("href","javascript:saveDate();");
			jQuery("#saveLicenseBtnQ").attr("href","javascript:saveDate(2);");
			jQuery("#see_img").hide();
			jQuery("img[iswarn='warning']").hide();
			jQuery("#licensename").addClass("BoxW300").removeClass("OInput2").addClass("OInput3").focus(function(){this.blur();});
		}
		if("<%=btnid%>"=="viewBtn")
		{
			jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31022,user.getLanguage())%>");
			jQuery(".OInput2").removeClass("OInput2").addClass("OInput3").focus(function(){this.blur();});
			jQuery(".OSelect[id!='searchSL']").removeClass("OSelect").addClass("OSelect2").focus(function(){this.blur();});
			jQuery("#scopebusiness").addClass("OInput4");
			jQuery("#saveLicenseBtn").css("display","none");
			jQuery("#saveLicenseBtnQ").css("display","none");
			jQuery("#save_H").hide();
			jQuery("#save_Q").hide();
			jQuery("#see_img").hide();
			jQuery("#licensename").addClass("BoxW300");
			jQuery(".Clock").hide();
			jQuery("#cu_idH").hide();
			jQuery("#licenseAffixUpload").hide();
			jQuery("img[iswarn='warning']").hide();
			
		}
		if("<%=btnid%>"!="newBtn")
		{
			init_license();//调用公司证照初始化方法
		}else{
			jQuery("#companyname").val("<%=companyname%>");
		}
		/*当有实际证照时才显示放大镜*/
		if("<%=affixdoc%>" == ""){
			jQuery("#source").find("img").attr("src","images/nopic.jpg");
			jQuery("#_s2uiContent").css("display","none");
		}else{
			
			//mouseonBig();
			jQuery("#_s2uiContent").css("display","");
		}
		
		displayimg(jQuery("#departinssue"));
		displayimg(jQuery("#licensename"));
	});
	

	
	function mouseonBig(){
		/*当鼠标放在图片上才显示放大镜，反之隐藏放大镜*/
		jQuery("#source").bind("mouseover",function(){
			if(jQuery("#affixdoc").val()!=""){	//因为删除图片后，还原无图片状态，不再监听
				var borderBox = document.createElement("div");
				borderBox.setAttribute("id","dest");  
				borderBox.style.clear = "both"; 
				borderBox.style.top = "55px";
				borderBox.style.left = "50px";
				borderBox.className = "dest";
				document.getElementById("destContent").appendChild(borderBox);
				Amplifier.init('source','dest',jQuery("select#speed").val());//调用放大镜
			}
		});
		
		jQuery("#source").bind("mouseout",function(){
			jQuery("#dest,#chooseArea").remove();
		});
	}
	
	/*公司证照 保存方法*/
	function saveBusinessLicense()
	{
	
	
		var requestname = jQuery('#requestname').val();
		var requestaffixid = "";
		var requestid = "";
		
		if(requestname == "")
		{
			requestname = jQuery('#workflowspan').find("a").html();
			requestid = jQuery('#workflowspan').find("a").attr("requestid");
		}
		else
		{
			requestname = jQuery('#requestname').val();
			requestid = jQuery("#requestid").val();
			requestaffixid = jQuery("#affixIds").val();
		}
		var o4params = {
			method:jQuery("#method").val(),
			isaddversion:jQuery("#isaddversion").val(),
			myfrom:"<%=myfrom %>",
			companyid:"<%=companyid%>",
			licenseid:"<%=licenseid%>",
			licensename:encodeURI(jQuery("#licensename").val()),
			licenseaffixid:encodeURI(jQuery("#licenseaffixid").val()),
			registeraddress:encodeURI(jQuery("#registeraddress").val()),
			corporation:encodeURI(jQuery("#corporation").val()),
			recordnum:encodeURI(jQuery("#recordnum").val()),
			usefulbegindate:encodeURI(jQuery("#begintime").val()),
			usefulenddate:encodeURI(jQuery("#endtime").val()),
			usefulyear:encodeURI(jQuery("#usefulyear").val()),
			dateinssue:encodeURI(jQuery("#inssuedate").val()),
			annualinspection:encodeURI(jQuery("#annualdate").val()),
			scopebusiness:encodeURI(jQuery("#scopebusiness").val()),
			departinssue:encodeURI(jQuery("#departinssue").val()),
			registercapital:encodeURI(jQuery("#registercapital").val()),
			paiclupcapital:encodeURI(jQuery("#paiclupcapital").val()),
			currencyid:encodeURI(jQuery("#currencyid").val()),
			corporatdelegate:encodeURI(jQuery("#corporatdelegate").val()),
			companytype:encodeURI(jQuery("#companytype").val()),
			licenseregistnum:encodeURI(jQuery("#licenseregistnum").val()),
			memo:encodeURI(jQuery("#memo").val()),
			affixdoc:encodeURI(jQuery("#affixdoc").val()),
			
			requestname1:encodeURI(requestname),
			requestid1:encodeURI(requestid),
			affixids1:encodeURI(requestaffixid),
			
			versionnum:encodeURI(jQuery("#versionnum").val()),
			versionname:encodeURI(jQuery("#versionname").val()),
			versionmemo:encodeURI(jQuery("#versionmemo").val()),
			versionaffix:"",
			date2Version:encodeURI(jQuery("#versionTime").val())
		};
		
		jQuery.post("/cpcompanyinfo/action/CPLicenseOperate.jsp",o4params,function(data){
			if(jQuery.trim(data)!="0"){
							alert(data);
			}
            if("<%=myfrom %>"=="implicenseBtn"){
                reflush2List();
            }else{
                closeMaint4Win("<%=btnid%>");
                reflush2List();
            }

		});
		
	}
	
	//证照的版本编辑方法
	function editversionDate(versionid,oneMoudel){
			o4params ={
			method:"editversion",
			versionid:versionid,
			versionnum:encodeURI(jQuery("#versionnum").val()),
			versionname:encodeURI(jQuery("#versionname").val()),
			versionmemo:encodeURI(jQuery("#versionmemo").val()),
			versionaffix:"",
			date2Version:encodeURI(jQuery("#versionTime").val()),
			oneMoudel:oneMoudel
			};
			//alert(jQuery("#versionname").val()+"提交数据"+jQuery("#versionnum").val());
			jQuery.post("/cpcompanyinfo/action/CPLicenseOperate.jsp",o4params,function(){
				alert("<%=SystemEnv.getHtmlLabelName(31024,user.getLanguage())%>!");
			//编辑版本以后统一不让关闭
			//closeMaint4Win();		
		});
	}
	
	/*验证表单方法*/
	function checkForm()
	{
		var ischecked = false;
		if(jQuery.trim(jQuery("#licensename").val())!="" &&jQuery.trim(jQuery("#inssuedate").val())!="" && jQuery.trim(jQuery("#departinssue").val())!=""  ){
			ischecked = true;
		}
	 	jQuery("#w_chedktable").find("img[align='absMiddle']").each(function (){
			ischecked=false;
		});
		
		if(!jQuery("#_fximg").is(":hidden")){
				ischecked=false;
		}
		if(!jQuery("#businessOnlyDiv").is(":hidden")){
				jQuery("#businessOnlyDiv").find("img[align='absMiddle']").each(function (){
							if(!jQuery(this).is(":hidden")){
										ischecked=false;
							}
				});
		}
		
		if(jQuery.trim(jQuery("#recordnum").val())==""||jQuery.trim(jQuery("#scopebusiness").val())==""){
				ischecked=false;
		}
		
		
		return ischecked;
	}
	
	
	function opinionStartTimeEndTime( stratTime , endTime ){
	      var strat = stratTime.split( "-" );
	      var end = endTime.split( "-" );
	      var sdate=new Date(strat[0],strat[1],strat[2]);
	      var edate=new Date(end[0],end[1],end[2]);
	      if(sdate.getTime()>edate.getTime()){
	        return false;
	      }
	      return true;
    }
    
	
	function displayimg(obj){
		if(jQuery.trim(jQuery(obj).val())!=""){
			jQuery(obj).parent().find("img[iswarn='warning']").css("display","none");
		}else{
			jQuery(obj).parent().find("img[iswarn='warning']").css("display","");
		}
	}
	function displayimgNext(obj){
		if(jQuery.trim(jQuery(obj).val())!=""){
			jQuery(obj).next().find("img[iswarn='warning']").css("display","none");
		}else{
			jQuery(obj).next().find("img[iswarn='warning']").css("display","");
		}
	}
	
	
	/* 关闭 qtip */
	function closeMaint4Win(btnid)
	{
		jQuery("#"+btnid).qtip("hide");
		jQuery("#"+btnid).qtip("destroy")
	}
	/*初始化证照 特别是第二块，针对编辑和查看*/
	function init_license(){
		jQuery("#companyname").val("<%=companyname%>");
		jQuery("#licenseaffixid").val("<%=licenseaffixid%>");
		
		jQuery("#registeraddress").val("<%=registeraddress%>");
		jQuery("#corporation").val("<%=corporation%>");
		jQuery("#recordnum").val("<%=recordnum%>");
		jQuery("#usefulbegindate01").html("<%=usefulbegindate%>");
		jQuery("#begintime").val("<%=usefulbegindate%>");
		
		
		jQuery("#usefulenddate").html("<%=usefulenddate%>");
		jQuery("#endtime").val("<%=usefulenddate%>");
		
		
		jQuery("#usefulyear").val("<%=usefulyear%>");
	
		jQuery("#inssuedate").val("<%=dateinssue%>");
	
		if("<%=btnid%>"=="editBtn")
		{
				jQuery("#dateinssue").html("<%=dateinssue%>");
		}
		if("<%=btnid%>"=="viewBtn")
		{
				jQuery("#dateinssue").html("<%=dateinssue%>");
		}
	
		
		
		jQuery("#licensestatu").val("<%=licensestatu%>");
		
		jQuery("#annualinspection").html("<%=annualinspection%>");
		jQuery("#annualdate").val("<%=annualinspection%>");
		
		
		jQuery("#departinssue").val("<%=departinssue%>");
		
		//jQuery("#workflowspan").html("<a style='color:blue;' viewVersion='N' requestid='<%=requestid%>' href=javascript:onWorkflowAttachmentOpen('<%=requestid%>','<%=requestname%>')><%=requestname%></a>");
		
		//有问题
		jQuery("#test").html("<%=Util.toHtml(scopebusiness)%>");
		jQuery("#scopebusiness").val(jQuery("#test").text());
		
		jQuery("#memo").val("<%=memo%>");
		jQuery("#licensename").val("<%=licensename%>");
		jQuery("#licensetype").val("<%=licensetype%>");
		
		jQuery("#affixdoc").val("<%=affixdoc%>");
		if(jQuery("#affixdoc").val()!=""){
			jQuery("#source").css("display","");
		}
		
		if("<%=licensetype%>"==1){
			jQuery("#businessOnlyDiv").css("display","");
			jQuery("#registercapital").val("<%=registercapital%>");
			jQuery("#paiclupcapital").val("<%=paiclupcapital%>");
			jQuery("#currencyid").val("<%=currencyid%>");
			jQuery("#currencyname").html("<%=currencyname%>");
			jQuery("#corporatdelegate").val("<%=corporatdelegate%>");
			jQuery("#licenseregistnum").val("<%=licenseregistnum%>");
			jQuery("#companytype").val("<%=companytype%>");
		}else{
			jQuery("#businessOnlyDiv").css("display","none");
		}
		
	}
	/*打开选择证照DIV*/
	function onLicenseDivOpen(){
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","80px").css("left","400px");
		jQuery("#wBoxContent").css("width","335px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31006,user.getLanguage())%>");
		jQuery("#wBoxContent").load("ChooseLicenseList.jsp");
		jQuery("#wBox_overlay").removeClass("wBox_hide"
		).addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
		jQuery("#source").css("display","none");
	}
	
	/*打开选择流程DIV*/
	function onWorkflowDivOpen(){
		
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","268px").css("left","30px");
		jQuery("#wBoxContent").css("width","476px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31025,user.getLanguage())%>");
		jQuery("#wBoxContent").load("/cpcompanyinfo/ChooseWorkflow.jsp");
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
		jQuery("#source").css("display","none");
	}
	
	/*打开流程附件DIV*/
	function onWorkflowAttachmentOpen(requestid,requestname){
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","130px").css("left","30px");
		jQuery("#wBoxContent").css("width","400px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31026,user.getLanguage())%>");
		jQuery("#wBoxContent").load("/cpcompanyinfo/WorkflowAtOperation.jsp?requestid="+requestid+"&requestname="+requestname+"&isNeedReSearch="+jQuery("#isNeedReSearch").val()+"&licenseid=<%=Util.null2String(request.getParameter("licenseid"))%>"+"&viewVersion="+jQuery('#workflowspan').find("a").attr("viewVersion")+
		"&versionId="+jQuery("#versionId").val()+"&isReEdit="+jQuery("#isReEdit").val()+"&affixidsReEdit="+jQuery("#affixidsReEdit").val());
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
		jQuery("#source").css("display","none");
	}
	
	/*打开版本新增DIV*/
	function onversionAddDivOpen(){
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","130px").css("left","550px");
		jQuery("#wBoxContent").css("width","335px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31011,user.getLanguage())%>");
		jQuery("#wBoxContent").load("CompanyVersionMaint.jsp?licenseid=<%=licenseid%>&oneMoudel=license&companyid=<%=companyid%>");
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
		jQuery("#source").css("display","none");
	}
	
	/*打开版本管理页面*/
	function openVersionManage(){
		jQuery("#wBoxContent").html("");
		//谷歌浏览器下需要提供px，否则不兼容
		jQuery("#wBox").css("top","130px").css("left","440px");
		jQuery("#wBoxContent").css("width","476px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(19450,user.getLanguage())%>");
		jQuery("#wBoxContent").load("/cpcompanyinfo/CompanyVersionManage.jsp?licenseid=<%=licenseid%>&oneMoudel=license&showOrUpdate=<%=showOrUpdate%>");
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
		jQuery("#source").css("display","none");
	}
	
	/*关闭选择证照DIV*/
	function onLicenseDivClose() {
		jQuery("#wBox_overlay").removeClass("wBox_overlayBG").addClass("wBox_hide");
		jQuery("#licenseDiv").css("display","none");
		jQuery("#saveLicenseBtn").attr("href","javascript:saveDate();");	//恢复保存按钮
		jQuery("#saveLicenseBtnQ").attr("href","javascript:saveDate(2);");	//恢复保存按钮
		jQuery("#source").css("display","");
	} 
	/*点击证照名称后 操作*/
	function clickLicenseName2List(licenseaffixid,licensename,licensetype){
		jQuery("#licensename").val(licensename);
		jQuery("#licenseaffixid").val(licenseaffixid);
		var o4params = {
				method:"haved",
				companyid:"<%=companyid%>",
				licenseaffixid:licenseaffixid,
				licenseid:"<%=licenseid%>",
				btnid:"<%=btnid%>"
			}
		jQuery.post("/cpcompanyinfo/action/CPLicenseOperate.jsp",o4params,function(data){
			if(licensetype=='1'){//判断是否营业执照，营业执照固定为1
				jQuery("#businessOnlyDiv").css("display","");
			}else{
				jQuery("#businessOnlyDiv").css("display","none");
			}
			if(jQuery.trim(data)=="haved"){
				//所选证照已在该公司存在
				alert("<%=SystemEnv.getHtmlLabelName(31027,user.getLanguage())%>！");
				jQuery("#newimg").html("<img src='images/O_44.jpg' iswarn='warning' class='ML5' style='margin-bottom: -3px;'  />");
				jQuery("#licensename").val("");
				jQuery("#saveLicenseBtn").css("display","none");
				jQuery("#saveLicenseBtnQ").css("display","none");
				if(licensetype=='1'){
					jQuery("#businessOnlyDiv").css("display","none");
				}
			}else{
					jQuery("#newimg").html("");
					jQuery("#saveLicenseBtn").css("display","");
					jQuery("#saveLicenseBtnQ").css("display","");
					if(licensetype=='1'){
						jQuery("#businessOnlyDiv").css("display","");
					}
					
			}
			
			onLicenseDivClose();
		});
	}
	
	
	
	function saveDate(obj){
		var begintime=jQuery.trim(jQuery("#begintime").val());
		var endtime=jQuery.trim(jQuery("#endtime").val());
		if(""!=begintime&&""!=endtime){
			if(opinionStartTimeEndTime(begintime,endtime)==false){
					alert("<%=SystemEnv.getHtmlLabelName(31191,user.getLanguage())  %>!");
					return;
			}
		}
		jQuery("#saveLicenseBtn").attr("href","javascript:void(0);");	//不让保存重复点击
		jQuery("#saveLicenseBtnQ").attr("href","javascript:void(0);");	//不让保存重复点击
		if(checkForm()){
				if (obj==undefined||obj!=2) {
					onversionAddDivOpen();
				} else {
					var truth4Told = true;
					if(truth4Told){
						StartUploadAll();
						checkuploadcomplet();
					}else{
						jQuery("#saveLicenseBtn").attr("href","javascript:saveDate();");	//恢复保存按钮
						jQuery("#saveLicenseBtnQ").attr("href","javascript:saveDate(2);");	//恢复保存按钮
					}
				}
		}
		else
		{
			alert("<%=SystemEnv.getHtmlLabelName(15859,user.getLanguage())%>");
			jQuery("#saveLicenseBtn").attr("href","javascript:saveDate();");	//恢复保存按钮
			jQuery("#saveLicenseBtnQ").attr("href","javascript:saveDate(2);");	//恢复保存按钮
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
	       saveBusinessLicense();
	    }
	}
	
	
	
	/*版本方法 开始*/
	
	
	function saveversionDate(){
		jQuery("#isaddversion").val("add");
		StartUploadAll();
		checkuploadcomplet();
	}
	
	
	/*删除一行或多行*/
	function dodel_gd(){
		var versionids="";
		var _versionnum="";
		jQuery('#webTable2version tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true)
			{
				versionids += jQuery(this).attr("versionid")+",";
				_versionnum+= jQuery(this).attr("_versionnum")+",";
			}
		});
		if(versionids.length == 0){
			alert("<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage()) %>！");
			return;
		}
		var truthBeTold = window.confirm("<%=SystemEnv.getHtmlLabelName(31013,user.getLanguage())%>？"); 
		if (truthBeTold) { 
			jQuery('#webTable2version tr').each(function(){
				if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true)
				{
					var o4params={method:"delVersion",versionids:versionids,_versionnum:_versionnum}
					jQuery.post("/cpcompanyinfo/action/CPLicenseOperate.jsp",o4params,function(){
						
					});
					jQuery(this).remove();
				}
			});
		}
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
			alert("<%=SystemEnv.getHtmlLabelName(31014,user.getLanguage())%>！");
		}else{
			jQuery("#versionId").val(versionids);//给版本号赋值
			var o4params = {method:"viewVersion",versionids:versionids}
			jQuery.post("/cpcompanyinfo/action/CPLicenseOperate.jsp",o4params,function(data){
				jQuery("#licenseaffixid").val(data[0]["licenseaffixid"]);
				jQuery("#registeraddress").val(data[0]["registeraddress"]);
				jQuery("#corporation").val(data[0]["corporation"]);
				jQuery("#recordnum").val(data[0]["recordnum"]);
				jQuery("#usefulbegindate01").html(data[0]["usefulbegindate"]);
				jQuery("#begintime").val(data[0]["usefulbegindate"]);
				
				jQuery("#spanTitle").html("");
				jQuery("#spanTitle").html("<%=SystemEnv.getHtmlLabelName(31028,user.getLanguage())%>["+data[1]+"]");
				
				jQuery("#usefulenddate").html(data[0]["usefulenddate"]);
				jQuery("#endtime").val(data[0]["usefulenddate"]);
				
				
				jQuery("#usefulyear").val(data[0]["usefulyear"]);
				jQuery("#inssuedate").val(data[0]["dateinssue"]);
				jQuery("#dateinssue").html(data[0]["dateinssue"]);
				
				
				jQuery("#licensestatu").val(data[0]["licensestatu"]);
				jQuery("#annualinspection").html(data[0]["annualinspection"]);
				jQuery("#annualdate").val(data[0]["annualinspection"]);
				
				
				jQuery("#departinssue").val(data[0]["departinssue"]);
				jQuery("#scopebusiness").val(data[0]["scopebusiness"]);
				jQuery("#memo").val(data[0]["memo"]);
				jQuery("#licensename").val(data[0]["licensename"]);
				jQuery("#licensetype").val(data[0]["licensetype"]);
				
				jQuery("#affixdoc").val(data[0]["affixdoc"]);
			//	jQuery("#workflowspan").html("<a style='color:blue;' viewVersion='Y' requestid='' href=javascript:onWorkflowAttachmentOpen('"+data[0]["requestid"]+"','"+data[0]["requestname"]+"')>"+data[0]["requestname"]+"</a>");
				
				if(data[0]["licensetype"]==1){
					jQuery("#businessOnlyDiv").css("display","");
					jQuery("#registercapital").val(data[0]["registercapital"]);
					jQuery("#paiclupcapital").val(data[0]["paiclupcapital"]);
					jQuery("#currencyid").val(data[0]["currencyid"]);
					jQuery("#currencyname").html(data[0]["currencyname"]);
					
					jQuery("#corporatdelegate").val(data[0]["corporatdelegate"]);
					jQuery("#licenseregistnum").val(data[0]["licenseregistnum"]);
					jQuery("#companytype").val(data[0]["companytype"]);
				}else{
					jQuery("#businessOnlyDiv").css("display","none");
				}
				var imgid4db = data[0]["imgid"].split("|");
				if(imgid4db.length>1){jQuery("#source").css("display","");}
				var imgname4db = data[0]["imgname"].split("|");
				jQuery("#source").find("img").attr("src","/weaver/weaver.file.FileDownload?fileid="+imgid4db[0]);
				
				var ispdf02="";
				var imgname4db_0=imgname4db[0];
				//得到第一个附件的类型
				if(imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".pdf")){
					ispdf02 = "1";
				}else if(imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".jpg")
						|| imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".bmp")
						|| imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".jpeg")
						|| imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".png")
				){
					ispdf02 ="0";
				}else{
					ispdf02="2";
				}
				changePDF(imgid4db[0],ispdf02);
				if(jQuery("#affixcpdosDIV").find("div").length/3>0){
					jQuery("#affixcpdosDIV").html("");
				}
				var html4doc="";
				for(i=0;i<imgid4db.length - 1;i++){
				
				
				 ispdf02="";
				 imgname4db_0=imgname4db[i];
				//得到第一个附件的类型
				if(imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".pdf")){
					ispdf02 = "1";
				}else if(imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".jpg")
						|| imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".bmp")
						|| imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".jpeg")
						|| imgname4db_0.substring(imgname4db_0.lastIndexOf("."),imgname4db_0.length).toLowerCase()==(".png")
				){
					ispdf02 ="0";
				}
				
					html4doc += "<div id='imgfileDiv"+i+"' style='background-color: #F7F7F7;width:291px;height:20px;padding-left:4px;border: solid 1px #E8E8E8;padding: 4px;margin-bottom: 5px;'>";
					html4doc+="<div style='width:80%;float:left;' >";
					html4doc+="<A id='pdflinkid"+i+"' href=\"javascript:changePDF('"+imgid4db[i]+"','"+ispdf02+"')\" class='aContent0 FL'>"+imgname4db[i]+"</A>";
					html4doc+="</div>";
					html4doc+="<div style='padding-right:0px;float:right;padding-top:0px'>";
					html4doc+="<a href='/weaver/weaver.file.FileDownload?fileid="+imgid4db[i]+"&download=1'><img src='images/downLoadPic.gif'  title='<%=SystemEnv.getHtmlLabelName(22629,user.getLanguage())%>'  ></a>";
					html4doc+="</div>";
					html4doc+="</div>";
				}
				jQuery("#affixcpdosDIV").html(html4doc);
				
				jQuery("#save_H").hide();
				jQuery("#save_Q").hide();
				jQuery("#see_img").hide();
				jQuery("#licensename").addClass("BoxW300");
				jQuery(".Clock").hide();
				jQuery("#cu_idH").hide();
				jQuery("#licenseAffixUpload").hide();
				jQuery(".OInput2").removeClass("OInput2").addClass("OInput3").focus(function(){this.blur();});
				jQuery(".OSelect[id!='searchSL']").removeClass("OSelect").addClass("OSelect2").focus(function(){this.blur();});
				onLicenseDivClose();
			},"json");
		}
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
			alert("<%=SystemEnv.getHtmlLabelName(31017,user.getLanguage())%>！");
		}else{
			jQuery("#wBoxContent").html("");
			jQuery("#wBox").css("top","130px").css("left","550px");
			jQuery("#wBoxContent").css("width","335px").css("height","225px");
			jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31018,user.getLanguage())%>");
			jQuery("#wBoxContent").load("CompanyVersionMaint.jsp?versionids="+versionids+"&oneMoudel=license&companyid=<%=companyid%>&licenseid=<%=licenseid%>");
			jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
			jQuery("#licenseDiv").css("display","");
			
		}
	}
	
	/*版本方法 结束*/
	
	
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
	
	function changePDF(pdfid,ispdf02){
			jQuery("#source").find("iframe").attr("src","/cpcompanyinfo/PdforImgShow/PdforImgindex.jsp?sjdata=<%=sjdata %>&imgid="+pdfid+"&ispdf="+ispdf02);
	}
	
	/*上传空间判断是否安装了flash控件*/
	var fls = flashChecker();
	var flashversion = 0;
	if (fls.f)
		flashversion = fls.v;
	if (flashversion < 9)
		document.getElementById("fsUploadProgress").innerHTML = "<br>&nbsp;&nbsp;附件上传的功能需要你的机器支持Flash9及其以上的版本，请从下面选择安装方式:<br><br><a target='_blank' href='http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=shockwaveFlash'>&nbsp;&nbsp;在线安装<a>	<br><br><a href='/resource/install_flash9_player.exe' target='_blank'>&nbsp;&nbsp;下载安装包</a>";	
</script>
<form>
<!--表头浮动层 start-->
<input type="hidden" id="method" />
<input type="hidden" id="isaddversion"/>
<div id="destContent"/>
<div class="Absolute BHeaderLayer Bgfff">
	<div class="BHeaderLayerTit FL BHeaderLayerW ">
		<span id="spanTitle" class="cBlue FontYahei FS16 PL15  FL"></span>
		<img src="images/O_40.jpg" class="FR MT10 MR10" style="cursor: hand;"
			onclick="javascript:closeMaint4Win('<%=btnid%>');" />
	</div>
	<div class="BLayerLeft"  style="height: 356px;overflow: auto;" >
		<table width="400" border="0" align="center" cellpadding="0"
			cellspacing="0" class="MLeft15 FL"   id="w_chedktable">
			<tr>
				<td width="75" height="25" align="left" valign="top">
					<strong><%=SystemEnv.getHtmlLabelName(1976,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" valign="top">
					<input type="text" name="companyname" id="companyname"
						class="OInput3 BoxW300" readonly="true" onfocus="this.blur();" /> 
				</td>
			</tr>
			<tr>
				<td height="25" align="left" valign="top">
					<strong><%=SystemEnv.getHtmlLabelName(30945,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" valign="top">
					<input type="text" name="licensename" id="licensename" class="OInput2 BoxW279" readonly  onblur="checkimg(this),showTb(this)"  maxlength="40" />
					<img src="images/O_45.jpg" class="ML5" style="margin-bottom: -3px;cursor:hand" onclick="onLicenseDivOpen()"  id="see_img" />
					<span id="newimg"><img src="images/O_44.jpg" iswarn="warning" class="ML5" style="margin-bottom: -3px;"  /></span>
					<input type="hidden" id="licenseaffixid" />
				</td>
			</tr>
			<tr style="display:none;">
				<td height="25" align="left" valign="top">
					<strong><%=SystemEnv.getHtmlLabelName(31133,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" valign="top">
					<input type="text" name="registeraddress" id="registeraddress"
						class="OInput2 BoxW300"  maxlength="40" />
				</td>
			</tr>
			<tr style="display:none;">
				<td height="25" align="left" valign="top">
					<!-- 法人 -->
					<strong><%=SystemEnv.getHtmlLabelName(23797,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" valign="top">
						<input type="text" name="corporation" id="corporation" class="OInput2 BoxW300"  maxlength="40"   onblur="displayimg(this)"/>
							<img src="images/O_44.jpg" iswarn="warning" class="ML5" style="margin-bottom: -3px;" />
				</td>
			</tr>
			<tr>
				<td height="25" align="left" valign="top">
					<strong>注册号：</strong>
				</td>
				<td height="25" align="left" valign="top">
					<!-- 文号 -->
					<input type="text" name="recordnum" id="recordnum" class="OInput2 BoxW300"  maxlength="40"   onblur="displayimg(this)"/>
						<img src="images/O_44.jpg" iswarn="warning" class="ML5" style="margin-bottom: -3px;" />
				</td>
			</tr>
			<tr>
				<td height="25" align="left" valign="top">
					<!-- 有效日期 -->
					<strong><%=SystemEnv.getHtmlLabelName(31029,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" >

				
					<BUTTON class="Clock"  type="button"  onclick="onShowDate_2(document.getElementById('usefulbegindate01'),document.getElementById('begintime'))"></BUTTON>
					<input type="hidden" name="begintime"   id="begintime" />
					<SPAN id="usefulbegindate01">	
						<img src="images/O_44.jpg"   class="ML5" style="display: none"/>
					</SPAN>
					-&nbsp;&nbsp;
					<BUTTON class="Clock"  type="button"   onclick="onShowDate_2(document.getElementById('usefulenddate'),document.getElementById('endtime'))"></BUTTON>
					<input type="hidden" name="endtime"  id="endtime" />
					<SPAN id="usefulenddate" >	
							&nbsp;
						<img src="images/O_44.jpg"   class="ML5" style="display: none;" />
					</SPAN> 
						
					
					
				</td>
			</tr>
			<tr>
				<td height="25" align="left" valign="top">
					
					<strong><%=SystemEnv.getHtmlLabelName(26852,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" valign="top">
					<!-- 有效期限 -->
					<input type="text" name="usefulyear" id="usefulyear"
						class="OInput2 BoxW30"  maxlength="3"     onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  onpaste="javascript: return false;" />
					&nbsp;<%=SystemEnv.getHtmlLabelName(26577,user.getLanguage())%>
		
				</td>
			</tr>
			<tr>
				<td height="25" align="left" valign="top">
					<strong><%=SystemEnv.getHtmlLabelName(27319,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" valign="top">
					<!-- 发证日期 -->
					 <BUTTON  class="Clock"  type="button"    onclick="onShowDate(document.getElementById('dateinssue'),document.getElementById('inssuedate'))"></BUTTON>
					<input type="hidden" id="inssuedate" name="inssuedate"  />
					<span id="dateinssue">
						<img src="images/O_44.jpg"   class="ML5" style="margin-bottom: -3px;" />
					</span>
					
					
				</td>
			</tr>
			<tr>
				<td height="25" align="left" valign="top">
					<strong><%=SystemEnv.getHtmlLabelName(31030,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" valign="top">
				<!-- 年检日期 -->
				
				<BUTTON type="button" class=Clock  onclick="onShowDate_2(document.getElementById('annualinspection'),document.getElementById('annualdate'))"></BUTTON>
					<input type="hidden" name="annualdate"   id="annualdate" >
					<span id="annualinspection">
						<img src="images/O_44.jpg"   class="ML5" style="margin-bottom: -3px;display: none;" />
					</span>
				</td>
			</tr>
			<tr>
				<td height="25" align="left" valign="top">
					<strong><%=SystemEnv.getHtmlLabelName(31031,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" valign="top" class="PB5">
					<!-- 经营范围 -->
					<textarea name="scopebusiness" id="scopebusiness"
						class="OInput2 BoxW300" onblur="displayimg(this)"></textarea>
						<span >
						<img src="images/O_44.jpg" iswarn="warning" class="ML5" style="margin-bottom: -3px;" />
					  </span>
				</td>
			</tr>
			<tr>
				<td height="25" align="left" valign="top">
					<strong><%=SystemEnv.getHtmlLabelName(125912,user.getLanguage())%>：</strong>
				</td>
				<td height="25" align="left" valign="top">
					<input type="text" name="departinssue" id="departinssue"
						class="OInput2 BoxW300" onblur="displayimg(this)"  maxlength="40" />
					<img src="images/O_44.jpg" iswarn="warning" class="ML5" style="margin-bottom: -3px;" />
				</td>
			</tr>
		</table>
		<div id="businessOnlyDiv" class="Border3 PL15 FL PTop5 PB5" style="display:none">
			<table width="420" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="72" height="25" align="left" valign="middle">
						<strong><%=SystemEnv.getHtmlLabelName(20668,user.getLanguage())%>：</strong>
					</td>
					<td width="80" align="left" valign="middle">
						<!-- 注册资本 -->
						<input type="text" name="registercapital" id="registercapital"
							class="OInput2 BoxW60"  onblur="displayimg(this)" />
						<span >
						<img src="images/O_44.jpg" iswarn="warning"  align='absMiddle'/>
					  </span>
					  
					</td>
					<td width="70" align="left" valign="middle">
						<strong><%=SystemEnv.getHtmlLabelName(31032,user.getLanguage())%>：</strong>
					</td>
					<td align="left" valign="middle">
						<!-- 实收资本 -->
						<input type="text" name="paiclupcapital" id="paiclupcapital"
							class="OInput2 BoxW60"   onblur="displayimgNext(this)" />
						<span >
						<img src="images/O_44.jpg" iswarn="warning" class="ML5"  align='absMiddle' />
					  </span>
					  &nbsp;
					  <strong><%=SystemEnv.getHtmlLabelName(406,user.getLanguage())%>：</strong>
					  <%
				String DefaultCurrency=ProTransMethod.getDefaultCurrency();
				if(null!=DefaultCurrency&&DefaultCurrency.indexOf(",")!=-1){
		 %>
					<!-- 货币 -->
							<button  id=cu_idH  class="Browser"  onclick="onCurrOpen(this)" type="button"/>
							<span  id="currencyname" >
								<%=DefaultCurrency.split(",")[1] %>
							</span>
							<input type="hidden"   id="currencyid"   value="<%=DefaultCurrency.split(",")[0] %>""/>
							<span>
							
							</span>
			<%
				}else{
			%>
						<!-- 货币 -->
							<button  id=cu_idH  class="Browser"  onclick="onCurrOpen(this)" type="button"/>
							<span  id="currencyname" >
							</span>
							<input type="hidden"   id="currencyid" />
							<span>
							<img src="images/O_44.jpg" iswarn="warning"  align='absMiddle'/>
							</span>
			<%
				}
			 %>
					</td>
				</tr>
				<tr>
					<td height="25" align="left" valign="middle">
						<strong><%=SystemEnv.getHtmlLabelName(20656,user.getLanguage())%>：</strong>
					</td>
					<td align="left" valign="middle">
						<!-- 法人代表 -->
						<input type="text" name="corporatdelegate" id="corporatdelegate"
							class="OInput2 BoxW60"  onblur="displayimg(this)"/>
							<span >
							<img src="images/O_44.jpg" iswarn="warning" class="ML5"   align='absMiddle'/>
						 </span>
							
					</td>
					<td align="left" valign="middle">
						<strong><%=SystemEnv.getHtmlLabelName(30976,user.getLanguage())%>：</strong>
					</td>
					<td align="left" valign="middle">
						<!-- 公司类型 -->
						<input type="text" name="companytype" id="companytype"
							class="OInput2 BoxW120"  onblur="displayimg(this)"/>
							<span >
							<img src="images/O_44.jpg" iswarn="warning" class="ML5" align='absMiddle'/>
						 </span>
							
					</td>
				</tr>
				<tr>
					<td height="25" colspan="4" align="left" valign="middle">
						<!-- 营业执照注册号 -->
						<strong>
						<%=SystemEnv.getHtmlLabelName(23798,user.getLanguage())%>： 
						</strong>
							<input type="text" name="licenseregistnum" id="licenseregistnum" class="OInput2 BoxW271"   onblur="displayimg(this)"/> 
							<span >
								<img src="images/O_44.jpg" iswarn="warning" class="ML5" align='absMiddle' />
							 </span>
							
					</td>
				</tr>
			</table>
		</div>
		<table width="400" border="0" align="center" cellpadding="0"
			cellspacing="0" class="MLeft15 FL MT10">
			<tr>
				<td width="75" height="55" align="left" valign="top">
					<strong><%=SystemEnv.getHtmlLabelName(17616,user.getLanguage())%>：</strong>
				</td>
				<td align="left" valign="top">
				
				
				<%if(!CompanyInfoTransMethod.CheckPack("1")){out.println("<span style='color:red'>"+SystemEnv.getHtmlLabelName(31004,user.getLanguage())+"！</span>");}%>
					<div id="licenseAffixUpload"  >
					<input type="hidden" name="affixdoc" id="affixdoc">
						<span> 
							<span id='spanButtonPlaceHolder'></span><!--选取多个文件-->
							<!-- <img src="images/O_44.jpg" iswarn="warning" class="ML5" style="margin-bottom: -3px;" /> -->
						</span>
						&nbsp;&nbsp;
						<span style="color: #262626; cursor: hand; TEXT-DECORATION: none;<%if(!CompanyInfoTransMethod.CheckPack("1")){out.println("display: none;");}%>"
							disabled id="btnCancel_upload" >
							<span><img src="/js/swfupload/delete.gif" border="0" onClick="oUploader.cancelQueue()"> </span> <span
							style="height: 19px"> <font style="margin: 0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage()) %>
							
							(<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage()) %>100<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage()) %>)
							</font> <!--清除所有--> </span> </span>
						<div id="divImgsAddContent" style="overflow: auto;">
							<div></div>
							<div class="fieldset flash" id="fsUploadProgress"></div>
							<div id="divStatus"></div>
						</div>
						
						<span  id="_fximg">
								<img src='/images/BacoError.gif' align=absMiddle  >
						 </span>
					</div>
					<div id="affixcpdosDIV">
						<%
							String isdoc="";
							if(!"".equals(affixdoc))
							{
								DocComInfo dc=new DocComInfo();
								String[] slaves=affixdoc.split(",");
								for(int i=0;i<slaves.length;i++)
								{
									String tempid="asid"+slaves[i];

									out.println("<div id='imgfileDiv"+i+"' style='background-color: #F7F7F7;width:291px;height:20px;padding-left:4px;border: solid 1px #E8E8E8;padding: 4px;margin-bottom: 5px;' class='progressWrapper'>");

								    String ispdf02="";
									String filename="";
									String fileid="";
									rs.execute("select imagefileid,imagefilename from imagefile where imagefileid = "+slaves[i]);
									if(rs.next()){
										ispdf02="";
										filename = rs.getString("imagefilename");
										fileid= rs.getString("imagefileid");
										if(filename.substring(filename.lastIndexOf("."),filename.length()).equalsIgnoreCase(".pdf")){
											ispdf02 = "1";
										}else if(filename.substring(filename.lastIndexOf("."),filename.length()).equalsIgnoreCase(".jpg")
											|| filename.substring(filename.lastIndexOf("."),filename.length()).equalsIgnoreCase(".bmp")
											|| filename.substring(filename.lastIndexOf("."),filename.length()).equalsIgnoreCase(".jpeg")
											|| filename.substring(filename.lastIndexOf("."),filename.length()).equalsIgnoreCase(".png")
											){
												ispdf02 ="0";
											}else{
												ispdf02 ="2";
											}
									}
									out.println("<div style='width:80%;float:left;' >");
									String str="<A id='pdflinkid"+i+"' href='javascript:changePDF("+fileid+","+ispdf02+")' class='aContent0 FL'>"+filename+"</A>";
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

									//if(dc.getDocCreaterid(slaves[0]).equals(userid+""))//当前用户是文档的创建者
									if(	"viewBtn".equals(btnid))
									{
									// document.location.href="/weaver/weaver.file.FileDownload?fileid="+files+"&download=1&coworkid="+coworkid;

										//输出下载文档超链接
										out.println("<a href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1'><img src='images/downLoadPic.gif'  title='"+SystemEnv.getHtmlLabelName(22629,user.getLanguage())+"'  ></a>");

									}else//编辑
									{
										//输出删除文档超链接
										//isdoc = "affixdoc";
										out.println("<a href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1'><img src='images/downLoadPic.gif'  title='"+SystemEnv.getHtmlLabelName(22629,user.getLanguage())+"'  ></a>");
										out.println("<img src='images/delwk.gif' onclick=delImg(document.getElementById('imgfileDiv"+i+"'),"+slaves[i]+") title='"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"'></a>");
									}

									out.println("</div>");
									out.println("</div>");
								}
							}


						%>
					</div>
				
				</td>
			</tr>
			<tr>
				<td height="20" align="left" valign="top">
					<strong><%=SystemEnv.getHtmlLabelName(20820,user.getLanguage()) %>：</strong>
				</td>
				<td height="20" align="left" valign="top">
					<input type="text" name="memo" id="memo" class="OInput2 BoxW300" />
				</td>
			</tr>
			
			<tr>
				<td height="20" align="left" valign="top">
					<ul class="BContRightMsg2 FR PR10 PTop10">
						<li>
								<!--  
							<a href="javascript:onWorkflowDivOpen();" class="hover"><div>
									<div>
										相关附件
									</div>
								</div> </a>
								-->
						</li>
					</ul>
				</td>
				<td height="20" align="left" valign="bottom">
					<span id="workflowspan"></span>
					<input type="hidden" name="affixIds" id="affixIds" /> 
					<input type="hidden" name="requestid" id="requestid"  />
					<input type="hidden" name="requestname" id="requestname"  /> 
					<input type="hidden" name="isNeedReSearch" id="isNeedReSearch" value="N" /> 
					<input type="hidden" name="versionId" id="versionId" /> 
					<input type="hidden" name="isReEdit" id="isReEdit" value="N"/>
					<input type="hidden" name="affixidsReEdit" id="affixidsReEdit" />
				</td>
			</tr>
		</table>
		
	</div>
	<div class="BLayerRight2 FL">
	 <% if(!"".equals(ispdf)){ %>
	 <div id="source" style="width:400px;height:300px;position: absolute;left:518px;">
			<iframe src="/cpcompanyinfo/PdforImgShow/PdforImgindex.jsp?sjdata=<%=sjdata %>&imgid=<%=imgid%>&ispdf=<%=ispdf %>"   frameborder=no  scrolling="no"  style="width:400px;height:300px;">
			</iframe>
		</div>
		<div id="_s2uiContent" style="height:50px;width:399px;position: absolute;left:518px;top:370px;">
			<jsp:include page="select2UISlider.jsp" flush="true">
			</jsp:include>
		</div>
		<%} else{}%>
		<div style="height:50px;width:399px;position: absolute;left:518px;top:370px;">
		    <span   class="newLISapn2" >
				<a href="javascript:openVersionManage();" id="versionManage" class="hover">
						<%=SystemEnv.getHtmlLabelName(19450,user.getLanguage()) %>	
				</a>
			</span>	
		
			<span   class="newLISapn2" id="save_H"  >
				 <a href="javascript:void(0);" id="saveLicenseBtn" class="hover">
					<%=SystemEnv.getHtmlLabelName(31005,user.getLanguage()) %>	
				</a>
			</span>
            <span   class="newLISapn2" id="save_Q"   >
				 <a href="javascript:void(0);" id="saveLicenseBtnQ" class="hover">
                     保存
                 </a>
			</span>

<%
if( "newBtn".equals( btnid)||("editBtn".equals(btnid)&&"implicenseBtn".equals(myfrom))){
%>
                    <span   class="newLISapn2" id="impLicenseSpan"  >
                    <a href="javascript:impLicense();" id="impLicenseBtn" class="hover">
                        引用
                    </a>
                    </span>
            <%
                }

            %>


		</div>
	</div> 
</div>

<!-- 证照弹出层 -->

<div style="clear:both;display:none" id="licenseDiv">
	<div id="wBox" style="top:80px;left:400px;"><!-- 定义层在什么位置上 -->
		<div class="wBox_popup">
    		<table>
    			<tbody>
    				<tr><td class="wBox_tl"/><td class="wBox_b"/><td class="wBox_tr"/></tr>
    				<tr><td class="wBox_b"></td>
    					<td>
		   					<div class="wBox_body">
		       					<table class="wBox_title">
		       						<tr>
		          						<td class="wBox_dragTitle"><div class="wBox_itemTitle"><%=SystemEnv.getHtmlLabelName(31006,user.getLanguage()) %>	</div></td>
		          						<td width="20px" title="关闭" onclick="javascript:onLicenseDivClose();"><div class="wBox_close"></div></td>
		       						</tr>
		     					</table>
		     					<div class="wBox_content" id="wBoxContent" style="width:335px;height:325px;overflow-y:auto;">
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
</form>
 <!-- 遮罩层 start -->
<div id='wBox_overlay' class='wBox_hide' style="clear:both;"></div>
<!-- 遮罩层 end --> 
<a href=""  id="load_img"></a>
<script language="javascript">

	/*打开币种DIV*/
	function onCurrOpen(obj){
		var tempid= window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/CurrencyBrowser.jsp");
		if(tempid){
			if(tempid.name){
				jQuery(obj).next().html(tempid.name);
				jQuery(obj).next().next().val(tempid.id);
				jQuery(obj).next().next().next().html("");
			}else{
				jQuery(obj).next().html("");
				jQuery(obj).next().next().val("");
				jQuery(obj).next().next().next().html("<img src=\"images/O_44.jpg\" iswarn=\"warning\"  align='absMiddle'/>");
			}
		}else{
			
		}
		//alert(tempid.id);
		//alert(tempid.name);
	}
	
function checkimg(obj){
		if($.trim($(obj).val())==""){
				$("#newimg").html("<img src='images/O_44.jpg' iswarn='warning' class='ML5' style='margin-bottom: -3px;'  />");
		}else{
				$("#newimg").html("");
				
		}
}
var upfilesnum=0;//计数器
var oUploader;//一个SWFUpload 实例
var mode="add";//当期模式

var settings = {   
	
	flash_url : "/js/swfupload/swfupload.swf",     
	upload_url: "/cpcompanyinfo/action/uploaderOperate.jsp",
	post_params: {
                "mainId": "-1",
                "subId":"-1",
                "secId":"-1"
            },
	file_size_limit :"100MB",							//单个文件大小
	file_types : "*.*;", 	//过滤文件类型
	file_types_description : "所有文件",					//描述，会添加在类型前面
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
	button_height: <%if(!CompanyInfoTransMethod.CheckPack("1")){out.println("0");}else{out.println("18");}%>,//“上传”按钮的高度
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
			document.getElementById("affixdoc").value += imageid +",";
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


var timer = setInterval(showmustinput , 400);
function showmustinput() {
			var _temp=0;
			var t_length=$(".progressWrapper").each(function(){
						//obj.css("display")=="none"
						//alert($(this).css("display"));
						if($(this).css("display")=="block"){
							_temp++;
						}
			});
			if(_temp>0){
				   $("#_fximg").hide();
			}else{
				   $("#_fximg").show();
			}
         /*  var sta = oUploader.getStats();
          if (sta.files_queued == 0) {
             $("#obj").html("<img src='/images/BacoError.gif' align=absMiddle>");
          } else {
             $("#obj").html("");
          } */
         
}
function showTb(obj){

	if("<%=btnid%>"=="newBtn")
	{
	//31412
	var o4params = {
				licensename:encodeURI($.trim(obj.value+"")),
				method:"haved",
				companyid:"<%=companyid%>",
				judgetype:"1"
			}
	jQuery.post("/cpcompanyinfo/action/CPLicenseOperate.jsp",o4params,function(data){
		var datasz=data.split("_");
		if(datasz[0]=="haved"){
			//所选证照已在该公司存在
			jQuery("#licenseaffixid").val(datasz[1]);//获得该证照类型的id
			alert("<%=SystemEnv.getHtmlLabelName(31027,user.getLanguage())%>！");
			jQuery("#newimg").html("<img src='images/O_44.jpg' iswarn='warning' class='ML5' style='margin-bottom: -3px;'  />");
			jQuery("#licensename").val("");
			jQuery("#saveLicenseBtn").css("display","none");
			jQuery("#saveLicenseBtnQ").css("display","none");

			jQuery("#businessOnlyDiv").css("display","none");
				
		}else{
		
				jQuery("#licenseaffixid").val(datasz[1]);//获得该证照类型的id
				if($.trim(obj.value)!=""){
				jQuery("#newimg").html("");
				}
				jQuery("#saveLicenseBtn").css("display","");
				jQuery("#saveLicenseBtnQ").css("display","");

				if($.trim(obj.value)=="<%=SystemEnv.getHtmlLabelName(31412,user.getLanguage())%>"){
					jQuery("#businessOnlyDiv").css("display","");
				}else{
						jQuery("#businessOnlyDiv").css("display","none");
				}
		}
	});
	}
}
function impLicense(){
    var data=window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/cpcompanyinfo/newpage/CompanyLicenseBrowser.jsp?companyid=<%=companyid %>");
    if(data){
        if(data.id>0){
            jQuery("#wBoxContent").load("/cpcompanyinfo/CompanyBusinessLicenseMaint.jsp?myfrom=implicenseBtn&btnid=editBtn&companyid=<%=companyid %>&licenseid="+data.id+"&showOrUpdate=1");

        }else{
            init_license();
            //jQuery("#wBoxContent").load("/cpcompanyinfo/CompanyBusinessLicenseMaint.jsp?btnid=newBtn&companyid=<%=companyid %>");
        }

    }
}
    jQuery(function(){
        var myfrom='<%=myfrom %>';
        if(myfrom=="implicenseBtn"){
            displayimg(jQuery("#recordnum")[0]);
        }

    });
</script>

