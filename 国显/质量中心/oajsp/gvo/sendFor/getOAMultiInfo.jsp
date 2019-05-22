<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.net.*"%>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ page import="weaver.general.BaseBean"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />	
<%!
	public String encrypt(String sSrc) throws Exception {
		String sKey = "7227730012772198";   //  加密
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
	String x_ifDecode = Util.null2String(request.getParameter("ifDecode"));//是否需要decode
	String x_login = Util.null2String(request.getParameter("account"));//账户信息参数值
	if("Y".equals(x_ifDecode)){
		x_login = java.net.URLDecoder.decode(x_login,"UTF-8");
	}
	String x_logintype = Util.null2String(request.getParameter("accountType"));//账户类型 1：人员id	2：人员工号	   3：人员loginid
	//x_type 0.自定义拼接	1.新建流程		2.查看流程		3.查看文档		4.表单建模查询	5.表单建模-树查询	6.表单建模-报表查询	7.门户页面
	String x_type = Util.null2String(request.getParameter("infoType"));
	String x_info = Util.null2String(request.getParameter("info"));//访问内容参数值
	if("".equals(x_login) || "".equals(x_logintype) || "".equals(x_type)){
		%>
			<script language="javascript">
				alert("系统验证信息失败,参数不可为空!");
				window.opener=null;
				window.open('','_self');
				window.close();
			</script>
		<%
		return;
	}
	String f_login = decrypt(x_login);   //  2次解密
	//String nsString = x_login; 
	if(f_login == null) f_login = "";
	
	if(f_login==""){
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
	
	
	String sql = "" ;
	String accountField = " loginid ";
	if( x_login.length() > 0){

		if(x_logintype.length() > 0){
			if(x_logintype.equals("1")){
				if(x_login.matches("^[0-9]*$")){
					accountField = " id ";
				} else {
					%>
					<script language="javascript">
						alert("登录ID为非数字，将关闭页面!");
						window.opener=null;
						window.open('','_self');
						window.close();
					</script>
					<%
					return;				
				}
			}else if (x_logintype.equals("2")){
				accountField = " workcode ";
			}else if(x_logintype.equals("3")){
				accountField = " loginid ";
			}
		}
		int xxxid = 0;
		String loginid = "";
		if("sysadmin".equals(f_login)){
			xxxid = 1;
		}else{
			sql = "select id,loginid from hrmresource where "+accountField+" = '" + f_login + "'";			
			rs.executeSql(sql);			
			if(rs.next()){
				xxxid = rs.getInt("id");
				loginid = Util.null2String(rs.getString("loginid"));
			}
		}
		
		if(xxxid < 1 ) {
			%>
			<script language="javascript">
				alert("原系统无账号，将关闭页面!");
				window.opener=null;
				window.open('','_self');
				//window.close();
			</script>
			<%
			out.print(f_login+"-------------"+x_login);
			return;
		}
		
		User user1 = new User();
		user1 = User.getUser(xxxid, 0);
		
		request.getSession(true).setMaxInactiveInterval(60 * 60 * 24);
		request.getSession(true).setAttribute("curloginid",loginid);
		request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
		request.getSession(true).setAttribute("SESSION_CURRENT_THEME","ecology8");
		request.getSession(true).setAttribute("SESSION_TEMP_CURRENT_THEME","ecology8"); 
    	request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
		request.getSession(true).setAttribute("weaver_user@bean", user1);
		request.getSession(true).setAttribute("browser_isie", "true");	
		
		String toRedirect = "/wui/main.jsp";
		String decodeurl = java.net.URLDecoder.decode(x_info,"UTF-8");
		if(x_type.length() > 0 ){
			//有内容类型，没有内容
			if(x_info.length() > 0){
				if(x_type.equals("0")){
					//自定义拼接链接
					toRedirect = decodeurl;
				} else if(x_type.equals("1")){
					//新建流程
					String infosql = "select nvl(activeVersionID,id) AVID from workflow_base  where id ='"+x_info+"'";
					rs1.executeSql(infosql);
					String workflowid = "";
					if(rs1.next()){
						workflowid = Util.null2String(rs1.getString("AVID"));
					} else {
						%>
						<script language="javascript">
							alert("该流程不存在，将关闭页面!");
							window.opener=null;
							window.open('','_self');
							window.close();
						</script>
						<%
						return;
					}
					toRedirect = "/workflow/request/AddRequest.jsp?workflowid="+workflowid;
				} else if(x_type.equals("2")){
					//查看待办流程
					toRedirect = "/workflow/request/RequestView.jsp";
				} else if(x_type.equals("3")){
					//查看已办流程
					toRedirect = "/workflow/request/RequestHandled.jsp";
				} else if(x_type.equals("4")){
					//查看单条流程
					toRedirect = "/workflow/request/ViewRequest.jsp?requestid="+x_info;
				} else if(x_type.equals("5")){
					//查看文档
					toRedirect = "/docs/docs/DocDsp.jsp?id="+x_info;
				} else if(x_type.equals("6")){
					//表单建模-查询
					toRedirect = "/formmode/search/CustomSearchBySimple.jsp?customid="+x_info;
				} else if(x_type.equals("7")){
					//表单建模-树查询
					toRedirect = "/formmode/tree/ViewCustomTree.jsp?id="+x_info;
				} else if(x_type.equals("8")){
					//表单建模-报表
					toRedirect = "/formmode/report/ReportCondition.jsp?id="+x_info;
				} else if(x_type.equals("9")){
					//门户页面
					toRedirect = "/homepage/Homepage.jsp?&isfromportal=1&isfromhp=0&hpid="+x_info;
				}else if(x_type.equals("10")){
					//门户页面
					String formid = "";
					String sqlmode = "select formid from modeinfo where id="+x_info;
					rs1.executeSql(sqlmode);
					if(rs1.next()){
						formid = Util.null2String(rs1.getString("formid"));
					}
					toRedirect = "/formmode/view/AddFormMode.jsp?customTreeDataId=null&mainid=0&modeId="+x_info+"&formId="+formid+"&type=1";
				}else if(x_type.equals("11")){
					//建模信息查询
					String arr[] = x_info.split(",");
					String modeid = arr[0];
					String billid = arr[1];
					String formid = "";
					String sqlmode = "select formid from modeinfo where id="+modeid;
					rs1.executeSql(sqlmode);
					if(rs1.next()){
						formid = Util.null2String(rs1.getString("formid"));
					}
					toRedirect = "/formmode/view/AddFormMode.jsp?type=0&modeId="+modeid+"&formId="+formid+"&billid="+billid+"&opentype=0";
				} else {
					//有内容类型，内容类型不在所含内容
					if(x_info.length() > 0){
						toRedirect = decodeurl; 
					}			
				}
			} 		
		} else {
			if(x_info.length() > 0){
				toRedirect = decodeurl; 
			}
		}
		//out.print(toRedirect);
		response.sendRedirect(toRedirect);
	}
%>