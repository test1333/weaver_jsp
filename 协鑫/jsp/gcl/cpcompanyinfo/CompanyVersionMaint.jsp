<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	String licenseid = Util.null2String(request.getParameter("licenseid"));
	String constitutionid = Util.null2String(request.getParameter("constitutionid"));
	String shareid = Util.null2String(request.getParameter("shareid"));
	String directorsid =  Util.null2String(request.getParameter("directorsid"));
	String companyid =  Util.null2String(request.getParameter("companyid"));
	
	//String versionnum = "";
	
		//String sql = "";
		
			//if(oneMoudel.equals("license")){
				//if(!licenseid.equals("")){
				//	sql = "select count(versionid) as versionnum from CPBUSINESSLICENSEVERSION where licenseid="+licenseid;
				//}else {
				//	versionnum = "v1.0";
				//}
			//}
		
		
			//if(oneMoudel.equals("constitution")){
				//if(!constitutionid.equals("")){
					//sql = "select count(versionid) as versionnum from CPCONSTITUTIONVERSION where constitutionid = "+constitutionid;
				
				//}else {
					//versionnum = "v1.0";
				//}
			//}
			//System.out.println(oneMoudel);
			//if(oneMoudel.equals("share")){
				//if(!shareid.equals("")){
				//	sql = "select count(versionid) as versionnum from CPSHAREHOLDERVERSION where shareid = "+shareid;
				
				//}else {
				//	versionnum = "v1.0";
				//}
			//}
			
			//if(oneMoudel.equals("director")){
				//if(!directorsid.equals("")){
				//	sql = "select count(versionid) as versionnum from CPBOARDVERSION where directorsid = "+directorsid;
				
				//}else {
					//versionnum = "v1.0";
				//}
			//}
		
		//System.out.println(sql);
		//rs.execute(sql);
		
		//if(rs.next())versionnum="v"+(rs.getInt("versionnum")+1)+".0";
	
	
	String versionids = Util.null2String(request.getParameter("versionids"));
	String oneMoudel = Util.null2String(request.getParameter("oneMoudel"));
	String sql = "";
	String versionnum05 = "";
	String versionname05 = "";
	String date2Version05 = "";
	String versionTime05 = "";
	String versionmemo05 = "";
	String _versionid = "";
	boolean flag=true;
	if(!versionids.equals("")){
		_versionid = versionids.substring(0,versionids.lastIndexOf(','));
		if(oneMoudel.equals("license")){
			sql = "select * from CPBUSINESSLICENSEVERSION where versionid = "+_versionid;
		}
		if(oneMoudel.equals("constitution")){
			sql = "select * from CPCONSTITUTIONVERSION where versionid = "+_versionid;
		}
		if(oneMoudel.equals("share")){
			sql = "select * from CPSHAREHOLDERVERSION where versionid = "+_versionid;
		}
		if(oneMoudel.equals("director")){
			
			sql = "select * from CPBOARDVERSION where versionid = "+_versionid;
		}
		//System.out.println(sql);
		rs.execute(sql);
		//System.out.println("查出版本数据"+sql);
		if(rs.next()){
			flag=false;
			versionnum05 = rs.getString("versionnum");
			versionname05 = rs.getString("versionname");
			date2Version05 = rs.getString("createdatetime");
			versionTime05 = rs.getString("createdatetime");
			versionmemo05 = rs.getString("versionmemo");
		}
	}
%>
<link rel="stylesheet" type="text/css" href="/cpcompanyinfo/style/wbox.css" />
<script type="text/javascript">
	jQuery(document).ready(function(){
		
		
		if("<%=versionids%>" !=""){
			jQuery("#versionSaveBtn05").bind("click",function(){
					if(jQuery.trim(jQuery("#versionnum").val())=="" || jQuery.trim(jQuery("#versionname").val())=="" || jQuery("#versionTime").val()==""){
						alert("<%=SystemEnv.getHtmlLabelName(31122,user.getLanguage()) %>!");
					}else{
						
						//alert("编辑版本"+jQuery("#versionnum").val());
						editversionDate("<%=_versionid%>","<%=oneMoudel%>");
					
					}
			});
		}else{
			jQuery("#versionSaveBtn05").bind("click",function(){
				
				if(jQuery.trim(jQuery("#versionnum").val())=="" || jQuery.trim(jQuery("#versionname").val())=="" || jQuery("#versionTime").val()==""){
					alert("<%=SystemEnv.getHtmlLabelName(31122,user.getLanguage()) %>!");
				}else{
					//alert("创建版本");
					saveversionDate();
				}
			});
		}
	});
	
	
	/* function editversionDate(versionid,oneMoudel){
		o4params ={
		method:"editversion",
		versionid:versionid,
		versionnum:encodeURI(jQuery("#versionnum").val()),
		versionname:encodeURI(jQuery("#versionname").val()),
		versionmemo:encodeURI(jQuery("#versionmemo").val()),
		versionaffix:"",
		date2Version:encodeURI(jQuery("#versionTime").val()),
		oneMoudel:oneMoudel
		};
		//alert(jQuery("#versionname").val()+"提交数据"+jQuery("#versionnum").val());
		jQuery.post("/cpcompanyinfo/action/CPConstitutionOperate.jsp",o4params,function(){
			alert("操作已成功!");
			//编辑版本以后统一不让关闭
			//closeMaint4Win();		
		});
	} */
	
	function AjaxCheckVersionnum(obj){
		//defaultValue 
		if(obj.defaultValue!=obj.value&&obj.value!=""){
			var o4params = {
				oneMoudel:"<%=oneMoudel%>",
				licenseid:"<%=licenseid%>",
				companyid:"<%=companyid%>",
				objvalue:obj.value+""
			}
			jQuery("#ck_red").html("<%=SystemEnv.getHtmlLabelName(31123,user.getLanguage()) %>.........").css("color","red");
			jQuery("#versionSaveBtn05").hide();
			jQuery.post("/cpcompanyinfo/AjaxCheckVersionnum.jsp",o4params,function(data){
					if(data==1){
							jQuery(obj).attr("value","").focus();
							jQuery(obj).next().show();
							jQuery("#ck_red").html("<%=SystemEnv.getHtmlLabelName(31124,user.getLanguage()) %>").css("color","red");
					}else{
							jQuery("#ck_red").html("<%=SystemEnv.getHtmlLabelName(31125,user.getLanguage()) %>").css("color","blue");
							jQuery("#versionSaveBtn05").show();
					}
			});
		}else if(obj.defaultValue==obj.value&&obj.value!=""){
				jQuery("#ck_red").html("<%=SystemEnv.getHtmlLabelName(31125,user.getLanguage()) %>").css("color","blue");
		}else if(obj.value==""){
				jQuery("#ck_red").html("");
		}
	}	
