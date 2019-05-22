<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.javen.Util.Util"%>
<%@ page import="com.javen.gvo.quality.ks.KSUtil"%>
<%@ page import="com.javen.gvo.quality.util.QualityUtil"%>
<jsp:useBean id="rs" class="com.javen.Util.RecordSet" scope="page" />
<%@ include file="/jsp/quality/systeminfo/init.jsp" %>
<jsp:include page="/jsp/quality/roles/checkRoles.jsp">
	<jsp:param name="cd" value="13" />
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
	String kswfid = qu.getWfid("ks");
	String kxwfid = qu.getWfid("kx");
	String kfrylb = qu.getWfid("kfrylb");
	String bldzb = qu.getWfid("bldzb");
	String khxxxj = qu.getWfid("khxxxj");
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
<link rel="stylesheet"
	href="/static/js/zDialog_e8_wev8.css" />
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
	padding-top: 7px;
	padding-bottom: 7px;
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
<body>
	<div class="container">
		<div class="row mt-10">
			<FORM id=report name=report action="/jsp/quality/main/main.jsp"
				method=post>
				<input type="hidden" id="seltab" name="seltab" value="0"></input> <input
					type="hidden" id="sel1" name="sel1" value="0"></input> <input type="hidden"
					id="sel2" name="sel2" value="0"></input>
					<input type="hidden"  name="sertype" value="1"></input>
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
								<select class="selectpicker" id="mainss" onchange="changest()" data-width="100px">
									<option value="ks" select>客诉</option>
									<option value="kx">客需</option>
									<option value="khxx">客户信息</option>
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
								<SPAN id=selectBeginDateSpan></SPAN> <INPUT type="hidden"
									name="beginDate" id="beginDate" value=""> &nbsp;-&nbsp;
								<button type="button" class="glyphicon glyphicon-calendar"
									id="selectEndDate"
									onclick="onshowPlanDate1('endDate','endDateSpan','1')"></BUTTON>
								<SPAN id=endDateSpan></SPAN> <INPUT type="hidden" name="endDate"
									id="endDate" value="">

							</div>
						</div>
						<div class="col-md-3"></div>
					</div>
				</div>
			</FORM>
		</div>
		<FORM id=report1 name=report1 action="/jsp/quality/ks/kslist.jsp"
			method=post>
			<input type="hidden"  name="sertype" value="2"></input>
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
				         <td class="sf2"> <input type="text" id="gjcpmc" name="gjcpmc" class="form-control" value=""/></td>
				         <td class="sf1">流程编号</td>
				         <td class="sf2"><input type="text" id="gjlcbh" name="gjlcbh" class="form-control" value=""/></td>
				      </tr>
				      <tr>
				          <td class="sf1">不良名称</td>
				         <td class="sf2">
				         	<select id="gjblmc" name="gjblmc"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=htmlblmc%>
							 </select>
				         </td>
				         <td class="sf1">产品型号</td>
				         <td class="sf2"><input type="text" id="gjcpxh" name="gjcpxh" class="form-control" value=""/></td>
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
				         <td class="sf2"><input type="text" id="gjsqr" name="gjsqr" class="form-control" value=""/></td>
				      </tr>
				      <tr>
				      	<td class="sf1">起止日期</td>
				         <td class="sf2">
								<button type="button" class="glyphicon glyphicon-calendar"
									id="gjselectBeginDate"
									onclick="onshowPlanDate1('gjbeginDate','gjselectBeginDateSpan','1')"></BUTTON>
								<SPAN id=gjselectBeginDateSpan></SPAN> <INPUT type="hidden"
									name="gjbeginDate" id="gjbeginDate" value=""/>-
								<button type="button" class="glyphicon glyphicon-calendar"
									id="gjselectEndDate"
									onclick="onshowPlanDate1('gjendDate','gjendDateSpan','1')"></BUTTON>
								<SPAN id=gjendDateSpan></SPAN> <INPUT type="hidden" name="gjendDate"
									id="gjendDate" value=""/>
				         </td>
				         <td class="sf1">生产厂区</td>
				         <td class="sf2">
				         	<select id="gjsccq" name="gjsccq"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=htmlsccq%>
							 </select>
				         </td>
				         <td class="sf1">发生地点</td>
				         <td class="sf2"><input type="text" id="gjfsdd" name="gjfsdd" class="form-control" value=""/></td>
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
		<FORM id=report2 name=report2 action="/jsp/quality/kx/kxlist.jsp"
			method=post>
			<div class="row collapse" id="demo1">
				<div class="col-md-12"
					style="background-color: #FCFCFC; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 1px #E8E8E8; height: 220px">
					<input type="hidden"  name="sertype" value="2"></input>
					<table class="table-bordered table-condensed" style="margin-top:10px;width: 100%;max-width: 100%">
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
					         <select  name="gjgkmc"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=htmlkhmc%>
							 </select>
						 </td>
				         <td class="sf1">产品名称</td>
				         <td class="sf2"> <input type="text" name="gjcpmc" class="form-control" value=""/></td>
				         <td class="sf1">生产厂区</td>
				         <td class="sf2">
				         	<select  name="gjsccq"  class="form-control selectpicker"  data-live-search="true" data-width="80%" data-height="80%">
								<%=htmlsccq%>
							 </select>
				         </td>
				      </tr>
				      <tr>
				          <td class="sf1">客需种类</td>
				         <td class="sf2">
				         <select name="gjkxzl"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=htmlbyzl%>
							 </select>
				         </td>
				         <td class="sf1">产品型号</td>
				         <td class="sf2"><input type="text"  name="gjcpxh" class="form-control" value=""/></td>
				         <td class="sf1">起止日期</td>
				         <td class="sf2">
								<button type="button" class="glyphicon glyphicon-calendar"
									id="gjselectBeginDate1"
									onclick="onshowPlanDate1('gjbeginDate1','gjselectBeginDateSpan1','1')"></BUTTON>
								<SPAN id=gjselectBeginDateSpan1></SPAN> <INPUT type="hidden"
									name="gjbeginDate" id="gjbeginDate1" value="">-
								<button type="button" class="glyphicon glyphicon-calendar"
									id="gjselectEndDate1"
									onclick="onshowPlanDate1('gjendDate1','gjendDateSpan1','1')"></BUTTON>
								<SPAN id=gjendDateSpan1></SPAN> <INPUT type="hidden" name="gjendDate"
									id="gjendDate1" value="">
				         </td>
				      </tr> 
				      <tr>
				         <td class="sf1">客需严重度</td>
				         <td class="sf2">
				         	<select id="gjkxyzd" name="gjkxyzd"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=qu.getSelectOption("ksyzd")%>
							 </select>
				         </td>
				         <td class="sf1">产品状态</td>
				         <td class="sf2">
				           <select id="gjcpzt" name="gjcpzt"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=qu.getSelectOption("cpzt")%>
							 </select></td>
				         <td class="sf1">产品阶段</td>
				         <td class="sf2">
				         	<select id="gjcpjd" name="gjcpjd"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=qu.getSelectOption("cpjd")%>
							 </select>
				         </td>
				      </tr>
				    <tr>
				    <td colspan="6" style="text-align: center;">
				   		 <input type="button" value="查询" class="e8_btn_submit" onclick="search3();">
				   		 <input type="button" value="取消" class="e8_btn_cancel" onclick="cancel();"/>
				    </td>
				    </tr>
				   </tbody>
			   </table>	
				</div>
			</div>
		</FORM>
		<FORM id=report3 name=report3 action="/jsp/quality/khxx/khlist.jsp"
			method=post>
			<div class="row collapse" id="demo2">
				<div class="col-md-12"
					style="background-color: #FCFCFC; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 1px #E8E8E8; height: 220px">
					<input type="hidden"  name="sertype" value="2"></input>
					<table class="table-bordered table-condensed" style="margin-top:10px;width: 100%;max-width: 100%">
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
				         <td class="sf2"> <input type="text" id="gjcpmc" name="gjcpmc" class="form-control" value=""/></td>
				         <td class="sf1">生产厂区</td>
				         <td class="sf2">
				         	<select id="gjsccq" name="gjsccq"  class="form-control selectpicker"  data-live-search="true" data-width="80%" data-height="80%">
								<%=htmlsccq%>
							 </select>
				         </td>
				      </tr>
				      <tr>
				          <td class="sf1">信息编号</td>
				         <td class="sf2"><input type="text" id="gjxxbh" name="gjxxbh" class="form-control" value=""/></td>
				         <td class="sf1">产品型号</td>
				         <td class="sf2"><input type="text" id="gjcpxh" name="gjcpxh" class="form-control" value=""/></td>
				         <td class="sf1">发生日期起止</td>
				         <td class="sf2">
								<button type="button" class="glyphicon glyphicon-calendar"
									id="gjselectBeginDate2"
									onclick="onshowPlanDate1('gjbeginDate2','gjselectBeginDateSpan2','1')"></BUTTON>
								<SPAN id=gjselectBeginDateSpan2></SPAN> <INPUT type="hidden"
									name="gjbeginDate" id="gjbeginDate2" value="">-
								<button type="button" class="glyphicon glyphicon-calendar"
									id="gjselectEndDate2"
									onclick="onshowPlanDate1('gjendDate2','gjendDateSpan2','1')"></BUTTON>
								<SPAN id=gjendDateSpan2></SPAN> <INPUT type="hidden" name="gjendDate"
									id="gjendDate2" value="">
				         </td>
				      </tr> 
				      <tr>
				         <td class="sf1">信息种类</td>
				         <td class="sf2">
				         	<select id="gjxxzl" name="gjxxzl"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=qu.getSelectOption("xxzl")%>
							 </select>
				         </td>
				         <td class="sf1">产品状态</td>
				         <td class="sf2">
				           <select id="gjcpzt" name="gjcpzt"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=qu.getSelectOption("cpzt_kh")%>
							 </select></td>
				         <td class="sf1">产品阶段</td>
				         <td class="sf2">
				         	<select id="gjcpjd" name="gjcpjd"  class="form-control selectpicker"  data-live-search="true" title="请选择" data-width="80%" data-height="80%">
								<%=qu.getSelectOption("cpjd_kh")%>
							 </select>
				         </td>
				      </tr>
				    <tr>
				    <td colspan="6" style="text-align: center;">
				   		 <input type="button" value="查询" class="e8_btn_submit" onclick="search3();">
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
				style="background-color: #4BACC6; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 3px #FFFFFF; height: 30px">
				<div
					style="text-align: center; color: #FFFFFF; font-size: 16px; padding: 2.5px; letter-spacing:4px"><%=xswb%></div>
			</div>
		</div>
		<div class="row mt-10">
			<div class="col-md-12"
				style="background-color: #FCFCFC; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 1px #E8E8E8; height: 270px">
				<div class="row">
					<div class="col-md-3 " style="height: 270px">
						<div class="row">
							<div class="col-xs-6" style="height: 90px">
								<a href="/jsp/quality/OARelated/createRoute.jsp?wfid=<%=kswfid%>" target="_blank" class="thumbnail"> <img
									src="/static/images/ksxjlc.png" alt="通用的占位符缩略图" width="100%">
								</a>
							</div>
							<div class="col-xs-6" style="height: 90px">
								<a href="/jsp/quality/OARelated/createRoute.jsp?wfid=<%=kxwfid%>" target="_blank" class="thumbnail"> <img
									src="/static/images/kxxjlc.png" alt="通用的占位符缩略图" width="100%">
								</a>
							</div>
							<div class="col-xs-6" style="height: 90px">
								<a href="/jsp/quality/OARelated/addModeInfo.jsp?modeid=<%=khxxxj%>" target="_blank" class="thumbnail"> <img
									src="/static/images/khxxxj.png" alt="通用的占位符缩略图" width="100%">
								</a>
							</div>
							<div class="col-xs-6" style="height: 90px">
								<a href="/jsp/quality/khxx/khlist.jsp" target="_blank" class="thumbnail"> <img
									src="/static/images/khxxlb.png" alt="通用的占位符缩略图" width="100%">
								</a>
							</div>
							<div class="col-xs-6" style="height: 90px">
								<a href="/jsp/quality/ks/kslist.jsp" target="_blank" class="thumbnail"> <img
									src="/static/images/ksxxlb.png" alt="通用的占位符缩略图" width="100%">
								</a>
							</div>
							<div class="col-xs-6" style="height: 90px">
								<a href="/jsp/quality/kx/kxlist.jsp" target="_blank" class="thumbnail"> <img
									src="/static/images/kxxxlb.png" alt="通用的占位符缩略图" width="100%">
								</a>
							</div>
						</div>
					</div>
					<div class="col-md-9 " style="height: 270px">
						<div class="row">
							<div class="col-md-12 "
								style="height: 32px; padding-left: 4px; padding-top: 4px">
								<span class="label label-info"
									style="font-size: 17px; vertical-align: bottom">客户信息</span> <a
									target="_blank" href="javascript:showkhmin()"
									class="btn btn-white btn-xs pull-right">更多>></a>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 "
								style="padding-left: 4px; padding-right: 4px">
								<table class="table" style='table-layout: fixed;font-size:13px;'>
									<thead>
										<tr style="background-color: #CECECE; font-size:14px;">
											<th width="20%">信息编号</th>
											<th width="15%">客户名称</th>
											<th width="15%">信息种类</th>
											<th width="50%">信息描述</th>
										</tr>
									</thead>
									<tbody>
										<%
											sql = "select * from (select id,infono,(select cus_name from uf_kskx_customer where id=a.cus_name) as cus_name,(select info_name from uf_kskx_infotype where id=a.infotype) as infotype,cus_des from uf_kskx_cus_product a order by id desc) where rownum<=6";
											rs.executeQuery(sql);
											int count = 1;
											while (rs.next()) {
												if (count > 6) {
													break;
												}
												String billid = Util.null2String(rs.getString("id"));
												String infono = Util.null2String(rs.getString("infono"));
												String cus_name = Util.null2String(rs.getString("cus_name"));
												String infotype = Util.null2String(rs.getString("infotype"));
												String cus_des = Util.null2String(rs.getString("cus_des")).replace("<br>", "&nbsp;&nbsp;");
												if(!"".equals(infono)) {
													infono = "<a class=\"text-primary\" href=\"/jsp/quality/OARelated/showModeinfo.jsp?modeid="+khxxxj+"&billid="+billid+"\" target=\"_blank\">"+infono+"</a>";
												}
												if (count <= 3) {
										%>
										<tr class="warning">
											<td><%=infono%></td>
											<td><%=cus_name%></td>
											<td><%=infotype%></td>
											<td><%=cus_des%></td>
										</tr>
										<%
											} else {
										%>
										<tr class="success">
											<td><%=infono%></td>
											<td><%=cus_name%></td>
											<td><%=infotype%></td>
											<td><%=cus_des%></td>
										</tr>
										<%
											}
												count++;
											}
										%>

									</tbody>
								</table>
							</div>
						</div>

					</div>

				</div>
			</div>
		</div>
		<div class="row mt-10">
			<div class="col-md-12"
				style="background-color: #FCFCFC; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 1px #E8E8E8; height: 270px">
				<div class="row">
					<div class="col-md-12 "
						style="height: 32px; padding-left: 4px; padding-top: 4px">
						<span class="label label-info"
							style="font-size: 17px; vertical-align: bottom">客诉动态</span> <a  href="javascript:showkhdt();"
							class="btn btn-white btn-xs pull-right">更多>></a>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 "
						style="padding-left: 4px; padding-right: 4px">
						<table class="table" style='table-layout: fixed; font-size:13px;'>
							<thead>
								<tr style="background-color: #CECECE; font-size:14px;">
									<th width="6%">状态</th>
									<th width="13%">客诉编号</th>
									<th width="9%">客户名称</th>
									<th width="9%">客诉种类</th>
									<th width="9%">不良名称</th>
									<th width="9%">不良率</th>
									<th width="9%">阶段/H</th>
									<th width="9%">责任人</th>
									<th width="9%">累计延期</th>
									<th width="9%">预警次数</th>
									<th width="9%">是否结案</th>
								</tr>
							</thead>
							<tbody>
								<%String ksdtstr = ksu.getksdtlist();%>
								<%=ksdtstr%>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row mt-10">
			<div class="col-md-12 "
				style="background-color: #FCFCFC; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 1px #E8E8E8; height: 60px; text-align: center">
				<div style="padding-top: 10px">
					<span style="color: blue">本站资讯：</span><a class="text-primary" 
						href="/jsp/quality/ks/kslist.jsp" target="_blank">客诉列表</a>&nbsp;&nbsp; 
						<a class="text-primary" href="/jsp/quality/kx/kxlist.jsp" target="_blank">客需列表</a>&nbsp;&nbsp;
					<a class="text-primary" href="/jsp/quality/khxx/khlist.jsp" target="_blank">客户信息列表</a>&nbsp;&nbsp; <a
						class="text-primary" href="/jsp/quality/OARelated/showModeQuery.jsp?customid=<%=kfrylb%>" target="_blank">客服人员信息</a>&nbsp;&nbsp; <a
						class="text-primary" href="/jsp/quality/OARelated/showModeQuery.jsp?customid=<%=bldzb%>" target="_blank">不良对照表</a>&nbsp;&nbsp; <a
						class="text-primary" href="/jsp/quality/ks/kssm.jsp" target="_blank">客诉说明(一般/重大) </a><br /> <span
						style="color: blue">外部链接：</span> <a class="text-info"
						target="_blank"
						href="http://report.visionox.cn:8080/GvoReport/decision#directory">VLRR系统</a>&nbsp;&nbsp;
					<a class="text-info" target="_blank"
						href="http://172.16.135.26:8080/wms-visionox-web-login/home.jsp">RMA系统</a>&nbsp;&nbsp;
					<a class="text-info" target="_blank"
						href="http://10.69.2.111/VidasLauncher">Vidas系统</a>&nbsp;&nbsp; <a
						class="text-info" href="#">QIT信息</a>&nbsp;&nbsp;

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
		jQuery(document).ready(function() {
			jQuery("#optionkhmc").click();

		})
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
				if ("2".equals(isMustInput)) {
					$ele4p(spanname).innerHTML = "<IMG src='/images/BacoError_wev8.gif' align=absMiddle>";
				} else {
					$ele4p(spanname).innerHTML = "";
				}
			}
		}
		function changest() {
			var selval = jQuery("#mainss").val()
			var htmlval = "";
			if(selval == "ks"){
				jQuery("#demo1").removeClass("in");
				jQuery("#demo2").removeClass("in");
				jQuery("#gjss").attr("data-target","#demo");
			}else if(selval == "kx"){
				jQuery("#demo").removeClass("in");
				jQuery("#demo2").removeClass("in");
				jQuery("#gjss").attr("data-target","#demo1");
			}else if(selval == "khxx"){
				jQuery("#demo1").removeClass("in");
				jQuery("#demo").removeClass("in");
				jQuery("#gjss").attr("data-target","#demo2");
			}
			if (selval == "kx" || selval == "khxx") {
				htmlval = "<label class=\"btn btn22\" onclick=\"changeselect('khmc')\"> <input type=\"radio\" name=\"ptions\" id=\"optionkhmc\">客户名称</label> "
						+ "<label class=\"btn btn22\" onclick=\"changeselect('sccq')\"> <input type=\"radio\" name=\"options\" id=\"optionsccq\">生产厂区</label>";
				jQuery("#maintab").html(htmlval);
				jQuery("#optionkhmc").click();

			} else if (selval == "ks") {
				htmlval = "<label class=\"btn btn22\" onclick=\"changeselect('khmc')\"> <input type=\"radio\" name=\"ptions\" id=\"optionkhmc\">客户名称</label> "
						+ "<label class=\"btn btn22\" onclick=\"changeselect('blmc')\"> <input type=\"radio\" name=\"options\" id=\"optionblmc\">不良名称</label> "
						+ "<label class=\"btn btn22\" onclick=\"changeselect('byzl')\"> <input type=\"radio\" name=\"options\" id=\"optionbyzl\">抱怨种类</label>"
						+ "<label class=\"btn btn22\" onclick=\"changeselect('bllx')\"> <input type=\"radio\" name=\"options\" id=\"optionbllx\">不良类型</label>"
						+ "<label class=\"btn btn22\" onclick=\"changeselect('sccq')\"> <input type=\"radio\" name=\"options\" id=\"optionsccq\">生产厂区</label>";
				jQuery("#maintab").html(htmlval);
				jQuery("#optionkhmc").click();
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
			var sel1 = jQuery("#sel1").val();
			if(sel1 == "ks"){
				window.parent.changebtlxs("首页》客诉列表")
				document.report.action="/jsp/quality/ks/kslist.jsp";
				report.submit();
			}else if(sel1 == "kx"){
				window.parent.changebtlxs("首页》客需列表")
				document.report.action="/jsp/quality/kx/kxlist.jsp";
				report.submit();
			}else if(sel1 == "khxx"){
				window.parent.changebtlxs("首页》客户信息列表")
				document.report.action="/jsp/quality/khxx/khlist.jsp";
				report.submit();
			}
		}
		
		function search2() {
			var seltab = jQuery("#seltab").val();
			jQuery("#sel1").val(jQuery("#mainss").val());
			jQuery("#sel2").val(jQuery("#mainss2").val())
			var sel1 = jQuery("#sel1").val();
			if(sel1 == "ks"){
				window.parent.changebtlxs("首页》客诉列表")
				document.report1.action="/jsp/quality/ks/kslist.jsp";
				report1.submit();
			}
		}
		function search3() {
			var seltab = jQuery("#seltab").val();
			jQuery("#sel1").val(jQuery("#mainss").val());
			jQuery("#sel2").val(jQuery("#mainss2").val())
			var sel1 = jQuery("#sel1").val();
			if(sel1 == "kx"){
				window.parent.changebtlxs("首页》客需列表")
				document.report1.action="/jsp/quality/kx/kxlist.jsp";
				report2.submit();
			}
		}
		function search3() {
			var seltab = jQuery("#seltab").val();
			jQuery("#sel1").val(jQuery("#mainss").val());
			jQuery("#sel2").val(jQuery("#mainss2").val())
			var sel1 = jQuery("#sel1").val();
			if(sel1 == "khxx"){
				window.parent.changebtlxs("首页》客户信息列表")
				document.report1.action="/jsp/quality/khxx/khlist.jsp";
				report3.submit();
			}
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