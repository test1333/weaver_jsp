package htkj.alarm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.DetailTableInfo;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.RequestService;
import weaver.soa.workflow.request.Row;


public class AutoRequestService extends BaseBean {

	BaseBean log = new BaseBean();

	public String createRequest(String workflowCode, String strJson,
			String createrid,String mainid,String tablename) {

		Map<String, String> retMap = new HashMap<String, String>();
		RecordSet rs = new RecordSet();
		//log.writeLog("json" + strJson);
		// ��ȡ������������
		String workflowID = workflowCode;
		String sql = "select count(1) as count from workflow_base where id="
				+ workflowID;
		rs.executeSql(sql);
		int count = 0;
		if (rs.next()) {
			count = rs.getInt("count");
		}
		if (count <= 0) {
			retMap.put("MSG_TYPE", "E");
			retMap.put("MSG_CONTENT", "���̺Ŵ���");
			retMap.put("OA_ID", "0");

			return getJsonStr(retMap);
		}

		// ���� json ��ȡ��Ա�ı�� REQ_BP
		String creater = createrid;

		if (creater.length() > 0 && !"1".equals(creater)) {
			sql = "select count(1) as count_cc from hrmresource "
					+ "where id='" + creater + "' and status in(0,1,2,3)";
			rs.executeSql(sql);
			if (rs.next()) {
				int count_cc = rs.getInt("count_cc");
				if (count_cc == 0) {
					creater = "";
				}
			}
		}

		if (creater.length() < 1) {
			retMap.put("MSG_TYPE", "E");
			retMap.put("MSG_CONTENT", "��Ա����޷�ƥ�䣡");
			retMap.put("OA_ID", "0");

			return getJsonStr(retMap);
		}

		String requestLevel = "0";
		String remindType = "0";
		String requestid = "";

		// ���� workflowCode ��ѯʵ�ʵ�����

		RequestInfo requestinfo = new RequestInfo();

		// ����������
		MainTableInfo mti = new MainTableInfo();
		try {
			mti = getMainTableInfo(strJson);
		} catch (Exception e2) {
			retMap.put("MSG_TYPE", "E");
			retMap.put("MSG_CONTENT", "����Json��ʽ�������ƥ�����ñ����");
			retMap.put("OA_ID", "0");
			e2.printStackTrace();
			return getJsonStr(retMap);
		}
		if (mti == null) {
			retMap.put("MSG_TYPE", "E");
			retMap.put("MSG_CONTENT", "����Json��ʽ�������ƥ�����ñ����");
			retMap.put("OA_ID", "0");

			return getJsonStr(retMap);
		}

		DetailTableInfo dti = new DetailTableInfo();
		try {
			dti = getDetailTableInfo(strJson);
		} catch (Exception e1) {
			e1.printStackTrace();
			retMap.put("MSG_TYPE", "E");
			retMap.put("MSG_CONTENT", "��ϸJson��ʽ�������ƥ�����ñ����");
			retMap.put("OA_ID", "0");
			return getJsonStr(retMap);
		}
	
		requestinfo.setDetailTableInfo(dti);
		requestinfo.setMainTableInfo(mti);
		requestinfo.setIsNextFlow("0");
		requestinfo.setCreatorid(creater);
		requestinfo.setDescription(getRequestName(workflowID, creater));
		requestinfo.setWorkflowid(workflowID);
		requestinfo.setRequestlevel(requestLevel);
		requestinfo.setRemindtype(remindType);
		RequestService res = new RequestService();
		try {
			requestid = res.createRequest(requestinfo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String return_type = "S";
		String return_message = "";

		int s_requestid = Integer.parseInt(requestid);
		if (s_requestid < 1) {
			return_type = "E";
			if(s_requestid ==-1){
				return_message = "��������ʧ��";
			}else if(s_requestid == -2){
				return_message = "�û�û�����̴���Ȩ��";
			}else if(s_requestid == -3){
				return_message = "�������̻�����Ϣʧ��";
			}else if(s_requestid == -4){
				return_message = "�����������Ϣʧ��";
			}else if(s_requestid == -4){
				return_message = "�����������Ϣʧ��";
			}else if(s_requestid == -5){
				return_message = "���½����̶�ʧ��";
			}else if(s_requestid == -6){
				return_message = "���̲�����ʧ��";
			}else if(s_requestid == -7){
				return_message = "��ת����һ�ڵ�ʧ��";
			}else if(s_requestid == -8){
				return_message = "�ڵ㸽�Ӳ���ʧ��";
			}else{
				return_message = "��������ʧ��";
			}
		}else{
			return_message ="���̴����ɹ�";
			if("uf_data_qinggou".equals(tablename)){
				updateCaigoutatus(mainid,tablename,requestid);
			}else{
				updateAlarmStatus(mainid,tablename,requestid);
			}
		}
		

		retMap.put("MSG_TYPE", return_type);
		retMap.put("MSG_CONTENT", return_message);
		retMap.put("OA_ID", requestid);
        //log.writeLog(getJsonStr(retMap));
		return getJsonStr(retMap);
	}

	private String getRequestName(String workflowID, String creater) {
		String requestName = "";
		String sql = "select workflowname||'-'||(select lastname from hrmresource where id="
				+ creater
				+ ")||'-'||to_char(sysdate,'yyyy-mm-dd') "
				+ " as r_name from workflow_base where id=" + workflowID;
		RecordSet rs = new RecordSet();
		rs.executeSql(sql);
		if (rs.next()) {
			requestName = Util.null2String(rs.getString("r_name"));
		}
		return requestName;
	}

	private DetailTableInfo getDetailTableInfo(String jsonStr) throws Exception {
		DetailTableInfo details = new DetailTableInfo();
		JSONObject json = null;
		json = new JSONObject(jsonStr);

		List<DetailTable> list_detail = new ArrayList<DetailTable>();

		JSONArray arr = json.getJSONArray("DETAILS");
		List<Row> list_row = new ArrayList<Row>();
		DetailTable dt = new DetailTable();
		for (int i = 0; i < arr.length(); i++) {
			JSONObject jo = arr.getJSONObject(i);
			
			Row row = new Row();
			List<Cell> list_cell = new ArrayList<Cell>();	
			Iterator it = jo.keys();
			while (it.hasNext()) {
				String key = it.next().toString();
				String value = jo.getString(key);
				//
				Cell cel = new Cell();
				cel.setName(key);
				if (Util.null2String(value).length() > 0) {
					cel.setValue(value);
					list_cell.add(cel);

				}
			}
			int size = list_cell.size();
			Cell cells[] = new Cell[size];
			for (int index = 0; index < list_cell.size(); index++) {
				cells[index] = list_cell.get(index);
			}
			row.setCell(cells);
			row.setId("" + i);
			list_row.add(row);
		}
		int size = list_row.size();
		// if(size == 0) break;
		Row rows[] = new Row[size];
		for (int index = 0; index < list_row.size(); index++) {

			rows[index] = list_row.get(index);
		}
		dt.setRow(rows);
		dt.setId("1");
		list_detail.add(dt);

		 size = list_detail.size();
		DetailTable detailtables[] = new DetailTable[size];
		for (int index = 0; index < list_detail.size(); index++) {
			detailtables[index] = list_detail.get(index);
		}
		details.setDetailTable(detailtables);
		return details;

	}

	// ��ȡ����� Property
	private MainTableInfo getMainTableInfo(String jsonStr) throws Exception {
		MainTableInfo mti = new MainTableInfo();

		List<Property> list = new ArrayList<Property>();
		JSONObject json = null;
		try {
			json = new JSONObject(jsonStr).getJSONObject("HEADER");
		} catch (JSONException e) {
			e.printStackTrace();
		}

		if (json == null)
			return null;
		Iterator it = json.keys();
		while (it.hasNext()) {
			String key = it.next().toString();
			String value = json.getString(key);
			Property pro = new Property();
			pro.setName(key);
			if (Util.null2String(value).length() > 0) {
				pro.setValue(value);
				list.add(pro);

			}
		}
		

		int size = list.size();
		if (size == 0)
			return null;

		Property properties[] = new Property[size];
		for (int index = 0; index < list.size(); index++) {
			properties[index] = list.get(index);
		}
		mti.setProperty(properties);
		return mti;
	}

	// mapתjson��ʽ
	private String getJsonStr(Map<String, String> map) {
		JSONObject json = new JSONObject();
		Iterator<String> it = map.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next();
			String value = map.get(key);
			try {
				json.put(key, value);
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}

		return json.toString();
	}
    
	private void updateCaigoutatus(String mainid,String tablename,String requestid){
		String ids=mainid+"0";
		String sql="update "+tablename+" set status=2,rqid=rqid||'"+requestid+"'||',' where id in("+ids+")";
		RecordSet rs = new RecordSet();
		rs.executeSql(sql);
	}
	private void updateAlarmStatus(String mainid,String tablename,String requestid){
		String sql="update "+tablename+" set status=1,requestid='"+requestid+"' where id = "+mainid;
		RecordSet rs = new RecordSet();
		rs.executeSql(sql);
	}
}
