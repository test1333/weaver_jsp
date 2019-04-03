package feilida.finance;

import org.json.JSONException;

import weaver.general.BaseBean;
/**
 * ��ȡFI05-��Ӧ��һ�㸶���������������ֱ����-��Ӧ��δ������ϸ��
 * @author jianyong
 *
 */
public class GetFinanceFI05 {
	BaseBean log = new BaseBean();
	public String getResult(String workflowId, String action,String code,String custom,String BZ){
		java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
		oaDatas.put("I_ACTION", action);
		oaDatas.put("I_BUKRS", custom);
		oaDatas.put("I_LIFNR", code);
		oaDatas.put("I_ZZB", BZ);
		tmc.BringMainAndDetailByMain bmb = new tmc.BringMainAndDetailByMain("81");
		String result = bmb.getReturn(oaDatas,workflowId); 
		return result;
}
	
	
	public String getDetialinfo(String code,String custom,String BZ){
		log.writeLog("result:code"+code+" custom:"+custom+" BZ:"+BZ);
		String result=getResult("12","I",code,custom,BZ);
		log.writeLog("result"+result);
		StringBuffer sb = new StringBuffer();
		try {
			org.json.JSONObject json = new org.json.JSONObject(result);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				String LIFNR = jsonx.getString("LIFNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//��Ӧ�̱��
				String BELNR = jsonx.getString("BELNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤���
				String BUDAT = jsonx.getString("BUDAT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤��������
				String WAERS = jsonx.getString("WAERS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����
				String SGTXT = jsonx.getString("SGTXT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//�ı�
				String BLDAT = jsonx.getString("BLDAT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//��Ʊ����
				String GJAHR = jsonx.getString("GJAHR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����
				
				String ZUONR = jsonx.getString("ZUONR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//��Ʊ����
				String BUZEI  = jsonx.getString("BUZEI").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤����Ŀ��
				
				String DMBTR = jsonx.getString("DMBTR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//��λ�ҽ��
				String WRBTR = jsonx.getString("WRBTR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ԭ�ҽ��
				
				sb.append(LIFNR);//��Ӧ�̱��
				sb.append("###");
				sb.append(BELNR);	//ƾ֤���
				sb.append("###");
				sb.append(BUDAT);//ƾ֤��������
				sb.append("###");
				sb.append(WRBTR);//ԭ�ҽ��
				sb.append("###");
				sb.append(DMBTR);//��λ�ҽ��
				sb.append("###");
				sb.append(WAERS);//����
				sb.append("###");
				sb.append(BLDAT);//��Ʊ����
				sb.append("###");
				sb.append(ZUONR);//��Ʊ����
				sb.append("###");
				sb.append(GJAHR);//����
				sb.append("###");
				sb.append(BUZEI);//ƾ֤����Ŀ��
				sb.append("###");
				sb.append(SGTXT);//�ı�
	
				sb.append("@@@");
				
				
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return sb.toString();	
		
	}

}
