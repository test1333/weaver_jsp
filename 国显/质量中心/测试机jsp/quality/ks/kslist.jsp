<%@page import="java.security.Guard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.javen.Util.Util"%>
<%@ page import="java.net.*"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="com.javen.gvo.quality.ks.KSUtil"%>
<%@ page import="com.javen.gvo.quality.util.QualityUtil"%>
<jsp:useBean id="rs" class="com.javen.Util.RecordSet" scope="page" />
<%@ include file="/jsp/quality/systeminfo/init.jsp" %>
<jsp:include page="/jsp/quality/roles/checkRoles.jsp">
	<jsp:param name="cd" value="3" />
</jsp:include>
<%
	QualityUtil qu = new QualityUtil();
	KSUtil ksu = new KSUtil();	
	String htmlkhmc = qu.getSelectOption("gkmc");	
	String htmlblmc = qu.getSelectOption("blmc");	
	String htmlbyzl = qu.getSelectOption("byzl");	
	String htmlbllx = qu.getSelectOption("bllx");	
	String htmlsccq = qu.getSelectOption("sccq");
	String xswb = "";
	String sql = "select xswb from uf_ks_main_textarea where sfqy=0";
	rs.executeQuery(sql);
	if (rs.next()) {
		xswb = Util.null2String(rs.getString("xswb")).replace(" ", "&nbsp;");
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" type="image/x-icon" href="/static/images/favicon.ico" />
<title>CS系统</title>
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css" />
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap-select.min.css" />
<link rel="stylesheet" href="/static/js/zDialog_e8_wev8.css" />
<style type="text/css">
.mt-10 {
	margin-top: 15px;
}

.mb-10 {
	margin-bottom: 10px;
}

.mt-3 {
	margin-top: 5px;
}

.div-right {
	float: right;
}

.col-md-* {
	padding-left: 0px;
	padding-right: 0px;
	padding-top: 0px;
}

BUTTON.Clock, Button.clock {
	BACKGROUND-IMAGE: url(/static/images/time_wev8.png) !important;
	WIDTH: 16px !important;
	margin-right: 5px;
	background-color: transparent;
}

BUTTON.Calendar, BUTTON.calendar {
	BACKGROUND-IMAGE: url(/static/images/calendar_wev8.png) !important;
	WIDTH: 16px !important;
	height: 16px;
	margin-right: 5px;
	background-color: transparent;
}

.btn22 {
	padding: 6px 2px 2px 2px;
	!
	important
}

.col-xs-6 {
	padding-right: 0px;
	padding-left: 0px;
}

.thumbnail {
	padding: 0px;
	margin-bottom: 0px;
}

.thumbnail>img {
	height: 86px;
}

.table>thead>tr>th, .table>tbody>tr>td {
	padding-top: 2px;
	padding-bottom: 2px;
}

.table>tbody>tr>td {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.container {
	width:92%;
}
.sf1{
	background-color:#DAEEF3;
	width:11%;
}
.sf2{
	width:22%;
    height: 40px;
}
.e8_btn_submit,.e8_btn_cancel{
		background-color:transparent;
		color:#007aff;
		word-wrap: normal;
	}
.e8_btn_cancel,.e8_btn_submit{
		border:0px;
		cursor:pointer;
		overflow:visible;
		font-size:12px;
	}
	
.e8_btn_cancel,.e8_btn_submit{
		padding-left:18px !important;
		padding-right:18px !important;
		height:30px;
		line-height:30px;
	}
</style>
</head>
<%
String workcode1 = Util.null2String((String)session.getAttribute("workcode"));
String seltab = Util.null2String(request.getParameter("seltab"));
String sel2 = Util.null2String(request.getParameter("sel2"));
String beginDate = Util.null2String(request.getParameter("beginDate"));
String endDate = Util.null2String(request.getParameter("endDate"));
String sertype = Util.null2String(request.getParameter("sertype"));
String gjgkmc = Util.null2String(request.getParameter("gjgkmc"));
String gjcpmc = Util.null2String(request.getParameter("gjcpmc"));
String gjlcbh = Util.null2String(request.getParameter("gjlcbh"));
String gjblmc = Util.null2String(request.getParameter("gjblmc"));
String gjcpxh = Util.null2String(request.getParameter("gjcpxh"));
String gjksyzd = Util.null2String(request.getParameter("gjksyzd"));
String gjbyzl = Util.null2String(request.getParameter("gjbyzl"));
String gjcpzt = Util.null2String(request.getParameter("gjcpzt"));
String gjsfja = Util.null2String(request.getParameter("gjsfja"));
String gjbllx = Util.null2String(request.getParameter("gjbllx"));
String gjcpjd = Util.null2String(request.getParameter("gjcpjd"));
String gjsqr = Util.null2String(request.getParameter("gjsqr"));
String gjbeginDate = Util.null2String(request.getParameter("gjbeginDate"));
String gjendDate = Util.null2String(request.getParameter("gjendDate"));
String gjsccq = Util.null2String(request.getParameter("gjsccq"));
String gjfsdd = Util.null2String(request.getParameter("gjfsdd"));
JSONObject jo = new JSONObject();
jo.put("seltab", seltab);
jo.put("sel2", sel2);
jo.put("beginDate", beginDate);
jo.put("endDate", endDate);
jo.put("sertype", sertype);

jo.put("gjgkmc", gjgkmc);
jo.put("gjcpmc", gjcpmc);
jo.put("gjlcbh", gjlcbh);
jo.put("gjblmc", gjblmc);
jo.put("gjcpxh", gjcpxh);
jo.put("gjksyzd", gjksyzd);
jo.put("gjbyzl", gjbyzl);
jo.put("gjcpzt", gjcpzt);
jo.put("gjsfja", gjsfja);
jo.put("gjbllx", gjbllx);
jo.put("gjcpjd", gjcpjd);
jo.put("gjsqr", gjsqr);
jo.put("gjbeginDate", gjbeginDate);
jo.put("gjendDate", gjendDate);
jo.put("gjsccq", gjsccq);
jo.put("gjfsdd", gjfsdd);
jo.put("workcode", workcode1);

String queryConditon = URLEncoder.encode(jo.toString(),"UTF-8");
%>
<body>
	<div class="container">
	<FORM id=report name=report action="/jsp/quality/ks/kslist.jsp"
				method=post>
		<input type="hidden" id="seltab" name="seltab" value=""></input> 
		<input type="hidden" id="sel1" name="sel1"  value=""></input>
		<input type="hidden" id="sel2"  name="sel2"value=""></input>
		<input type="hidden" id="sertype" name="sertype"  value=""></input>
		<div class="row mt-10">
			
				
				<div class="col-md-12"
					style="background-color: #FCFCFC; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 1px #E8E8E8; height: 105px">
					<div class="row" style="height: 30px">
						<div class="col-md-3 "></div>
						<div class="col-md-6 ">
							<div class="btn-group" data-toggle="buttons" id="maintab">
								<label class="btn btn22" onclick="changeselect('khmc')">
									<input type="radio" name="ptions" id="optionkhmc">客户名称
								</label> <label class="btn btn22" onclick="changeselect('blmc')">
									<input type="radio" name="options" id="optionblmc">不良名称
								</label> <label class="btn btn22" onclick="changeselect('byzl')">
									<input type="radio" name="options" id="optionbyzl">抱怨种类
								</label> <label class="btn btn22" onclick="changeselect('bllx')">
									<input type="radio" name="options" id="optionbllx">不良类型
								</label> <label class="btn btn22" onclick="changeselect('sccq')">
									<input type="radio" name="options" id="optionsccq">生产厂区
								</label>
							</div>
						</div>
						<div class="col-md-3 "></div>
					</div>
					<div class="row mt-3" style="height: 30px">
						<div class="col-md-3 ">
							<div style="position: absolute; width: 70%">
								<img src="/static/images/vision.jpg" width="70%" height="30px">
							</div>
							<div style="position: absolute; left: 60%;">
								<select class="selectpicker" id="mainss" disabled="disabled" data-width="100px">
									<option value="ks" select>客诉</option>
								</select>


							</div>
						</div>
						<div class="col-md-6" id="select2">
							<select class="selectpicker" data-live-search="true" id="mainss2" data-width="420px" 
								title="请选择">
								<option value=""></option>
							</select>
						</div>
						<div class="col-md-3">
							<p>
								<button type="button" class="btn btn-default"
									onclick="search1()">搜索</button>
								<button type="button" class="btn btn-default"
									data-toggle="collapse" data-target="#demo" id="gjss">高级搜索</button>
							</p>
						</div>
					</div>
					<div class="row" style="height: 35px">
						<div class="col-md-3 "></div>
						<div class="col-md-6 ">
							<div style="">
								起止日期：
								<button type="button" class="glyphicon glyphicon-calendar"
									id="selectBeginDate"
									onclick="onshowPlanDate1('beginDate','selectBeginDateSpan','1')"></BUTTON>
								<SPAN id=selectBeginDateSpan><%=beginDate%></SPAN> <INPUT type="hidden"
									name="beginDate" id="beginDate" value="<%=beginDate%>"> &nbsp;-&nbsp;
								<button type="button" class="glyphicon glyphicon-calendar"
									id="selectEndDate"
									onclick="onshowPlanDate1('endDate','endDateSpan','1')"></BUTTON>
								<SPAN id=endDateSpan><%=endDate%></SPAN> <INPUT type="hidden" name="endDate"
									id="endDate" value="<%=endDate%>">

							</div>
						</div>
						<div class="col-md-3"></div>
					</div>
				</div>
			
		</div>
			<div class="row collapse" id="demo">
				<div class="col-md-12"
					style="background-color: #FCFCFC; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 1px #E8E8E8; height: 310px">
				<table class="table-bordered table-condensed"  style="margin-top:10px;width: 100%;max-width: 100%">
				   <thead>
				      <tr>
				         <th colspan="2" >常用条件</th>
				         <th colspan="2" >其他条件1</th>
				         <th colspan="2" >其他条件2</th>
				      </tr>
				   </thead>
				   <tbody>
				      <tr>
				         <td class="sf1">顾客名称</td>
				         <td class="sf2">
					         <select id="gjgkmc" name="gjgkmc"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=htmlkhmc%>
							 </select>
						 </td>
				         <td class="sf1">产品名称</td>
				         <td class="sf2"> <input type="text" id="gjcpmc" name="gjcpmc" class="form-control" value="<%=gjcpmc%>"/></td>
				         <td class="sf1">流程编号</td>
				         <td class="sf2"><input type="text" id="gjlcbh" name="gjlcbh" class="form-control" value="<%=gjlcbh%>"/></td>
				      </tr>
				      <tr>
				          <td class="sf1">不良名称</td>
				         <td class="sf2">
				         	<select id="gjblmc" name="gjblmc"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=htmlblmc%>
							 </select>
				         </td>
				         <td class="sf1">产品型号</td>
				         <td class="sf2"><input type="text" id="gjcpxh" name="gjcpxh" class="form-control" value="<%=gjcpxh%>"/></td>
				         <td class="sf1">客诉严重度</td>
				         <td class="sf2">
				         	<select id="gjksyzd" name="gjksyzd"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=qu.getSelectOption("ksyzd")%>
							 </select>
				         </td>
				      </tr> <tr>
				          <td class="sf1">抱怨种类</td>
				         <td class="sf2">
				         <select id="gjbyzl" name="gjbyzl"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=htmlbyzl%>
							 </select>
				         </td>
				         <td class="sf1">产品状态</td>
				         <td class="sf2">
				           <select id="gjcpzt" name="gjcpzt"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=qu.getSelectOption("cpzt")%>
							 </select></td>
				         <td class="sf1">是否结案</td>
				         <td class="sf2"> <select id="gjsfja" name="gjsfja"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<option value=''></option>
								<option value='0'>Close</option>
								<option value='1'>Open</option>
								
							 </select></td>
				      </tr>
				       <tr>
				          <td class="sf1">不良类型</td>
				         <td class="sf2">
				         	 <select id="gjbllx" name="gjbllx"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=htmlbllx%>
							 </select>
				         </td>
				         <td class="sf1">产品阶段</td>
				         <td class="sf2">
				         	<select id="gjcpjd" name="gjcpjd"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=qu.getSelectOption("cpjd")%>
							 </select>
				         </td>
				         <td class="sf1">申请人</td>
				         <td class="sf2"><input type="text" id="gjsqr" name="gjsqr" class="form-control" value="<%=gjsqr%>"/></td>
				      </tr>
				      <tr>
				      	<td class="sf1">起止日期</td>
				         <td class="sf2">
								<button type="button" class="glyphicon glyphicon-calendar"
									id="gjselectBeginDate"
									onclick="onshowPlanDate1('gjbeginDate','gjselectBeginDateSpan','1')"></BUTTON>
								<SPAN id=gjselectBeginDateSpan><%=gjbeginDate%></SPAN> <INPUT type="hidden"
									name="gjbeginDate" id="gjbeginDate" value="<%=gjbeginDate%>"/>-
								<button type="button" class="glyphicon glyphicon-calendar"
									id="gjselectEndDate"
									onclick="onshowPlanDate1('gjendDate','gjendDateSpan','1')"></BUTTON>
								<SPAN id=gjendDateSpan><%=gjendDate%></SPAN> <INPUT type="hidden" name="gjendDate"
									id="gjendDate" value="<%=gjendDate%>"/>
				         </td>
				         <td class="sf1">生产厂区</td>
				         <td class="sf2">
				         	<select id="gjsccq" name="gjsccq"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=htmlsccq%>
							 </select>
				         </td>
				         <td class="sf1">发生地点</td>
				         <td class="sf2"><input type="text" id="gjfsdd" name="gjfsdd" class="form-control" value="<%=gjfsdd%>"/></td>
				      </tr>
				    <tr>
				    <td colspan="6" style="text-align: center;">
				   		 <input type="button" value="查询" class="e8_btn_submit" onclick="search2();">
				   		 <input type="button" value="取消" class="e8_btn_cancel" onclick="cancel();"/>
				    </td>
				    </tr>
				   </tbody>
			   </table>	
				</div>
			</div>
		</FORM>
		
		
		
		<div class="row mt-10">
			<div class="col-md-12"
				style="background-color: #FCFCFC; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 1px #E8E8E8; ">
				<div id='kslist' style="margin-top:10px">
				<iframe src="/jsp/quality/ks/ksfylist.jsp?queryCondition=<%=queryConditon%>" id="mainFrame"
						style="height: 99%; width: 100%; overflow-x:scroll" frameborder="no" border="0"
						marginwidth="0" marginheight="0" scrolling="yes"  
						allowtransparency="yes" ></iframe>
				</div>
			</div>
		</div>
		
		
	</div>
	<script src="/static/jquery-3.3.1/jquery-3.3.1.min.js"></script>
	<script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<script src="/static/bootstrap-3.3.7-dist/js/bootstrap-select.min.js"></script>
	<script src="/static/bootstrap-3.3.7-dist/js/defaults-zh_CN.min.js"></script>
	<SCRIPT language="javascript" src="/static/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/static/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/static/js/zDialog_wev8.js"></script>
	<SCRIPT language="javascript"
		src="/static/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript">
	window.onload = function() {
		var clienthei = window.innerHeight
		var height1 = Number(clienthei) - 151;
		height1 = height1 + 'px';
		document.getElementById('kslist').style.height = height1;
	}
		jQuery(document).ready(function() {
			var seltab = "<%=seltab%>";
			var sel2 =  "<%=sel2%>";
			var gjgkmc =  "<%=gjgkmc%>";
			var gjblmc =  "<%=gjblmc%>";
			var gjksyzd =  "<%=gjksyzd%>";
			var gjbyzl =  "<%=gjbyzl%>";
			var gjcpzt =  "<%=gjcpzt%>";
			var gjsfja =  "<%=gjsfja%>";
			var gjbllx =  "<%=gjbllx%>";
			var gjcpjd =  "<%=gjcpjd%>";
			var gjsccq =  "<%=gjsccq%>";
			if(seltab == ""){
				jQuery("#optionkhmc").click();
			}else if(seltab == "khmc"){
				jQuery("#optionkhmc").click();
			}else if(seltab == "blmc"){
				jQuery("#optionblmc").click();
			}else if(seltab == "byzl"){
				jQuery("#optionbyzl").click();
			}else if(seltab == "bllx"){
				jQuery("#optionbllx").click();
			}else if(seltab == "sccq"){
				jQuery("#optionsccq").click();
			}
			if(sel2 != ""){
				$("#mainss2").selectpicker('val', sel2);
			}
			if(gjgkmc != ""){
				$("#gjgkmc").selectpicker('val', gjgkmc);
			}
			if(gjblmc != ""){
				$("#gjblmc").selectpicker('val', gjblmc);
			}
			if(gjksyzd != ""){
				$("#gjksyzd").selectpicker('val', gjksyzd);
			}
			if(gjbyzl != ""){
				$("#gjbyzl").selectpicker('val', gjbyzl);
			}
			if(gjcpzt != ""){
				$("#gjcpzt").selectpicker('val', gjcpzt);
			}
			if(gjsfja != ""){
				$("#gjsfja").selectpicker('val', gjsfja);
			}
			if(gjbllx != ""){
				$("#gjbllx").selectpicker('val', gjbllx);
			}
			if(gjcpjd != ""){
				$("#gjcpjd").selectpicker('val', gjcpjd);
			}
			if(gjsccq != ""){
				$("#gjsccq").selectpicker('val', gjsccq);
			}
			
			

		})
		function cancel(){
			jQuery("#demo").removeClass("in");
		}
		function onshowPlanDate1(inputname, spanname, isMustInput) {
			var returnvalue;
			var oncleaingFun = function() {
				if (isMustInput == "2") {
					$ele4p(spanname).innerHTML = "<IMG src='/images/BacoError_wev8.gif' align=absMiddle>";
				} else {
					$ele4p(spanname).innerHTML = "";
				}
				$ele4p(inputname).value = '';
			}
			WdatePicker({
				lang : languageStr,
				el : spanname,
				onpicked : function(dp) {
					returnvalue = dp.cal.getDateStr();
					$dp.$(spanname).innerHTML = returnvalue;
					$dp.$(inputname).value = returnvalue;
				},
				oncleared : oncleaingFun
			});

			var hidename = $ele4p(inputname).value;
			if (hidename != "") {
				$ele4p(inputname).value = hidename;
				$ele4p(spanname).innerHTML = hidename;
			} else {
				if ("2"==isMustInput) {
					$ele4p(spanname).innerHTML = "<IMG src='/images/BacoError_wev8.gif' align=absMiddle>";
				} else {
					$ele4p(spanname).innerHTML = "";
				}
			}
		}
		
		function changeselect(flag) {
			var htmlkhmc = "<%=htmlkhmc%>";
			var htmlblmc = "<%=htmlblmc%>";
			var htmlbyzl = "<%=htmlbyzl%>";
			var htmlbllx = "<%=htmlbllx%>";
			var htmlsccq = "<%=htmlsccq%>";
			jQuery("#seltab").val(flag);
			if (flag == "khmc") {
				jQuery("#mainss2").html(htmlkhmc);
				$("#mainss2").selectpicker('refresh');
			} else if (flag == "blmc") {
				jQuery("#mainss2").html(htmlblmc);
				$("#mainss2").selectpicker('refresh');
			} else if (flag == "byzl") {
				jQuery("#mainss2").html(htmlbyzl);
				$("#mainss2").selectpicker('refresh');
			} else if (flag == "bllx") {
				jQuery("#mainss2").html(htmlbllx);
				$("#mainss2").selectpicker('refresh');
			} else if (flag == "sccq") {
				jQuery("#mainss2").html(htmlsccq);
				$("#mainss2").selectpicker('refresh');
			} else {
				var htmlval = "<option value=''></option>";
				jQuery("#mainss2").html(htmlval);
				$("#mainss2").selectpicker('refresh');
			}

		}

		function getselectOptionhtml(lx) {
			var htmlval = "";
			jQuery.ajax({
				type : "POST",
				url : "/jsp/quality/main/getselectoption.jsp",
				data : {
					'lx' : lx
				},
				dataType : "text",
				async : false,//同步   true异步
				success : function(data) {
					data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
					//alert(data);
					htmlval = data;

				}
			});
			return htmlval;
		}
		function search1() {
			var seltab = jQuery("#seltab").val();
			jQuery("#sel1").val(jQuery("#mainss").val());
			jQuery("#sel2").val(jQuery("#mainss2").val())
			jQuery("#sertype").val("1");
			report.submit();
			
		}
		function search2() {
			jQuery("#sertype").val("2");
			report.submit();
		
		}
		function showkhmin() {
			var title = "客户信息";
			var url = "/jsp/quality/khxx/khxxlistnew.jsp";
			var diag_vote;
			if (window.top.Dialog) {
				diag_vote = new window.top.Dialog();
			} else {
				diag_vote = new Dialog();
			}
			;
			diag_vote.currentWindow = window;

			diag_vote.maxiumnable = true;
			diag_vote.Width = 800;
			diag_vote.Height = 600;
			diag_vote.Model = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			//diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
			diag_vote.show("");

		}
		function showkhdt() {
			var title = "客诉动态";
			var url = "/jsp/quality/ks/ksdtlist.jsp";
			var diag_vote;
			if (window.top.Dialog) {
				diag_vote = new window.top.Dialog();
			} else {
				diag_vote = new Dialog();
			}
			;
			diag_vote.currentWindow = window;

			diag_vote.maxiumnable = true;
			diag_vote.Width = 1000;
			diag_vote.Height = 600;
			diag_vote.Model = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			//diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
			diag_vote.show("");

		}
	</script>
</body>
</html>