</script>

<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0" class="MT5">
			<tr>
				<td width="70" height="25">
					<%=SystemEnv.getHtmlLabelName(22186,user.getLanguage()) %>：			</td>
				<td colspan="3">
						<input type=text   name="versionnum"   maxlength="8"  onblur="displayimg(this),AjaxCheckVersionnum(this)" id="versionnum" value="<%=versionnum05 %>" onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onblur="if(!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\.\d+$/))this.value=0+this.value;if(this.value.match(/^\.$/))this.value=0;this.o_value=this.value}">
						<%if(flag){%><img src="images/O_44.jpg" class="ML5" style="margin-bottom: -3px;" iswarn="warning"/><%	}else{
						%>
							<img src="images/O_44.jpg" class="ML5" style="display:none" iswarn="warning"/>
						<%
						}%>
						<span  id="ck_red">
						
						</span>
				</td>
			</tr>
			<tr>
				<td height="25">
					<%=SystemEnv.getHtmlLabelName(31126,user.getLanguage()) %>：
				</td>
				<td colspan="3">
					<input type="text" name="versionname" id="versionname" value= "<%=versionname05 %>"
						class="OInput2 BoxW208" onblur="displayimg(this)" />
							<%if(flag){%><img src="images/O_44.jpg" class="ML5" style="margin-bottom: -3px;" iswarn="warning"/><%	}else{
						%>
							<img src="images/O_44.jpg" class="ML5" style="display:none" iswarn="warning"/>
						<%
						}%>
				</td>
			</tr>
			<tr>
				<td height="25">
					<%=SystemEnv.getHtmlLabelName(31127,user.getLanguage()) %>：
				</td>
				<td colspan="3">
				
				<BUTTON  class="Clock"  type="button"    onclick="onShowDate(document.getElementById('date2Version'),document.getElementById('versionTime'))"></BUTTON>
					<input type="hidden" id="versionTime" name="versionTime"  value="<%=date2Version05%>"/>
					<span id="date2Version">
					<%if(flag){%><img src="images/O_44.jpg" class="ML5" style="margin-bottom: -3px;" iswarn="warning"/><%	}else{out.println(date2Version05);}%>
					</span>
					
				<!--
					<input type="text" name="date2Version" id="date2Version" value="<%= date2Version05%>"
						class="OInput2 BoxW120" onfocus="this.blur();" onpropertychange="displayimg(this)"/>
						<img src="images/O_44.jpg" class="ML5" style="margin-bottom: -3px;"  iswarn="warning"/>
						<input type="hidden" id="versionTime" value="<%=versionTime05 %>"/>
					<BUTTON class="Clock" style="margin-bottom: -5px;"  type="button"   onclick="gettheDate(versionTime,date2Version)"></BUTTON>
				  -->
				  
				</td>
			</tr>
			<tr>
				<td height="40">
					<%=SystemEnv.getHtmlLabelName(31128,user.getLanguage()) %>：
				</td>
				<td colspan="3">
					<textarea name="versionmemo"
						class="OInput2 BoxWAuto BoxHeight60" id="versionmemo"><%=versionmemo05 %></textarea>
				</td>
			</tr>
			<!-- <tr>
				<td height="25" vAlign="top">
					相关资料：
				</td>
				<td colspan="3" height="25" >
					<div  style="height:100px;width:250px;overflow-y:auto;">
		    		<div id="versionAffixUpload">
					<input type="hidden" name="versionaffix" id="versionaffix">
						<span> 
							<span id='spanButtonPlaceHolder'></span>
						</span>
						&nbsp;&nbsp;
						<span style="color: #262626; cursor: hand; TEXT-DECORATION: none"
							disabled id="btnCancel_upload">
							<span><img src="/js/swfupload/delete.gif" border="0" onClick="oUploader.cancelQueue()"> </span> <span
							style="height: 19px"> <font style="margin: 0 0 0 -1"><%//="--清除所有"%>
							</font>  </span> </span>
						<div id="divImgsAddContent" style="overflow: auto;">
							<div></div>
							<div class="fieldset flash" id="fsUploadProgress"></div>
							<div id="divStatus"></div>
						</div>
					</div>
						
					</div>
			  	</td>
			</tr> -->
			<tr>
				<td colspan="4" align="center" sytle="padding-right:10px;">  
					<button class="BtnLM " id="versionSaveBtn05" type="button"> <%=SystemEnv.getHtmlLabelName(86,user.getLanguage()) %> </button>
					<button class="BtnLM" onclick="onLicenseDivClose()" type="button"> <%=SystemEnv.getHtmlLabelName(31129,user.getLanguage()) %></button>
				</td>
			</tr>
	  </table>