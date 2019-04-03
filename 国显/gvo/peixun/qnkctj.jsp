<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<html>
	<head>
		<script type="text/javascript" src="/js/weaver.js"></script>
		<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
	</head>
	<%
	int emp_id = user.getUID();
	int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
	int	perpage = 10;
	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	String pxlb_lb = Util.null2String(request.getParameter("pxlb_lb"));
	String imagefilename = "/images/hdDOC.gif";
	String titlename = "全年课程统计表";
	String needfav ="1";
	String needhelp ="";

	if(!HrmUserVarify.checkUserRight("BaoBiao201504:Edit",user)){
	response.sendRedirect("/notice/noright.jsp");
	return;}//权限控制
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
										<colgroup><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col></colgroup>
										<tr>
											<TD>培训日期</TD>
											<TD class=field>
												<BUTTON class=Calendar type="button" id=selectfromdate onclick="getDate(fromdatespan,fromdate)"></BUTTON>
												<SPAN id=fromdatespan ><%=fromdate%></SPAN>
												<input class=inputstyle type="hidden" name="fromdate" value="<%=fromdate%>">
												-<BUTTON class=Calendar type="button" id=selectenddate onclick="getDate(enddatespan,enddate)"></BUTTON>
												<SPAN id=enddatespan ><%=enddate%></SPAN>
												<input class=inputstyle type="hidden" name="enddate" value="<%=enddate%>">
											</TD>
											<TD>&nbsp;</TD>
											<td>讲师姓名</td>
											<td class=Field><BUTTON class=Browser type="button" id=SelectManagerID onClick="onShowResourceID('resourceid','resourceidspan')"></BUTTON>
												<span id=resourceidspan><%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%></span>
												<INPUT class=saveHistory id=resourceid type=hidden name=resourceid value="<%=resourceid%>"></td>
												<td></td>
											</tr>
											<tr>
												<TD>培训类别</TD>
												<td><select id="pxlb_lb" name="pxlb_lb">
													<option value=""></option>
													<option value="0" <%if("0".equals(pxlb_lb)){%>selected<%}%>>公开培训</option>
													<option value="1" <%if("1".equals(pxlb_lb)){%>selected<%}%>>专题培训</option>
												</select>
											</td>
											<TD>&nbsp;</TD>
										</tr>
										<tr style="height:1px;"><td class=Line colspan=11></td></tr>
									</table>
									<TABLE width="100%">
										<tr>
											<td valign="top">
												<%
												String backfields = "(select subcompanyname from hrmsubcompany where id = pxzzf)as zzf_name,"
												+" f.kcmc,f.ks,f.pxrq,"
												+" decode(f.kclb,0,'管理类','技术类') as kclx,"
												+" decode(f.pxxs,0,'课堂式教学',1,'现场示范',2,'会议/研讨','电视/录像学习') as pxfs,"
												+" (select jsmc from formtable_main_192 fa where fa.id = f.jsmc) as js_name ";
												String fromSql  = " from formtable_main_193 f ";
												String sqlWhere = " 1=1 ";
												if(!"".equals(fromdate)){
												sqlWhere +=" and f.pxrq>='"+fromdate+" 00:00:00' ";
												if(!"".equals(enddate)){
												sqlWhere +=" and f.pxrq <='"+enddate+" 23:59:59' ";
												}
												}else{
												if(!"".equals(enddate)){
												sqlWhere +=" and f.pxrq<='"+enddate+" 23:59:59' ";
												}
												}
												if(!"".equals(resourceid)){
												sqlWhere += "and jsmc in(select id from formtable_main_192 where jsmc="+resourceid+") ";
												}
												if(!"".equals(pxlb_lb)){
												sqlWhere += "and f.pxlb ="+pxlb_lb+" ";
												}
												// out.println("select "+ backfields + fromSql + " where " + sqlWhere);
												//System.out.println(sqlWhere);
												String orderby = " pxrq " ;
												String tableString = "";
												tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
													"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />"+
													"			<head>"+
													    " 				<col width=\"40%\" text=\"培训课程\" column=\"kcmc\" orderkey=\"kcmc\"  />"+
													    " 				<col width=\"10%\" text=\"培训日期\" column=\"pxrq\" orderkey=\"pxrq\"  />"+
													    "				<col width=\"8%\" text=\"课时(Hr)\" column=\"ks\" orderkey=\"ks\"  />"+
														" 				<col width=\"12%\" text=\"培训组织方\" column=\"zzf_name\" orderkey=\"zzf_name\"  />"+
														"				<col width=\"10%\" text=\"讲师姓名\" column=\"js_name\" orderkey=\"js_name\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
														" 				<col width=\"10%\" text=\"培训形式\" column=\"pxfs\" orderkey=\"pxfs\"  />"+
														" 				<col width=\"10%\" text=\"课程类别\" column=\"kclx\" orderkey=\"kclx\"  />"+
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