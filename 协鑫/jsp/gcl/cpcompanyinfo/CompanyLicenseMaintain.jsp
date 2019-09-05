<%@page import="weaver.cpcompanyinfo.CompanyInfoTransMethod"%>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	if(!HrmUserVarify.checkUserRight("License:manager", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<LINK href="/cpcompanyinfo/style/Public.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
String imagefilename = "/images/hdSystem.gif";
String titlename = ""+SystemEnv.getHtmlLabelName(30945,user.getLanguage());
String needfav ="1";
String needhelp ="";

String n_01="4px";
String n_02="0px";
String n_03="430px";
String  isie=Util.null2String(session.getAttribute("browser_isie")+"");
if(!"true".equals(isie)){
		n_01="0px";
		n_02="10px";
		n_03="400px";
}
int temp=0;
String flag=Util.null2String(request.getParameter("flag"));
%>
<BODY >
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(611,user.getLanguage())+",javascript:doadd_gd(),_self} " ;    
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:dodel_gd(),_self} " ;    
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(30986,user.getLanguage())+",javascript:dosave_gd(),_self} " ;    
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

	<iframe src="" style="display: none;" id="postiframe" name="postiframe"></iframe>
	<FORM id=frmMain  name=frmMain action="/cpcompanyinfo/CompanyServiceOperate.jsp" method=post  target="postiframe">
	<table style="width:98%;border-collapse:collapse;" align="center"  id="sss">
	<tr>
		<td valign="top" >
			<TABLE class=Shadow>
			<tr>
			<td valign="top"  >
	
								<input type="hidden" name=delete_n   id="delete_n" >	
								<input type="hidden" name=temp_n   id="temp_n" value="<%=temp%>">
								<input type="hidden" name=countryid_count   id="countryid_count"  >
								<input type="hidden" name=temp_type   id="temp_type" value="CompanyLicenseMaintain">
									
									
									<table class="liststyle" cellspacing="1"  style="table-layout: fixed;background-color: white;margin-left: <%=n_02 %>" >
									<colgroup>
											<col width="31px">
											<col width="250px">
											<col width="250px">
											<col width="*">
									</colgroup>
									<tr class="header">
									<th ><input type="checkbox"   onclick="checkAll(this)"></th>
									<th><%=SystemEnv.getHtmlLabelName(15486,user.getLanguage())%></th>
									<th><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></th>
									<th><%=SystemEnv.getHtmlLabelName(31086,user.getLanguage())%></th>
									</tr>
									<tr>
											<td colspan="4"  style="padding:0px">
														<div style="overflow-y: auto;overflow-x:none ;height:<%=n_03 %>"  id=valign_div>
																		<table class="liststyle" cellspacing="1"  id="webTable2gd"   style="table-layout: fixed;margin: 0px;">
																			<colgroup>
																				<col width="30px">
																				<col width="250px">
																				<col width="250px">
																				<col width="*">
																		</colgroup>
																					<%
																		        			String sql="select CPLMLICENSEAFFIX.*,(select count(*) from CPLMLICENSEAFFIX ) s from CPLMLICENSEAFFIX  order by affixindex";
																			      			rs.execute(sql);
																			      			int temp_nubm=0;
																			      			while(rs.next()){
																			      					temp=Util.getIntValue(rs.getString("s"),0);
																			      					String licensename=rs.getString("licensename");
																			      					String licenseaffixid=rs.getString("licenseaffixid");
																			      					String affixindex=rs.getString("affixindex");
																			      					String ismulti=rs.getString("ismulti");
																			      					
																			      	%>
																								<tr   <%if(temp_nubm%2==0){out.println(" style='background-color:#EEE'");} %>>
																								<td style="padding:5px ">
																											<%
																										 			//affixindex为空字符的是系统初始化的类型，不能删
																										 			if(!CompanyInfoTransMethod.CheckSION("1",licenseaffixid)&&!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
																										 	%>
																										 			<input type="checkbox" value='<%=licenseaffixid %>'  name='aa'>
																										 	<%			
																										 			}
																										 	 %>
																								</td>
																								<td style="padding:5px ">
																										<%
																											if(!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
																										%>
																											<input class=inputstyle   type=text  style="80px;padding: 0px;background-image: none;ime-mode: disabled"  onblur="changeimg(this)"   name=affixindexdesc   maxlength="5"   value="<%=affixindex%>"    onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" >
																									<%
																											}else{
																										%>
																										-1
																										<input class=inputstyle  type=hidden  style="80px;padding: 0px;background-image: none;"   name=affixindexdesc   maxlength="5"   value="<%=affixindex%>"   onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value">
																										
																									<%	
																											
																											}
																										 %>
																										  <SPAN> </SPAN>
																								</td>
																								<td style="padding:5px ">
																										
																											<input class=inputstyle type=hidden  style="80px"   name=countryid     value="<%=licenseaffixid%>">
																											<%
																												if(!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
																											%>
																												<input class=inputstyle type=text  style="80px"   name=affname   maxlength="10"  onblur="changeimg(this)" value="<%=licensename%>">
																												<%
																											}else{
																										 %>
																										 	<input class=inputstyle type=text  style="80px;background-image: none;background-color: white;border: 0px"   name=affname   maxlength="10"  onfocus="this.blur()" value="<%=licensename%>">
																										 <%
																										 	}
																										  %>
																								            <SPAN> </SPAN>
																								</td>
																								<td style="padding:5px ">
																										<%
																											if(!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
																										%>
																											<input type="checkbox"  id="ismulti" name="ismulti" <%if("1".equals(ismulti)){out.println("checked='checked'");}%> value="1">
																										<%
																											}else{
																										%>	
																												
																												<div style="background:url('/cpcompanyinfo/images/ck.png')  no-repeat; margin-left: <%=n_01%>">&nbsp;</div>
																												<input type=hidden  id="ismulti" name="ismulti"  value="0" >
																										<%
																											}
																										 %>
																								</td>
																								</tr>
																						<%			
																					 			}
																					 	
																					 	 %>
																		</table>
														</div>
											</td>
									</tr>
									</table>
			</td>
			</tr>
			</TABLE>
		</td>
	</tr>
	</table>
</FORM>	
			<div id="hiddenTrInDIV" style="display:none">	
				<span _name="s">
						<input type="checkbox" name='aa'>
				</span>
				<span _name="s">
								<input class=inputstyle type=text  style="80px"  name=affixindexdesc   maxlength="5"  onblur="changeimg(this)"   onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value">
					            <SPAN ><IMG src="/images/BacoError.gif" align=absMiddle></SPAN>
				</span>
				<span _name="s">
						<input class=inputstyle type=hidden  style="80px"   name=countryid  >
						<input class=inputstyle type=text   style="80px"   name=affname   _id=""  maxlength="10"  onblur="changeimg(this)">
			            <SPAN ><IMG src="/images/BacoError.gif" align=absMiddle></SPAN>
				</span>
				<span _name="s">
							<input type="checkbox"  id="ismulti" name="ismulti"  value="1">
				</span>
			</div>




		<script type="text/javascript">
		
			jQuery(window).ready(function(){
				<%
					if(!"".equals(flag)){
					out.println("alert('"+SystemEnv.getHtmlLabelName(30992,user.getLanguage())+"')");
					}
				%>
			});
			var temp_n=<%=temp%>;
			/*增加一行tr*/
			function doadd_gd(){
				var trhrml="<tr height=46px>";
				jQuery("#hiddenTrInDIV").find("span[_name='s']").each(function(i){
								var temp=jQuery(this).html();
								if(i==0){
									trhrml+="<td >";
								}else if(i==1){
									trhrml+="<td class=Field>";
								}else if(i==2){
									trhrml+="<td >";
								}else if(i==3){
										trhrml+="<td class=Field>";
								}else if(i==4){
									trhrml+="<td >";
								}else if(i==5){
									trhrml+="<td >";
								}else if(i==6){
										trhrml+="<td class=Field>";
								}else if(i==7){
									trhrml+="<td >";
								}
								trhrml+=temp;
								trhrml+="</td>";
				})
				trhrml+="</tr>";
				jQuery("#webTable2gd").append(trhrml);
				temp_n++;
				//控制新添加的行获得焦点
				var allelm = jQuery('#webTable2gd tr:gt(0)');
		        allelm.each( function(i){
		            		 jQuery(this).children("td:eq(1)").find("input").focus();
		         });
			}
			
			function dodel_gd(){
						var cheon=0;
						jQuery("#webTable2gd").find("input:checked[name='aa']").each(function(){
							if(jQuery(this).attr("checked")==true){
								cheon++;
							}
						});
						if(cheon<=0){
							alert("<%=SystemEnv.getHtmlLabelName(30993,user.getLanguage())%>!");
						}else{
							if(window.confirm("<%=SystemEnv.getHtmlLabelName(30695,user.getLanguage())%>?")){
										jQuery("#webTable2gd").find("input[type='checkbox'][name='aa']").each(function(){
										if(jQuery(this).attr("checked")==true){
											var t_value=jQuery(this).val();
											if(t_value){
												jQuery("#delete_n").val(jQuery("#delete_n").val()+t_value+",");
											}
											jQuery(this).parent().parent().remove();
											temp_n--;
										}
									});
							}
						}
			}
			function changeimg(obj){
				if(jQuery.trim(jQuery(obj).val())!==""){
					jQuery(obj).next().html("");
				}else{
				  jQuery(obj).next().html("<IMG src='/images/BacoError.gif' align=absMiddle>");
				}
			}
			function dosave_gd(){
					var l=jQuery("#webTable2gd img").length;
					var arr = new Array();
					jQuery("#webTable2gd").find("input[type='text'][name='affname']").each(function(jk){
								arr[jk]=$.trim($(this).val());
					});
					if(mm(arr)){
							alert("<%=SystemEnv.getHtmlLabelName(31413,user.getLanguage()) %>【"+mm(arr)+"】!");
							return;
					}		
					if(l>0){
							//必填信息不完整
							alert("<%=SystemEnv.getHtmlLabelName(30702,user.getLanguage())%>");
					}else{
							var ary =  new Array();
							jQuery("#webTable2gd").find("input[name='affixindexdesc']").each(function(jk){
										ary.push(jQuery(this).val());
							});
							var s = ","+ary.join(",")+",";
							 for(var i=0;i<ary.length;i++) {
							 			if(ary[i]!=""){
											if(s.replace(","+ary[i]+",",",").indexOf(","+ary[i]+",")>-1) {
												alert("<%=SystemEnv.getHtmlLabelName(31434,user.getLanguage())%>：" + ary[i]+" !");
												return;
											}
										}
							}
							jQuery("#temp_n").val(temp_n);
							jQuery("#webTable2gd").find("input[type='text'][name='affname']").each(function(jk){
									jQuery(this).attr("name","affname_"+jk);
									
							});
							jQuery("#webTable2gd").find("input[type='hidden'][name='countryid']").each(function(jk){
									jQuery("#countryid_count").attr("value",jQuery("#countryid_count").attr("value")+jQuery(this).val()+",");
									jQuery(this).attr("name","countryid_"+jk);
							});
							jQuery("#webTable2gd").find("input[name='affixindexdesc']").each(function(jk){
									jQuery(this).attr("name","affixindexdesc_"+jk);
							});
							jQuery("#webTable2gd").find("input[name='ismulti']").each(function(jk){
									jQuery(this).attr("name","ismulti_"+jk);
									
							});
							
						 	jQuery("#frmMain").submit();
					}
			}
			
			function checkAll(obj){
					var allelm = jQuery('#webTable2gd tr:gt(0)');
			        allelm.each( function(i){
			            		 jQuery(this).children("td:eq(0)").find("input").attr("checked",obj.checked);       
			         });
			}
			// 验证重复元素，有重复返回true；否则返回false
			function mm(ary){
			   		var nary = ary.sort();
					for(var i = 0; i < nary.length - 1; i++){
					    if (nary[i] == nary[i+1]){
					         return  nary[i];
					    }
					}
			}
			</script>
	</body>
</html>