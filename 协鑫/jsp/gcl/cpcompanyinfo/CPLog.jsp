<%@ page import="weaver.company.CompanyUtil" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CompanyPermissionService" class="weaver.cpcompanyinfo.CompanyPermissionService" scope="page"/>
<jsp:include page="/cpcompanyinfo/CompanyInfoContainer.jsp" />
<%

    String from=Util.null2String(request.getParameter("from"));//项目类型id
    boolean showAll="companyinfolist".equals(from);

%>


<html>
	<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

    <%

            RCMenu += "{"+"查询"+",javascript:search(),_self} " ;
            RCMenuHeight += RCMenuHeightStep ;
            RCMenu += "{"+"导出"+",javascript:_xtable_getAllExcel(),_self} " ;
            RCMenuHeight += RCMenuHeightStep ;

        if(!showAll){
            RCMenu += "{"+"返回"+",javascript:back(),_self} " ;
            RCMenuHeight += RCMenuHeightStep ;
        }


    %>

	<%@ include file="/systeminfo/RightClickMenu.jsp" %>
	<body>
				<%
        		String pt_id=Util.null2String(request.getParameter("pt_id"));//项目类型id
        		String plog_qf=Util.null2String(request.getParameter("plog_qf"));//日志类型
        		String plog_desc=Util.null2String(request.getParameter("plog_desc"));//操作描述
        		String plog_coding=Util.null2String(request.getParameter("plog_coding"));//编号
        		//公司id
        		String companyid=Util.null2String(request.getParameter("companyid"));
        		String glgs_=Util.null2String(request.getParameter("glgs_"));
        		String gsmc_=Util.null2String(request.getParameter("gsmc_"));
        		String czr_=Util.null2String(request.getParameter("czr_"));
        		String fromdate2=Util.null2String(request.getParameter("fromdate2"));
				String todate2=Util.null2String(request.getParameter("todate2"));
        		
        		int language=user.getLanguage();
				String refComlog = "column:language";				
					
        		String tableString="";	
				String pagesize="10";
				String backfields=" tt1.plog_before,tt1.plog_after,tt1.plog_id,tt1.plog_coding,tt1.plog_proname,tt1.plog_desc,tt1.plog_data,tt1.plog_person,"+language+" as language,tt1.plog_time,t1.companyname,t3.name ";
				String fromSql=" from  pro_taskLog tt1, CPCOMPANYINFO t1,COMPANYBUSINESSSERVICE t3 ";
				String sqlorderby="tt1.plog_data,tt1.plog_time";
				String sqlsortway="desc";
				String sqlwhere=" tt1.PLOG_PROTASKID=t1.COMPANYID and t1.BUSINESSTYPE=t3.id and tt1.plog_qf = '3' ";//1，2状态的内容表示是项目管理的日志内容，其他表示其他模块的日志内容
				
				if(!"".equals(companyid)){
					sqlwhere+=" and tt1.plog_protaskid='"+companyid+"'";
				}
				
				if(!"".equals(fromdate2)){
					sqlwhere+=" and tt1.plog_data >='"+fromdate2+"' ";
				}
				if(!"".equals(todate2)){
					sqlwhere+=" and tt1.plog_data <='"+todate2+"' ";
				}
		
				if(!"".equals(plog_qf))
				{
					sqlwhere+=" and tt1.plog_qf='"+plog_qf+"'";
				}
				if(!"".equals(plog_desc))
				{
					sqlwhere+=" and tt1.plog_desc='"+plog_desc+"'";
				}
				if(!"".equals(czr_))
				{
					sqlwhere+=" and tt1.PLOG_PERSON='"+czr_+"' ";
				}
				if(!"".equals(glgs_))
				{
					sqlwhere+=" and t3.name like '%"+glgs_+"%' ";
				}
				if(!"".equals(gsmc_))
				{
					sqlwhere+=" and t1.companyname like '%"+gsmc_+"%' ";
				}

				if(!"".equals(plog_coding))
				{
					sqlwhere+=" and tt1.plog_coding like '%"+plog_coding+"%'";
				}
                    String userManager="";
                    CompanyUtil cu=new CompanyUtil();
                    if(!cu.canOperate(user,"2")) {
                        //得到当前用户管辖那几个公司
                        userManager = cu.canOperateCOM(user, "2");
                    }
                    if("".equals(userManager)){
                        //防止报错，如果传个空字符串进去会报错
                        userManager="NONE";
                    }
                    if(!"1".equals(""+user.getUID())){
                            sqlwhere += " and t1.businesstype  not in( select id from CompanyBusinessService where affixindex=-1) and ( t1.businesstype in("+CompanyPermissionService.getCanviewGlgsIds(user)+") or ( t1.companyid in ("+("NONE".equals(userManager)?"-1":userManager)+") and t1.BUSINESSTYPE not in ("+CompanyPermissionService.getCanviewGlgsIds(user)+") ) ) ";	//过滤掉自然人
                    }else{
                            sqlwhere += " and t1.businesstype  not in( select id from CompanyBusinessService where affixindex=-1) ";
                    }

