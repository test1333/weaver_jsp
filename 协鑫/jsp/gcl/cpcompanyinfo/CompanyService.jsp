<%@page import="weaver.cpcompanyinfo.CompanyInfoTransMethod"%>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page" />
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
String titlename = ""+SystemEnv.getHtmlLabelName(125906,user.getLanguage());
String needfav ="1";
String needhelp ="";
int temp=0;
String flag=Util.null2String(request.getParameter("flag"));
String n_01="4px";
String n_02="0px";
String n_03="430px";
String  isie=Util.null2String(session.getAttribute("browser_isie")+"");
if(!"true".equals(isie)){
		n_01="0px";
		n_02="10px";
		n_03="400px";
}
%>
<BODY>
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
		<table style="width:98%;height:92%;border-collapse:collapse" align="center"  >
	<tr>
	<td valign="top" >
		<TABLE class=Shadow>
		<tr>
		<td valign="top"  >

					<input type="hidden" name=delete_n   id="delete_n" >	
					<input type="hidden" name=temp_n   id="temp_n" value="<%=temp%>">
					<input type="hidden" name=countryid_count   id="countryid_count"  >
					<input type="hidden" name=temp_type   id="temp_type" value="CompanyBusinessService">
								
								
								<table class="liststyle" cellspacing="1"  style="table-layout: fixed;background-color: white;margin-left: <%=n_02 %>" >
								<colgroup>
											<col width="31px">
											<col width="250px">
											<col width="250px">
											<col width="250px">
											<col width="250px">
											<col width="*">
								</colgroup>
								<tr class="header">
								<th ><input type="checkbox"   onclick="checkAll(this)"></th>
								<th><%=SystemEnv.getHtmlLabelName(15486,user.getLanguage())%></th>
								<th><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></th>
								<th><%=SystemEnv.getHtmlLabelName(433,user.getLanguage())%></th>
								<th>编辑授权</th>
								<th>查看授权</th>
								</tr>
								<tr>
										<td colspan="6"  style="padding:0px">
													<div style="overflow-y: auto;overflow-x:none ;height:<%=n_03 %>"  id=valign_div>
																	<table class="liststyle" cellspacing="1"  id="webTable2gd"   style="table-layout: fixed;margin: 0px">
																		<colgroup>
																				<col width="30px">
																				<col width="250px">
																				<col width="250px">
																				<col width="250px">
																				<col width="250px">
																				<col width="*">
																		</colgroup>
																			<%
																        		String sql="select CompanyBusinessService.*,(select count(*) from CompanyBusinessService ) s from CompanyBusinessService  order by affixindex";
																	      			rs.execute(sql);
																	      			while(rs.next()){
																	      					temp=Util.getIntValue(rs.getString("s"),0);
																	      					String name=rs.getString("name");
																	      					String id=rs.getString("id");
																	      					String affixindex=rs.getString("affixindex");
																	      					String affdesc=rs.getString("affdesc");
																	      					String bjsqid_=rs.getString("bjsqid_");
																	      					String bjsqtype_=rs.getString("bjsqtype_");
                                                                                        String selectnames="";
                                                                                        if(!"".equals(bjsqid_)){
                                                                                            if(Util.getIntValue(bjsqtype_) ==1){
                                                                                                String[] arr= Util.TokenizerString2(bjsqid_, ",");
                                                                                                for (String s : arr) {
                                                                                                    selectnames+=ResourceComInfo.getResourcename(s)+" ";
                                                                                                }
                                                                                            }else if(Util.getIntValue(bjsqtype_)==2){
                                                                                                selectnames+=RolesComInfo.getRolesRemark(bjsqid_)+" ";
                                                                                            }
                                                                                            if(Util.getIntValue(bjsqtype_) ==1){
                                                                                                selectnames+="(人力资源类型)";
                                                                                            }else if(Util.getIntValue(bjsqtype_) ==2){
                                                                                                selectnames+="(角色类型)";
                                                                                            }
                                                                                        }
																	      					String cksqid_=rs.getString("cksqid_");
																	      					String cksqtype_=rs.getString("cksqtype_");
                                                                                        String selectnames2="";
                                                                                        if(!"".equals(cksqid_)){
                                                                                            if(Util.getIntValue(cksqtype_) ==1){
                                                                                                String[] arr= Util.TokenizerString2(cksqid_, ",");
                                                                                                for (String s : arr) {
                                                                                                    selectnames2+=ResourceComInfo.getResourcename(s)+" ";
                                                                                                }
                                                                                            }else if(Util.getIntValue(cksqtype_)==2){
                                                                                                selectnames2+=RolesComInfo.getRolesRemark(cksqid_)+" ";
                                                                                            }
                                                                                            if(Util.getIntValue(cksqtype_) ==1){
                                                                                                selectnames2+="(人力资源类型)";
                                                                                            }else if(Util.getIntValue(cksqtype_) ==2){
                                                                                                selectnames2+="(角色类型)";
                                                                                            }
                                                                                        }
																	      	%>
																	      		 <tr>
																			 	<td style="padding:5px "> 
																					<%
																		 			if(!CompanyInfoTransMethod.CheckSION("2",id)&&!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
																		 			%>
																			 			<input type="checkbox"  value='<%=id%>'>
																				 	<%			
																				 			}
																				 	 %>
																				</td> 
																				<td style="padding:5px "> 
																				<%
																					if(!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
																				 %>
																						<input class=inputstyle type=text  style="80px"  name=affixindexdesc   value='<%=affixindex%>' maxlength="5"  onblur="changeimg(this)"   onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value">
																            			<SPAN ></SPAN>
														            			<%
														            				}else{
														            						out.println("-1");
														            				}
														            			 %>
																				</td> 
																				<td style="padding:5px "> 
																					<%
																						if(!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
																					 %>
																						<input class=inputstyle type=hidden  size=50  name=countryid     value="<%=id%>">
																						<input class=inputstyle type=text  style="80px"   name=affname   maxlength="10"  onblur="changeimg(this)" value="<%=name%>">
																			            <SPAN> </SPAN>
																			          <%
																            				}else{
																            						out.println(name);
																            				}
														            			 	%>
																				</td> 
																				<td style="padding:5px "> 
																					<%
																						if(!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
																					 %>
																						<input class=inputstyle type=text  style="80px"  name=affdesc   maxlength="20"   value='<%=affdesc%>'   >
																						<%
																            				}else{
																            						out.println(affdesc);
																            				}
														            			 	%>
																				</td>

                                                                                 <td style="padding:5px ">
                                                                                     <%
                                                                                         if(!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
                                                                                     %>
                                                                                     <button type="button" class="Browser" onclick="glgsrightadd(2,this)"></button>
                                                                                     <input type="hidden" name="bjsq" value="<%=bjsqid_ %>" />
                                                                                     <input type="hidden" name="bjsqtype" value="<%=bjsqtype_ %>" />
                                                                                     <span bjsqspan><%=selectnames %></span>
                                                                                     <%}%>

                                                                                 </td>

                                                                                 <td style="padding:5px ">
                                                                                     <%
                                                                                         if(!"-1".equals(affixindex)&&!"-1.0".equals(affixindex)){
                                                                                     %>
                                                                                     <button type="button" class="Browser" onclick="glgsrightadd(1,this)"></button>
                                                                                     <input type="hidden" name="cksq" value="<%=cksqid_ %>" />
                                                                                     <input type="hidden"  name="cksqtype" value="<%=cksqtype_ %>" />
                                                                                     <span cksqspan><%=selectnames2 %></span>
                                                                                     <%}%>
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
 </form>
			
		<div id="hiddenTrInDIV" style="display:none">	
				<span _name="s">
						<input type="checkbox" >
				</span>
				<span _name="s">
						<input class=inputstyle type=text  style="80px"  name=affixindexdesc   maxlength="5"  onblur="changeimg(this)"   onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value">
						<SPAN ><IMG src="/images/BacoError.gif" align=absMiddle></SPAN>
				</span>
				<span _name="s">
						<input class=inputstyle type=hidden  size=50  name=countryid  >
						<input class=inputstyle type=text style="80px"  name=affname   _id=""  maxlength="10"  onblur="changeimg(this)">
			            <SPAN ><IMG src="/images/BacoError.gif" align=absMiddle></SPAN>
				</span>
				<span _name="s">
						<input class=inputstyle type=text  style="80px"  name=affdesc   maxlength="20"   >
				</span>
                <span _name="s">
                    <button type="button" class="Browser" onclick="glgsrightadd(2,this)"></button>
                    <input type="hidden" name="bjsq" value="" />
                    <input type="hidden"  name="bjsqtype" value="" />
                    <span bjsqspan></span>

                </span>
                <span _name="s">
                    <button type="button" class="Browser" onclick="glgsrightadd(1,this)"></button>
                    <input type="hidden" name="cksq" value="" />
                    <input type="hidden"  name="cksqtype" value="" />
                    <span cksqspan></span>

                </span>
			</div>
		<script type="text/javascript">
		
			jQuery(document).ready(function(){
				<%
					if(!"".equals(flag)){
					out.println("alert('"+SystemEnv.getHtmlLabelName(30992,user.getLanguage()) +"')");
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
									trhrml+="<td class=Field>";
								}
								else if(i==3){
									trhrml+="<td class=Field>";
								}else if(i==4){
                                    trhrml+="<td class=Field>";
                                }else if(i==5){
                                    trhrml+="<td class=Field>";
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
						jQuery("#webTable2gd").find("input[type='checkbox']").each(function(){
							if(jQuery(this).attr("checked")==true){
								cheon++;
							}
						});
						if(cheon<=0){
							alert("<%=SystemEnv.getHtmlLabelName(30993,user.getLanguage()) %>!");
						}else{
							if(window.confirm("<%=SystemEnv.getHtmlLabelName(30695,user.getLanguage()) %>?")){
										jQuery("#webTable2gd").find("input[type='checkbox']").each(function(){
										if(jQuery(this).attr("checked")==true){
											var t_value=jQuery(this).val();
											if(t_value){
												jQuery("#delete_n").val(jQuery("#delete_n").val()+t_value+",");
											}
											//jQuery(this).parent().parent().next().remove();
											jQuery(this).parent().parent().remove();
											temp_n--;
										}
									});
							}
						}
			}
			function changeimg(obj){
				if(jQuery(obj).val()!==""){
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
							alert("<%=SystemEnv.getHtmlLabelName(31339,user.getLanguage()) %>【"+mm(arr)+"】!");
							return;
					}		
					
					if(l>0){
							alert("<%=SystemEnv.getHtmlLabelName(30702,user.getLanguage()) %>");
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
							
							jQuery("#webTable2gd").find("input[type='hidden'][name='countryid']").each(function(jk){
									jQuery("#countryid_count").attr("value",jQuery("#countryid_count").attr("value")+jQuery(this).val()+",");
									jQuery(this).attr("name","countryid_"+jk);
							});
							
							jQuery("#webTable2gd").find("input[type='text'][name='affname']").each(function(jk){
									jQuery(this).attr("name","affname_"+jk);
									
							});
							jQuery("#webTable2gd").find("input[type='text'][name='affixindexdesc']").each(function(jk){
									jQuery(this).attr("name","affixindexdesc_"+jk);
									
							});
							
							jQuery("#webTable2gd").find("input[type='text'][name='affdesc']").each(function(jk){
									jQuery(this).attr("name","affdesc_"+jk);
									
							});
							jQuery("#webTable2gd").find("input[type='hidden'][name='bjsq']").each(function(jk){
									jQuery(this).attr("name","bjsq_"+jk);

							});
							jQuery("#webTable2gd").find("input[type='hidden'][name='bjsqtype']").each(function(jk){
									jQuery(this).attr("name","bjsqtype_"+jk);

							});
							jQuery("#webTable2gd").find("input[type='hidden'][name='cksq']").each(function(jk){
									jQuery(this).attr("name","cksq_"+jk);

							});
							jQuery("#webTable2gd").find("input[type='hidden'][name='cksqtype']").each(function(jk){
									jQuery(this).attr("name","cksqtype_"+jk);

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
<script>
    function glgsrightadd(opertype,obj) {
        var xposition = 0;
        var yposition = 0;
        if ((parseInt(navigator.appVersion) >= 4 )) {
            xposition = (screen.width - 500) / 2;
            yposition = (screen.height - 400) / 2;
        }
        var selinput=jQuery(obj).next();
        var seltype=jQuery(obj).next().next();
        var selspan=jQuery(obj).next().next().next();
        var data = window.showModalDialog("/cpcompanyinfo/newpage/glgsrightadd.jsp?selecttype="+seltype.val()+"&selectids="+selinput.val()+"&opertype=" + opertype + "", window, "dialogWidth:450px; dialogHeight:250px; dialogLeft:" + xposition + "px; dialogTop:" + yposition + "px; status:no;scroll:no;resizable=no;");
        if (data) {
            var sqid=data.sqid;
            var sqname=data.sqname;
            var sqtype=data.sqtype;
            if(sqtype=="1"&&data.sqid){
                sqname+="(人力资源类型)"
            }else if(sqtype=="2"&&data.sqid){
                sqname+="(角色类型)"
            }else{
                sqname="";
            }
            selinput.val(""+sqid);
            seltype.val(""+sqtype);
            selspan.html(""+sqname);


        }
    }
</script>
	</body>
</html>