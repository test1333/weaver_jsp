<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="TaiSon.kq.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
  KqUtil kq = new KqUtil();
   kq.insertLdkData("2019-06-02","2019-06-02");
   //kq.insertLdkData("2019-05-20","2019-05-21");
   //CreateLDKFlowAction clf = new CreateLDKFlowAction();
  // clf.createFlow("3012");
  CreateLDKRemind cl = new CreateLDKRemind();
  cl.createLDKRemind("2019-06-02","2019-06-02");
  //CreateQqRemind cq = new CreateQqRemind();
  //cq.createQqRemind("2019-05-20","2019-05-20");
%>