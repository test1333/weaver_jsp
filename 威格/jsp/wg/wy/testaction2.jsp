<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="weaver.general.BaseBean" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%!
    public String postConnection(String url, String param) throws Exception {
		PrintWriter printWriter = null;
		BufferedReader bufferedReader = null;			
		HttpURLConnection httpURLConnection = null;

		StringBuffer responseResult = new StringBuffer();

		try {
			URL realUrl = new URL(url);
			// �򿪺�URL֮�������
			httpURLConnection = (HttpURLConnection) realUrl.openConnection();
			httpURLConnection.setConnectTimeout(3000);
			httpURLConnection.setReadTimeout(3000);
			// ����ͨ�õ���������
			httpURLConnection.setRequestProperty("accept", "*/*");
			httpURLConnection.setRequestProperty("connection", "Keep-Alive");
			//httpURLConnection.setRequestProperty("Content-Length", String.valueOf(param.length()));
			httpURLConnection.setRequestProperty("Charset", "GBK");
			httpURLConnection.setRequestProperty("Content-type", "application/xml;charset=GBK"); 
			// ����POST�������������������
			httpURLConnection.setDoOutput(true);
			httpURLConnection.setDoInput(true);
			// ��ȡURLConnection�����Ӧ�������
			//printWriter = new PrintWriter(httpURLConnection.getOutputStream());
			DataOutputStream  out =new DataOutputStream (httpURLConnection.getOutputStream());
			out.write(param.toString().getBytes("GBK"));
			// �����������
			//printWriter.write(new String(param.toString().getBytes(), "UTF-8"));
			// flush������Ļ���
			out.flush();
			out.close();
			// ����ResponseCode�ж������Ƿ�ɹ�
			int responseCode = httpURLConnection.getResponseCode();
			if (responseCode == httpURLConnection.HTTP_OK) {
				// ����BufferedReader����������ȡURL��ResponseData
				bufferedReader = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream(),"GBK"));
				String line;
				while ((line = bufferedReader.readLine()) != null) {
					responseResult.append(line);
				}
				return responseResult.toString();
			}
			return null;
		} catch (ConnectException e) {
			throw new Exception(e);
		} catch (MalformedURLException e) {
			throw new Exception(e);
		} catch (IOException e) {
			throw new Exception(e);
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			httpURLConnection.disconnect();
			try {
				if (printWriter != null) {
					printWriter.close();
				}
				if (bufferedReader != null) {
					bufferedReader.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}
%>
<%
    String result = "";
		String parm = "<?xml   version=\"1.0\" encoding=\"GBK\"?><CMBSDKPGK>\r\n" + 
				"                           <INFO>\r\n" + 
				"                              <FUNNAM>GetTransInfo</FUNNAM>\r\n" + 
				"                              <DATTYP>2</DATTYP>\r\n" + 
				"                              <LGNNAM>ѧ��԰����ѧ532</LGNNAM>\r\n" + 
				"                           </INFO>\r\n" + 
				"                           <SDKTSINFX>\r\n" + 
				"<BBKNBR>75</BBKNBR>\r\n" +           
        "                <C_BBKNBR></C_BBKNBR>\r\n" + 
         "               <ACCNBR>755915711310210</ACCNBR>\r\n" +  
         "               <BGNDAT>20190915</BGNDAT>\r\n" +      
        "                <ENDDAT>20191025</ENDDAT>\r\n" +  
        "                <LOWAMT></LOWAMT>\r\n" +         
         "               <HGHAMT></HGHAMT>\r\n" +        
         "               <AMTCDR></AMTCDR>\r\n" +    
				"                           </SDKTSINFX>\r\n" + 
				"                        </CMBSDKPGK>";
                out.print(parm);
                result = postConnection("http://192.168.7.26:8080", parm);
                //result = new String(result.getBytes("GBK"),"UTF-8");
								BaseBean log = new BaseBean();
								log.writeLog("parmbbb:"+parm);
								log.writeLog("resultbbb:"+result);
                out.print(result);

%>
