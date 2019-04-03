<!DOCTYPE html>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<LINK href="/wui/theme/ecology8/jquery/js/e8_zDialog_btn_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<%
	String id = Util.null2String(request.getParameter("id"));
	String bdbh = Util.null2String(request.getParameter("bdbh"));
	if(id.length() == 0){
		RecordSet.executeSql("select * from uf_zy where bdbh = '" + bdbh +"'");
		if(RecordSet.next()){
			id = Util.null2String(RecordSet.getString("id")); 
		}
	}
	
%>
	<style type="text/css">
		.td_warp {
			width:95%;
			display: inline-block;
			text-align: center;
			height:33px;
			line-height: 33px;
			background-color: rgb(16,160,234);
			float:left;
			margin-bottom:3%;
			color:rgb(255,255,255);
		}
		.td_warpMore {
			width:95%;
			display: inline-block;
			text-align: center;
			height:60px;
			line-height: 33px;
			background-color: rgb(16,160,234);
			float:left;
			margin-bottom:3%;
			color:rgb(255,255,255);
		}
		
		.warp_cont{
			height:30px;
			width:90%;
			line-height: 25px;
		}
		.warp{
			width:97%;
		}
		.title{
			margin:2% auto;
			text-align: center;
		}
		.btnSummbit{  
			background-color:#10A0EA;  
			border:none;  
			height:40px;  
			color:white;  
			font-size:18px;  
			width:150px  
		} 
		
	    	.bg{
			width: 80px;
			height: 40px;
			background-color: #33CCFF;
			float:left;
		}
		.bg:hover{
			background-color: #FFCC66;
		}
		.div_warp div{
			float:left;
			width:10%;
			margin-left:3%;
		}
		.bg1{
			width: 80px;
			height: 40px;
			background-color: #FF6633;
			float:left;
		}
		.bg1:hover{
			background-color: #FFCC66;
		}
	</style>
		
<SCRIPT>
	var diag_vote;
	function Foo(bttID){
		
		var title = "";
		var url = "/hehui/qa/ra/qaRAListOtherDetail1.jsp?mainid="+bttID;
//		alert(url);
		diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1700;
		diag_vote.Height = 800;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){
			diag_vote.close();
			window.location.reload();
		};
		diag_vote.show();
	}
	
	function closeDialog(){
		diag_vote.close();
	}
	
	function delitem(bttID){
		if(window.confirm('你是确认删除？')){
			var urlx = "/hehui/qa/ra/qaRASMList.jsp?uf=del&dtid="+bttID+"&id=<%=id%>";
	//		alert("urlx = " + urlx);
			$.get(urlx,function(data,status){
				 jQuery("#tableChlddivx").html(data);
			});
		}
	}
	
	function submitData(){
		var sData = jQuery("#syxm_dt").val();
		// alert("sData = " + sData);
		if(sData.length > 0 && sData != "-1"){
			if(window.confirm('你是确认增加？')){
				var urlx = "/hehui/qa/ra/qaRASMList.jsp?uf=add&syxm="+sData+"&id=<%=id%>";
		//		alert("urlx = " + urlx);
				$.get(urlx,function(data,status){
					 jQuery("#tableChlddivx").html(data);
				});

			}
		}else{
			alert("请选择一种实验目的！");
		}
		
	}
	
	function savaDataBt(){
		var checkIDS = jQuery("#checkIDS").val();
	//	alert("checkIDS = " + checkIDS);
		if (check_form(weaver,checkIDS)){
			weaver.submit();
		}
	} 
	
	function changeSyzl(){
		var syzl_val = jQuery("#syzl  option:selected").text();
		// DVT MVT   syjd  ra
		if(syzl_val=='DVT'||syzl_val=='MVT'){
			jQuery("#yzxh").attr("disabled",false).css("background-color","");
			jQuery("#syjd_1").css("display","none");
			jQuery("#syjd_2").show();
			
			// 必填字段 校验加上 checkIDS
			var checkIDS = jQuery("#checkIDS").val();
		//	alert("checkIDS = " + checkIDS);
			if(checkIDS.indexOf(",yzxh") < 0){
				checkIDS = checkIDS + ",yzxh";
				// 把必填的感叹号 增加上，添加前，判断文本框中是否值,有值不添感叹号
			//	alert("yzxh = " + checkIDS);
				if(jQuery("#yzxh").val().length <=0){
					jQuery("#yzxhmage").html("<img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\">");
				}
			}
			if(checkIDS.indexOf(",syjd") < 0){
				checkIDS = checkIDS + ",syjd";
			}
			jQuery("#checkIDS").val(checkIDS);
		}else{
			// 文本修改成只读
			jQuery("#yzxh").attr("disabled","disabled").css("background-color","#EEEEEE;");
			// 把必填的感叹号 出掉。
			jQuery("#yzxhmage").html("");
			
			// 下拉框没办法修改只读，采用div隐藏和显示的方式。
			jQuery("#syjd_1").css("display","block");
			jQuery("#syjd_2").hide();
			// 必填字段 校验去掉
			var checkIDS = jQuery("#checkIDS").val();
			if(checkIDS.indexOf(",yzxh") >= 0){
				checkIDS = checkIDS.replace(",yzxh","");
			}
			if(checkIDS.indexOf(",syjd") >= 0){
				checkIDS = checkIDS.replace(",syjd","");
			}
			jQuery("#checkIDS").val(checkIDS);
		}
		
		
		if(syzl_val == "DC"){
		//	alert("==");
			// DC编号必填
			var checkIDS = jQuery("#checkIDS").val(); 
			if(checkIDS.indexOf(",dcbh") < 0){
				checkIDS = checkIDS + ",dcbh";
				// 把必填的感叹号 增加上，添加前，判断文本框中是否值,有值不添感叹号
				if(jQuery("#dcbh").val().length <=0){
					jQuery("#dcbhmage").html("<img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\">");
				}
			}
			jQuery("#checkIDS").val(checkIDS);
		}else{
		//	alert("!=");
			// DC编号 可编辑
			var checkIDS = jQuery("#checkIDS").val();
			jQuery("#dcbhmage").html("");
			if(checkIDS.indexOf(",dcbh") >= 0){
				checkIDS = checkIDS.replace(",dcbh","");
			}
			jQuery("#checkIDS").val(checkIDS);
		}
	}
	
