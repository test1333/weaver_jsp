<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ page import="com.javen.Util.Util"%>
<%@ page import="java.util.ResourceBundle"%>
<%
	ResourceBundle bundle = ResourceBundle.getBundle("ks");
	String workCode = Util.null2String((String)session.getAttribute("workcode"));
	//response.setCharacterEncoding("utf-8");
	//String workCode = encrypt("V0017940");
	workCode = encrypt(workCode);
	String modeid = request.getParameter("modeid");
	workCode = java.net.URLEncoder.encode(workCode ,"utf-8" ); 
	workCode = java.net.URLEncoder.encode(workCode ,"utf-8" ); 
	String url = bundle.getString("oaurl")+"/gvo/sendFor/getOAMultiInfo.jsp?ifDecode=Y&accountType=2&";
	url +="account="+workCode.toString().trim()+"&infoType=10&info="+modeid;
	response.sendRedirect(url);
%>
<%!
	public String encrypt(String sSrc) throws Exception {
		String sKey = "7227730012772198";   //  加密
		 // 判断Key是否为16位
		 if (sKey.length() != 16) {
			 System.out.print("Key长度不是16位");
			 return null;
		 }
		 byte[] raw = sKey.getBytes("UTF-8");
		 SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
		 Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");//"算法/模式/补码方式"
		 cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
		 byte[] encrypted = cipher.doFinal(sSrc.getBytes("UTF-8"));
		 return (new BASE64Encoder()).encodeBuffer(encrypted);
	}
%>