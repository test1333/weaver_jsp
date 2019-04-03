package htkj.alarm;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;

public class CreateAlarmServiceAction {
	public void CreateAlarmService(String ids, String creater) throws Exception {
		BaseBean log = new BaseBean();
		RecordSet rs = new RecordSet();
		AutoRequestService ars= new AutoRequestService();
		String sql = "";
		String dataIds[] = ids.split(",");
		String dataId = "";
		String wheresystem = "";
		String aramid = "";
		String remark = "";
		String gxbh = "";
		String pc = "";
		String lh = "";
		String sbbh = "";
		String ygxm = "";
		String status = "";
		String sqrbm = "";
		String sqr = creater;
		String sqrq = "";
		String mainid="";
		String workflowCode="1302";
        //log.writeLog("开始创建alarmids"+ids+"creater"+creater);
		sql="select departmentid,to_char(sysdate,'yyyy-mm-dd') as sqrq from hrmresource where id="+creater;
		rs.executeSql(sql);
		if(rs.next()){
			sqrbm = Util.null2String(rs.getString("departmentid"));
			sqrq = Util.null2String(rs.getString("sqrq"));
		}
		
		
		for (int i = 0; i < dataIds.length; i++) {
			dataId = dataIds[i];
			sql = "select * from uf_alarm_info where status='0' and id="
					+ dataId;
			//log.writeLog("开始创建alarmsql"+sql);
			rs.executeSql(sql);
			if (rs.next()) {
				mainid = Util.null2String(rs.getString("id"));
				wheresystem = Util.null2String(rs.getString("wheresystem"));
				aramid = Util.null2String(rs.getString("aramid"));
				remark = Util.null2String(rs.getString("remark"));
				gxbh = Util.null2String(rs.getString("gxbh"));
				pc = Util.null2String(rs.getString("pc"));
				lh = Util.null2String(rs.getString("lh"));
				sbbh = Util.null2String(rs.getString("sbbh"));
				ygxm = Util.null2String(rs.getString("ygxm"));
				status = Util.null2String(rs.getString("status"));
				JSONObject json = new JSONObject();
				JSONObject header = new JSONObject();
				JSONArray detail = new JSONArray();
				json.put("HEADER", header);
				json.put("DETAILS", detail);
				header.put("wheresystem", wheresystem);
				header.put("aramid", aramid);
				header.put("remark", remark);
				header.put("gxbh", gxbh);
				header.put("pc", pc);
				header.put("lh", lh);
				header.put("sbbh", sbbh);
				header.put("ygxm", ygxm);
				header.put("status", status);
				header.put("sqrbm", sqrbm);
				header.put("sqrq", sqrq);
				header.put("sqr", sqr);
				header.put("infoID", mainid);
				
				ars.createRequest(workflowCode, json.toString(), creater, mainid, "uf_alarm_info");

			}

		}

	}
}
