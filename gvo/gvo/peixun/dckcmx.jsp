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
	int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
	int	perpage = 10;
	String cjkc_name = Util.null2String(request.getParameter("cjkc_name"));
	String imagefilename = "/images/hdDOC.gif";
	String titlename = "���ογ���ϸͳ�Ʊ�";
	String needfav ="1";
	String needhelp ="";
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
											<TD>�γ�����</TD>
											<td><input class=inputstyle id='cjkc_name' name=cjkc_name size="20" value="<%=cjkc_name%>" ></td>
										</tr>
										<tr style="height:1px;"><td class=Line colspan=11></td></tr>
									</table>
									<TABLE width="100%">
										<tr>
											<td valign="top">
												<%
												String backfields =
												" (select subcompanyname from hrmsubcompany where id = pxzzf)as zzf_name,f.pxrq, "
												+" (select kcmc from formtable_main_193 where id = sqcjkc) as kc_name,"
												+" (select jsmc from formtable_main_192 fm where fm.id = f.jsmc) as js_name,f.ks,"
												+" (select lastname from hrmresource where id = sqr) as sqr_name,"
												+" (select subcompanyname from hrmsubcompany where id = ssgs)as gs_name ";
												String fromSql  = " from formtable_main_194 f ";
												String sqlWhere = " 1=1 ";
												if(!"".equals(cjkc_name)){
												cjkc_name = cjkc_name.trim();
												sqlWhere += "and f.sqcjkc in (select id from formtable_main_193 where kcmc like '%"+cjkc_name+"%')";
												}
												//if(!"".equals(resourceid)){
												//sqlWhere += "and za.operateuserid ="+resourceid+" ";
												//}
												// out.println("select "+ backfields + fromSql + " where " + sqlWhere);
												//System.out.println(sqlWhere);
												String orderby = " pxrq " ;
												String tableString = "";
												tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
													"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />"+
													"			<head>"+
														" 				<col width=\"29%\" text=\"��ѵ��֯��\" column=\"zzf_name\" orderkey=\"zzf_name\"  />"+
														" 				<col width=\"7%\" text=\"����\" column=\"pxrq\" orderkey=\"pxrq\"  />"+
														"				<col width=\"40%\" text=\"�γ�����\" column=\"kc_name\" orderkey=\"kc_name\"  />"+
														"				<col width=\"6%\" text=\"��ʦ����\" column=\"js_name\" orderkey=\"js_name\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
														" 				<col width=\"6%\" text=\"��ʱ(Hr)\" column=\"ks\" orderkey=\"ks\"  />"+
														" 				<col width=\"6%\" text=\"������\" column=\"sqr_name\" orderkey=\"sqr_name\"  />"+
														" 				<col width=\"6%\" text=\"���ڹ�˾\" column=\"gs_name\" orderkey=\"gs_name\"  />"+
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
			var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //��ô��ڵĴ�ֱλ��;
			var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //��ô��ڵ�ˮƽλ��;
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