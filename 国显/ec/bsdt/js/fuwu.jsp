<%@page import="weaver.systeminfo.SystemEnv"%>
<%@page import="bsdt.bean.FwlxBean" %> 
<%@page import="java.util.*"%>
<%@page import="java.util.Set"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%@ page import="weaver.general.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs3" class="weaver.conn.RecordSet" scope="page" />
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>服务中心</title>
		<meta name="description" content="port" />
		<meta name="viewport"
			content="width=device-width, initial-scale=1, maximum-scale=1" />
		<link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
		<link rel="stylesheet" href="css/animate.css" type="text/css" />
		<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
		<link rel="stylesheet" href="css/font.css" type="text/css"
			cache="false" />
		<link rel="stylesheet" href="css/plugin.css" type="text/css" />
		<link rel="stylesheet" href="css/app.css" type="text/css" />
		<script type="text/javascript"
			src="/js/ecology8/lang/weaver_lang_7_wev8.js"></script>
		<script type="text/javascript"
			src="/js/select/script/jquery-1.8.3.min_wev8.js"></script>
		<script type="text/javascript"
			src="/wui/common/jquery/jquery.min_wev8.js"></script>
		<script language=javascript
			src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
		<script language="javascript" type="text/javascript"
			src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language="javascript" src="/bsdt/js/common.js"></script>
		<!--[if lt IE 9]>
    <script src="js/ie/respond.min.js" cache="false"></script>
    <script src="js/ie/html5.js" cache="false"></script>
    <script src="js/ie/excanvas.js" cache="false"></script>
    <script src="js/ie/fix.js" cache="false"></script>
  <![endif]-->
	</head>
	<body>
		<%
					String serviceTypeId = Util.null2String(request
					.getParameter("serviceTypeId"));//服务类型
			String serviceName = Util.null2String(request
					.getParameter("serviceName")); //服务名称
			String departId = Util
					.null2String(request.getParameter("departId")); //部门类型
			String hrmTypeId = Util.null2String(request
					.getParameter("hrmTypeId")); //人员类型
			String roleId = Util.null2String(request.getParameter("roleId")); //角色类型

			if (serviceName == null) {
				serviceName = "";
			}
		%>
		<!-- .vbox -->
		<section class="vbox">
		<%@ include file="head.jsp"%>
		<section class="scrollable">
		<div class="slim-scroll wrapper" data-height="auto"
			data-disable-fade-out="true" data-distance="0">
			<section class="panel bg-info">
			<div class="panel-body">
				<form class="" action="fuwu.jsp">
					<div class="input-group input-group" style="max-width: 700px; ">
						<span class="input-group-addon dker no-border"><i
							class="icon-fighter-jet"></i>
						</span>
						<input name="serviceTypeId" type="hidden" id="serviceTypeId"
							value="<%=serviceTypeId%>" />
						<input name="hrmTypeId" type="hidden" id="hrmTypeId"
							value="<%=hrmTypeId%>" />
						<input name="departId" type="hidden" id="departId"
							value="<%=departId%>" />
						<input name="roleId" type="hidden" id="roleId" value="<%=roleId%>" />
						<input type="text" class="form-control input no-border"
							name="serviceName" id="serviceName" value="<%=serviceName%>"
							placeholder="搜索服务事项">
						<span class="input-group-btn">
							<button class="btn btn-success" type="submit">
								搜索
							</button> </span>
					</div>
				</form>
			</div>
			<div class="m-b">
				<div class="line line-dashed"></div>
				<div class="padder">
					<span class="h5 m-r">按人员类型</span>
					<span> <%
 	String hrmTypeAllClass = "btn btn-white btn-sm";
 	if (!"".equals(hrmTypeId)) {
 		hrmTypeAllClass = "btn dker btn-sm";
 	}
 %> <a href="#" name="hrmType"
						onclick="onHrmType('',this);" class="<%=hrmTypeAllClass%>">全部</a>
						<%
							String queryRylx = "select * from uf_ser_rylx order by xh";
							rs.executeSql(queryRylx);
							while (rs.next()) {
								String rylxId = rs.getString("id");
								String lxmc = rs.getString("lxmc");
								String hrmTypeClass = "btn dker btn-sm";
								if (hrmTypeId.equals(rylxId)) {
									hrmTypeClass = "btn btn-white btn-sm";
								}
						%> <a href="#" name="hrmType"
						onclick="onHrmType('<%=rylxId%>',this);" class="<%=hrmTypeClass%>"><%=lxmc%>
					</a> <%
 }
 %> </span>
				</div>
				<div class="line line-dashed"></div>
				<div class="padder">
					<span class="h5 m-r">按角色类型</span>
					<span> <%
 	String roleAllClass = "btn btn-white btn-sm";
 	if (!"".equals(roleId)) {
 		roleAllClass = "btn dker btn-sm";
 	}
 %> <a href="#" name="roleId"
						onclick="onRoleType('',this);" class="<%=roleAllClass%>">全部</a> <%
 	String queryJslx = "select * from uf_ser_jslx order by xh";
 	rs.executeSql(queryJslx);
 	while (rs.next()) {
 		String jslxId = rs.getString("id");
 		String lxmc = rs.getString("lxmc");
 		String roleClass = "btn dker btn-sm";
 		if (roleId.equals(jslxId)) {
 			roleClass = "btn btn-white btn-sm";
 		}
 %> <a href="#" name="roleId"
						onclick="onRoleType('<%=jslxId%>',this);" class="<%=roleClass%>"><%=lxmc%>
					</a> <%
 }
 %> </span>
				</div>
				<div class="line line-dashed"></div>
				<div class="padder">
					<span class="h5 m-r">按部门类型</span>
					<span> <%
 	String deptAllClass = "btn btn-white btn-sm";
 	if (!"".equals(departId)) {
 		deptAllClass = "btn dker btn-sm";
 	}
 %> <a href="#" name="departId"
						onclick="onDepartType('',this);" class="<%=deptAllClass%>">全部</a>
						<%
							String queryBmlx = "select * from uf_ser_bmlx order by xh";
							rs.executeSql(queryBmlx);
							while (rs.next()) {
								String bmlxId = rs.getString("id");
								String lxmc = rs.getString("lxmc");
								String deptClass = "btn dker btn-sm";
								if (departId.equals(bmlxId)) {
									deptClass = "btn btn-white btn-sm";
								}
						%> <a href="#" name="departId"
						onclick="onDepartType('<%=bmlxId%>',this);" class="<%=deptClass%>"><%=lxmc%>
					</a> <%
 }
 %> </span>
				</div>
				<div class="line line-dashed"></div>
				<div class="padder">
					<span class="h5 m-r">按服务类型</span>
					<span> <%
 	String serviceTypeAllClass = "btn btn-white btn-sm";
 	if (!"".equals(serviceTypeId)) {
 		serviceTypeAllClass = "btn dker btn-sm";
 	}
 %> <a href="#" name="serviceType"
						onclick="onServiceType('',this);" class="<%=serviceTypeAllClass%>">全部</a>
						<%
							String queryFwlx = "select * from uf_ser_fulx order by xh";
							rs.executeSql(queryFwlx);
							while (rs.next()) {
								String fwlxId = rs.getString("id");
								String lxmc = rs.getString("lxmc");
								String serviceTypeClass = "btn dker btn-sm";
								if (serviceTypeId.equals(fwlxId)) {
									serviceTypeClass = "btn btn-white btn-sm";
								}
						%> <a href="#" name="serviceType"
						onclick="onServiceType('<%=fwlxId%>',this);"
						class="<%=serviceTypeClass%>"><%=lxmc%>
					</a> <%
 }
 %> </span>
				</div>
				<div class="line line-dashed"></div>
			</div>
			</section>

			<section class="wrapper">
			<div class="row">

				<div class="col-lg-12">
					<h3 class="font-thin">
						办事服务目录
					</h3>
					<h5>
						请根据您的事项需求选择办事服务应用.
					</h5>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12 m-b">
					<div>
						<%
							BaseBean bb = new BaseBean();
							Set<String> set = new HashSet<String>();
							String serviceSql = " select service.id,service.fwmc,service.dtbys,service.rylx,service.jslx,service.bmlx,service.fwlx,service.fwlj,service.xh,item.selectname as xtbys from uf_ser_services service "
									+ "left join workflow_selectitem item on service.xtbys=item.selectvalue where item.fieldid=14963 ";
							if (serviceName != null && !"".equals(serviceName)) {
								serviceSql += " and service.fwmc like '%" + serviceName + "%'";
							}
							if (serviceTypeId != null && !"".equals(serviceTypeId)) {
								serviceSql += " and service.fwlx=" + serviceTypeId;
							}
							if (departId != null && !"".equals(departId)) {
								serviceSql += " and service.bmlx=" + departId;
							}
							if (hrmTypeId != null && !"".equals(hrmTypeId)) {
								serviceSql += " and ','||service.rylxdx||',' like '%,"
								+ hrmTypeId + ",%'  ";
							}
							if (roleId != null && !"".equals(roleId)) {
								serviceSql += "  and ','||service.jslxdx||',' like '%,"
								+ roleId + ",%' ";
							}
							serviceSql += " order by xh ";
							rs1.executeSql(serviceSql);
							bb.writeLog("11111111::::::::::" + serviceSql);
							String id="";
							String clss="";
							String fwmc="";
							Map<String,List> map=new HashMap<String,List>();
							List<FwlxBean> list=new ArrayList<FwlxBean>();
							FwlxBean fw=new FwlxBean();
							String  selsql="select fwlxdx from uf_ser_services group by fwlxdx";
							rs3.executeSql(selsql);
							while(rs3.next()){
								map.put(rs3.getString("fwlxdx"), list);
							}
							while (rs1.next()) {
												fw.setId(rs1.getString("id"));
												fw.setFwlx(rs1.getString("fwlx"));
												fw.setFwmc(rs1.getString("fwmc"));
												fw.setXtbys(rs1.getString("xtbys"));
												map.get(rs1.getString("fwlx")).add(fw);
											}
							for(String ss:map.keySet()){
								if(ss!=""||ss!=null){
								%>
										<section id="<%=ss%>">
										<h4 class="page-header"><%=ss%></h4>
										<div class="row the-icons">
								<% 
									ArrayList<FwlxBean> as=(ArrayList)map.get(ss);
									for(FwlxBean f:as){
								%>

								<div class="col-sm-3">
								<a href="#modal" onclick="showService('<%=f.getId()%>');" data-toggle="modal" class="dk m5"><i class="<%=f.getXtbys()%>"></i> <%=f.getFwmc()%></a>
							</div>		
								<% 
								
									}
														
						%>


						</div>
						</section>
							<% 
							}
							%>
				<%
						}
						%>

					</div>
				</div>
			</div>

			</section>
			<footer class="footer bg-black pull-out m-t-xl">
			<p>
				同济大学 版权所有. 上海市四平路1239号 021-65982200 E-mail:webmaster@tongji.edu.cn
				沪ICP备10014176号
			</p>
			</footer>
		</div>
		</section>
		</section>
		<!-- /.vbox -->

		<!-- .modal -->
		<div id="modal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title">
							<span id="fwmcTitleId">校园网二级域名及外网IP地址申请</span>
						</h4>
					</div>
					<div class="modal-body">
						<section class="panel">
						<div class="table-responsive">
							<table class="table table-striped text-sm  m-b-sm">
								<tbody>
									<tr>
										<th>
											服务名称
										</th>
										<td id="fwmcid"></td>
										<td width="10"></td>
										<th>
											事项编号
										</th>
										<td id="sxbhid"></td>
									</tr>
									<tr>
										<th>
											事项简称
										</th>
										<td id="sxjcid"></td>
										<td width="10"></td>
										<th>
											承诺期限
										</th>
										<td id="cnqxid"></td>
									</tr>
									<tr>
										<th>
											受理地址
										</th>
										<td id="sldzid"></td>
										<td width="10"></td>
										<th>
											事务负责人
										</th>
										<td id="swfzrid"></td>
									</tr>
									<tr>
										<th>
											咨询电话
										</th>
										<td id="zxdhid"></td>
										<td width="10"></td>
										<th>
											监督电话
										</th>
										<td id="jddhid"></td>
									</tr>
									<tr>
										<th>
											部门类型
										</th>
										<td id="bmlxid"></td>
										<td width="10"></td>
										<th>
											服务类型
										</th>
										<td id="fwlxid"></td>
									</tr>
									<tr>
										<th>
											流程图
										</th>
										<td colspan="4" id="lctid">
										</td>
									</tr>
									<tr>
										<th>
											相关资料
										</th>
										<td colspan="4" id="xgzlid">
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="line"></div>
						<div class="modal-body" id="sxsmid">
						</div>
						</section>
					</div>
					<div class="modal-footer">
						<input type="hidden" id="fwljid" />
						<button type="button" class="btn btn-info" id="submitid"
							onclick="submitWf();">
							立即申请
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->

		<!-- Bootstrap -->
		<script src="js/bootstrap.js"></script>
		<!-- App -->
		<script src="js/app.js"></script>
		<script src="js/app.plugin.js"></script>
		<script src="js/app.data.js"></script>
		<script src="js/slimscroll/jquery.slimscroll.min.js" cache="false"></script>
		<script src="js/libs/moment.min.js"></script>
		<script src="js/charts/easypiechart/jquery.easy-pie-chart.js"></script>
	</body>
</html>
