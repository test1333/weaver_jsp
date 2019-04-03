package htkj.alarm;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;

public class CreateXunJiaServiceAction {
	public String CreateXunJiaService(String ids, String creater) throws Exception {
		BaseBean log = new BaseBean();
		RecordSet rs = new RecordSet();
		AutoRequestService ars= new AutoRequestService();
		String sql = "";
		String dataIds[] = ids.split(",");
		String dataId = "";
		String cjr = creater;
		String cjbm = "";
		String cjrq = "";
		
		String wlmc = "";
		String xh = "";
		String gg = "";
		String dw = "";
		String sl = "";
		String th = "";
		String mainid="";
		String workflowCode="1741";
        //log.writeLog("开始创建alarmids"+ids+"creater"+creater);
		sql="select departmentid,to_char(sysdate,'yyyy-mm-dd') as sqrq from hrmresource where id="+creater;
		rs.executeSql(sql);
		if(rs.next()){
			cjbm = Util.null2String(rs.getString("departmentid"));
			cjrq = Util.null2String(rs.getString("sqrq"));
		}
		JSONObject json = new JSONObject();
		JSONObject header = new JSONObject();
		JSONArray detail = new JSONArray();
		json.put("HEADER", header);
		json.put("DETAILS", detail);

		header.put("cjr", cjr);
		header.put("cjbm", cjbm);
		header.put("cjrq", cjrq);
	
		for (int i = 0; i < dataIds.length; i++) {
			dataId = dataIds[i];
			sql = "select * from uf_data_qinggou where  id="
					+ dataId;
			//log.writeLog("开始创建alarmsql"+sql);
			rs.executeSql(sql);
			if (rs.next()) {
				mainid = Util.null2String(rs.getString("id"));
				wlmc = Util.null2String(rs.getString("wlmc"));
				xh = Util.null2String(rs.getString("xh"));
				gg = Util.null2String(rs.getString("gg"));
				dw = Util.null2String(rs.getString("dwzw"));
				sl = Util.null2String(rs.getString("sl"));
				th = Util.null2String(rs.getString("th"));
				
				JSONObject node = new JSONObject();
				node.put("wlmc", wlmc);
				node.put("xh", xh);
				node.put("gg", gg);
				node.put("dw", dw);
				node.put("sl", sl);
				node.put("th", th);
				detail.put(node);

			}

		}
		return ars.createRequest(workflowCode, json.toString(), creater, ids, "uf_data_qinggou");

	}
}
