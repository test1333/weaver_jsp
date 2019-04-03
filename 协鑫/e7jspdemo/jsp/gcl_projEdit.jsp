<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ModeRightInfo" class="weaver.formmode.setup.ModeRightInfo" scope="page" />
<%
	
	String projid = Util.null2String(request.getParameter("projid"));
	String projName = Util.null2String(request.getParameter("projName"));
	String opttype = Util.null2String(request.getParameter("opttype"));
	out.print("projid="+projid);
	out.print("projName="+projName);
	out.print("opttype="+opttype);
	String miCharge = "6236";
	Date beforeDate = new Date();
	if(!"".equals(projid)&&!"".equals(projName)&&!"".equals(opttype)){
		RecordSet.executeSql("update formtable_main_2471 set xmzt = nvl(xmzt,0)+1 where id="+projid);
		if("0".equals(opttype)){
			String missionName = projName+"搜集详细资料";
			String sql_0 = " select count(id) as num_cc from formtable_main_2486 where ssxm = " + projid + " and rwmc = '" + missionName + "' and cjr=" + miCharge + " ";
			int num_cc = 0;
			res.executeSql(sql_0);
			if (res.next()) {
				num_cc = res.getInt("num_cc");
			}
			if(num_cc==0){
				String sql_insert=" insert into formtable_main_2486(rwmc,formmodeid,ssxm,cjr,modedatacreater) "
				+" values('"+missionName+"','1081','"+projid+"','"+miCharge+"','"+miCharge+"') ";
				res.executeSql(sql_insert);
				
				String sql_1 = " select id,formmodeid from formtable_main_2486 where ssxm = " + projid + " and cjr="+miCharge+" ";
				res.executeSql(sql_1);
				out.print("sql_1="+sql_1);
				if (res.next()) {
					String dataID = Util.null2String(res.getString("id"));
					String formmodeid = Util.null2String(res.getString("formmodeid"));
					out.print("formmodeid="+formmodeid);
					//新插入数据权限重构
					//ModeRightInfo modeRightInfo = new ModeRightInfo();
					ModeRightInfo.editModeDataShareForModeField(Integer.parseInt(miCharge),1081,Integer.parseInt(dataID));
					ModeRightInfo.editModeDataShare(Integer.parseInt(miCharge),1081, Integer.parseInt(dataID));
				}
			}
		}else if("1".equals(opttype)){
			String missionName = projName+"签订合作意向书";
			String sql_0 = " select count(id) as num_cc from formtable_main_2487 where ssxm = " + projid + " and rwmc = '" + missionName + "' and cjr=" + miCharge + " ";
			int num_cc = 0;
			res.executeSql(sql_0);
			if (res.next()) {
				num_cc = res.getInt("num_cc");
			}
			if(num_cc==0){
				String sql_insert=" insert into formtable_main_2487(rwmc,formmodeid,ssxm,cjr,modedatacreater) "
				+" values('"+missionName+"','1082','"+projid+"','"+miCharge+"','"+miCharge+"') ";
				res.executeSql(sql_insert);
				
				String sql_1 = " select id,formmodeid from formtable_main_2487 where ssxm = " + projid + " and cjr="+miCharge+" ";
				res.executeSql(sql_1);
				out.print("sql_1="+sql_1);
				if (res.next()) {
					String dataID = Util.null2String(res.getString("id"));
					String formmodeid = Util.null2String(res.getString("formmodeid"));
					out.print("formmodeid="+formmodeid);
					//新插入数据权限重构
					//ModeRightInfo modeRightInfo = new ModeRightInfo();
					ModeRightInfo.editModeDataShareForModeField(Integer.parseInt(miCharge), 1082, Integer.parseInt(dataID));
					ModeRightInfo.editModeDataShare(Integer.parseInt(miCharge),1082, Integer.parseInt(dataID));
				}
			}
		}else if("2".equals(opttype)){
			String missionName = projName+"设计详细方案";
			String sql_0 = " select count(id) as num_cc from formtable_main_2488 where ssxm = " + projid + " and rwmc = '" + missionName + "' and cjr=" + miCharge + " ";
			int num_cc = 0;
			res.executeSql(sql_0);
			if (res.next()) {
				num_cc = res.getInt("num_cc");
			}
			if(num_cc==0){
				String sql_insert=" insert into formtable_main_2488(rwmc,formmodeid,ssxm,cjr,modedatacreater) "
				+" values('"+missionName+"','1083','"+projid+"','"+miCharge+"','"+miCharge+"') ";
				res.executeSql(sql_insert);
				
				String sql_1 = " select id,formmodeid from formtable_main_2488 where ssxm = " + projid + " and cjr="+miCharge+" ";
				res.executeSql(sql_1);
				out.print("sql_1="+sql_1);
				if (res.next()) {
					String dataID = Util.null2String(res.getString("id"));
					String formmodeid = Util.null2String(res.getString("formmodeid"));
					out.print("formmodeid="+formmodeid);
					//新插入数据权限重构
					//ModeRightInfo modeRightInfo = new ModeRightInfo();
					ModeRightInfo.editModeDataShareForModeField(Integer.parseInt(miCharge), 1082, Integer.parseInt(dataID));
					ModeRightInfo.editModeDataShare(Integer.parseInt(miCharge),1083, Integer.parseInt(dataID));
				}
			}
		}
		//RequestDispatcher rd = request.getRequestDispatcher("/gcl/jsp/gcl_project_process_new.jsp?billid="+projid+"&rd="+beforeDate);
		//rd.forward(request,response);
		response.sendRedirect("/gcl/jsp/gcl_project_process_new.jsp?billid="+projid+"&rd="+beforeDate);
	}
	
%>

<script type="text/javascript">
	gcl_reload();

	function gcl_reload(){
		alert("项目状态修改成功！");
		var projid = "<%=projid%>";
		window.opener.location.reload("/gcl/jsp/gcl_project_process_new.jsp?billid="+projid); //刷新父窗口中的网页
		window.open('','_self');//关闭IE提醒
		window.close("/gcl/jsp/gcl_projEdit.jsp);//关闭当前窗窗口	
	}
</script>