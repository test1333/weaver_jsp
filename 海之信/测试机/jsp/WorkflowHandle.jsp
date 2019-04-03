<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String idx = request.getParameter("id");//id
String operate = "";
String checkid = "";
String workflowshow = "";
String url = "";
String requestid = "";
String sql = "select operate,checkid from uf_differhandle where id = "+idx+"";
rs.executeSql(sql);
if(rs.next()){
	operate = Util.null2String(rs.getString("operate"));
  checkid = Util.null2String(rs.getString("checkid"));
}
sql = "select * from uf_checkrecord where id = "+checkid+"";
rs.executeSql(sql);
if(rs.next()){
  workflowshow = Util.null2String(rs.getString("workflowshow"));
}
		    	      if(operate.equals("1")){
                        String sql_rk = "select * from  formtable_main_111 where workflowcheckid = "+idx+"";
                        rs.executeSql(sql_rk);
                        if(rs.next()){
                        requestid = Util.null2String(rs.getString("requestid"));
                      }
                      if(workflowshow.equals("1")){
                         url = "/workflow/request/AddRequest.jsp?workflowid=122&field7953="+idx+"";
                      }else if(workflowshow.equals("2")){
                         url = "/workflow/request/ViewRequest.jsp?requestid="+requestid+"";
                    }

                }else if(operate.equals("2")){
                        String sql_jy = "select * from formtable_main_107 where workflowcheckid = "+idx+"";
                        rs.executeSql(sql_jy);
                        if(rs.next()){
                        requestid = Util.null2String(rs.getString("requestid"));
                      }
                      if(workflowshow.equals("1")){
	                      url = "/workflow/request/AddRequest.jsp?workflowid=118&field7951="+idx+"";
                      }else if(workflowshow.equals("2")){
                      url = "/workflow/request/ViewRequest.jsp?requestid="+requestid+"";
                    }

                }else if(operate.equals("3")){
                        String sql_gh = "select * from  formtable_main_106 where workflowcheckid = "+idx+"";
                        rs.executeSql(sql_gh);
                        if(rs.next()){
                        requestid = Util.null2String(rs.getString("requestid"));
                      }
                      if(workflowshow.equals("1")){
	                    url = "/workflow/request/AddRequest.jsp?workflowid=116&field7950="+idx+"";
                      }else if(workflowshow.equals("2")){
                      url = "/workflow/request/ViewRequest.jsp?requestid="+requestid+"";
                    }

                }else if(operate.equals("4")){
                        String sql_ly = "select * from  formtable_main_109 where workflowcheckid = "+idx+"";
                        rs.executeSql(sql_ly);
                        if(rs.next()){
                        requestid = Util.null2String(rs.getString("requestid"));
                      }
                      if(workflowshow.equals("1")){
	                     url = "/workflow/request/AddRequest.jsp?workflowid=120&field7952="+idx+"";
                      }else if(workflowshow.equals("2")){
                       url = "/workflow/request/ViewRequest.jsp?requestid="+requestid+"";
                    }

                }else if(operate.equals("5")){
                      String sql_th = "select * from  formtable_main_112 where workflowcheckid = "+idx+"";
                        rs.executeSql(sql_th);
                        if(rs.next()){
                        requestid = Util.null2String(rs.getString("requestid"));
                      }
                      if(workflowshow.equals("1")){
	                      url = "/workflow/request/AddRequest.jsp?workflowid=124&field7954="+idx+"";
                      }else if(workflowshow.equals("2")){
                        url = "/workflow/request/ViewRequest.jsp?requestid="+requestid+"";
                    }

                }else if(operate.equals("6")){

                      String sql_bf = "select * from  formtable_main_104 where workflowcheckid = "+idx+"";
                        rs.executeSql(sql_bf);
                        if(rs.next()){
                        requestid = Util.null2String(rs.getString("requestid"));
                      }
                      if(workflowshow.equals("1")){
	                       url = "/workflow/request/AddRequest.jsp?workflowid=110&field7948="+idx+"";
                       }else if(workflowshow.equals("2")){

                         url = "/workflow/request/ViewRequest.jsp?requestid='"+requestid+"'";
                     }

                }else if(operate.equals("7")){
                      String sql_bs = "select * from  formtable_main_105 where workflowcheckid = "+idx+"";
                        rs.executeSql(sql_bs);
                        if(rs.next()){
                        requestid = Util.null2String(rs.getString("requestid"));
                      }
                      if(workflowshow.equals("1")){
	                      url = "/workflow/request/AddRequest.jsp?workflowid=113&field7949="+idx+"";
                      }else if(workflowshow.equals("2")){
                       url = "/workflow/request/ViewRequest.jsp?requestid="+requestid+"";
                    }

                }else if(operate.equals("8")){
                      String sql_wx = "select * from  formtable_main_114 where workflowcheckid = "+idx+"";
                        rs.executeSql(sql_wx);
                        if(rs.next()){
                        requestid = Util.null2String(rs.getString("requestid"));
                      }
                      if(workflowshow.equals("1")){
                        url = "/workflow/request/AddRequest.jsp?workflowid=126&field7955="+idx+"";
                      }else if(workflowshow.equals("2")){
                      url = "/workflow/request/ViewRequest.jsp?requestid="+requestid+"";
                    }

                }

          System.out.println("URL= " + url);
          response.sendRedirect(url);

       
%>