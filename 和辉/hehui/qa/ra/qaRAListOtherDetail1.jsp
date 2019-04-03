<!DOCTYPE html>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<HTML><HEAD>
<%
	String mainid = Util.null2String(request.getParameter("mainid"));
	String radetailid = Util.null2String(request.getParameter("mainid"));
	String accsize ="20";
	String accsec="9";//目录
%>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<LINK href="/wui/theme/ecology8/jquery/js/e8_zDialog_btn_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/swfupload_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/swfupload.queue_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/fileprogress_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/handlers_wev8.js"></script>
<SCRIPT>
	function changeColorx(bttID){
		var bttSptID = "#btt" + bttID;
		var ztdID = "#ztd_x" ;
		var bttSpt = jQuery(bttSptID);
//		alert("1 = " + bttSpt.attr("class"));
//		alert("2 = " + bttSpt.text());
		if(jQuery(bttSptID).attr("class") == 'btnNormal'){
			jQuery(bttSptID).removeClass("btnNormal");
			jQuery(bttSptID).addClass("btnException");
			jQuery(bttSptID).text("异 常");
			jQuery(ztdID).val("1");
		}else if(jQuery(bttSptID).attr("class") == 'btnException'){
			jQuery(bttSptID).removeClass("btnException");
			jQuery(bttSptID).addClass("btnNormal");
			jQuery(bttSptID).text("正 常");
			jQuery(ztdID).val("0");
		}	
	}
	// 计算截止目前时间
	function calStx(){
		// 获取上次量测日期和时间
		var lstDate = jQuery("#scclsj").val();
		var lstTime = jQuery("#scclsj1").val();
		// 获取 上次量测时数
		var sccls =  jQuery("#sccls").val();
		if(sccls=='' ) sccls = "0";
		// jzsj  截止目前时间(实时计
		if(lstDate == "" || lstTime == ""){
			 jQuery("#jzsj").val(sccls);
			 return;
		}
		var time1 = new Date(lstDate + " " + lstTime);
		var nowTime = new Date();    //结束时间  
    		var date3 = nowTime.getTime() - time1.getTime();   //时间差的毫秒数
    		//计算出相差小时数
    		var hours = Math.floor(date3/(3600*1000));
    		var resHours = parseInt(hours) + parseInt(sccls);
 		jQuery("#jzsj").val(resHours);
		
	}
	
	// 计算下次量测时间
	function calSt(){
		// 获取上次量测日期和时间
		var lstDate = jQuery("#scclsj").val();
		var lstTime = jQuery("#scclsj1").val();
		// 获取 量测小时数
		var clxss =  jQuery("#clxss").val();
		// 综合赋值  xxx12    日期： yjcl   时间： yjcl1
		if(lstDate == "" || lstTime == ""){
			 jQuery("#xxx12").val("");
			 jQuery("#yjcl").val("");jQuery("#yjcl1").val("");
			 return;
		}
		if(clxss == "" || clxss == "0"){
			jQuery("#xxx12").val(lstDate + " " + lstTime);
			 jQuery("#yjcl").val(lstDate);jQuery("#yjcl1").val(lstTime);
			 return;
		}
		// 日期计算
		var time1 = new Date(lstDate + " " + lstTime);
//		alert("time1 = " + time1.toLocaleString());
		var time2 = new Date(time1.valueOf() + clxss*60*60*1000);
//		alert("time2 = " + time2.toLocaleString());
		
		var year = time2.getFullYear();//当前年份
		var month = time2.getMonth() + 1;//当前月份
		var day = time2.getDate();//当前日
		var hours = time2.getHours();       //获取当前小时数(0-23)
		var minute = time2.getMinutes();     //获取当前分钟数(0-59)
		var htDate = year + "-";
		if(month < 10){
			htDate = htDate + "0" + month + "-";
		}else{
			htDate = htDate + month + "-";
		}
		if(day < 10){
			htDate = htDate + "0" + day;
		}else{
			htDate = htDate + day;
		}
		var htTime = "";
		if(hours < 10){
			htTime = htTime + "0" + hours + ":";
		}else{
			htTime = htTime + hours + ":";
		}
		if(minute < 10){
			htTime = htTime + "0" + minute;
		}else{
			htTime = htTime + minute;
		}
		jQuery("#xxx12").val(htDate + " " + htTime);
		jQuery("#yjcl").val(htDate);jQuery("#yjcl1").val(htTime);
	}
	
	// 重新计算 fail  总片数
	function calFailAll(){
		var allNum = 0;
		var failNum = 0;
		var baseFd = "#ztd_";
		for(var index = 0; index < 500;index++){
			var tmpFd = baseFd + index;
			if(jQuery(tmpFd).length > 0){
				allNum = allNum + 1;
				var tmpVal = jQuery(tmpFd).val();
				// 异常状态
				if(tmpVal == "1"){
					failNum = failNum + 1;
				}
			}else{
				index = 500;
			}
		}
		// 结束后 赋值
		jQuery("#FAILps").val(failNum);
		jQuery("#FAILbl").val(failNum);
		jQuery("#FAILbl1").val(allNum);
		
	}
	
	function changeColor(bttID){
		var bttSptID = "#btt" + bttID;
		var ztdID = "#ztd_" + bttID;
		var bttSpt = jQuery(bttSptID);
//		alert("1 = " + bttSpt.attr("class"));
//		alert("2 = " + bttSpt.text());
		var zt_val = "";
		if(jQuery(bttSptID).attr("class") == 'btnNormal'){
			jQuery(bttSptID).removeClass("btnNormal");
			jQuery(bttSptID).addClass("btnException");
			jQuery(bttSptID).text("异 常");
			jQuery(ztdID).val("1");
			zt_val = "1";
		}else if(jQuery(bttSptID).attr("class") == 'btnException'){
			jQuery(bttSptID).removeClass("btnException");
			jQuery(bttSptID).addClass("btnNormal");
			jQuery(bttSptID).text("正 常");
			jQuery(ztdID).val("0");
			zt_val = "0";
		}
		
		var urlx = "/hehui/qa/ra/qaRADetailInfo.jsp?uf=update&ztd="+zt_val +"&dtid=" + bttID +"&mainid=<%=mainid%>";
	//	alert("urlx = " + urlx);
		$.get(urlx,function(data,status){
		//	alert("Data: " + data + "\nStatus: " + status);
			if(data != "1"){
				 jQuery("#tableChlddiv").html(data);
				 calFailAll();
			}
		});
	}
	var diag_vote;
	function edtitem(bttID){
		var title = "";
		var url = "/hehui/qa/ra/lqOperLoad.jsp?id="+bttID;
		
		diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1000;
		diag_vote.Height = 370;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
	}
	
	function closeDialog(){
		diag_vote.close();
	}
	
	function addPan(){
		var nz1 = jQuery("#nz1").val();
		var nz2 = jQuery("#nz2").val();
		var ztd = jQuery("#ztd_x").val();
		if(nz2 == ''){
			 jQuery("#nz2").val(' PANELID');
		}else{
			 jQuery("#nz1").val(" DEMONO");
			var urlx = "/hehui/qa/ra/qaRADetailInfo.jsp?uf=add&ztd="+ztd+"&nz1="+nz1 + "&nz2=" + nz2+"&mainid=<%=mainid%>";
		//	alert("urlx = " + urlx);
			$.get(urlx,function(data,status){
		//		alert("Data: " + data + "\nStatus: " + status);
				if(data != "1"){
					 jQuery("#tableChlddiv").html(data);
					 calFailAll();
				}
			});
		}
	}
	
	function delitem(bttID){
	//	alert("delitem = " + bttID);
		if(window.confirm('你是确认删除？')){
			var urlx = "/hehui/qa/ra/qaRADetailInfo.jsp?uf=del&dtid="+bttID+"&mainid=<%=mainid%>";
	//		alert("urlx = " + urlx);
			$.get(urlx,function(data,status){
			//	alert("Data: " + data + "\nStatus: " + status);
				 jQuery("#tableChlddiv").html(data);
				 calFailAll();
			});
		}
	}
