package feilida.finance;

import org.json.JSONException;

import weaver.general.BaseBean;
/**
 * 获取FI08-报销申请表单(供应商未清项明细表)
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
				String LIFNR = jsonx.getString("LIFNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//供应商编号
				String BELNR = jsonx.getString("BELNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//凭证编号
				String BUDAT = jsonx.getString("BUDAT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//凭证过账日期
				String WRBTR = jsonx.getString("WRBTR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//金额
				String WAERS = jsonx.getString("WAERS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//币种
				String SGTXT = jsonx.getString("SGTXT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//文本
				String XBLNR = jsonx.getString("XBLNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//凭证编号
				String GJAHR = jsonx.getString("GJAHR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//财年
				String BUZEI = jsonx.getString("BUZEI").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//行项目数 
				
				
				sb.append(LIFNR);//供应商编号
				sb.append("###");
				sb.append(XBLNR);//OA预付款申请编号
				sb.append("###");
				sb.append(BELNR);//凭证编号		
				sb.append("###");
				sb.append(BUDAT);//币种
				sb.append("###");
				sb.append(WAERS);//币种
				sb.append("###");
				sb.append(WRBTR);//金额				
				sb.append("###");
				sb.append(GJAHR);//财年			
				sb.append("###");
				sb.append(BUZEI);//行项目数 	 			
				sb.append("###");
				sb.append(SGTXT);//文本								
				sb.append("@@@");
				
				
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return sb.toString();	
		
	}

}
