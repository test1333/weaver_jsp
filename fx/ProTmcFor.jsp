<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.User" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
	<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
	<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<%
	String src = Util.null2String(request.getParameter("src"));
	String fost = Util.null2String(request.getParameter("fost"));
	
	String url_for = "";
	//  
	if(src.length() < 1){
		url_for = "/fx/tmcMessage.jsp?messid=101";
		response.sendRedirect(url_for);
  		return;
	}
	
	request.getSession(true).removeAttribute("weaver_user@bean");
	request.getSession(true).removeAttribute("curloginid");

	String allKey = "68421921";
	fx.TmcProMethod tpm = new fx.TmcProMethod(allKey);
	String randTime = Util.null2String(request.getParameter("randTime"));
	String loginRand = tpm.getSource(randTime);
	if(randTime.length() < 1){
		url_for = "/fx/tmcMessage.jsp?messid=102";
		response.sendRedirect(url_for);
  		return;
	}
	System.out.println("loginRand = " + loginRand);
	String sql = "select count(id) as count_cc from hrmresource where id=" + loginRand + " and status in(0,1,2,3)";
	rs.executeSql(sql);
	int idCount = 0;
	if(rs.next()){
		idCount = rs.getInt("count_cc");
	}
	if(idCount < 1){
		url_for = "/fx/tmcMessage.jsp?messid=103";
		response.sendRedirect(url_for);
  		return;
	}
	sql = "select * from hrmresource where id="+loginRand;
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
	
	int subCom = Util.getIntValue(rs.getString("subcompanyid1"), 0);
	
	String url_x = "";
	
	if("more".equalsIgnoreCase(fost)){
		url_x = "";
	}else{
		url_x = "/workflow/request/RequestView.jsp";
	}
	Date date = new Date();
	String ranNo = String.valueOf(date.getTime());
	url_x = url_x + "?randTime="+ranNo;
 	// 跳转到  目标界面
  	response.sendRedirect(url_x);
  	return;
%>