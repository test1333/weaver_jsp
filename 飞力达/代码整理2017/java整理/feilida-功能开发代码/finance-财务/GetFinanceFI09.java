package feilida.finance;

import org.json.JSONException;

import weaver.general.BaseBean;
/**
 * ��ȡFI09-�ڲ��ʽ������(�ͻ�δ������ϸ��)
 * @author jianyong
 *
 */
public class GetFinanceFI09 {
	BaseBean log = new BaseBean();
	public String getResult(String workflowId, String action,String code,String custom){
		java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
		oaDatas.put("I_ACTION", action);
		oaDatas.put("I_BUKRS", custom);
		oaDatas.put("I_KUNNR", code);
		tmc.BringMainAndDetailByMain bmb = new tmc.BringMainAndDetailByMain("81"); 
		String result = bmb.getReturn(oaDatas,workflowId);
		return result;
}
	
	
	public String getDetialinfo(String code,String custom){
		String result=getResult("14","J",code,custom);
		StringBuffer sb = new StringBuffer();
		try {
			org.json.JSONObject json = new org.json.JSONObject(result);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				String KUNNR = jsonx.getString("KUNNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//��Ӧ�̱��
				String BELNR = jsonx.getString("BELNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤���
				String BUDAT = jsonx.getString("BUDAT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤��������
				String WRBTR = jsonx.getString("WRBTR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//���
				String WAERS = jsonx.getString("WAERS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����
				String SGTXT = jsonx.getString("SGTXT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//�ı�
				
				
				sb.append(KUNNR);//��Ӧ�̱��
				sb.append("###");
				sb.append(BELNR);	//ƾ֤���	
				sb.append("###");
				sb.append(BUDAT);//��������
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
