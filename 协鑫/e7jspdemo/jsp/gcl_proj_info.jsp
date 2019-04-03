<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
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
	String titlename = "项目基本信息";
	String needfav ="1";
	String needhelp ="";
	
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
									<tr>
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
									</tr>

									<tr style="height:1px;"><td class=Line colspan=11></td></tr>
									</table>
									<TABLE width="100%">
										<tr>
											<td valign="top">
												<%
												//V_GCL_PROJINFO formtable_main_2471
												String backfields =" id,xmmc,khmc,gsdz,lxr,lxdh,xmfzr,cjrq,ssdw,xmzt,xmbh,p_status ";
												String fromSql  = " from V_GCL_PROJINFO ";
												String sqlWhere = " 1=1 ";
												
												if(!"".equals(proj_code)){
													proj_code = proj_code.trim();
													sqlWhere += "and xmbh like '%"+proj_code+"%' ";
												}
												
												if(!"".equals(proj_name)){
													proj_name = proj_name.trim();
													sqlWhere += "and xmmc like '%"+proj_name+"%' ";
												}
												
												if(!"".equals(pro_manager)){
													pro_manager = pro_manager.trim();
													sqlWhere += "and xmfzr in (select id from hrmresource where lastname like '%"+pro_manager+"%')";
												}
												
												if(!"".equals(proj_status)){
													//proj_code = proj_code.trim();
													sqlWhere += "and xmzt = "+proj_status+" ";
												}
												//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
												//out.println(sqlWhere);
												String orderby = " id " ;
												String tableString = "";
												tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
													"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />"+
													"			<head>"+
														" 	<col width=\"12%\" text=\"项目编号\" column=\"xmbh\" orderkey=\"xmbh\"  />"+
	" 	<col width=\"12%\" text=\"项目名称\" column=\"xmmc\" orderkey=\"xmmc\" linkvaluecolumn=\"id\" linkkey=\"billid\" "
	+" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=82&amp;formId=-2471&amp;opentype=0&amp;customid=102&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\" />"+
														"	<col width=\"12%\" text=\"项目负责人\" column=\"xmfzr\" orderkey=\"xmfzr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
														"	<col width=\"12%\" text=\"项目状态\" column=\"p_status\" orderkey=\"p_status\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/gcl/jsp/gcl_project_process_new.jsp\" target=\"_fullwindow\" />"+
														" 				<col width=\"12%\" text=\"客户名称\" column=\"khmc\" orderkey=\"khmc\"  />"+
														" 				<col width=\"12%\" text=\"行业\" column=\"ssdw\" orderkey=\"ssdw\"  />"+
														" 				<col width=\"12%\" text=\"用电分类\" column=\"gsdz\" orderkey=\"gsdz\"  />"+
														" 				<col width=\"12%\" text=\"收资日期\" column=\"cjrq\" orderkey=\"cjrq\"  />"+
													"			</head>"+
												"</table>";
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