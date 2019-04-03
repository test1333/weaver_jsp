package feilida.finance;

import org.json.JSONException;

import weaver.general.BaseBean;

public class GetFinanceFI03 {
    BaseBean log = new BaseBean();

    public String getResult(String workflowId, String action, String code, String custom, String date) {
        java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
        oaDatas.put("I_ACTION", action);
        oaDatas.put("I_KUNNR", code);
        oaDatas.put("I_BUKRS", custom);
        oaDatas.put("I_ZFBDT", date);
        tmc.BringMainAndDetailByMain bmb = new tmc.BringMainAndDetailByMain("81");
        String result = bmb.getReturn(oaDatas, workflowId);
        return result;
    }


    public String getDetialinfo(String code, String custom, String date) {
        String result = getResult("11", "J", code, custom, date);
        StringBuffer sb = new StringBuffer();
        try {
            org.json.JSONObject json = new org.json.JSONObject(result);
            org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");
            for (int index = 0; index < jsonArr.length(); index++) {
                org.json.JSONObject jsonx = (org.json.JSONObject) (jsonArr.get(index));
                //String BUKRS = jsonx.getString("BUKRS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//��˾����
                String KUNNR = jsonx.getString("KUNNR").replace("'", "'||chr(39)||'").replace("&", "'||chr(38)||'");//�ͻ����
                //String UMSKS = jsonx.getString("UMSKS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//�����ܷ�������������
                //String UMSKZ = jsonx.getString("UMSKZ").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//�ر����˱�ʶ
                //String AUGDT = jsonx.getString("AUGDT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//��������
                //String AUGBL = jsonx.getString("AUGBL").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//���㵥�ݵĵ��ݺ���
                //String ZUONR = jsonx.getString("ZUONR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//������
                // GJAHR = jsonx.getString("GJAHR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����
                String BELNR = jsonx.getString("BELNR").replace("'", "'||chr(39)||'").replace("&", "'||chr(38)||'");//���ƾ֤����
                //String BUZEI  = jsonx.getString("BUZEI").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//���ƾ֤�е�����Ŀ��

                String BUDAT = jsonx.getString("BUDAT").replace("'", "'||chr(39)||'").replace("&", "'||chr(38)||'");//ƾ֤�еĹ�������
                //String BLDAT = jsonx.getString("BLDAT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤�еķ�Ʊ����
                //String CPUDT = jsonx.getString("CPUDT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//���ƾ֤��������
                String WAERS = jsonx.getString("WAERS").replace("'", "'||chr(39)||'").replace("&", "'||chr(38)||'");//������
                //String XBLNR = jsonx.getString("XBLNR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//�ο�ƾ֤���
                //String BLART = jsonx.getString("BLART").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ƾ֤����
                //String MONAT = jsonx.getString("MONAT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����ڼ�
                //String BSCHL = jsonx.getString("BSCHL").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//���ʴ���
                //String ZUMSK = jsonx.getString("ZUMSK").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//Ŀ���ر����ʱ�־
                //String SHKZG  = jsonx.getString("SHKZG").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//�跽/������ʶ

                //String GSBER = jsonx.getString("GSBER").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//ҵ��Χ
                //String MWSKZ = jsonx.getString("MWSKZ").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����/����˰����
                //String DMBTR = jsonx.getString("DMBTR").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//����λ�ҼƵĽ��
                String WRBTR = jsonx.getString("WRBTR").replace("'", "'||chr(39)||'").replace("&", "'||chr(38)||'");//ƾ֤���ҽ��
                String SGTXT = jsonx.getString("SGTXT").replace("'", "'||chr(39)||'").replace("&", "'||chr(38)||'");//��Ŀ�ı�
                String ZFBDT = jsonx.getString("ZFBDT").replace("'", "'||chr(39)||'").replace("&", "'||chr(38)||'");//���ڵ����ռ���Ļ�׼����
                //String ZTERM = jsonx.getString("ZTERM").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//�ո���������
                sb.append(KUNNR);//�ͻ����
                sb.append("###");
                sb.append(BELNR);    //ƾ֤���
                sb.append("###");
                sb.append(BUDAT);//ƾ֤����
                sb.append("###");
                sb.append(ZFBDT);//������
                sb.append("###");
                sb.append(WRBTR);//���
                sb.append("###");
                sb.append(WAERS);//����
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
