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
				"                              <FUNNAM>DCPAYREQ</FUNNAM>\r\n" + 
				"                              <DATTYP>2</DATTYP>\r\n" + 
				"                              <LGNNAM>学科园科兴学5321</LGNNAM>\r\n" + 
				"                           </INFO>\r\n" + 
				"                           <SDKPAYRQX>\r\n" + 
				"                              <BUSCOD>N02030</BUSCOD>\r\n" + //业务类别 N02030:支付 N02040:集团支付
				"                              <BUSMOD>00001</BUSMOD>\r\n" + 
				"                           </SDKPAYRQX>\r\n" + 
				"                           <DCPAYREQX>\r\n" + 
				"                              <YURREF>201905130003</YURREF>\r\n" + //业务号
				"                              <DBTACC>755915711310210</DBTACC>\r\n" + //付款账号
				"                              <DBTBBK>75</DBTBBK>\r\n" + //地区
				"                              <BNKFLG>N</BNKFLG>\r\n" + //Y：招行；N：非招行；
				"                              <STLCHN>N</STLCHN>\r\n" + //结算方式
				"                              <TRSAMT>23.35</TRSAMT>\r\n" + //金额
				"                              <CCYNBR>10</CCYNBR>\r\n" + //人民币
				"                              <NUSAGE>测试002</NUSAGE>\r\n" + //对应对账单中的摘要
				"                              <CRTACC>7777880230001175</CRTACC>\r\n" + //收方账号
                //"                              <BRDNBR>102100099996</BRDNBR>\r\n" + //收方行号
                "                              <CRTBNK>中国工商银行总行清算中心</CRTBNK>\r\n" + //收方开户行名称
				"                              <CRTNAM>中国工商银行总行清算中心</CRTNAM>\r\n" + //帐户名称
				"                              <CRTPVC>北京</CRTPVC>\r\n" + //收方省份
				"                              <CRTCTY>北京</CRTCTY>\r\n" + //收方城市
				//"                              <CRTDTR>石龙区</CRTDTR>\r\n" + 
				"                              <RCVCHK>1</RCVCHK>\r\n" + 
				"                              <BUSNAR>测试支付</BUSNAR>\r\n" + 
				"                           </DCPAYREQX>  \r\n" + 
				"                        </CMBSDKPGK>";
                out.print(parm);
                result = postConnection("http://192.168.7.36:8080", parm);
                //result = new String(result.getBytes("GBK"),"UTF-8");
                out.print(result);

%>
