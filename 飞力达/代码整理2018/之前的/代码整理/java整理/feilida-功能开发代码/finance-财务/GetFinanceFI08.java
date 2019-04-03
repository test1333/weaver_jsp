package feilida.finance;

import org.json.JSONException;

import weaver.general.BaseBean;
/**
 * ��ȡFI08-���������(��Ӧ��δ������ϸ��)
 * @author jianyong
 *
 */
public class GetFinanceFI08 {
	BaseBean log = new BaseBean();
	public String getResult(String workflowId, String action,String code,String custom){
		java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
		oaDatas.put("I_ACTION", action);
		oaDatas.put("I_BUKRS", custom);
		oaDatas.put("I_LIFNR", code);
		tmc.BringMainAndDetailByMain bmb = new tmc.BringMainAndDetailByMain("81");
		String result = bmb.getReturn(oaDatas,workflowId);
		return result; 
}
	
	
	public String getDetialinfo(String code,String custom){
		String result=getResult("16","I",code,custom);
		StringBuffer sb = new StringBuffer();
		try {
			org.json.JSONObject json = new org.json.JSONObject(result);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				String LIFNR = jsonx.getString("LIFNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//��Ӧ�̱��
				String BELNR = jsonx.getString("BELNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤���
				String BUDAT = jsonx.getString("BUDAT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤��������
				String WRBTR = jsonx.getString("WRBTR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//���
				String WAERS = jsonx.getString("WAERS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����
				String SGTXT = jsonx.getString("SGTXT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//�ı�
				String XBLNR = jsonx.getString("XBLNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤���
				String GJAHR = jsonx.getString("GJAHR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����
				String BUZEI = jsonx.getString("BUZEI").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����Ŀ�� 
				
				
				sb.append(LIFNR);//��Ӧ�̱��
				sb.append("###");
				sb.append(XBLNR);//OAԤ����������
				sb.append("###");
				sb.append(BELNR);//ƾ֤���		
				sb.append("###");
				sb.append(BUDAT);//����
				sb.append("###");
				sb.append(WAERS);//����
				sb.append("###");
				sb.append(WRBTR);//���				
				sb.append("###");
				sb.append(GJAHR);//����			
				sb.append("###");
				sb.append(BUZEI);//����Ŀ�� 	 			
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