</SCRIPT>
</head>
<%
	

	if(id.length() < 1){
		return;
	}
	String bt = ""; //标题
//	String bdbh = ""; //表单编号
	String sqr = ""; //申请人
	String gh = ""; //工号
	String ssbm = ""; //所属部门
	String sqrq = ""; //申请日期
	String cc = ""; //尺寸
	String cpxh = ""; //产品型号
	String kh = ""; //客户
	String cpxhjb = ""; //产品型号级别(如一代)
	String syzsl = ""; //实验总数量(MDL)
	String syzslp = ""; //实验总数量(Panel)
	String cldj = ""; //有机材料类别
	String syzl = ""; //试验种类
	String syjd = ""; //试验阶段
	String yzxh = ""; //RA验证序号
	String ecbh = ""; //EC编号
	String dcbh = ""; //DC编号
	String sjxyx = ""; //是否需要新Code
	String sfxytp = ""; //是否需要TP新配置文件
	String cl = ""; //量测
		String gx = ""; String gh1 = ""; String tp = "";  //  光学   功耗   TP
	String gcxm = ""; //观察项目  
		String hz = ""; String wg = ""; //  画质  外观
	String jcsj = ""; //检查时间(hr)
		String sj1 = ""; String sj2 = ""; String sj3 = ""; String sj4 = ""; String sj5 = ""; String qt = "";
	String sqrlxfs = ""; //申请人联系方式 
	String bgyylb = ""; //变更原因类别 
	String sqjjcd = ""; //申请紧急程度 
	String csyy = ""; //实验目的 
	String bgqsm = ""; //变更前说明
	String bghsm = ""; //变更后说明
	String scx = ""; //上传新Code
	String scip = ""; //上传TP新配置文件 
	String xsjg = ""; //测试结果 
		String xsjg1 = "";
	String scjh = ""; //上传附件‘计划’
	String czr = ""; //操作人 
	String czsm = ""; //操作说明  
	String csbg = ""; //RA测试报告  
	String yaqzsj = ""; //样品取走时间
	
	RecordSet.executeSql("select * from uf_zy where id = " + id);
	if(RecordSet.next()){
		bt = Util.null2String(RecordSet.getString("bt")); //标题
		bdbh = Util.null2String(RecordSet.getString("bdbh")); //表单编号
		sqr = Util.null2String(RecordSet.getString("sqr")); //申请人
		gh = Util.null2String(RecordSet.getString("gh")); //工号
		ssbm = Util.null2String(RecordSet.getString("ssbm")); //所属部门
		sqrq = Util.null2String(RecordSet.getString("sqrq")); //申请日期
		cc = Util.null2String(RecordSet.getString("cc")); //尺寸
		cpxh = Util.null2String(RecordSet.getString("cpxh")); //产品型号
		kh = Util.null2String(RecordSet.getString("kh")); //客户
		cpxhjb = Util.null2String(RecordSet.getString("cpxhjb")); //产品型号级别(如一代)
		syzsl = Util.null2String(RecordSet.getString("syzsl")); //实验总数量(MDL)
		syzslp = Util.null2String(RecordSet.getString("syzslp")); //实验总数量(Panel)
		cldj = Util.null2String(RecordSet.getString("cldj")); //有机材料类别
		syzl = Util.null2String(RecordSet.getString("syzl")); //试验种类
		syjd = Util.null2String(RecordSet.getString("syjd")); //试验阶段
		yzxh = Util.null2String(RecordSet.getString("yzxh")); //RA验证序号
		ecbh = Util.null2String(RecordSet.getString("ecbh")); //EC编号
		dcbh = Util.null2String(RecordSet.getString("dcbh")); //DC编号
		sjxyx = Util.null2String(RecordSet.getString("sjxyx")); //是否需要新Code
		sfxytp = Util.null2String(RecordSet.getString("sfxytp")); //是否需要TP新配置文件
		cl = Util.null2String(RecordSet.getString("cl")); //量测
			 gx = Util.null2String(RecordSet.getString("gx")); gh1 = Util.null2String(RecordSet.getString("gh1"));  tp = Util.null2String(RecordSet.getString("tp"));  //  光学   功耗   TP
		gcxm = Util.null2String(RecordSet.getString("gcxm")); //观察项目  
			 hz = Util.null2String(RecordSet.getString("hz")); wg = Util.null2String(RecordSet.getString("wg")); //  画质  外观
		jcsj = Util.null2String(RecordSet.getString("jcsj")); //检查时间(hr)
			sj1 = Util.null2String(RecordSet.getString("sj1"));sj2 = Util.null2String(RecordSet.getString("sj2"));sj3 = Util.null2String(RecordSet.getString("sj3"));
			sj4 = Util.null2String(RecordSet.getString("sj4"));sj5 = Util.null2String(RecordSet.getString("sj5"));qt = Util.null2String(RecordSet.getString("qt"));
		sqrlxfs = Util.null2String(RecordSet.getString("sqrlxfs")); //申请人联系方式 
		bgyylb = Util.null2String(RecordSet.getString("bgyylb")); //变更原因类别 
		sqjjcd = Util.null2String(RecordSet.getString("sqjjcd")); //申请紧急程度 
		csyy = Util.null2String(RecordSet.getString("csyy")); //实验目的 
		bgqsm = Util.null2String(RecordSet.getString("bgqsm")); //变更前说明
		bghsm = Util.null2String(RecordSet.getString("bghsm")); //变更后说明
		scx = Util.null2String(RecordSet.getString("scx")); //上传新Code
		scip = Util.null2String(RecordSet.getString("scip")); //上传TP新配置文件 
		xsjg = Util.null2String(RecordSet.getString("xsjg")); //测试结果 
			xsjg1 = Util.null2String(RecordSet.getString("xsjg1"));
		scjh = Util.null2String(RecordSet.getString("scjh")); //上传附件‘计划’
		czr = Util.null2String(RecordSet.getString("czr")); //操作人 
		czsm = Util.null2String(RecordSet.getString("czsm")); //操作说明  
		csbg = Util.null2String(RecordSet.getString("csbg")); //RA测试报告  
		yaqzsj = Util.null2String(RecordSet.getString("yaqzsj")); //样品取走时间
	}

	String imagefilename = "/images/hdHRMCard_wev8.gif";
	String titlename = "展示";
	String needfav ="1";
	String needhelp ="";
	String sql = "";
