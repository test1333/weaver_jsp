package htkj.project;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class UpdatePrjInfoByxmpg implements Action {
	public String execute(RequestInfo info) {
		BaseBean log = new BaseBean();
		log.writeLog("UpdatePrjInfoByxmpg_start");
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String xmzz = "";
		String xsy = "";
		String xmgcs = "";
		String khmc ="";
		String khdm = "";
		String cus_contacter = "";
		String khlxrdh = "";
		String khlxryx = "";
		String cplx = "";
		String project_name = "";
		String sql = "Select tablename From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id="+workflow_id+")";
		rs.executeSql(sql);
		
		//	rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		if (!"".equals(tableName)) {
			sql="select xmzz,xsy,xmgcs,khmc,khdm,cus_contacter,khlxrdh,khlxryx,cplx,project_name from "+tableName+" where requestid="+requestid;
			log.writeLog("sql ---------" + sql);
			rs.executeSql(sql);
			if(rs.next()){
				xmzz = Util.null2String(rs.getString("xmzz"));
				xsy = Util.null2String(rs.getString("xsy"));
				xmgcs = Util.null2String(rs.getString("xmgcs"));
				khmc = Util.null2String(rs.getString("khmc"));
				khdm = Util.null2String(rs.getString("khdm"));
				cus_contacter = Util.null2String(rs.getString("cus_contacter"));
				khlxrdh = Util.null2String(rs.getString("khlxrdh"));
				khlxryx = Util.null2String(rs.getString("khlxryx"));
				cplx = Util.null2String(rs.getString("cplx"));
				project_name = Util.null2String(rs.getString("project_name"));
			}
			sql="update cus_fielddata set xmzz='"+xmzz+"',xsy='"+xsy+"',proer1='"+xmgcs+"',khmc='"+khmc+"',khdm='"+khdm+"',"+
                " khlxr='"+cus_contacter+"',khlxrdh='"+khlxrdh+"',khlxryx='"+khlxryx+"',cplx=(select name from mode_selectitempagedetail where mainid=21 and id="+cplx+") where scope='ProjCustomFieldReal' and id="+project_name;
			log.writeLog("updatesql ---------" + sql);
			rs.executeSql(sql);
		}

		return SUCCESS;
	}

}
