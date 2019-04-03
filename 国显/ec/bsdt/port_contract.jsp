<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="weaver.systeminfo.SystemEnv"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs3" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>网报|费控|财务共享服务平台</title>
  <meta name="description" content="port" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" cache="false" />
  <link rel="stylesheet" href="css/plugin.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" />
  
   <script type="text/javascript" src="/js/select/script/jquery-1.8.3.min_wev8.js"></script>	  
  <script type="text/javascript" src="/wui/common/jquery/jquery.min_wev8.js"></script>
  <script type="text/javascript" src="/js/ecology8/lang/weaver_lang_7_wev8.js"></script>
  <script language=javascript src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
  <script language="javascript" type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
  <script  language="javascript" src="/bsdt/js/common.js"></script>
</head>
<body data-spy="scroll" data-target="#header" class="landing" id="home"> 

<%@ include file="headSeach_contract.jsp"%>
<iframe frameborder="0" width="100%" height="100%" src="/homepage/Homepage.jsp?hpid=21&subCompanyId=82&isfromportal=1&isfromhp=0" ></iframe>
</body>


