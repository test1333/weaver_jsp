
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
	<script type="text/javascript">	
				
		function onCheckup1(){
			if(window.confirm('是否查询并更新')){
				document.report.multiIds.value = "1";
				document.report.submit();
			}
		}
				
		function onBtnSearchClick() {
			report.submit();
		}
					
	</script>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
boolean isShow = false;

int userid = user.getUID();
String loginip = user.getLoginip();
String multiIds = Util.null2String(request.getParameter("multiIds"));
SimpleDateFormat sf1  = new SimpleDateFormat("yyyy-MM-dd");
String nowdata = sf1.format(new Date());
//out.print("userid:"+userid+" ip:"+loginip);


%>

<BODY>
<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
<%

	//RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;
	//RCMenu += "{查询并更新,javascript:onCheckup(),_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;

%>
	<FORM id=report name=report action=/zx/hr/person-info-confirm.jsp method=post>
		<input type="hidden" name="multiIds" value="-1">
			<%
		if("1".equals(multiIds)){	
			String  result = "";	
			
			out.println(result);
			
		}
		
			
	%>

<wea:layout type="2col">
<wea:group context="人员信息确认" attributes="test">


<wea:item >确认日期:</wea:item>
<wea:item><%=nowdata%></wea:item>
<wea:item>姓名:</wea:item>
<wea:item>
        <input name="xm" id="xm" class="InputStyle" type="text" value=""/>
</wea:item>
<wea:item>工号:</wea:item>
<wea:item>
        <input name="gh" id="gh" class="InputStyle" type="text" value=""/>
</wea:item>
<wea:item>部门:</wea:item>
<wea:item>
        <input name="bm" id="bm" class="InputStyle" type="text" value=""/>
</wea:item>
<wea:item>证件号码:</wea:item>
<wea:item>
        <input name="zjhm" id="zjhm" class="InputStyle" type="text" value=""/>
</wea:item>
<wea:item>相关文档:</wea:item>
<wea:item>
<div>
 <%
	String docid = "";
	String docsubject = "";
	String flag = "";
	String sql = "select id,docsubject from DocDetail where id in(24476,24477) order by id asc";
	rs.execute(sql);
	while(rs.next()){
		docid = Util.null2String(rs.getString("id"));
		docsubject = Util.null2String(rs.getString("docsubject"));
%>
<%=flag%>
<a href = "/docs/docs/DocDsp.jsp?id=<%=docid%>" target="_blank" ><%=docsubject%></a>

<%
flag="<br/>";
	}
 
 %>
 <br/>
 <span style="color:blue">-------------------------------------------------------------------------</span>
 <br/>
 <span style="color:red">人员信息填写完成后，视同已阅此三份文档，并且确认无异议！</span>
 </div>
</wea:item>
<wea:item>&nbsp;&nbsp;</wea:item>
		<wea:item>
		<table width="30%">
			<tr>
				<td><input name="hi1" type="button" value="提交" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:100px;height:30px;font-size:15px;" onClick="onCheckup()"></td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</tr>
		</table>
			<script type="text/javascript">	
				
				function onCheckup(){
					 var dialog = parent.getDialog(window);
					var xm=jQuery("#xm").val();
					var gh=jQuery("#gh").val();
					var bm=jQuery("#bm").val();
					var zjhm=jQuery("#zjhm").val();
					if(xm == "" || gh==""|| bm==""|| zjhm==""){
						window.top.Dialog.alert("所有信息需填写完整");
						return;
					}
					 top.Dialog.confirm('是否提交确认信息',function(){

						   var result = "";
						   jQuery.ajax({
								type: "POST",
								url: "/zx/hr/confirminfo.jsp",
								data: {'xm':xm,'gh':gh,'bm':bm,'zjhm':zjhm},
								dataType: "text",
								async:false,//同步   true异步
								success: function(data){
											data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
											result=data;
										}
							});

       					 dialog.closeByHand();
   					 });

					//if(window.confirm('是否启用预算版本？')){
					//	document.report.multiIds.value = "1";
					//	document.report.submit();
				   // }
				}
								
				
					
			</script>
		
		</wea:item>
		


</wea:group>
</wea:layout>	
			
	</FORM>

</BODY>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>

</HTML>
	