%>
<BODY>
<div align="center">
	<div class= "title">
		<h1>RA_信赖性实验室综合实验单管理查询</h1>
	</div>
	<FORM id=weaver name=frmMain action="/hehui/qa/ra/？？？.jsp" method=post enctype="multipart/form-data">
		<input type = "hidden" id="checkIDS" name="checkIDS"  value="syzsl,yzxh,syjd"> 
			<!--存放必填字段ID-->
	<table class="warp">
		<colgroup><col width="12%"/><col width="16%"/><col width="8%"/><col width="16%"/>
					<col width="16%"/><col width="20%"/><col width="16%"/><col width="16%"/></colgroup>
		<tbody>
			<tr>
				<td class="td_warp">标题</td>
				<td ><input type = "text" class="warp_cont"  value = "<%=bt%>" name = "bt" disabled title="<%=bt%>" /></td>
				<td class="td_warp">表单编号</td>
				<td  ><input type = "text" class="warp_cont"  value = "<%=bdbh%>" name = "bdbh" disabled title="<%=bdbh%>" /></td>
				<td class="td_warp">申请人</td>
				<td ><%=Util.toScreen(ResourceComInfo.getResourcename(sqr),user.getLanguage())%></td>
				<td  class="td_warp">工号</td>
				<td class="warp_cont"><input type = "text" class="warp_cont" value = "<%=gh%>"  disabled title="<%=gh%>"  /></td>
			</tr>
			<tr>
				<td class="td_warp">所属部门</td>
				<td ><%=Util.toScreen(DepartmentComInfo.getDepartmentname(ssbm),user.getLanguage())%></td>
				<td class="td_warp">申请日期</td>
				<td ><input type = "text"  class="warp_cont" value = "<%=sqrq%>" name = "sqrq"  disabled  /></td>
				<td class="td_warp">尺寸</td>
				<td >  
					<select name="cc">
		    				<option value=-1></option>   
		    				<%
							int cc_int = -1;
							if(cc.length() > 0 ) {
								cc_int = Integer.parseInt(cc);
							}
		    					sql = "select disorder,name from mode_selectitempagedetail where  mainid in(15)";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("name"));
								double tmp_val = RecordSet.getDouble("disorder");
		    				%>
						<option value=<%=tmp_val%>  <%if(cc_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">产品类型</td>
				<td > 
					<select name="cpxh">
		    				<option value=-1></option>   
		    				<%
		    					int cpxh_int = -1;
							if(cpxh.length() > 0 ) {
								cpxh_int = Integer.parseInt(cpxh);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(7849) order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(cpxh_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
			</td>
			</tr>
			<tr>
				<td class="td_warp">客户</td>
				<td >
					<select name="kh">
		    				<option value=-1></option>   
		    				<%
		    					int kh_int = -1;
							if(kh.length() > 0 ) {
								kh_int = Integer.parseInt(kh);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(7850) and cancel = 0 order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(kh_int==tmp_val){ %>selected <%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">产品型号级别</td>
				<td ><input type = "text" class="warp_cont" value = "<%=cpxhjb%>" name = "cpxhjb"/></td>
				<td class="td_warp">实验总数量(MDL)</td>
				<td ><input type = "text"  class="warp_cont" value = "<%=syzsl%>"  id = "syzsl" name = "syzsl" onchange = "checkinput('syzsl','syzslmage')"/>
				<span id="syzslmage"><%if("".equals(syzsl)){%><img src="/image/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
				<td class="td_warp">实验总数量(Panel)</td>
				<td ><input type = "text" class="warp_cont" value = "<%=syzslp%>" id="syzslp" name = "syzslp" onchange = "checkinput('syzslp','syzslpmage')"/>
				<span id="syzslpmage"><%if("".equals(syzslp)){%><img src="/image/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
			</tr>
			<tr> 
				<td class="td_warp">有机材料类别</td>
				<td >
					<select name="cldj">
		    				<option value=-1></option>   
		    				<%
		    					int cldj_int = -1;
							if(cldj.length() > 0 ) {
								cldj_int = Integer.parseInt(cldj);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(7855) order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(cldj_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">试验种类</td> 
				<td >
					<select name="syzl" id= "syzl" onchange="changeSyzl()">
		    				<option value=-1></option>   
		    				<%
		    					int syzl_int = -1;
							if(syzl.length() > 0 ) {
								syzl_int = Integer.parseInt(syzl);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(7846) order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(syzl_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">试验阶段</td>
				<td >
					<div id="syjd_1" style="display:none"> 
						<input type = "text" id="syjd_1_1" name = "syjd_1_1" disabled size="10" />
					</div>
					<div id="syjd_2">
						<select name="syjd" id="syjd">
								<option value=-1></option>   
								<%
									int syjd_int = -1;
								if(syjd.length() > 0 ) {
									syjd_int = Integer.parseInt(syjd);
								}
									sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(7847) order by selectvalue";
								RecordSet.executeSql(sql);
								while(RecordSet.next()){
									String tmp_name = Util.null2String(RecordSet.getString("selectname"));
									int tmp_val = RecordSet.getInt("selectvalue");
								%>
									<option value=<%=tmp_val%>  <%if(syjd_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
							<%}%>
						</select>
					</div>
				</td>
				<td class="td_warp">RA验证序号</td>
				<td ><input type = "text" class="warp_cont" value = "<%=yzxh%>" id="yzxh" name = "yzxh" onchange = "checkinput('yzxh','yzxhmage')"/>
					<span id="yzxhmage"><%if("".equals(yzxh)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
			</tr>
			<tr>
				<td class="td_warp">EC编号</td>
				<td ><input type = "text" class="warp_cont" value = "<%=ecbh%>" name = "ecbh"/></td>
				<td class="td_warp">DC编号</td>
				<td ><input type = "text" class="warp_cont" value = "<%=dcbh%>" name = "dcbh" id="dcbh" onchange = "checkinput('dcbh','dcbhmage')"/>
					<span id="dcbhmage"><%if("".equals(dcbh)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span>
				</td>
				<td class="td_warp">是否需要新Code</td>
				<td >
					<select name="sjxyx">
		    				<option value=-1></option>   
		    				<%
		    					int sjxyx_int = -1;
							if(sjxyx.length() > 0 ) {
								sjxyx_int = Integer.parseInt(sjxyx);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(7860) order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(sjxyx_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warpMore">是否需要TP新文件</td> 
				<td >
					<select name="sfxytp">
		    				<option value=-1></option>   
		    				<%
		    					int sfxytp_int = -1;
							if(sfxytp.length() > 0 ) {
								sfxytp_int = Integer.parseInt(sfxytp);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(7861) order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(sfxytp_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
			</tr>
			<tr>
				<td class="td_warp">量测</td>
				<td ><!--<input type = "text" class="warp_cont" value = "<%=cl%>" name = "cl"/> --> 
						<input type="checkbox" name="gx" value=""  <%if("1".equals(gx)){%>checked="checked" <%}%> />	光学 ; &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="gh1" value="" <%if("1".equals(gh1)){%> checked="checked" <%}%> /> 功耗 ; &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="tp" value="" <%if("1".equals(tp)){%>checked="checked" <%}%> />	TP ;
				</td>
				<td class="td_warp">观察项目</td>
				<td ><!--<input type = "text" class="warp_cont"  value = "<%=gcxm%>" name = "gcxm"/> --> 
					  <input type="checkbox" name="gx" value=""  <%if("1".equals(hz)){%>checked="checked" <%}%> />	画质 ; &nbsp;&nbsp;&nbsp;&nbsp;
					 <input type="checkbox" name="gh1" value="" <%if("1".equals(wg)){%> checked="checked" <%}%> /> 外观 ; 
				</td>
				<td class="td_warp">检查时间</td>
				<td ><!--<input type = "text" class="warp_cont" value = "<%=jcsj%>" name = "jcsj"/> -->
						<input type="checkbox" name="sj1" value=""  <%if("1".equals(sj1)){%>checked="checked" <%}%> />	24; 
						<input type="checkbox" name="sj2" value="" <%if("1".equals(sj2)){%> checked="checked" <%}%> /> 120;
						<input type="checkbox" name="sj3" value="" <%if("1".equals(sj3)){%>checked="checked" <%}%> />	128; 
						<input type="checkbox" name="sj4" value="" <%if("1".equals(sj4)){%>checked="checked" <%}%> />	240;<br>
						<input type="checkbox" name="qt" value="" <%if("1".equals(qt)){%>checked="checked" <%}%> />	其他 
						<input type = "text" size="10"  value = "<%=jcsj%>" name = "jcsj"/>
				</td>
				<td class="td_warpMore">申请人联系方式(手机+座机)</td>
				<td ><input type = "text" class="warp_cont" value = "<%=sqrlxfs%>" id="sqrlxfs" name = "sqrlxfs" onchange = "checkinput('sqrlxfs','sqrlxfsmage')"/>
					<span id="sqrlxfsmage"><%if("".equals(sqrlxfs)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
			
			</tr>
			<tr>
				<td class="td_warp">变更原因类型</td>
				<td >
					<select name="bgyylb">
		    				<option value=-1></option>   
		    				<%
		    					int bgyylb_int = -1;
							if(bgyylb.length() > 0 ) {
								bgyylb_int = Integer.parseInt(bgyylb);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(11413) order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(bgyylb_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">申请人紧急程度</td>
				<td >
					<select name="sqjjcd">
		    				<option value=-1></option>   
		    				<%
		    					int sqjjcd_int = -1;
							if(sqjjcd.length() > 0 ) {
								sqjjcd_int = Integer.parseInt(sqjjcd);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(14278) order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(sqjjcd_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">实验目的</td>
				<td colspan="3"><input type = "text" class="warp_cont" value = "<%=csyy%>" id="csyy" name = "csyy" onchange = "checkinput('csyy','csyymage')"/>
					<span id="csyymage"><%if("".equals(csyy)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
			
			</tr>
			<tr>
				<td class="td_warpMore">变更前说明</td>
				<td colspan="3"> 
						<% 
								bgqsm = bgqsm.replaceAll("<br>", "\n");
						 %>
							<textarea rows="4" cols="72" id="bgqsm" name="bgqsm" onchange = "checkinput('bgqsm','bgqsmmage')"><%=bgqsm%></textarea>	
							<span id="bgqsmmage"><%if("".equals(bgqsm)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span>	
				</td>
				
				<td class="td_warpMore">变更后说明</td>
				<td colspan="3">
						<% 
								bghsm = bghsm.replaceAll("<br>", "\n");
						 %>
					<textarea rows="4" cols="75" id="bghsm" name="bghsm" onchange = "checkinput('bghsm','bghsmmage')"> <%=bghsm%></textarea>	
					<span id="bghsmmage"><%if("".equals(bghsm)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span>	
				
				</td>
			</tr>
			<tr>
				<td class="td_warp">上传新Code</td>
				<td colspan="3"><input type = "text" class="warp_cont"  value = "<%=scx%>" name = "scx"/></td>
				<td class="td_warp">上传TP新配置文件 </td>
				<td colspan="3"><input type = "text" class="warp_cont" value = "<%=scip%>" name = "scip"/></td>
			</tr>
			<tr>
				<td class="td_warp">测试结果 </td>
				<td colspan="3">
					<select name="xsjg">
		    				<option value=-1></option>   
		    				<%
		    					int xsjg_int = -1;
							if(xsjg.length() > 0 ) {
								xsjg_int = Integer.parseInt(xsjg);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(11422) order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(xsjg_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select> -- 
					<select name="xsjg1">
		    				<option value=-1></option>   
		    				<%
		    					int xsjg1_int = -1;
							if(xsjg1.length() > 0 ) {
								xsjg1_int = Integer.parseInt(xsjg1);
							}
		    					sql = "select selectvalue,selectname from workflow_selectitem where fieldid in(11423) order by selectvalue";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(xsjg1_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">上传附件‘计划’</td>
				<td colspan="3"><input type = "text" class="warp_cont" value = "<%=scjh%>" name = "scjh"/></td>
			</tr>
			<tr>
				<td class="td_warp">操作人</td>
				<td colspan="3">
					<brow:browser viewType="0"  name="czr" browserValue="<%=czr %>"
						browserOnClick=""
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
						hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
						completeUrl="/data.jsp" width="165px"
						browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(czr),user.getLanguage())%>">
					</brow:browser>
				</td>
				<td class="td_warp">操作说明 </td>
				<td colspan="3"><input type = "text" class="warp_cont" value = "<%=czsm%>" name = "czsm"/></td>
			</tr>
			<tr>
				<td class="td_warp">RA测试报告</td>
				<td colspan="3"><input type = "text" class="warp_cont"  value = "<%=csbg%>" name = "csbg"/></td>
				<td class="td_warp">样品取走时间</td>
				<td colspan="3"><input type = "text" class="warp_cont" value = "<%=yaqzsj%>" name = "yaqzsj"/></td>
			</tr>
		</tbody>
	</table>
	</form>
	<br><hr><br>
	<div id="tableChlddivx">
		<table align="center" width = "95%">
			<colgroup><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/>
						<col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/>
			</colgroup>
			<tbody>
			<tr><td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td>  <td > &nbsp;</td> <td > &nbsp;</td> 
				<td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td>  <td > &nbsp;</td> <td > &nbsp;</td> 
			<!--  系统开始记录表里信息    一个内容占据四行,   一行即一个TR占用 3个值内容   -->
			 <%
				sql  = "select id,(select syxm  from uf_syxm u where u.id=f.syxm) as syxm1 "
					+" ,(select COUNT(1) from uf_ycjm_dt1 where mainid=f.id and zt=1) as fnum "
					+" from uf_ycjm f where lcmxid in(select lcmxid from uf_zy_dt9 where mainid=" + id + ") order by id ";
				RecordSet.executeSql(sql);	
				int lineFlag = 0;
				while(RecordSet.next()){
					String t_id = Util.null2String(RecordSet.getString("id"));  		// 唯一标示
					String t_syxm = Util.null2String(RecordSet.getString("syxm1"));  // 实验目的
					
					int fnum = RecordSet.getInt("fnum");  // 是否有异常
										
					if(lineFlag%14 == 0){
						out.println("</tr><tr height=\"58px\">");
					}
					
					if(fnum > 0){
						out.println("	<td> <div class= \"bg1\"  onclick=\"Foo("+t_id+");\">");
					}else{
						out.println("	<td> <div class= \"bg\"  onclick=\"Foo("+t_id+");\">");
					}
					// 增加显示名和连接
					out.println(t_syxm + " : " + t_id);
					// 增加删除按钮
					out.println("  </div>&nbsp;<img src=\"/images/delete_wev8.gif\" height=\"20px\" onmouseover=\"this.style.border='1px solid #009933'\" onmouseout=\"this.style.border='none'\"    onclick=\"delitem(" + t_id + ")\">  ");
					// 增加隐藏字段	
					out.println("<input type=\"hidden\" name=\"uq_" + t_id + "\" value=\"" + t_id + "\" > ");
					out.println("	</td>");

					lineFlag++;
				}
			%>
		</tr>
	</tbody></table>
	</div>
	<br><br>
	<div width="500px"> 
		<select name="syxm_dt" id="syxm_dt" style="font-size:60px; ">
			<option value=-1></option>   
		<%
			sql  = "select id,syxm from uf_syxm";
			RecordSet.executeSql(sql);
			while(RecordSet.next()){
				String tmp_id =Util.null2String(RecordSet.getString("id")); 
				String tmp_syxm =Util.null2String(RecordSet.getString("syxm")); 
				out.println("<option value=\""+ tmp_id +"\">" + tmp_syxm + "</option>");
			}
		%>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="插入实验项目" id="zd_btn_submit" class="btnSummbit" onclick="submitData()">
	</div> 
	
	<br><br>
	
		<input type="button" value="提交" id="zd_btn_save" class="btnSummbit" onclick="savaDataBt()">

		<br><br><br>
		</div>
</BODY>
</HTML>