</SCRIPT>
<script type="text/javascript">
			var oUpload;
				window.onload = function() {
				  var settings = {
						flash_url : "/js/swfupload/swfupload.swf",
						upload_url: "/proj/data/uploadPrjAcc.jsp",	// Relative to the SWF file
						post_params: {"method" : "uploadPrjAcc","secid":"<%=accsec %>"},
						file_size_limit : "<%=accsize %> MB",
						file_types : "*.*",
						file_types_description : "All Files",
						file_upload_limit : 100,
						file_queue_limit : 0,
						custom_settings : {
							progressTarget : "fsUploadProgress",
							cancelButtonId : "btnCancel"
						},
						debug: false,
						 

						// Button settings
						
						button_image_url : "/js/swfupload/add_wev8.png",	// Relative to the SWF file
						button_placeholder_id : "spanButtonPlaceHolder",
		
						button_width: 100,
						button_height: 18,
						button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,user.getLanguage())%></span>',
						button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
						button_text_top_padding: 0,
						button_text_left_padding: 18,
							
						button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
						button_cursor: SWFUpload.CURSOR.HAND,
						
						// The event handler functions are defined in handlers.js
						file_queued_handler : fileQueued,
						file_queue_error_handler : fileQueueError,
						file_dialog_complete_handler : fileDialogComplete_1,
						upload_start_handler : uploadStart,
						upload_progress_handler : uploadProgress,
						upload_error_handler : uploadError,
						upload_success_handler : uploadSuccess,
						upload_complete_handler : uploadComplete,
						queue_complete_handler : queueComplete	// Queue plugin event
					};
						try{
						oUpload = new SWFUpload(settings);
					} catch(e){alert(e)}
				}
				
				function fileDialogComplete_1(){
					document.getElementById("btnCancel1").disabled = false;
					fileDialogComplete
				}
				
				function uploadSuccess(fileObj,serverdata){
					var data=eval(serverdata);
					//alert(data);
					if(data){
						var a=data;
						if(a>0){
							if(jQuery("#yctp").val() == ""){

								jQuery("#yctp").val(a);
							}else{
							
								jQuery("#yctp").val(jQuery("#yctp").val()+","+a);
							}
						}
					}
					//alert("scx"+jQuery("#scx").val());
				}
				function uploadComplete(fileObj) {
					try {
						/*  I want the next upload to continue automatically so I'll call startUpload here */
						if (this.getStats().files_queued === 0) {
								weaver.submit();
							document.getElementById(this.customSettings.cancelButtonId).disabled = true;
						} else {	
							this.startUpload();
						}
					} catch (ex) { this.debug(ex); }
		
				}
			</script>
	<style type="text/css">
		.td_warp {
			width:95%;
			display: inline-block;
			text-align: center;
			height:33px;
			line-height: 33px;
			background-color:rgb(16,160,234);
			float:left;
			margin-bottom:3%;
			color:rgb(255,255,255);
		}
		.td_warp_new {
			width:95%;
			display: inline-block;
			text-align: center;
			height:33px;
			line-height: 33px;
			background-color: #009100;
			float:left;
			margin-bottom:3%;
			color:rgb(255,255,255);
		}
		
		.warp_cont{
			height:30px;
			width:90%;
			line-height: 25px;
		}
		
		.det_cont{
			border: 1px solid #10A0EA;
			height:30px;
			width:85%;
			line-height: 25px;
	/*		color:rgb(255,255,255);*/
		/*	background-color:#10A0EA; */
		}
		
		.det1_cont{
			border: none;
			width:170px;
			height:29px;
			line-height: 26px;
			color:#ADADAD;
		}
		.btnSummbit{  
			background-color:#10A0EA;  
			border:none;  
			height:60px;  
			color:white;  
			font-size:24px;  
			width:100px  
		}  
		
		.div_input{
			width:97%;
		/*	 background-color:#10A0EA; */
		 	 position:relative;
    		}
		
		.warp{
			width:97%;
		}
		.title{
			margin:2% auto;
			text-align: center;
		}
		
		.btnNormal{  
			background-color:#009100;  
			border:none;  
			height:30px;  
			color:white;  
			font-size:12px;  
			width:55px  
		}  
		.btnException{  
			background-color:#EA0000;  
			border:none;  
			height:30px;  
			color:white;  
			font-size:12px;  
			width:55px  
		} 
		
	</style>
