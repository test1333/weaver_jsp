<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%!
	public String encrypt(String sSrc) throws Exception {
		String sKey = "7227730012772198";  //  加密
		 if (sKey == null) {
			 System.out.print("Key为空null");
			 return null;
		 }
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
<%
	String userCode = "";
	String userid = ""+user.getUID();
	String serverUrl = "http://60.10.65.80:11544";
	String sql = "";
	if("1".equals(userid)){
		userCode = "sysadmin";
	}else{
		sql = "select * from hrmresource where id = '" + userid + "'" ;
		rs.executeSql(sql);
		if(rs.next()){
			userCode = Util.null2String(rs.getString("workcode"));
		}
	}
	String userXf = encrypt(userCode + "@" + userid + "#" + new Date().getTime());
	//out.print(userXf);
	String ulXf = "";
	try{
		ulXf = URLEncoder.encode(userXf,"UTF-8");
	}catch(Exception e){
		e.printStackTrace();
	}
	String url_str = serverUrl+"/jsp/quality/main/accept.jsp?x_login=" + ulXf;
	//out.print(url_str);
	response.sendRedirect(url_str);
	

%>