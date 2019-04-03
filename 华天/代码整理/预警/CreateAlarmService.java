package htkj.services;

import java.util.HashMap;
import java.util.Map;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;

public class CreateAlarmService extends BaseBean {

	public String createAlarm(String wheresystem, String aramid, String remark,
			String gxbh, String pc, String lh, String sbbh, String ygxm) {
		BaseBean log = new BaseBean();
		Map<String, String> retMap = new HashMap<String, String>();
		RecordSet rs = new RecordSet();

		String status = "0";

		if ("".equals(wheresystem)) {

			return "ERROR:wheresystem����Ϊ��";
		}
		if ("".equals(aramid)) {

			return "ERROR:aramid����Ϊ��";
		}
		if ("".equals(remark)) {

			return "ERROR:remark����Ϊ��";
		}
		if ("".equals(gxbh)) {

			return "ERROR:gxbh����Ϊ��";
		}

		String sql = "insert into uf_alarm_info(wheresystem,aramid,remark,gxbh,pc,lh,sbbh,ygxm,status) "
				+ "values('"
				+ wheresystem
				+ "','"
				+ aramid
				+ "','"
				+ remark
				+ "','"
				+ gxbh
				+ "','"
				+ pc
				+ "','"
				+ lh
				+ "','"
				+ sbbh
				+ "','"
				+ ygxm + "','" + status + "')";
		rs.executeSql(sql);
		return "SUCCESS";
	}

}
