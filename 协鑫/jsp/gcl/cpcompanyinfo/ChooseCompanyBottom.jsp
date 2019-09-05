<%@page import="weaver.cpcompanyinfo.CompanyKeyValue"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="infoMeth" class="weaver.cpcompanyinfo.CompanyInfoTransMethod" scope="page" />

<%
	
	int type = Util.getIntValue(Util.null2String(request.getParameter("type")),0);
	// 1--法人，2--董事会，3-即将到期证照，4-股东，5--年检证照
	int showvalue = Util.getIntValue( Util.null2String(request.getParameter("showvalue")),0);
	int companyid=Util.getIntValue( Util.null2String(request.getParameter("companyid")),0);
%>
<script type="text/javascript">

	/* 关闭 qtip */
	function closeMaint4Win()
	{
		jQuery("#a_click").qtip("hide");
		jQuery("#a_click").qtip("destroy")
	}
	
	
</script>
<!--表头浮动层 start-->
<!--表头浮动层 start-->
<input type="hidden" id="method" />
<input type="hidden" id="ishaved" value="true"/>
<div class="Absolute OHeaderLayer8 Bgfff BorderLMDIVHide">
	<div class="OHeaderLayerTit FL OHeaderLayerW3 ">
		<span id="spanTitle" class="cBlue FontYahei FS16 PL15 FL">
			<%
					if("1".equals(showvalue+"")){
						out.print(SystemEnv.getHtmlLabelName(31081,user.getLanguage()));
					}else if("2".equals(showvalue+"")){
						out.print(SystemEnv.getHtmlLabelName(31082,user.getLanguage()));
					}else	if("3".equals(showvalue+"")){
						out.print(SystemEnv.getHtmlLabelName(31079,user.getLanguage()));
					}else	if("4".equals(showvalue+"")){
						out.print(SystemEnv.getHtmlLabelName(31083,user.getLanguage()));
					}else	if("5".equals(showvalue+"")){
						out.print(SystemEnv.getHtmlLabelName(31080,user.getLanguage()));
					}
			 %>
				
		</span>
		<img src="images/O_40.jpg" class="FR MT10 MR10" style="cursor: hand;"
			onclick="javascript:closeMaint4Win();" />
	</div>
	<div class="FL"  style="padding: 5px">
		
		
		<div class="border17 FL OHeaderLayerW9 ">
			<ul class="ONav FL cBlue">
				<li>
					<a href="javascript:void(0)" class="hover">
						<div>
							<div>
								<%=SystemEnv.getHtmlLabelName(19918,user.getLanguage())%>
							</div>
						</div> </a>
				</li>
			</ul>
			<div class="clear"></div>
		</div>
		
			<table width="463" border="0" cellpadding="0" cellspacing="1"
				class="stripe OTable">
				<tr id="OTable2" class="cBlack">
					<td style="width:40px">
						<strong><%=SystemEnv.getHtmlLabelName(15486,user.getLanguage())%></strong>
					</td>
					<td width="30%" >
						<strong>
									<%
										if(1==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31081,user.getLanguage()));
										}else if(2==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31082,user.getLanguage()));
										}else if(3==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31079,user.getLanguage()));
										}else if(4==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31083,user.getLanguage()));
										}else if(5==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31080,user.getLanguage()));
										}
											
									 %>
						</strong>
					</td>
					<td width="30%" >
						<strong><%=SystemEnv.getHtmlLabelName(26113,user.getLanguage())%></strong>
					</td>
					<td>
						<strong>
									<% 
										if(1==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31796,user.getLanguage()));
										}else if(2==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31796,user.getLanguage()));
										}else if(3==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31029,user.getLanguage()));
										}else if(4==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31796,user.getLanguage()));
										}else if(5==showvalue){
												out.print(SystemEnv.getHtmlLabelName(31030,user.getLanguage()));
										}
						%>
						
						</strong>
					</td>
				</tr>
			</table>
			<div class="FR" style="height:24px;width:16px;background-color:#eeeeee; margin-top:-26px"></div>
			<div class="OContRightScroll FL OHeaderLayerW9 " style="height:300px">
			<table id="webTable2gd" width="462" border="0" cellpadding="0" cellspacing="1"
				class="stripe OTable">
					<%
						
							List list=infoMeth.getStaleValue(showvalue,type,companyid);
							if(null!=list){
							for(int i=0;i<list.size();i++){
								CompanyKeyValue ckvalue=(CompanyKeyValue)list.get(i);
					 %>
				 	<tr>
				 		<td style="width:40px">
								<%=(i+1) %>
						</td>
						<td width="30%" >
										<%=ckvalue.getDesc() %>
						</td>
						<td width="30%" >
									<%=ckvalue.getValue() %>
						</td>
						<td>
									<%=ckvalue.getDatetime()%>
						</td>
					</tr>
					<%
								}
						}
					 %>
	
			</table>
</div>


	</div>
</div>
<!--表头浮动层 end-->

<script type="text/javascript">
	function  onShowLocationID(){
		var tempid= window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/web/broswer/CityBrowser.jsp");
		if(tempid){
			if(tempid.id!=0){
					$("#companyregionSpan").html(tempid.name);
					$("#companyregion").val(tempid.id);
			}else{
					$("#companyregionSpan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
					$("#companyregion").val("");
			}
		}else{
			$("#companyregionSpan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
			$("#companyregion").val("");
		}
		
		
	}
</script>