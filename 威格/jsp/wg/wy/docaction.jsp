<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
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
				"                              <FUNNAM>DCPAYREQ</FUNNAM>\r\n" + 
				"                              <DATTYP>2</DATTYP>\r\n" + 
				"                              <LGNNAM>ѧ��԰����ѧ5321</LGNNAM>\r\n" + 
				"                           </INFO>\r\n" + 
				"                           <SDKPAYRQX>\r\n" + 
				"                              <BUSCOD>N02030</BUSCOD>\r\n" + //ҵ����� N02030:֧�� N02040:����֧��
				"                              <BUSMOD>00001</BUSMOD>\r\n" + 
				"                           </SDKPAYRQX>\r\n" + 
				"                           <DCPAYREQX>\r\n" + 
				"                              <YURREF>201905130003</YURREF>\r\n" + //ҵ���
				"                              <DBTACC>755915711310210</DBTACC>\r\n" + //�����˺�
				"                              <DBTBBK>75</DBTBBK>\r\n" + //����
				"                              <BNKFLG>N</BNKFLG>\r\n" + //Y�����У�N�������У�
				"                              <STLCHN>N</STLCHN>\r\n" + //���㷽ʽ
				"                              <TRSAMT>23.35</TRSAMT>\r\n" + //���
				"                              <CCYNBR>10</CCYNBR>\r\n" + //�����
				"                              <NUSAGE>����002</NUSAGE>\r\n" + //��Ӧ���˵��е�ժҪ
				"                              <CRTACC>7777880230001175</CRTACC>\r\n" + //�շ��˺�
                //"                              <BRDNBR>102100099996</BRDNBR>\r\n" + //�շ��к�
                "                              <CRTBNK>�й���������������������</CRTBNK>\r\n" + //�շ�����������
				"                              <CRTNAM>�й���������������������</CRTNAM>\r\n" + //�ʻ�����
				"                              <CRTPVC>����</CRTPVC>\r\n" + //�շ�ʡ��
				"                              <CRTCTY>����</CRTCTY>\r\n" + //�շ�����
				//"                              <CRTDTR>ʯ����</CRTDTR>\r\n" + 
				"                              <RCVCHK>1</RCVCHK>\r\n" + 
				"                              <BUSNAR>����֧��</BUSNAR>\r\n" + 
				"                           </DCPAYREQX>  \r\n" + 
				"                        </CMBSDKPGK>";
                out.print(parm);
                result = postConnection("http://192.168.7.36:8080", parm);
                //result = new String(result.getBytes("GBK"),"UTF-8");
                out.print(result);

%>
