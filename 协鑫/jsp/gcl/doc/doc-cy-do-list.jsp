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
	String titlename = "�Ѵ����б�";
	String needfav ="1";
	String needhelp ="";
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
		RCMenu += "{ˢ��,javascript:refresh(),_top} " ;
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
										<TD align="center" valign="middle">��Ŀ���</TD>
										<td><input class=inputstyle id='proj_code' name=proj_code size="20" value="<%=proj_code%>" ></td>
										<TD align="center" valign="middle">��Ŀ����</TD>
										<td><input class=inputstyle id='proj_name' name=proj_name size="20" value="<%=proj_name%>" ></td>
										<TD align="center" valign="middle">��Ŀ������</TD>
										<td><input class=inputstyle id='pro_manager' name=pro_manager size="20" value="<%=pro_manager%>" ></td>
										<TD align="center" valign="middle">��Ŀ״̬</TD>
										<td><select id="proj_status" name="proj_status">
												<option value=""></option>
												<option value="0" <%if ("0".equals(proj_status)) {%>selected<%}%>>���������Ʒ���</option>
												<option value="1" <%if ("1".equals(proj_status)) {%>selected<%}%>>�Ѽ���ϸ����</option>
												<option value="2" <%if ("2".equals(proj_status)) {%>selected<%}%>>ǩ������������</option>
												<option value="3" <%if ("3".equals(proj_status)) {%>selected<%}%>>�����ϸ����</option>
												<option value="4" <%if ("4".equals(proj_status)) {%>selected<%}%>>ǩ����ͬ</option>
												<option value="5" <%if ("5".equals(proj_status)) {%>selected<%}%>>�鵵</option>
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
												String backfields =" id,requestid,(select requestname from workflow_requestbase where requestid=a.requestid) as requestname,gwbh,fwbh,fwrq,wjbt,fwzt,tjbm,tjrfb,tjren,tjrq,(select mj from "+tablenamemj+" where id=a.mj) as mjname,mj,mjts,(select jjcd from "+tablenamejjcd+" where id=a.jjcd) as jjcdname,jjcd,jjcdts,sjzzcyr,sjzzjsrq||' '||sjzzjssj as sjzccysj,bcjzzcyr,bcjzzjsrq||' '||bcjzzjssj as bcjzzjssj, bcjzzcyrq||' '||bcjzzcysj as bcjzzcysj,(select count(1) from "+wftablename+" where sjcyid=a.id) as countnum,case when bcjzzcyrq is null then '' else round((to_date(bcjzzcyrq||' '||bcjzzcysj,'yyyy-mm-dd HH24:mi:ss')-to_date(bcjzzjsrq||' '||bcjzzjssj,'yyyy-mm-dd HH24:mi:ss'))*24,2)||'h' end as hs";
												String fromSql  = " from  "+tablename+" a ";
												String sqlWhere = " cllx='1' and 1=1 ";
												
											
												//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
												//out.println(sqlWhere);
												String orderby = " id " ;
												String tableString = "";
											
												tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
													"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />"+
													"			<head>"+
														" 	<col width=\"8%\" text=\"���ı���\" column=\"wjbt\" orderkey=\"wjbt\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId="+modeid+"&amp;formId="+formid+"&amp;opentype=0\" target=\"_fullwindow\"/>"+
													"              <col width=\"8%\" text=\"����\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
														" 	<col width=\"6%\" text=\"���ı��\" column=\"gwbh\" orderkey=\"gwbh\"  />"+
														" 	<col width=\"6%\" text=\"��������\" column=\"fwzt\" orderkey=\"fwzt\"  />"+
														" 	<col width=\"6%\" text=\"�ܼ�\" column=\"mjname\" orderkey=\"mjname\"  />"+
														" 	<col width=\"6%\" text=\"�����̶�\" column=\"jjcdname\" orderkey=\"jjcdname\"  />"+
														" 	<col width=\"6%\" text=\"�ύ��\" column=\"tjren\" orderkey=\"tjren\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
														" 	<col width=\"6%\" text=\"�ύ�ֲ�\" column=\"tjrfb\" orderkey=\"tjrfb\" transmethod=\"weaver.hrm.company.SubCompanyComInfo.getSubCompanyname\" />"+
														" 	<col width=\"6%\" text=\"�ύ����\" column=\"tjrq\" orderkey=\"tjrq\" />"+
													
														" 	<col width=\"5%\" text=\"�ϼ���֯������\" column=\"sjzzcyr\" orderkey=\"sjzzcyr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"/>"+
														" 	<col width=\"6%\" text=\"�ϼ���֯����ʱ��\" column=\"sjzccysj\" orderkey=\"sjzccysj\" />"+
														" 	<col width=\"5%\" text=\"���㼶��֯���İ�����\" column=\"bcjzzcyr\" orderkey=\"bcjzzcyr\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"/>"+
														" 	<col width=\"6%\" text=\"���㼶����ʱ��\" column=\"bcjzzjssj\" orderkey=\"bcjzzjssj\" />"+
														" 	<col width=\"6%\" text=\"���㼶����ʱ��\" column=\"bcjzzcysj\" orderkey=\"bcjzzcysj\" />"+
														" 	<col width=\"4%\" text=\"��ʱ\" column=\"hs\" orderkey=\"hs\"  />"+
														" 	<col width=\"4%\" text=\"���Ĵ���\" column=\"countnum\" orderkey=\"countnum\" linkvaluecolumn=\"id\" linkkey=\"cyid\" href=\"/gcl/doc/doc-cy-workflow-list.jsp\" target=\"_fullwindow\" />"+
															
														" 	<col width=\"6%\" text=\"����\" column=\"requestid\" orderkey=\"requestid\"  otherpara=\"column:id\" transmethod=\"gcl.doc.workflow.DocUtil.getCYButtonForDo\" hide=\"true\" />"+
													
	
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
		function cy(id){
			//alert("id")
			var creater = "<%=emp_id%>";
			var rqid = "";
			var result = "";
			$.ajax({
             type: "POST",
             url: "/gcl/doc/docaction.jsp",
             data: {'billid':id, 'creater':creater,'type':'check'},
             dataType: "text",
             async:false,//ͬ��   true�첽
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        result=data;
                      }
        	 });
			 //alert(result);
			 if(result == "1"){
				 alert("��δ�ύ�Ĵ���������");
				 return;
			 }

			$.ajax({
             type: "POST",
             url: "/gcl/doc/docaction.jsp",
             data: {'billid':id, 'creater':creater,'type':'cw'},
             dataType: "text",
             async:false,//ͬ��   true�첽
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        rqid=data;
                      }
        	 });
			 //alert(rqid);
			 if(rqid == "-1"){
 				alert("������������ʧ��");
				return;
			 }

	       openFullWindowForXtable('/workflow/request/ViewRequest.jsp?requestid='+rqid);
		}	

		function ycy(id){
			 var   obj  =  new  Object();   
   			obj.keyid=id;  
			var iTop = (window.screen.availHeight-30-parseInt(300))/2+"px"; //��ô��ڵĴ�ֱλ��;
			var iLeft = (window.screen.availWidth-10-parseInt(500))/2+"px"; //��ô��ڵ�ˮƽλ��
			var k=window.showModalDialog("/gcl/doc/editRemark.jsp",
					obj,"addressbar=no;status=0;scroll=no;dialogHeight=300px;dialogWidth=500px;dialogLeft="+iLeft+";dialogTop="+iTop+";resizable=0;center=1;");
			if(k == 1){//�ж��Ƿ�ˢ��
				window.location.reload();
			}
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