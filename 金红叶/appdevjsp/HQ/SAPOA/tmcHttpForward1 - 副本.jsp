<%@ page import="weaver.general.Util"%>
<%@ page import="com.opentext.ecm.lea.common.ALHttpMethod"%>
<%@ page import="com.opentext.ecm.lea.common.ICSException"%>
<%@ page import="com.opentext.ecm.leaclient.ArchiveLinkClient"%>
<%@ page import="org.apache.http.client.methods.ObtainByteArray"%>
<%
	//response.setContentType("APPLICATION/OCTET-STREAM");
	//response.setContentType("image/jpeg");
	response.setContentType("application/pdf");

	response.setHeader("Content-Disposition", "inline;filename=\""+ "c.pdf");
	
	
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "0");
	//String url = "http://oa.app.com.cn:8081/appdevjsp/HQ/SAPOA/tmcHttpForward.jsp?url=http://172.18.95.157:8080/archive?get***pVersion=0045***contRep=EA***docId=0050568B93691EE89CEE70CF68D7C9B6&type=mobile/plugin/1/showLocationTrack.jsp";
    String url = Util.null2String(request.getParameter("url"));

	//out.print(url);
	url = url.replaceAll("\\*\\*\\*", "&");

	String fileName = "APP.pem";
	String homePath = System.getProperty("java.home");
	String file = homePath + "/" + fileName;
	String urlx = "";
	try {
		urlx = ArchiveLinkClient.getSignature4Url(url,
				ALHttpMethod.GET, 30, file);
	} catch (ICSException e) {
		e.printStackTrace();
		out.println(e);
	}

	ServletOutputStream outp = response.getOutputStream();

	byte[] result = {};
	try {
		result = ObtainByteArray.toByteArray(urlx);
		outp.write(result);
		outp.flush();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (outp != null)
			outp.close();
	}
%>

