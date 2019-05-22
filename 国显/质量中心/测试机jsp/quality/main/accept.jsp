<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.javen.Util.Util"%>
<%!
	public String decrypt(String sSrc) throws Exception {
		String sKey = "7227730012772198";
		try {
			// 判断Key是否正确
			if (sKey == null) {
				System.out.print("Key为空null");
				return null;
			}
			// 判断Key是否为16位
			if (sKey.length() != 16) {
				System.out.print("Key长度不是16位");
				return null;
			}
			byte[] raw = sKey.getBytes("utf-8");
			SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, skeySpec);
			
			byte[] encrypted1 = (new BASE64Decoder()).decodeBuffer(sSrc);  
			
			byte[] original = cipher.doFinal(encrypted1);
			String originalString = new String(original,"UTF-8");
			return originalString;
		}catch (Exception ex) {
			System.out.println(ex.toString());
			return null;
		}
	}
%>
<%
	String x_login = Util.null2String(request.getParameter("x_login")) ;
	String nsString = decrypt(x_login); 
	if(nsString == null) nsString = "";
	String arr[] = nsString.split("@");
	
	if(arr.length !=2){
		%>
			<script language="javascript">
				alert("系统验证信息失败!");
				window.opener=null;
				window.open('','_self');
				window.close();
			</script>
		<%
		return;
	}
	String workcode = arr[0];
	//out.print(workcode);
	request.getSession(true).setMaxInactiveInterval(60 * 60 * 24);
	request.getSession(true).setAttribute("workcode",workcode);
	String toRedirect = "/";
	response.sendRedirect(toRedirect);
%>