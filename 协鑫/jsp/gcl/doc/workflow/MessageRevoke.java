package gcl.doc.workflow;


import net.sf.json.JSONObject;
import weaver.general.BaseBean;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.Map;

public class MessageRevoke {
    /**
     * ��ָ�� URL ����POST����������
     *
     * @param url      ��������� URL
     *                 //     * @param param    ����������������Ӧ���� name1=value1&name2=value2 ����ʽ��
     * @param type     �����ʽ��0��ʾֱ�Ӵ��������1��ʾbody����json
     * @param paramMap body����json
     * @return ������Զ����Դ����Ӧ���
     */
    public static String sendPost(String url, String type, Map<String, String> paramMap) {
        BaseBean log = new BaseBean();
        OutputStreamWriter out = null;
        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);
            // �򿪺�URL֮�������
            URLConnection conn = realUrl.openConnection();
            // ����ͨ�õ���������
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            if ("1".equals(type)) {
                conn.setRequestProperty("Content-Type", "application/json"); // ���÷������ݵĸ�ʽ
            }
//            conn.setRequestProperty("Accept", "application/json"); // ���ý������ݵĸ�ʽ
            // ����POST�������������������
            conn.setDoOutput(true);
            conn.setDoInput(true);
            //1.��ȡURLConnection�����Ӧ�������
//            out = new PrintWriter(conn.getOutputStream());
            //2.�������������Ҫ��PrintWriter��Ϊ����
            out = new OutputStreamWriter(conn.getOutputStream(), "utf-8");
            if ("1".equals(type)) {
                out.append(map2Json(paramMap));
            }

//            conn.getOutputStream().write(param.getBytes("utf-8"));
            // �����������
//            out.write(param);
            // flush������Ļ���
            out.flush();
            // ����BufferedReader����������ȡURL����Ӧ
//            in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            log.writeLog("���� POST ��������쳣��" + e);
            e.printStackTrace();
        }
        //ʹ��finally�����ر��������������
        finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (in != null) {
                    in.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        log.writeLog("post���ͽ����" + result);
        return result;
    }

    public static String map2Json(Map map) {
        JSONObject json = new JSONObject();
        //net.sf.json.JSONObject ��Mapת��ΪJSON����
        if(!map.isEmpty()){
            json = JSONObject.fromObject(map);
        }

//        JSONObject json =new JSONObject(map);
        return json.toString();
    }
    public static String getOdd(String[] str) {
        StringBuffer odd = new StringBuffer(1024);
        StringBuffer even = new StringBuffer(1024);
        for (int i = 0; i < str.length; i++) {
            if (i % 2 == 0) {
                if (0 == even.length()) {
                    even.append(str[i]);
                } else {
                    even.append("," + str[i]);
                }
            } else {
                if (0 == odd.length()) {
                    odd.append(str[i]);
                } else {
                    odd.append("," + str[i]);
                }
            }
        }
        return odd.toString();
    }

   /* public static void main(String[] args) {
        //���� POST ����
        JSONObject json = new JSONObject();
        Map map = new HashMap();
        if(!map.isEmpty()){
            json = JSONObject.fromObject(map);
        }else{
            System.out.println(json.isEmpty());
            System.out.println(json.toString());
        }
        String sr = sendPost("http://lanxin.gcl-power.com/cgi-bin/token?grant_type=client_credential&appid=100600&secret=_1_@X@@_r@d_f@D6Y__@e_ngb71KE_", "0", map);
        JSONObject jsStr = JSONObject.fromObject(sr);
        String access_token = "";
        String errcode = jsStr.getString("errcode");
        if ("0".equals(errcode)) {
            access_token = jsStr.getString("access_token");
        }

        String ss = sendPost("http://10.31.2.118:8088/wxthirdapi/getLXMSGID?requestid=2178612", "0", map);
        JSONObject jsStr1 = JSONObject.fromObject(ss);
//        JSONObject json = new JSONObject(sr);
        String msgids = "";
        String status = jsStr1.getString("status");
        if ("0".equals(status)) {
            msgids = jsStr1.getString("msgids");
        }
        if(msgids.length()>0){
            String[] aa = msgids.split("\"");
            String ww = getOdd(aa);
            System.out.println(ww);
            if(ww.length()>0){
                String[] sm = ww.split(",");
                for (int j = 0; j < sm.length; j++) {
                    System.out.println(sm[j]);
                    map.put("userMessageId", sm[j]);
                    String st = sendPost("http://lanxin.gcl-power.com/cgi-bin/richMessage/revoke?access_token=" + access_token, "1", map);
                    System.out.println(st);
                }
            }

        }
    }*/

}