</head>
<%


	if(mainid.length() < 1){
		return;
	}
	String syxm = ""; //实验项目
	String xplx = ""; //样品类型
	String CG = ""; //CG
	String ypsl = ""; //样品数量
	String xcsj = ""; //需测时间hr
	String wd = ""; //温度C
	String sd = ""; //湿度%RH
	String syjg = ""; //实验结果
	String tj = ""; //条件
	String mdcs = ""; //每点次数/次
	String qsdy = ""; //起始电压KV
	String jsdy = ""; //结束电压KV
	String clwz = ""; //测试位置
	String dj = ""; //等级
	String sdms = ""; //上电模式
	String syzt = ""; //实验状态
	String cscode = ""; //测试code
	String Tpcode = ""; //TP code
	String jzsj = ""; //截止目前时间（实时计算HR）
	String lh = ""; //炉号
	String sctrsj = ""; //首次投入时间
		String sctrsj1 = "";
	String scclsj = ""; //上次量测时间
		String scclsj1 = "";
	String clxss = ""; //量测小时数
	String yjcl = ""; //预计下次量测时间
		String yjcl1 = "";
	String yjwc = ""; //预计完成时间
		String yjwc1 = "";
	String sjsj = ""; //实际完成时间
		String sjsj1 = "";
	String sccls = ""; //上次量测时数
	String FAILps = ""; //FAIL片数
	String FAILbl = ""; //FAIL比例
		String FAILbl1 = "";
	String x = ""; //FA解析报告
	String yctp = ""; //异常图片
	String nz = ""; //备注
	
	RecordSet.executeSql("select * from uf_ycjm where id = " + mainid);
	if(RecordSet.next()){
		syxm = Util.null2String(RecordSet.getString("syxm")); //实验项目
		xplx = Util.null2String(RecordSet.getString("xplx")); //样品类型
		CG = Util.null2String(RecordSet.getString("CG")); //CG
		ypsl = Util.null2String(RecordSet.getString("ypsl")); //样品数量
		xcsj = Util.null2String(RecordSet.getString("xcsj")); //需测时间hr
		wd = Util.null2String(RecordSet.getString("wd")); //温度C
		sd = Util.null2String(RecordSet.getString("sd")); //湿度%RH
		syjg = Util.null2String(RecordSet.getString("syjg")); //实验结果
		tj = Util.null2String(RecordSet.getString("tj")); //条件
		mdcs = Util.null2String(RecordSet.getString("mdcs")); //每点次数/次
		qsdy = Util.null2String(RecordSet.getString("qsdy")); //起始电压KV
		jsdy = Util.null2String(RecordSet.getString("jsdy")); //结束电压KV
		clwz = Util.null2String(RecordSet.getString("clwz")); //测试位置
		//dj = Util.null2String(RecordSet.getString("dj")); //阻容套件电容
		sdms = Util.null2String(RecordSet.getString("sdms")); //上电模式
		syzt = Util.null2String(RecordSet.getString("syzt")); //实验状态
		cscode = Util.null2String(RecordSet.getString("cscode")); //测试code
		Tpcode = Util.null2String(RecordSet.getString("Tpcode")); //TP code
		jzsj = Util.null2String(RecordSet.getString("jzsj")); //截止目前时间（实时计算HR）
		lh = Util.null2String(RecordSet.getString("lh")); //炉号
		sctrsj = Util.null2String(RecordSet.getString("sctrsj")); //首次投入时间
			sctrsj1 = Util.null2String(RecordSet.getString("sctrsj1"));
		scclsj = Util.null2String(RecordSet.getString("scclsj")); //上次量测时间
			scclsj1 = Util.null2String(RecordSet.getString("scclsj1")); 
		clxss = Util.null2String(RecordSet.getString("clxss")); //量测小时数
		yjcl = Util.null2String(RecordSet.getString("yjcl")); //预计下次量测时间
			yjcl1 = Util.null2String(RecordSet.getString("yjcl1")); 
		yjwc = Util.null2String(RecordSet.getString("yjwc")); //预计完成时间
			yjwc1 = Util.null2String(RecordSet.getString("yjwc1"));
		sjsj = Util.null2String(RecordSet.getString("sjsj")); //实际完成时间
			sjsj1 = Util.null2String(RecordSet.getString("sjsj1"));
		sccls = Util.null2String(RecordSet.getString("sccls")); //上次量测时数
		FAILps = Util.null2String(RecordSet.getString("FAILps")); //FAIL片数
		FAILbl = Util.null2String(RecordSet.getString("FAILbl")); //FAIL比例  计算。。
			FAILbl1 = Util.null2String(RecordSet.getString("FAILbl1"));
		x = Util.null2String(RecordSet.getString("x")); //FA解析报告
		yctp = Util.null2String(RecordSet.getString("yctp")); //异常图片
		nz = Util.null2String(RecordSet.getString("nz")); //备注
	}

	String imagefilename = "/images/hdHRMCard_wev8.gif";
	String titlename = "展示";
	String needfav ="1";
	String needhelp ="";
	String sql = "";
