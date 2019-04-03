<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="ModeRightInfo" class="weaver.formmode.setup.ModeRightInfo" scope="page" />
<%
	
	String projid = Util.null2String(request.getParameter("projid"));
	if(!"".equals(projid)){
		String sql = " select xmzt,ytlx from formtable_main_2471 where id="+projid;
		String projstatus = "";
		String ytlx = "";
		RecordSet.executeSql(sql);
		if(RecordSet.next()){
			projstatus = Util.null2String(RecordSet.getString("xmzt"));
			ytlx = Util.null2String(RecordSet.getString("ytlx"));
			log.writeLog("ytlx="+ytlx);
		}
		if("".equals(projstatus)){
			RecordSet.executeSql("update formtable_main_2471 set xmzt = 0 where id="+projid);
		}
		String sql_0 = " select count(id) as num_cc from formtable_main_2481 where ssxm = " + projid;
        int num_cc = 0;
        rs.executeSql(sql_0);
        if (rs.next()) {
            num_cc = rs.getInt("num_cc");
		}
		
		if(num_cc == 0){
			if(!"".equals(ytlx)){
				//formtable_main_2790 正式环境 任务配置表；formtable_main_2490 测试环境任务配置表
				String sql_mission = "select rwmc,fzr,sfkx,ssjd from formtable_main_2490 where sfkx=0 and ssjd=0 and remark=" + ytlx;
				rs.execute(sql_mission);
				if (rs.next()) {
					String miName = Util.null2String(rs.getString("rwmc"));
					String miCharge = Util.null2String(rs.getString("fzr"));
					log.writeLog("miName=" + miName);


					String sql_insert=" insert into formtable_main_2481(rwmc,formmodeid,ssxm,fzr,modedatacreater,FTriggerFlag) "
					+" values('"+miName+"','581','"+projid+"','"+miCharge+"','"+miCharge+"',0) ";
					res.executeSql(sql_insert);

					String sql_1 = " select id,formmodeid from formtable_main_2481 where ssxm = " + projid;
                    res.executeSql(sql_1);
                    log.writeLog("sql_1=" + sql_1);
                    if (res.next()) {
                        String dataID = Util.null2String(res.getString("id"));
                        String formmodeid = Util.null2String(res.getString("formmodeid"));
                        log.writeLog("dataID=" + dataID);
                        //新插入数据权限重构
                        //ModeRightInfo modeRightInfo = new ModeRightInfo();
                        ModeRightInfo.editModeDataShare(Integer.parseInt(miCharge), 581, Integer.parseInt(dataID));
                        //i:人员ID;i1:formmodeid;i2:id
                        ModeRightInfo.editModeDataShareForModeField(Integer.parseInt(miCharge), 581, Integer.parseInt(dataID));
                    }
				}
			}
		}
	}
	response.sendRedirect("/gcl/jsp/gcl_project_process_new.jsp?billid="+projid);
%>