//out.print(sqlwhere);
				
				tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"none\" pagesize=\""+pagesize+"\" width=\"100%\" isfixed=\"true\" isnew= \"true\"   > "+
			    "<checkboxpopedom  popedompara=\"column:plog_id\"  showmethod=\"weaver.promanage.ProTransMethod.getIsShowBox\"/>"+
			    "<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlwhere)+"\"  sqlorderby=\""+sqlorderby+"\"  sqlprimarykey=\"plog_id\" sqlsortway=\""+sqlsortway+"\" sqlisdistinct=\"true\" orderbynumberkey=\"3\"/>"+
			    "<head>";
                    tableString+="	<col   text=\""+"操作类型" +"\"    column=\"plog_desc\"  orderkey=\"plog_desc\"   otherpara='"+refComlog+"'   transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getPlog_desc\"  />";
                    tableString+="	<col   text=\""+SystemEnv.getHtmlLabelName(31131,user.getLanguage()) +"\"   column=\"plog_data\"     orderkey=\"plog_data\" />";
                    tableString+="	<col   text=\""+SystemEnv.getHtmlLabelName(25130,user.getLanguage()) +"\"   column=\"plog_time\"      />";
                    tableString+="	<col   text=\""+SystemEnv.getHtmlLabelName(17482,user.getLanguage()) +"\"   column=\"plog_person\"       transmethod=\"weaver.cpcompanyinfo.ProTransMethod.getPlog_person\" />";
                    tableString+="	<col   text=\""+"管理归属" +"\"   column=\"name\"          />";
                    tableString+="	<col   text=\""+"公司名称" +"\"   column=\"companyname\"          />";
                    tableString+="	<col   text=\""+"业务名称" +"\" width=\"60\"  column=\"plog_proname\"       transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getYwmc\"	 	 />";
                    tableString+="	<col   text=\""+"变更前" +"\" width=\"300\"  column=\"plog_before\"       	 />";
                    tableString+="	<col   text=\""+"变更后" +"\" width=\"300\"  column=\"plog_after\"      	 	 />";

		        tableString+=" </head> </table>";     
        
				%>
				<div class="OBoxW">
				<div class="OBoxW PTop5">





				<div class="OBoxTit">
				<span class="FontYahei cWhite PL20 PTop5 FL"></span>




				<span class="FL  PLeft5" style="color: white;display:none;">

							
						
					
					
						
										
						<input type="hidden" value="<%=pt_id%>" name="pt_id">
						<input type="hidden" value="<%=plog_qf%>" name="plog_qf">
						<input type="hidden" value="<%=plog_desc%>" name="plog_desc">
						<input type="hidden" value="<%=companyid%>" name="companyid">
						
				</span>
				</div>


				</div>
                </div>

                <form name="weoa"  id="weoa"  method="post" action="/cpcompanyinfo/CPLog.jsp">
                    <input type="hidden" name="from" value="<%=from %>"/>


                    <table class=Viewform id="searchTable" >
                        <tbody>
                        <COLGROUP>
                            <COL width="15%">
                            <COL width="35%">
                            <COL width="15%">
                            <COL width="35%">

                            <TR class=Title>
                                <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
                            </TR>
                            <TR class=Spacing style="height:1px;"> <TD class=Line1 colSpan=4 ></TD> </TR>
                            <tr>
                                <td>开始日期</td>
                                <td class=Field>
                                    <button type=button  class=Calendar id=selectstartdate onClick="onShowDate_2('fromdate2span','fromdate2')"></button>
                                    <input type="hidden"  name="fromdate2" size=30 value="<%=fromdate2 %>" />
                                    <span id="fromdate2span"><%=fromdate2 %></span>
                                </td>
                                <td>结束日期</td>
                                <td class=Field>
                                    <button type=button  class=Calendar id=selectenddate onClick="onShowDate_2('todate2span','todate2')"></button>
                                    <input type="hidden"  name="todate2" size=30 value="<%=todate2 %>" />
                                    <span id="todate2span"><%=todate2 %></span>
                                </td>
                            </tr>
                            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

                            <tr>
                                <td>管理归属</td>
                                <td class=Field>
                                    <input class=InputStyle maxlength=60 size=30 name="glgs_" value="<%=glgs_ %>">
                                </td>
                                <td>操作类型</td>
                                <td class=Field>
                                    <select name="plog_desc" style="height: 20px;line-height: 17px">
                                        <option value="" <%if("".equals(plog_desc)){out.println("selected");}%>>--</option>
                                        <option value="1" <%if("1".equals(plog_desc)){out.println("selected");}%>><%=SystemEnv.getHtmlLabelName(125,user.getLanguage()) %></option>
                                        <option value="2" <%if("2".equals(plog_desc)){out.println("selected");}%>><%=SystemEnv.getHtmlLabelName(103,user.getLanguage()) %></option>
                                        <option value="4" <%if("4".equals(plog_desc)){out.println("selected");}%>><%=SystemEnv.getHtmlLabelName(367,user.getLanguage()) %></option>
                                    </select>
                                </td>
                            </tr>
                            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

                            <tr>
                                <td>公司名称</td>
                                <td class=Field>
                                    <input class=InputStyle maxlength=60 size=30 name="gsmc_" value="<%=gsmc_ %>">
                                </td>
                                <td>操作人</td>
                                <td class=Field>
                                    <button type=button  class=Browser onClick="onShowResource()"></button>
                                    <input type=hidden name=czr_ value="<%=czr_%>"><span id=czr_span><%=ResourceComInfo.getResourcename (czr_) %></span>
                                </td>
                            </tr>
                            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

                    </table>
                </form>
                <wea:SplitPageTag   tableString="<%=tableString%>"  mode="run"  isShowBottomInfo="true"/>



    <script>
        function back(){
            window.location.href='/cpcompanyinfo/CompanyInfoSurvey.jsp';
        }
        function search(){
            document.getElementById('weoa').submit();
        }

        function onShowResource() {
            var id = window.showModalDialog(
                    "/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp",
                    "", "dialogWidth:550px;dialogHeight:550px;");
            if (id != null) {
                if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
                    $GetEle("czr_span").innerHTML = "<A href='/hrm/resource/HrmResource.jsp?id="
                            + wuiUtil.getJsonValueByIndex(id, 0)
                            + "'>"
                            + wuiUtil.getJsonValueByIndex(id, 1) + "</A>";
                    $GetEle("czr_").value = wuiUtil.getJsonValueByIndex(id, 0);
                } else {
                    $GetEle("czr_span").innerHTML = "";
                    $GetEle("czr_").value = "";
                }
            }
        }
    </script>
	</body>

</html>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>