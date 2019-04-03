package feilida.finance;

import org.json.JSONException;

import weaver.general.BaseBean;
/**
 * ��ȡFI17-Ա����������-��ϸ�� Ա��δ������
 * @author jianyong
 *
 */
public class GetFinanceFI17 {
	BaseBean log = new BaseBean();
	public String getResult(String workflowId, String action,String code,String custom,String date){
		java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
		oaDatas.put("I_ACTION", action);
		oaDatas.put("I_BUKRS", custom);
		oaDatas.put("I_LIFNR", code);
		oaDatas.put("I_ZFBDT", date);
		tmc.BringMainAndDetailByMain bmb = new tmc.BringMainAndDetailByMain("81");
		String result = bmb.getReturn(oaDatas,workflowId);
		return result;
} 
	
	
	public String getDetialinfo(String code,String custom,String date){
		String result=getResult("15","I",code,custom,date);
		StringBuffer sb = new StringBuffer();
		try {
			org.json.JSONObject json = new org.json.JSONObject(result);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				String LIFNR = jsonx.getString("LIFNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//Ա����Ӧ�̱��
				String BELNR = jsonx.getString("BELNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤���
				String BUDAT = jsonx.getString("BUDAT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤����
				String WAERS = jsonx.getString("WAERS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����
				String WRBTR = jsonx.getString("WRBTR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//���
				String SGTXT = jsonx.getString("SGTXT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//�ı�
				
				
				sb.append(LIFNR);//��Ӧ�̱��
				sb.append("###");
				sb.append(BELNR);	//ƾ֤���	
				sb.append("###");
				sb.append(BUDAT);//����
				sb.append("###");
				sb.append(WAERS);//����
				sb.append("###");
				sb.append(WRBTR);//���				
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
