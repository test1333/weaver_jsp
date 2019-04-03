<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<html>
	<head>
		<script type="text/javascript" src="/js/weaver.js"></script>
		<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
	</head>
	<%
	int emp_id = user.getUID();
	String sub_com = ResourceComInfo.getSubCompanyID(""+emp_id);
	int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
	int	perpage = 10;
	String cjkc_name = Util.null2String(request.getParameter("cjkc_name"));
	String imagefilename = "/images/hdDOC.gif";
	String titlename = "传阅子流程清单";
	String needfav ="1";
	String needhelp ="";
	String cyid = Util.null2String(request.getParameter("cyid"));  
	DocUtil du = new DocUtil();
	String tablename = du.getBillTableName("CY");
	String wftablename = du.getWfTableName("CY");
	String tablenamemj = du.getBillTableName("MJ");
	String tablenamejjcd = du.getBillTableName("JJCD");
	String formid = "";
	String modeid = "";
	String sql = "select id from workflow_bill where tablename='"+tablename+"'";
	rs.executeSql(sql);
	if(rs.next()){
		formid = Util.null2String(rs.getString("id"));
	}
	sql = "select id from modeinfo where  formid="+formid;
	rs.executeSql(sql);
	if(rs.next()){
		modeid = Util.null2String(rs.getString("id"));
	}
	
	String proj_code = Util.null2String(request.getParameter("proj_code"));  
	String proj_name = Util.null2String(request.getParameter("proj_name"));  
	String pro_manager = Util.null2String(request.getParameter("pro_manager"));  
	String proj_status = Util.null2String(request.getParameter("proj_status"));

	%>
	<BODY>
		<%@ include file="/systeminfo/TopTitle.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.weaver.submit(),_top} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{刷新,javascript:refresh(),_top} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu.jsp" %>
		<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
			<colgroup>
			<col width="10">
			<col width="">
			<col width="10">
			<tr>
				<td height="10" colspan="3"></td>
			</tr>
			<tr>
				<td ></td>
				<td valign="top">
					<TABLE class=Shadow>
						<tr>
							<td valign="top">
								<FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
									<input type="hidden" name="multiRequestIds" value="">
									<input type="hidden" name="operation" value="">
									<table width=100% class=ViewForm>
									<colgroup>
										<col width="10%"></col>
										<col width="10%"></col>
										<col width="10%"></col>
										<col width="10%"></col>
										<col width="10%"></col>
										<col width="10%"></col>
										<col width="10%"></col>
										<col width="10%"></col>
										<col></col>
										</colgroup>
									<!--	<tr>
										<TD align="center" valign="middle">项目编号</TD>
										<td><input class=inputstyle id='proj_code' name=proj_code size="20" value="<%=proj_code%>" ></td>
										<TD align="center" valign="middle">项目名称</TD>
										<td><input class=inputstyle id='proj_name' name=proj_name size="20" value="<%=proj_name%>" ></td>
										<TD align="center" valign="middle">项目负责人</TD>
										<td><input class=inputstyle id='pro_manager' name=pro_manager size="20" value="<%=pro_manager%>" ></td>
										<TD align="center" valign="middle">项目状态</TD>
										<td><select id="proj_status" name="proj_status">
												<option value=""></option>
												<option value="0" <%if ("0".equals(proj_status)) {%>selected<%}%>>整理初步设计方案</option>
												<option value="1" <%if ("1".equals(proj_status)) {%>selected<%}%>>搜集详细资料</option>
												<option value="2" <%if ("2".equals(proj_status)) {%>selected<%}%>>签订合作意向书</option>
												<option value="3" <%if ("3".equals(proj_status)) {%>selected<%}%>>设计详细方案</option>
												<option value="4" <%if ("4".equals(proj_status)) {%>selected<%}%>>签订合同</option>
												<option value="5" <%if ("5".equals(proj_status)) {%>selected<%}%>>归档</option>
											</select>
										</td>
									</tr>-->

									<tr style="height:1px;"><td class=Line colspan=11></td></tr>
									</table>
									<TABLE width="100%">
										<tr>
											<td valign="top">
												<%
												//V_GCL_PROJINFO formtable_main_2471
												String backfields ="wjbt,fwbh,a.requestid,b.requestname,b.creater,b.createdate||' '||b.createtime as createtime,(select count(1) from workflow_currentoperator where requestid=a.requestid and isremark in(2,4))||'/'||(select count(1) from workflow_currentoperator where requestid=a.requestid and isremark not in(2,4))||'/'||(select count(1) from workflow_currentoperator where requestid=a.requestid) as ckzt ";
												String fromSql  = " from  "+wftablename+" a,workflow_requestbase b ";
												String sqlWhere = " a.requestid=b.requestid and a.sjcyid='"+cyid+"' ";
												
											
												//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
												//out.println(sqlWhere);
												String orderby = " a.requestid " ;
												String tableString = "";
											
												tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
													"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.requestid\" sqlsortway=\"desc\" />"+
													"			<head>"+
														" 	<col width=\"15%\" text=\"公文标题\" column=\"wjbt\" orderkey=\"wjbt\" />"+
														" 	<col width=\"15%\" text=\"发文编号\" column=\"gwbh\" orderkey=\"gwbh\"  />"+
														"   <col width=\"15%\" text=\"传阅流程\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
														" 	<col width=\"15%\" text=\"已查看/未查看/总传阅\" column=\"ckzt\" orderkey=\"ckzt\"  />"+
														" 	<col width=\"15%\" text=\"流程发起人\" column=\"creater\" orderkey=\"creater\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"/>"+
														" 	<col width=\"15%\" text=\"发起时间\" column=\"createtime\" orderkey=\"createtime\"  />"+												
														" 	<col width=\"10%\" text=\"操作\" column=\"requestid\" orderkey=\"requestid\"  transmethod=\"gcl.doc.workflow.DocUtil.deleteRequest\" hide=\"true\" />"+
													
	
													"			</head>"+
												"</table>";
														//showExpExcel="true"
												%>
												
												<wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" showExpExcel="true" />
											</td>
										</tr>
									</TABLE>
								</FORM>
							</td>
						</tr>
					</TABLE>
				</td>
				<td></td>
			</tr>
			<tr>
				<td height="10" colspan="3"></td>
			</tr>
		</table>
		<script type="text/javascript">
			function refresh(){
			window.location.reload();
		}
		function deleterq(rqid){
			//alert("id")
			var creater = "<%=emp_id%>";
			var result = "";
			$.ajax({
             type: "POST",
             url: "/gcl/doc/docaction.jsp",
             data: {'billid':rqid, 'creater':creater,'type':'deleterq'},
             dataType: "text",
             async:false,//同步   true异步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        result=data;
                      }
        	 });
			 window.location.reload();
			 
		
		}	

	
		function downloadxml(){
		}	
		function onShowResourceID(inputname,spanname){
			var opts={
					_dwidth:'550px',
					_dheight:'550px',
					_url:'about:blank',
					_scroll:"no",
					_dialogArguments:"",
					_displayTemplate:"#b{name}",
					_displaySelector:"",
					_required:"no",
					_displayText:"",
					value:""
				};
			var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //获得窗口的垂直位置;
			var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //获得窗口的水平位置;
			opts.top=iTop;
			opts.left=iLeft;
			datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp",
					"","addressbar=no;status=0;scroll="+opts._scroll+";dialogHeight="+opts._dheight+";dialogWidth="+opts._dwidth+";dialogLeft="+opts.left+";dialogTop="+opts.top+";resizable=0;center=1;");
			if (datas) {
				if (datas.id!= "") {
					$("#"+spanname).html("<A href='javascript:openhrm("+datas.id+");' onclick='pointerXY(event);'>"+datas.name+"</A>");
					$("input[name="+inputname+"]").val(datas.id);
				}else{
					$("#"+spanname).html("");
					$("input[name="+inputname+"]").val("");
				}
			}
		}
		
		</script>
		<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
		<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
	</BODY>
</HTML>