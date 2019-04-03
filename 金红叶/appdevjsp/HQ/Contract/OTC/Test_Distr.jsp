<%@ page import="weaver.general.Util" %>
<%@ page import="APPDEV.HQ.Contract.OTC.OTC_Tissue_Con_Distr_Webservice" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%

	String json="{'HEADER':{\"KONDAMEMO\":\"\",\"SALES\":1,\"DENGJIS\":5,\"REGZIP\":\"1\",\"KUNNRS\":\"6008321\",\"DENGJIP\":6,\"PROCESS_TYPE\":\"C\",\"KONDAZONE1NAME\":\"东城区,朝阳区\",\"TOTALSALE\":10,\"TOWNS\":\"xxxx\",\"KONDAPROV\":\"1100\",\"STORAGESPACE\":100,\"DEALERS\":\"N\",\"APPLICANTDATE\":\"\",\"XDYNAME\":\"z3\",\"BRAND3\":\"z\",\"COMBRANCH\":\"上海分公司\",\"KUNNR\":\"6000542\",\"QFDEPT\":\"B\",\"DEPT\":\"\",\"CGWEIXIN\":\"wx2\",\"DCOMBRANCH\":\"上海分公司2\",\"ZD\":\"Y\",\"OTHERCHANNELS\":\"\",\"CITYNAME\":\"上海市\",\"CGTEL\":\"2\",\"MAINCHANNELS\":\"\",\"FZRNAME\":\"zhangsan\",\"FXINFO\":\"Y\",\"BRAND2\":\"y\",\"CITYNAME2\":\"上海市                        \",\"ZONE1NAME2\":\"黄浦区,普陀区\",\"PAYWAY\":\"B\",\"DKUNNR\":\"6006630\",\"DENGJID\":4,\"C_NO\":\"GHY2018SALSEGT000009\",\"DNAME_ORG1\":\"上海顶通物流有限公司\",\"KONDANAME\":\"\",\"CLASSNAME\":\"全渠道经销商\",\"ZONE1NAME\":\"黄浦区\",\"APPLICANTTIME\":\"\",\"DINVOICE\":\"N\",\"VEHICLES\":2,\"AFKONDA\":\"\",\"CONSTATUS\":\"\",\"HASDMS\":\"N\",\"ATTRIB\":\"A\",\"XDYWEIXIN\":\"wx3\",\"BRAND1\":\"x\",\"APPLICANT\":\"61502355\",\"YEAR\":\"2018\",\"NAME_ORG1\":\"上海秋韵贸易有限公司\",\"DENGJIB\":2,\"DENGJIA\":1,\"XDYTEL\":\"3\",\"SALEPER\":\"A\",\"OUTLETS\":20,\"WEBURL\":\"http://www.xx.com\",\"FZRWEIXIN\":\"wx1\",\"FZRTEL\":\"123\",\"VTWEG\":\"GT\",\"GHYSALE\":5,\"INVOICE\":\"Y\",\"CLASSID\":\"I\",\"KONDACITYNAME\":\"北京市                        \",\"BALANCEDAYS\":2,\"CHANNEL\":\"GT\",\"Y\":\"2018\",\"YZ\":\"EC\",\"AREAS\":2,\"CGNAME\":\"z2\",\"DEPTUP\":\"\",\"KUNNRMEMO\":\"备注内容xxx\",\"KONDAPROVNAME\":\"北京市                        \",\"PROVNAME2\":\"上海市                        \",\"ASSOCIATION\":\"Y\",\"WEBNAME\":\"xxx\",\"DENGJIC\":3,\"TRADING\":\"A,B,C\",\"PROVNAME\":\"上海市\"},'DT1':[{\"YEAR\":\"2018\",\"M3\":30,\"MT\":780,\"CUSER\":\"61502355\",\"M6\":60,\"M9\":90,\"M1\":10,\"M11\":110,\"M4\":40,\"M7\":70,\"M2\":20,\"KUNNR\":\"6000542\",\"M12\":120,\"M5\":50,\"M8\":80,\"M10\":100,\"VTWEG\":\"GT\",\"CDATE\":\"2018-01-05T08:58:28\",\"STYPE\":\"T\"}],'DT2':[{\"M3\":3,\"MT\":78,\"CUSER\":\"61502355\",\"M6\":6,\"M9\":9,\"M1\":1,\"M11\":11,\"Y\":\"2018\",\"M4\":4,\"M7\":7,\"M2\":2,\"KUNNR\":\"6000542\",\"M12\":12,\"M5\":5,\"M8\":8,\"M10\":10,\"VTWEG\":\"GT\",\"CDATE\":\"2018-01-05T08:58:55\"}],'DT3':[],'DT4':[{\"WEBURL\":\"http://www.xx.com\",\"Y\":\"2018\",\"ROWNUM\":1,\"WEBNAME\":\"xxx\",\"KUNNR\":\"6000542\"}]}";
	  OTC_Tissue_Con_Distr_Webservice sd = new OTC_Tissue_Con_Distr_Webservice();
	  String result=sd.createOrUpdataContract(json);
	  out.println("success:"+result);
%>