%>
<BODY>

<div align="center">
<!--	<FORM id=weaver name=frmMain action="qaRAListOperation.jsp" method=post> -->
	<FORM id=weaver name=weaver action="/hehui/qa/ra/submit-qaRAListOtherDetail1-info.jsp" method=post enctype="multipart/form-data">
		<input type = "hidden"   value = "<%=yctp%>" id="yctp" name = "yctp"/>
		<input type = "hidden"   value = "<%=radetailid%>" id="radetailid" name = "radetailid"/>
	<div class= "title">
		<h1>作业表单</h1>
	</div>
	<table class="warp">
		<colgroup><col width="8%"/><col width="17%"/><col width="8%"/><col width="17%"/>
					<col width="8%"/><col width="17%"/><col width="8%"/><col width="17%"/></colgroup>
		<tbody>
			<tr>
				<td class="td_warp">实验项目</td>
				<td >
						<%
							String comzb_val = "";
							sql  = "select id,syxm from uf_syxm where id = '" +  syxm +"'";
							RecordSet.executeSql(sql);
							if(RecordSet.next()){
								comzb_val = Util.null2String(RecordSet.getString("syxm"));
							}
						%>
						<%=comzb_val %>
				<!--	<brow:browser viewType="0"  name="syxm" browserValue="<%=syxm%>"
				                browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.uf_syxm"
				              hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
				                 width="120px"
				                linkUrl=""
				                browserSpanValue="">
				         </brow:browser> -->
				</td>
				<td class="td_warp">实验结果</td>
				<td  >
					<select name="syjg">
		    				<option value=-1></option>   
		    				<%
							int syjg_int = -1;
							if(syjg.length() > 0 ) {
								syjg_int = Integer.parseInt(syjg);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='syjg' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
						<option value=<%=tmp_val%>  <%if(syjg_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">实验状态</td>
				<td  >
					<select id = "syzt" name="syzt">
		    				<option value=-1></option>   
		    				<%
							int syzt_int = -1;
							if(sdms.length() > 0 ) {
								syzt_int = Integer.parseInt(syzt);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='syzt' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
							int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
							<option value=<%=tmp_val%>  <%if(syzt_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">样品类型</td> 
				<td  >
					<select name="xplx">
		    				<option value=-1></option>   
		    				<%
							int xplx_int = -1;
							if(xplx.length() > 0 ) {
								xplx_int = Integer.parseInt(xplx);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='xplx' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
						<option value=<%=tmp_val%>  <%if(xplx_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				
			</tr>
			<tr>
			<td class="td_warp">CG</td>
				<td  >
					<select name="CG">
		    				<option value=-1></option>   
		    				<%
							int CG_int = -1;
							if(CG.length() > 0 ) {
								CG_int = Integer.parseInt(CG);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='CG' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
						<option value=<%=tmp_val%>  <%if(CG_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td  class="td_warp">样品数量</td>
				<td >
				<input type = "text" id="ypsl" name="ypsl" value="<%=ypsl%>" class="warp_cont" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
				</td>
				<!--<td  >
					<select name="ypsl">
		    				<option value=-1></option>   
		    				<%
							int ypsl_int = -1;
							if(ypsl.length() > 0 ) {
								ypsl_int = Integer.parseInt(ypsl);
							}
		    					sql = "select disorder,name from mode_selectitempagedetail where  mainid in(18)";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("name"));
								double tmp_val = RecordSet.getDouble("disorder");
		    				%>
						<option value=<%=tmp_val%>  <%if(ypsl_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>-->
				<td class="td_warp">需测时间hr</td>
				<td  >
					<select id = "xcsj" name="xcsj">
		    				<option value=-1></option>   
		    				<%
							int xcsj_int = -1;
							if(xcsj.length() > 0 ) {
								xcsj_int = Integer.parseInt(xcsj);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='xcsj' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
						<option value=<%=tmp_val%>  <%if(xcsj_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">温度℃</td>
				<td  >
					<select name="wd">
		    				<option value=-1></option>   
		    				<%
							int wd_int = -1;
							if(wd.length() > 0 ) {
								wd_int = Integer.parseInt(wd);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='wd' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
						<option value=<%=tmp_val%>  <%if(wd_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				
				
			</tr>
			<tr>
			<td class="td_warp">湿度%RH</td>
				<td  >
					<select name="sd">
		    				<option value=-1></option>   
		    				<%
							int sd_int = -1;
							if(sd.length() > 0 ) {
								sd_int = Integer.parseInt(sd);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='sd' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
						<option value=<%=tmp_val%>  <%if(sd_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">上电模式</td>
				<td  >
					<select name="sdms">
		    				<option value=-1></option>   
		    				<%
							int sdms_int = -1;
							if(sdms.length() > 0 ) {
								sdms_int = Integer.parseInt(sdms);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='sdms' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
							<option value=<%=tmp_val%>  <%if(sdms_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">起始电压KV</td>
				<td  >
					<select name="qsdy">
		    				<option value=-1></option>   
		    				<%
							int qsdy_int = -1;
							if(qsdy.length() > 0 ) {
								qsdy_int = Integer.parseInt(qsdy);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='qsdy' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
							<option value=<%=tmp_val%>  <%if(qsdy_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">结束电压KV</td>
				<td  >
					<select name="jsdy">
		    				<option value=-1></option>   
		    				<%
							int jsdy_int = -1;
							if(jsdy.length() > 0 ) {
								jsdy_int = Integer.parseInt(jsdy);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='jsdy' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
							<option value=<%=tmp_val%>  <%if(jsdy_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				
				
			</tr>
			
			<tr>
			<td class="td_warp">测试位置</td>
				<td ><input type = "text" class="warp_cont" value = "<%=clwz%>" name = "clwz"/></td>
				<td class="td_warp">每点次数/次</td>
				<td  >
					<select name="mdcs">
		    				<option value=-1></option>   
		    				<%
							int mdcs_int = -1;
							if(mdcs.length() > 0 ) {
								mdcs_int = Integer.parseInt(mdcs);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='mdcs' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
							<option value=<%=tmp_val%>  <%if(mdcs_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">条件</td>
				<td ><input type = "text"  class="warp_cont" value = "<%=tj%>" name = "tj"/></td>
				<!--<td class="td_warp">等级</td>
				<td ><input type = "text" class="warp_cont" value = "<%=dj%>" name = "dj"/></td>-->
				
				
			</tr>
			<tr>
			<td class="td_warp_new">测试code</td>  
				<td ><input type = "text" class="warp_cont" value = "<%=cscode%>" name = "cscode"/></td>
				<td class="td_warp_new">TP code</td>
				<td ><input type = "text" class="warp_cont"  value = "<%=Tpcode%>" name = "Tpcode"/></td>
				<td class="td_warp_new">截止目前时间(实时计算HR)</td>    
				<%
					sql = " select isnull(DATEDIFF(HH,scclsj+' '+scclsj1,CONVERT(varchar(16), GETDATE(), 25))+isnull(sccls,0),0) as shh from uf_ycjm where id = " + mainid;
					RecordSet.executeSql(sql);
					int tss_ffk = 0; 
					if(RecordSet.next()){
						tss_ffk = RecordSet.getInt("shh");
					}
					if(tss_ffk < 0 || tss_ffk > 100000)  tss_ffk = 0;
				%>
				<td ><input type = "text" class="warp_cont" value = "<%=tss_ffk%>" id="jzsj" name = "jzsj"  disabled /></td>
				<td class="td_warp_new">炉号</td> 
				<td > 
					<select name="lh">
		    				<option value=-1></option>   
		    				<%
		    					int lh_int = -1;
							if(lh.length() > 0 ) {
								lh_int = Integer.parseInt(lh);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_ycjm' and a.fieldname='lh' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(lh_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
			</td>	
				
			</tr>
			<tr>
				<td class="td_warp_new">首次投入时间</td>
				<td >
					<BUTTON type=button class=calendar id=SelectDate onclick=onShowDate(sctrsjSpan,sctrsj)></BUTTON>&nbsp;
					    <SPAN id=sctrsjSpan ><%=sctrsj%></SPAN>
					    <input class="inputstyle" type="hidden" id="sctrsj" name="sctrsj" value="<%=sctrsj%>"> -- 
					    	
					<BUTTON type="button" class=Clock onClick="onShowTime(sctrsj1span,sctrsj1)"></BUTTON>
					<SPAN id="sctrsj1span"><%=sctrsj1%></span>
					<input type="hidden" name="sctrsj1" id="sctrsj1" value="<%=sctrsj1%>" />   
				</td>
				<td class="td_warp_new">上次量测时间</td> 
				<td >
					<BUTTON type="button" class=calendar onclick="onShowDate(scclsjSpan,scclsj)"></BUTTON>
					    <SPAN id=scclsjSpan ><%=scclsj%></SPAN>
					    <input type="hidden" id="scclsj" name="scclsj" value="<%=scclsj%>" onpropertychange="calSt()"> -- 
					    	
					<BUTTON type="button" class=Clock onClick="onShowTime(scclsj1span,scclsj1)"></BUTTON>
					<SPAN id="scclsj1span"><%=scclsj1%></span>
					<input type="hidden" name="scclsj1" id="scclsj1" value="<%=scclsj1%>" onpropertychange="calSt()"/>   
				</td>
				<td class="td_warp_new">量测小时数</td>
				<td ><input type = "text" class="warp_cont"  value = "<%=clxss%>" id="clxss" name = "clxss" onchange="calSt()"/></td>
				<td class="td_warp_new">预计下次量测时间</td>    
					<%

  						sql = "select CONVERT(varchar(10),dateadd(HH,isnull(clxss,0),scclsj+' '+scclsj1),25)  as dtkk, "
  							+" CONVERT(varchar(5),dateadd(HH,isnull(clxss,0),scclsj+' '+scclsj1),108) as ttkk from uf_ycjm where id = " + mainid;
  						RecordSet.executeSql(sql);
  						String nedkk = "";String netkk = "";
						if(RecordSet.next()){
							nedkk = Util.null2String(RecordSet.getString("dtkk"));
							netkk = Util.null2String(RecordSet.getString("ttkk"));
						}
					%>
				<td >  
				<!--	<BUTTON type=button class=calendar id=SelectDate onclick=onShowDate(yjclSpan,yjcl)></BUTTON>&nbsp;
					    <SPAN id=yjclSpan ><%=yjcl%></SPAN>
					    <input class="inputstyle" type="hidden" id="yjcl" name="yjcl" value="<%=yjcl%>"> -- 
					    	
					<BUTTON type="button" class=Clock onClick="onShowTime(yjcl1span,yjcl1)"></BUTTON>
					<SPAN id="yjcl1span"><%=yjcl1%></span>
					<input type="hidden" name="yjcl1" id="yjcl1" value="<%=yjcl1%>" />   -->
					<input type = "text" class="warp_cont"  value = "<%=nedkk%> <%=netkk%>" id="xxx12" name = "xxx12" disabled  />
					<input type="hidden" name="yjcl" id="yjcl" value="<%=yjcl%>" />
					<input type="hidden" name="yjcl1" id="yjcl1" value="<%=yjcl1%>" />
				</td>
			</tr>
			<tr>
				<td class="td_warp_new">预计完成时间</td>
				<td >
					<BUTTON type=button class=calendar id=SelectDate onclick=onShowDate(yjwcSpan,yjwc)></BUTTON>&nbsp;
					    <SPAN id=yjwcSpan ><%=yjwc%></SPAN>
					    <input class="inputstyle" type="hidden" id="yjwc" name="yjwc" value="<%=yjwc%>"> -- 
					    	
					<BUTTON type="button" class=Clock onClick="onShowTime(yjwc1span,yjwc1)"></BUTTON>
					<SPAN id="yjwc1span"><%=yjwc1%></span>
					<input type="hidden" name="yjwc1" id="yjwc1" value="<%=yjwc1%>" />   
				</td>
				<td class="td_warp_new">实际完成时间</td>
				<td >
					<BUTTON type=button class=calendar id=SelectDate onclick=onShowDate(sjsjSpan,sjsj)></BUTTON>&nbsp;
					    <SPAN id=sjsjSpan ><%=sjsj%></SPAN>
					    <input class="inputstyle" type="hidden" id="sjsj" name="sjsj" value="<%=sjsj%>"> -- 
					    	
					<BUTTON type="button" class=Clock onClick="onShowTime(sjsj1span,sjsj1)"></BUTTON>
					<SPAN id="sjsj1span"><%=sjsj1%></span>
					<input type="hidden" name="sjsj1" id="sjsj1" value="<%=sjsj1%>" />   
				</td>
					
					<%
						// 重新计算  
						sql  = "select isnull(zt,0) as zt1,COUNT(1) as nus from uf_ycjm_dt1 where mainid="+mainid+" group by isnull(zt,0)";
						RecordSet.executeSql(sql);
						int allNumK = 0;
						int failNumK = 0;
						while(RecordSet.next()){
							int tmp_num = RecordSet.getInt("nus");
							allNumK = allNumK + tmp_num;
							String zt1 = Util.null2String(RecordSet.getString("zt1"));
							if("1".equals(zt1)){
								failNumK = failNumK + tmp_num;
							}
						}
					%>	
					
				<td class="td_warp_new">上次量测时数</td>
				<td ><input type = "text"class="warp_cont"  value = "<%=sccls%>" id="sccls" name = "sccls"/></td>
				<td class="td_warp_new">FAIL片数</td>
				<td ><input type = "text" class="warp_cont" value = "<%=failNumK%>" id = "FAILps" name = "FAILps" disabled /></td>
			</tr>
			<tr>
				<td class="td_warp_new">FAIL比例</td>
				<td colspan="3"><input type = "text"  value = "<%=failNumK%>" name = "FAILbl" id="FAILbl" disabled/>  /  
							<input type = "text"  value = "<%=allNumK%>" name = "FAILbl1" id="FAILbl1"  disabled/>  </td>
				<td class="td_warp_new">FA解析报告</td>
				<td colspan="3"><!--<input type = "text" class="warp_cont" value = "<%=x%>" name = "x"/>-->
						
						<a href="/formmode/search/CustomSearchBySimple.jsp?customid=20" target="_blank">点击访问</a>
						
				</td>
			</tr>
			<tr>
				<td class="td_warp_new">异常图片</td>
				<td colspan="3"><!--<input type = "text" class="warp_cont"  value = "<%=yctp%>" name = "yctp"/>-->
				<%
									if(!"".equals(yctp)){
											String docid="";
											String fileName="";
											String fileId="";
											sql = "select a.docid,b.imagefileid,b.imagefilename from docimagefile a,imagefile b where a.imagefileid=b.imagefileid and a.docid in ("+ yctp + ")";
											rs.execute(sql);
											while (rs.next()) {
												docid = Util.null2String(rs.getString("docid"));
												fileName = Util.null2String(rs.getString("imagefilename"));
												fileId = Util.null2String(rs.getString("imagefileid"));
								%>
								 <input type=hidden id="field_del_<%=docid%>" value="0" />
								 <a target="_blank" href="/weaver/weaver.file.FileDownload?fileid=<%=fileId%>&coworkid=-1&requestid=0&desrequestid=0"><%=fileName%></a>&nbsp&nbsp
								  <input type=hidden id="field_id_<%=docid%>" value=<%=docid%>>	
								 <button type="button" class=btnFlow accessKey=1 onclick="onChangeSharetype('<%=docid%>','yctp')">
								 <%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></button>
								 <span id="span_id_<%=docid%>" name="span_id_<%=docid%>" style="visibility:hidden">
									<B><FONT COLOR="#FF0033">√</FONT></B>
								</span></br>
								<%			
											}
									}
								%>					
					<div>
						<span> <span id="spanButtonPlaceHolder"></span><!--选取多个文件--></span>
						&nbsp;&nbsp;
						<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUpload.cancelQueue();" id="btnCancel1">
							<span><img src="/js/swfupload/delete_wev8.gif"  border="0"></span>
							<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage())%></font><!--清除所有选择--></span>
						</span>
					</div>
					<div class="fieldset flash" id="fsUploadProgress"></div>
					<div id="divStatus"></div>
					<input class=inputstyle style="display:none;" type=file name="accessory1" onchange='accesoryChanage(this)' style="width:100%">
					<span id="shfj_span"></span>
					(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:<%=accsize %>M)
					<button type="button" class=AddDoc style="display:none" name="addacc" onclick="addannexRow()"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
					<input type=hidden name=accessory_num value="1">						
				</td>
				<td class="td_warp_new">备注</td>
				<td colspan="3"><input type = "text" class="warp_cont" value = "<%=nz%>" name = "nz"/></td>
			</tr>
		</tbody>
	</table><br>
	<hr>
	<br>
	<table align="center" width = "95%">
		<colgroup><col width="4%"/><col width="10%"/><col width="15%"/><col width="4%"/>
					<col width="4%"/><col width="10%"/><col width="15%"/><col width="4%"/>
					<col width="4%"/><col width="10%"/><col width="15%"/><col width="4%"/></colgroup>
		<tbody>
			<tr>
				<td></td><td></td>
				<td  colspan="8" align="center">
					<button  id = "btt0"  type = "button" onclick="changeColorx(0)" class = "btnNormal">正 常</button> &nbsp&nbsp
					<input type ="hidden" name="ztd_x" id="ztd_x" value="0" >
					<input type = "text" class="det1_cont" id="nz2"   name = "nz2" value=" PANELID" onFocus="if(value==' PANELID') {value=''}" onBlur="addPan();" />
					<input type = "text" class="det1_cont" id="nz1"   name = "nz1" value=" DEMONO" onFocus="if(value==' DEMONO') {value=''}" onBlur="if(value==''){value=' DEMONO'}"/>&nbsp&nbsp
					
				</td>
				<td></td><td></td>
			</tr></tbody></table>
<div id="tableChlddiv">
	<table align="center" width = "95%">
	
		<colgroup><col width="4%"/><col width="10%"/><col width="13%"/><col width="6%"/>
					<col width="4%"/><col width="10%"/><col width="13%"/><col width="6%"/>
					<col width="4%"/><col width="10%"/><col width="13%"/><col width="6%"/></colgroup>
		<tbody>
			<tr><td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> 
				<td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> 
				<td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> 
			<!--  系统开始记录表里信息    一个内容占据四行,   一行即一个TR占用 3个值内容   -->
			 <%
				RecordSet.executeSql("select * from uf_ycjm_dt1 where mainid = " + mainid + " order by id");	
				int lineFlag = 0;
				while(RecordSet.next()){
					if(lineFlag %3 == 0){
						out.println("</tr><tr height=\"38px\">");
					}
					String t_id = Util.null2String(RecordSet.getString("id")); //唯一标示
					// 状态标示
					String t_status = Util.null2String(RecordSet.getString("zt")); //状态
					// 增加隐藏字段	
					out.println("	<td>");
					if("1".equals(t_status)){
						out.println("<button  id = \"btt" + t_id + "\"  type = \"button\" onclick=\"changeColor(" + t_id + ")\" class = \"btnException\">异 常</button>");
					}else{
						out.println("<button  id = \"btt" + t_id + "\"  type = \"button\" onclick=\"changeColor(" + t_id + ")\" class = \"btnNormal\">正 常</button>");
						t_status = "0";
					}
					out.println("<input type=\"hidden\" id =\"ztd_" + lineFlag + "\"  name=\"ztd_" + t_id + "\" value=\"" + t_status + "\" > ");
					out.println("	</td>");
					//  PANEL bh
					String t_panel = Util.null2String(RecordSet.getString("PANEL")); //PANEL ID
					String t_code = Util.null2String(RecordSet.getString("bh")); //RA 编号
					out.println("	<td align=\"center\" > <div class=\"div_input\"><input type = \"text\" class=\"det_cont\"  value = \"" + t_code + "\" name = \"bh _" + t_id +"\"/> </td></div>");
					out.println("	<td align=\"center\" > <div class=\"div_input\"><input type = \"text\" class=\"det_cont\"  value = \"" + t_panel + "\" name = \"PANEL _" + t_id +"\"/> </td></div>");
					
					//    编辑 ：/images/edit_wev8.gif     删除/images/delete_wev8.gif
					out.println("  <td><img src=\"/images/edit_wev8.gif\" height=\"20px\" onclick=\"edtitem(" + t_id + ")\"> &nbsp");
					out.println("  	<img src=\"/images/delete_wev8.gif\" height=\"20px\" onclick=\"delitem(" + t_id + ")\"></td>");
					lineFlag++;
				}
			%>
			</tr>
		</tbody>
	</table>
	</div>
	 </form>
	<br><br>
	 <input type="button" value="提交" id="zd_btn_submit" class="btnSummbit" onclick="submitData()">
	 <br><br><br><br><br>
</div>	

<SCRIPT>
function onChangeSharetype(docid,fieldid){
		var delspan="span_id_"+docid;
		var field_id="#field_id_"+docid;
		var field_del="#field_del_"+docid;
		
		  var attachids=jQuery("#"+fieldid).val();
		if(document.all(delspan).style.visibility=='visible'){
          document.all(delspan).style.visibility='hidden';
          jQuery(field_del).val("0"); 
		  if(attachids==""){
			  jQuery("#"+fieldid).val(docid);
		  }else{
			  attachids=attachids+","+docid;
			  jQuery("#"+fieldid).val(attachids);
		  }
        }else{
			
          document.all(delspan).style.visibility='visible';
         jQuery(field_del).val("1"); 
    	  var attachArr=attachids.split(",");
		  var flag="";
		  var newids = "";
		  for(var i=0;i<attachArr.length;i++){
			if(attachArr[i] !=docid){
				newids = newids+flag+attachArr[i];
				flag=","; 
			}
		  }
		  attachids = newids;
		  jQuery("#"+fieldid).val(attachids);
        }
	}
function onChangeSharetype(docid,fieldid){
		var delspan="span_id_"+docid;
		var field_id="#field_id_"+docid;
		var field_del="#field_del_"+docid;
		
		  var attachids=jQuery("#"+fieldid).val();
		if(document.all(delspan).style.visibility=='visible'){
          document.all(delspan).style.visibility='hidden';
          jQuery(field_del).val("0"); 
		  if(attachids==""){
			  jQuery("#"+fieldid).val(docid);
		  }else{
			  attachids=attachids+","+docid;
			  jQuery("#"+fieldid).val(attachids);
		  }
        }else{
			
          document.all(delspan).style.visibility='visible';
         jQuery(field_del).val("1"); 
    	  var attachArr=attachids.split(",");
		  var flag="";
		  var newids = "";
		  for(var i=0;i<attachArr.length;i++){
			if(attachArr[i] !=docid){
				newids = newids+flag+attachArr[i];
				flag=","; 
			}
		  }
		  attachids = newids;
		  jQuery("#"+fieldid).val(attachids);
        }
	}
	
jQuery("#syzt").change(function(){
			var opt=jQuery("#syzt").val();
			if(opt==2.0){
				var xcsj = jQuery('#xcsj option:selected').text();
				jQuery("#jzsj").val(xcsj);
			}else{
				calStx();
			}
		});
	function submitData(){
		if(!oUpload){
				weaver.submit();
			}else{
			   if(oUpload.getStats().files_queued === 0){
						weaver.submit();
				}else {
						oUpload.startUpload();
			    }
				
			}
		
	}
</SCRIPT>
	
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
			
</BODY></HTML>
