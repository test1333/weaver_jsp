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
			// 打开和URL之间的连接
			httpURLConnection = (HttpURLConnection) realUrl.openConnection();
			httpURLConnection.setConnectTimeout(3000);
			httpURLConnection.setReadTimeout(3000);
			// 设置通用的请求属性
			httpURLConnection.setRequestProperty("accept", "*/*");
			httpURLConnection.setRequestProperty("connection", "Keep-Alive");
			//httpURLConnection.setRequestProperty("Content-Length", String.valueOf(param.length()));
			httpURLConnection.setRequestProperty("Charset", "GBK");
			httpURLConnection.setRequestProperty("Content-type", "application/xml;charset=GBK"); 
			// 发送POST请求必须设置如下两行
			httpURLConnection.setDoOutput(true);
			httpURLConnection.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			//printWriter = new PrintWriter(httpURLConnection.getOutputStream());
			DataOutputStream  out =new DataOutputStream (httpURLConnection.getOutputStream());
			out.write(param.toString().getBytes("GBK"));
			// 发送请求参数
			//printWriter.write(new String(param.toString().getBytes(), "UTF-8"));
			// flush输出流的缓冲
			out.flush();
			out.close();
			// 根据ResponseCode判断连接是否成功
			int responseCode = httpURLConnection.getResponseCode();
			if (responseCode == httpURLConnection.HTTP_OK) {
				// 定义BufferedReader输入流来读取URL的ResponseData
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
				"                              <FUNNAM>NTQRYSTN</FUNNAM>\r\n" + 
				"                              <DATTYP>2</DATTYP>\r\n" + 
				"                              <LGNNAM>学科园科兴学532</LGNNAM>\r\n" + 
				"                           </INFO>\r\n" + 
				"                           <NTQRYSTNY1>\r\n" + 
				"                              <BUSCOD>N02030</BUSCOD>\r\n" + //业务类别 N02030:支付 N02040:集团支付
				"                              <BUSMOD>00001</BUSMOD>\r\n" + 
				"                              <BGNDAT>20190206</BGNDAT>\r\n" + //业务类别 N02030:支付 N02040:集团支付
				"                              <ENDDAT>20190208</ENDDAT>\r\n" +
				"                           </NTQRYSTNY1>\r\n" + 
				"                        </CMBSDKPGK>";
                out.print(parm);
                result = postConnection("http://192.168.7.26:8080", parm);
                //result = new String(result.getBytes("GBK"),"UTF-8");
								BaseBean log = new BaseBean();
								log.writeLog("parmbbb:"+parm);
								log.writeLog("resultbbb:"+result);
                out.print(result);

%>
