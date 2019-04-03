<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<%
//	 java.util.List<String> session_list = new java.util.ArrayList<String>();
//	 java.util.Enumeration enumeration = request.getSession(true).getAttributeNames();   //遍历enumeration中的 
//	 while(enumeration.hasMoreElements()){   //获取session键值     
//		 String name = enumeration.nextElement().toString();
//		 session_list.add(name);
//	}
	
//	for(int i=0;i<session_list.size();i++){
//		request.getSession(true).removeAttribute(session_list.get(i));
//	}
	
	//request.getSession(true).invalidate(); 
	
	request.getSession(true).removeAttribute("weaver_user@bean");
	request.getSession(true).removeAttribute("curloginid");

	String uid = Util.null2String(request.getParameter("uid"));
	
	String sql = "select * from hrmresource where id="+uid;
	rs.executeSql(sql);
	rs.next();
	User user = new User();

    String tmp_loginid = rs.getString("loginid");
    
                user.setUid(rs.getInt("id"));
                user.setLoginid(tmp_loginid);
                user.setFirstname(rs.getString("firstname"));
                user.setLastname(rs.getString("lastname"));
                user.setAliasname(rs.getString("aliasname"));
                user.setTitle(rs.getString("title"));
                user.setTitlelocation(rs.getString("titlelocation"));
                user.setSex(rs.getString("sex"));
       //         user.setPwd("password");
                String languageidweaver = rs.getString("systemlanguage");
                
                user.setLanguage(7);

                user.setTelephone(rs.getString("telephone"));
                user.setMobile(rs.getString("mobile"));
                user.setMobilecall(rs.getString("mobilecall"));
                user.setEmail(rs.getString("email"));
                user.setCountryid(rs.getString("countryid"));
                user.setLocationid(rs.getString("locationid"));
                user.setResourcetype(rs.getString("resourcetype"));
             //   user.setStartdate(startdate);
           //     user.setEnddate(enddate);
                user.setContractdate(rs.getString("contractdate"));
                user.setJobtitle(rs.getString("jobtitle"));
                user.setJobgroup(rs.getString("jobgroup"));
                user.setJobactivity(rs.getString("jobactivity"));
                user.setJoblevel(rs.getString("joblevel"));
                user.setSeclevel(rs.getString("seclevel"));
                user.setUserDepartment(Util.getIntValue(rs.getString("departmentid"), 0));
                user.setUserSubCompany1(Util.getIntValue(rs.getString("subcompanyid1"), 0));
                user.setUserSubCompany2(Util.getIntValue(rs.getString("subcompanyid2"), 0));
                user.setUserSubCompany3(Util.getIntValue(rs.getString("subcompanyid3"), 0));
                user.setUserSubCompany4(Util.getIntValue(rs.getString("subcompanyid4"), 0));
                user.setManagerid(rs.getString("managerid"));
                user.setAssistantid(rs.getString("assistantid"));
                user.setPurchaselimit(rs.getString("purchaselimit"));
                user.setCurrencyid(rs.getString("currencyid"));
          //      user.setLastlogindate(currentdate);
                user.setLogintype("1");
                user.setAccount(rs.getString("account"));
                
user.setLoginip(request.getRemoteAddr());
                request.getSession(true).setMaxInactiveInterval(60 * 60 * 24);
                
    	request.getSession(true).setAttribute("curloginid",tmp_loginid);
	request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
	request.getSession(true).setAttribute("SESSION_CURRENT_THEME","ecology7");
	request.getSession(true).setAttribute("SESSION_TEMP_CURRENT_THEME","ecology7"); 
    	request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
	request.getSession(true).setAttribute("weaver_user@bean", user);
	request.getSession(true).setAttribute("browser_isie", "true");
	
	if (user.getUID() != 1) {  //is not sysadmin
		java.util.List accounts = new weaver.login.VerifyLogin().getAccountsById(rs.getInt("id"));
		request.getSession(true).setAttribute("accounts", accounts);
	}
	
	
 // 跳转到  目标界面
  response.sendRedirect("/wui/main.jsp?templateId=1");
  return;
%>