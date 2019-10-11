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
			// ???URL????????
			httpURLConnection = (HttpURLConnection) realUrl.openConnection();
			httpURLConnection.setConnectTimeout(3000);
			httpURLConnection.setReadTimeout(3000);
			// ????????????????
			httpURLConnection.setRequestProperty("accept", "*/*");
			httpURLConnection.setRequestProperty("connection", "Keep-Alive");
			//httpURLConnection.setRequestProperty("Content-Length", String.valueOf(param.length()));
			httpURLConnection.setRequestProperty("Charset", "GBK");
			httpURLConnection.setRequestProperty("Content-type", "application/xml;charset=GBK"); 
			// ????POST???????????????????
			httpURLConnection.setDoOutput(true);
			httpURLConnection.setDoInput(true);
			// ???URLConnection?????????????
			//printWriter = new PrintWriter(httpURLConnection.getOutputStream());
			DataOutputStream  out =new DataOutputStream (httpURLConnection.getOutputStream());
			out.write(param.toString().getBytes("GBK"));
			// ???????????
			//printWriter.write(new String(param.toString().getBytes(), "UTF-8"));
			// flush??????????
			out.flush();
			out.close();
			// ????ResponseCode?§Ø??????????
			int responseCode = httpURLConnection.getResponseCode();
			if (responseCode == httpURLConnection.HTTP_OK) {
				// ????BufferedReader???????????URL??ResponseData
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
				"                              <LGNNAM>?????????532</LGNNAM>\r\n" + 
				"                           </INFO>\r\n" + 
				"                           <SDKPAYRQX>\r\n" + 
				"                              <BUSCOD>N02030</BUSCOD>\r\n" + //?????? N02030:??? N02040:???????
				"                              <BUSMOD>00001</BUSMOD>\r\n" + 
				"                           </SDKPAYRQX>\r\n" + 
				"                           <DCPAYREQX>\r\n" + 
				"                              <YURREF>201905130001</YURREF>\r\n" + //????
				"                              <DBTACC>755915711310210</DBTACC>\r\n" + //???????
				"                              <DBTBBK>75</DBTBBK>\r\n" + //????
				"                              <BNKFLG>Y</BNKFLG>\r\n" + //Y?????§µ?N???????§µ?
				"                              <STLCHN>N</STLCHN>\r\n" + //?????
				"                              <TRSAMT>12.35</TRSAMT>\r\n" + //???
				"                              <CCYNBR>10</CCYNBR>\r\n" + //?????
				"                              <NUSAGE>????001</NUSAGE>\r\n" + //?????????§Ö???
				"                              <CRTACC>6225880230001175</CRTACC>\r\n" + //??????
				"                              <CRTNAM>????</CRTNAM>\r\n" + //???????
				"                              <CRTPVC>????</CRTPVC>\r\n" + //??????
				"                              <CRTCTY>????</CRTCTY>\r\n" + //???????
				//"                              <CRTDTR>?????</CRTDTR>\r\n" + 
				//"                              <RCVCHK>1</RCVCHK>\r\n" + 
				"                              <BUSNAR>???????</BUSNAR>\r\n" + 
				"                           </DCPAYREQX>  \r\n" + 
				"                        </CMBSDKPGK>";
                out.print(parm);
                result = postConnection("http://192.168.7.36:8080", parm);
                //result = new String(result.getBytes("GBK"),"UTF-8");
                out.print(result);

%>
