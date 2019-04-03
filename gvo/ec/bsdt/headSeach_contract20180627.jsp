<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="HT.HTSrvAPI" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.login.Account" %>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<%String messagerurl = "";
String lastname = "";
User user = (User) request.getSession(true).getAttribute("weaver_user@bean");
boolean ifGuest = true;
int userId = 0;
if(user!=null){
	userId = user.getUID(); 
	if(userId!=228989){
		ifGuest = false;
	}
}
if(ifGuest){
	//response.sendRedirect("/bsdt/login.jsp");
}

	//包含次账号
	String accountall_son=""+userId;
	String sql_allaccount_son=" select id from hrmresource where status<5 and belongto="+userId+" ";
	rs.executeSql(sql_allaccount_son);
	while(rs.next()){
		accountall_son=accountall_son+","+rs.getString("id");
	}
%>
<SCRIPT src="/bsdt/js/bootstrap.js"></SCRIPT>    
    <header class="header navbar navbar-default bg-white">
            
      <div class="navbar-header nav-bar aside">
        <a class="btn btn-link visible-xs" data-toggle="class:show" data-target=".nav-primary">
          <i class="icon-comment-alt"></i>
        </a>
		<a class="nav-brand"><img src="images/logo-hn1.png"></a>
        <a class="btn btn-link visible-xs" data-toggle="collapse" data-target=".navbar-collapse"><i class="icon-reorder"></i></a>
      </div>
      
      <div class="collapse navbar-collapse">
        <ul class="nav navbar-nav">

          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown">
              <i class="icon-user"></i>
              <span>一键申请</span> <b class="caret"></b>
            </a>
            <ul class="dropdown-menu"><li>
			<div class="line"></div></li>  
                <li class="dropdown-submenu">
					<a><span>员工报销</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=886&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">员工费用报销流程</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=642&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">差旅费报销流程（有事前申请）</a>
						</li>
				                 <li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=501&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">差旅费报销流程（无事前申请）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=55&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">业务招待费报销流程（无事前申请）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=206&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">培训费事前申请</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=207&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">培训费报销流程（有事前申请）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=367&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">公共费用分摊报销流程</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=164&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">工资计提申请流程</a>
						</li>
					</ul>
				</li>
				<li><div class="line"></div></li>  
                <li class="dropdown-submenu">
					<a><span>借支管理</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=44&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">借款流程</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=45&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">还款申请</a>
						</li>	
					</ul>
				</li>
                <li><div class="line"></div></li>
                  
                <li class="dropdown-submenu">
					<a><span>预算调剂</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=461&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">预算追加申请（费用类）</a>
						</li>

						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=343&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">预算变更申请（费用类）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=621&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">预算追加申请流程（设备类资产）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=263&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">预算追加申请流程（非设备类资产）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=601&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">预算调剂申请流程（设备类资产）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=622&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">预算调剂申请流程（非设备类资产）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=801&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">跨年预算申请流程</a>
						</li>
					</ul>
				</li>   
				
                <li><div class="line"></div></li>
				<li class="dropdown-submenu">
					<a><span>项目立项</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=238&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">立项申请审批流程</a>
						</li>
			                        <li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=741&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">立项申请审批流程（专项费用）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=239&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">立项变更申请流程</a>
						</li>	
					</ul>
				</li>
                <li><div class="line"></div></li>
				
                <li class="dropdown-submenu">
				<a><span>立项类合同</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=205&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同申请流程（黑牛）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=222&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同变更流程（黑牛）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=231&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同解除/终止流程（黑牛）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=422&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同付款申请流程（黑牛）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=224&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同申请流程（云谷）</a>
						</li>

						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=226&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同变更流程（云谷）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=233&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同解除/终止流程（云谷）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=261&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同付款申请流程（云谷）</a>
						</li>
					</ul>
				</li>
				<li><div class="line"></div></li>
                <li class="dropdown-submenu">
				<a><span>非立项类合同</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=228&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同申请流程（黑牛）</a>
						</li>

						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=230&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同变更流程（黑牛）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=264&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同解除/终止流程（黑牛）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=312&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同付款申请流程（黑牛）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=306&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同申请流程（云谷）</a>
						</li>

						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=308&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同变更流程（云谷）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=265&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同解除/终止流程（云谷）</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=275&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同付款申请流程（云谷）</a>
						</li>
					</ul>
				</li>
				<li><div class="line"></div></li>
				<li class="dropdown-submenu">
					<a><span>供应商报销付款</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=71&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">对公报销支付流程</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=341&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">对公预付款流程</a>
						</li>
		                                <li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=701&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">对公支付申请流程（其他类）</a>
						</li>
												<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=275&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同付款申请流程（云谷非立项类）</a>
						</li>
												<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=261&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同付款申请流程（云谷立项类）</a>
						</li>
												<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=312&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同付款申请流程（黑牛非立项类）</a>
						</li>
												<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=422&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">合同付款申请流程（黑牛立项类）</a>
						</li>
					</ul>
				</li>
                <li><div class="line"></div></li>
				<li class="dropdown-submenu">
					<a><span>EC_SAP集成</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=143&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">采购订单审批流程-S</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=144&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">采购订单修改审批流程-S</a>
						</li>
						<li>
							<a href="/workflow/request/AddRequest.jsp?workflowid=121&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">领退料/调拨申请单-S</a>
						</li>						
					</ul>
				</li>
                <li><div class="line"></div></li>
            </ul>
          </li>

           <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown">
              <i class="icon-pencil"></i>
              <span>一键审批</span> <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
              <li><a href="/workflow/request/RequestView.jsp?e71483059591116=" target="_blank">待办报账</a></li>
                <li><div class="line"></div></li>
              <li><a href="/workflow/request/RequestHandled.jsp?e71483059632019=" target="_blank">已办报账</a></li>
                <li><div class="line"></div></li>
              <li><a href="/workflow/search/RequestSupervise.jsp?e71483059660590=" target="_blank">报账督办</a></li>
                <li><div class="line"></div></li>
              <li><a href="/system/systemmonitor/workflow/WorkflowMonitor.jsp?fromleftmenu=1&e71483059684466=" target="_blank">报账监控</a></li>
                <li><div class="line"></div></li>
              <li><a href="/workflow/request/MyRequestView.jsp?e71483059743499=" target="_blank">我的报账</a></li>
                <li><div class="line"></div></li>
              <li><a href="/workflow/request/wfAgentStatistic.jsp?e71483059764086=" target="_blank">报账代理</a></li>
                <li><div class="line"></div></li>
              <li><a href="/workflow/search/WFSearch.jsp?fromleftmenu=1&e71483059784929=" target="_blank">报账查询</a></li>
                <li><div class="line"></div></li>
              <li><a href="/workflow/search/CustomSearch.jsp?e71483059797851=" target="_blank">自定义查询</a></li>
                <li><div class="line"></div></li>
              <li><a href="/workflow/request/WorkflowMultiPrintTree.jsp?fromleftmenu=1&e71483059810309=" target="_blank">批量打印</a></li>
                <li><div class="line"></div></li>
				
              <!--<li class="dropdown-submenu">
                <a><span>一级</span> <b class="caret"></b>
				</a>
				<ul class="dropdown-menu">
					<li>
						<a href="#">二级</a>              
					</li>
					<li class="dropdown-submenu">
						<a><span>二级1</span><b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
								<a href="http://www.baidu.com" target="_blank">三级</a>
								</li>
							</ul>
					</li>
				</ul>
              </li>-->
            </ul>
          </li>
<li class="dropdown">
            <a href="/workflow/request/RequestType.jsp" class="dropdown-toggle">
              <i class="icon-folder-close-alt"></i>
              <span>流程门户</span>  
            </a>
      	</li>
           <!--<li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown">
              <i class="icon-folder-close-alt"></i>
              <span>一键分析</span> <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
              <li class="dropdown-submenu">
				<a><span>效率分析</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li>
							<a href="/workflow/flowReport/FlowTypeStat.jsp" target="_blank">报账类型统计</a>
						</li>
						<li>
							<a href="/workflow/flowReport/PendingRequestStat.jsp" target="_blank">待办报账统计</a>
						</li>
						<li>
							<a href="/workflow/flowReport/FlowTimeAnalyse.jsp" target="_blank">报账时间分析</a>
						</li>
						<li>
							<a href="/workflow/flowReport/HandleRequestAnalyse.jsp" target="_blank">报账办理分析</a>
						</li>
						<li>
							<a href="/workflow/flowReport/SpendTimeStat.jsp" target="_blank">报账耗时统计</a>
						</li>
						<li>
							<a href="/workflow/flowReport/DocWfReport.jsp" target="_blank">报账情况统计</a>
						</li>
						<li class="dropdown-submenu">
							<a><span>报账效率排名</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
								<ul class="dropdown-menu">
									<li>
										<a href="/workflow/flowReport/MostPendingRequest.jsp" target="_blank">待办数量排名</a>
									</li>
									<li>
										<a href="/workflow/flowReport/MostSpendTime.jsp" target="_blank">耗时最长排名</a>
									</li>
									<li>
										<a href="/workflow/flowReport/NodeOperatorfficiency.jsp" target="_blank">操作效率排名</a>
									</li>
									<li>
										<a href="/workflow/flowReport/MostExceedFlow.jsp" target="_blank">超期流程排名</a>
									</li>
									<li>
										<a href="/workflow/flowReport/MostExceedPerson.jsp" target="_blank">超期人员排名</a>
									</li>
								</ul>
							</a>
						</li>
						<li>
							<a href="/workflow/report/CustomReportView.jsp" target="_blank">自定义报表</a>
						</li>				
					</ul>
			  </li>
                <li><div class="line"></div></li>            
              <li class="dropdown-submenu">
				<a><span>效益分析</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li>
							<a href="/fna/report/costSummary/costSummary.jsp" target="_blank">费用汇总</a>
						</li>
						<li>
							<a href="/fna/report/budgetDetailed/budgetDetailed.jsp" target="_blank">费用细化分析</a>
						</li>	
						<li>
							<a href="/fna/report/fanRptCost/fanRptCost.jsp" target="_blank">费用查询统计</a>
						</li>	
						<li>
							<a href="/fna/report/LoanRepaymentAnalysis/LoanRepaymentAnalysis.jsp" target="_blank">个人借款汇总</a>
						</li>	
					</ul>
			  </li>
                <li><div class="line"></div></li>
              <li class="dropdown-submenu">
				<a><span>台账分析</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li>
							<a href="/formmode/search/CustomSearchBySimple.jsp?customid=2" target="_blank">电子发票虚拟数据</a>
						</li>
						<li>
							<a href="/formmode/search/CustomSearchBySimple.jsp?customid=9" target="_blank">增值税专用发票台账</a>
						</li>							
						<li>
							<a href="/formmode/search/CustomSearchBySimple.jsp?customid=3" target="_blank">电子发票台账</a>
						</li>	
						<li>
							<a href="/formmode/search/CustomSearchBySimple.jsp?customid=6" target="_blank">员工信用台账</a>
						</li>
						<li>
							<a href="/formmode/search/CustomSearchBySimple.jsp?customid=15" target="_blank">合同台账</a>
						</li>
					</ul>
			  </li>
                <li><div class="line"></div></li>
              <li class="dropdown-submenu">
				<a><span>预算分析</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
								<li>
									<a href="/fna/report/fanRptTotalBudget/fanRptTotalBudget.jsp" target="_blank">预算总额表</a>
								</li>
								<li>
									<a href="/fna/report/fnaRptImplementation/fnaRptImplementation.jsp" target="_blank">预算执行情况表</a>
								</li>
								<li>
									<a href="/fna/report/costSummary/costSummary.jsp" target="_blank">费用汇总表</a>
								</li>									
								<li>
									<a href="/fna/report/budgetDetailed/budgetDetailed.jsp" target="_blank">预算费用细化表</a>
								</li>	
								<li>
									<a href="/fna/report/fanRptCost/fanRptCost.jsp" target="_blank">预算费用查询统计表</a>
								</li>	
					</ul>
			  </li>
                <li><div class="line"></div></li>       
            </ul>
          </li>
           <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown">
              <i class="icon-laptop"></i>
              <span>一键配置</span><b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
              <li class="dropdown-submenu">
				<a><span>基础设置</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li>
							<a href="/fna/init/FnaInitSetEditInner.jsp" target="_blank">初始设置</a>
						</li>
						<li>
							<a href="/fna/budget/FnaSystemSetEdit.jsp" target="_blank">全局设置</a>
						</li>	
						<li>
							<a href="/fna/maintenance/FnaTab.jsp?_fromURL=FnaYearsPeriods" target="_blank">期间设置</a>
						</li>	
						<li>
							<a href="/fna/maintenance/FnaBudgetfeeType.jsp" target="_blank">科目设置</a>
						</li>	
						<li>
							<a href="/formmode/search/CustomSearchBySimple.jsp?customid=16" target="_blank">科目关联</a>
						</li>	
						<li>
							<a href="/fna/costCenter/CostCenter.jsp" target="_blank">成本中心设置</a>
						</li>	
						<li>
							<a href="/formmode/search/CustomSearchBySimple.jsp?customid=8" target="_blank">币种设置</a>
						</li>	
					</ul>
			  </li>
                <li><div class="line"></div></li>            
              <li class="dropdown-submenu">
				<a><span>网上报销</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li class="dropdown-submenu">
							<a><span>借支管理</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/workflow/request/AddRequest.jsp?workflowid=61&isagent=0&beagenter=0" target="_blank">借款初始化</a>
								</li>
								<li>
									<a href="/fna/budget/wfset/FnaBorrowWfSetEdit.jsp" target="_blank">个人/备用金借款设置</a>
								</li>
								<li>
									<a href="/fna/budget/wfset/FnaRepaymentWfSetEdit.jsp" target="_blank">个人/备用金还款设置</a>
								</li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a><span>预付管理</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/workflow/request/AddRequest.jsp?workflowid=62&isagent=0&beagenter=0" target="_blank">预付款初始化</a>
								</li>
								<li>
									<a href="/fna/budget/wfset/budgetAdvance/FnaAdvanceWfSetEdit.jsp" target="_blank">预付款设置</a>
								</li>
							</ul>
						</li>
						<li>
							<a href="/fna/budget/FnaWfSetEdit.jsp" target="_blank">动支设置</a>
						</li>
						<li>
							<a href="/fna/budget/FnaWfSetEdit.jsp" target="_blank">报销设置</a>
						</li>
						<li>
							<a href="/fna/budget/wfset/budgetShare/FnaShareWfSetEdit.jsp" target="_blank">分摊设置</a>
						</li>
						<li class="dropdown-submenu">
							<a><span>标准管理</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/fna/costStandard/costStandard.jsp" target="_blank">标准维度</a>
								</li>
								<li>
									<a href="/fna/costStandard/costStandardDefi.jsp" target="_blank">标准设置</a>
								</li>
								<li>
									<a href="/fna/costStandard/wfset/costStandardWfSetEdit.jsp" target="_blank">流程关联</a>
								</li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a><span>信用管理</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/formmode/search/CustomSearchBySimple.jsp?customid=4" target="_blank">信用等级设置</a>
								</li>
								<li>
									<a href="/formmode/search/CustomSearchBySimple.jsp?customid=6" target="_blank">信用分数初始化</a>
								</li>
								<li>
									<a href="/formmode/search/CustomSearchBySimple.jsp?customid=5" target="_blank">信用规则设置</a>
								</li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a><span>报账集成</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/integration/icontent.jsp?showtype=12" target="_blank">商旅集成</a>
								</li>
								<li>
									<a href="/integration/financesetting.jsp" target="_blank">凭证集成</a>
								</li>
								<li>
									<a href="/workflow/action/WsFormActionEditSet.jsp?urlType=21&&isdialog=1&fromintegration=1&operate=addws&webservicefrom=1&typename=&backto=" target="_blank">银企直连</a>
								</li>
								<li>
									<a href="/workflow/action/WsFormActionEditSet.jsp?urlType=21&&isdialog=1&fromintegration=1&operate=addws&webservicefrom=1&typename=&backto=" target="_blank">影像集成</a>
								</li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a><span>发票管理</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/workflow/action/WsFormActionEditSet.jsp?urlType=21&&isdialog=1&fromintegration=1&operate=addws&webservicefrom=1&typename=&backto=" target="_blank">集成接口设置</a>
								</li>
								<li>
									<a href="/formmode/search/CustomSearchBySimple.jsp?customid=1" target="_blank">进项发票控制</a>
								</li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a><span>合同管理</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/workflow/selectItem/selectItemMain.jsp" target="_blank">合同类型设置</a>
								</li>
								<li>
									<a href="/formmode/view/AddFormMode.jsp?modeId=14&formId=-37&type=1" target="_blank">合同关联应用</a>
								</li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a><span>报账计划</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/worktask/base/WT_MainCategory.jsp" target="_blank">计划管理设置</a>
								</li>
								<li>
									<a href="/formmode/setup/RemindJobSettings.jsp" target="_blank">系统提醒设置</a>
								</li>
							</ul>
						</li>
					</ul>
			  </li>
                <li><div class="line"></div></li>
              <li class="dropdown-submenu">
				<a><span>预算费控</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li>
							<a href="/fna/init/wizard/FnaInitWizard.jsp" target="_blank">预算快速向导</a>
						</li>
						<li class="dropdown-submenu">
							<a><span>预算基础设置</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/fna/budget/FnaLeftRuleSet/ruleSet.jsp" target="_blank">编制权限设置</a>
								</li>
								<li>
									<a href="/fna/budget/AuditSetting.jsp" target="_blank">预算审批设置</a>
								</li>
								<li>
									<a href="/fna/BudgetAutoMove/FnaJz.jsp" target="_blank">预算结转设置</a>
								</li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a><span>预算编制管理</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/fna/batch/OccurredExpenseBatch.jsp" target="_blank">预算数据初始化</a>
								</li>
								<li>
									<a href="/fna/budget/FnaBudget.jsp" target="_blank">预算编制</a>
								</li>
								<li>
									<a href="/fna/batch/FnaBudgetBatch.jsp" target="_blank">批量导入</a>
								</li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a><span>预算执行控制</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li>
									<a href="/fna/budget/FnaControlSchemeSet.jsp" target="_blank">预算管控方案</a>
								</li>
								<li class="dropdown-submenu">
									<a><span>预算流程设置</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
									<ul class="dropdown-menu">
										<li>
											<a href="/fna/  /FnaWfSetEdit.jsp" target="_blank">申请流程管控设置</a>
										</li>
										<li>
											<a href="/fna/budget/FnaWfSetEdit.jsp" target="_blank">报销流程管控设置</a>
										</li>
										<li>
											<a href="/fna/budget/wfset/budgetShare/FnaShareWfSetEdit.jsp" target="_blank">费用分摊管控设置</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>
						<li>
							<a href="/fna/budget/wfset/budgetChange/FnaChangeWfSetEdit.jsp" target="_blank">预算变更管理</a>
						</li>
					</ul>
			  </li>
                <%--<li><div class="line"></div></li>
              <li class="dropdown-submenu">
				<a><span>共享中心</span>&nbsp;&nbsp;&nbsp;<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li>
							<a href="/fna/init/FnaInitSetEditInner.jsp" target="_blank">SSC组织管理</a>
						</li>
						<li>
							<a href="/fna/init/FnaInitSetEditInner.jsp" target="_blank">SSC流程管理</a>
						</li>
						<li>
							<a href="/fna/init/FnaInitSetEditInner.jsp" target="_blank">SSC集成管理</a>
						</li>
						<li>
							<a href="/fna/init/FnaInitSetEditInner.jsp" target="_blank">SSC运营管理</a>
						</li>
						<li>
							<a href="/fna/init/FnaInitSetEditInner.jsp" target="_blank">SSC分析管理</a>
						</li>
					</ul>
			  </li>
                <li><div class="line"></div></li>--%>
            </ul>
          </li> -->
       	<li class="dropdown">
            <a href="/bsdt/port.jsp" class="dropdown-toggle">
              <i class="icon-external-link"></i>
              <span>费控门户</span>  
            </a>
      	</li>
      	<li class="dropdown">
            <a href="/gvo/report/index.jsp" class="dropdown-toggle" target="_blank">
              <i class="icon-laptop"></i>
              <span>报表平台</span>  
            </a>
      	</li> 
      	<li class="dropdown">
            <a href="/wui/main.jsp?templateId=1" class="dropdown-toggle" target="_blank">
              <i class="icon-signin"></i>
              <span>前端应用中心</span>  
            </a>
      	</li>              
        </ul>
           <%--<form class="navbar-form navbar-left m-t-sm" role="search" action="#">
          <div class="form-group">
            <div class="input-group input-s">
              <input type="text" class="form-control input-sm" name="serviceName" id="serviceName" placeholder="搜索报账应用">
              <span class="input-group-btn">
                <button type="submit" class="btn btn-sm btn-info btn-icon"><i class="icon-search"></i></button>
              </span>
            </div>
          </div>
        </form>--%>
         <%
         	if(user!=null && !ifGuest){
         		String sql = "select count(1) num from workflow_requestbase t1 left join workflow_currentoperator t2 on t1.requestid=t2.requestid where (t1.deleted <> 1 or t1.deleted is null or t1.deleted = '') and t2.userid in ("+accountall_son+") and t2.usertype = 0 and (t1.deleted = 0 or t1.deleted is null) and ((t2.isremark = 0 and (t2.takisremark is null or t2.takisremark = 0)) or t2.isremark in ('1', '5', '8', '9', '7')) and (t1.deleted = 0 or t1.deleted is null) and t2.islasttimes = 1 and (nvl(t1.currentstatus, -1) = -1 or (nvl(t1.currentstatus, -1) = 0 and t1.creater in ("+accountall_son+"))) and t1.workflowid in (select id from workflow_base where (isvalid = '1' or isvalid = '3'))";
         		rs.executeSql(sql);
         		int count = 0;
         		if(rs.next()){
         			count = rs.getInt("num");
         		}
         %> 
         
        <ul class="nav navbar-nav navbar-right">
          <%--<li class="dropdown">
            <a href="/middlecenter/index.jsp" target="_blank" class="dropdown-toggle">
              <i class="icon-gears"></i>
              <span>系统后台</span>  
            </a>
		   </li>--%>

          <%
          if(count>0) {%>
          <li class="hidden-xs">
            <a class="dropdown-toggle dk" data-toggle="dropdown">
              <i class="icon-bell-alt"></i>
              <span class="badge up bg-danger m-l-n-sm"><%=count %></span>
            </a>
            <section class="dropdown-menu animated fadeInUp input-s-lg">
              <section class="panel bg-white">
                <header class="panel-heading">
                  <strong>您有 <span class="count-n"><%=count %></span> 个事项</strong>
                </header>
                <div class="list-group">
                <%
                	String workflowSql = "select t1.requestid,t1.workflowid, t1.requestname, t1.requestnamenew,t2.receivetime,t1.createdate, t1.createtime from workflow_requestbase t1 left join workflow_currentoperator t2 on t1.requestid=t2.requestid where (t1.deleted <> 1 or t1.deleted is null or t1.deleted = '') and t2.userid in ("+accountall_son+") and t2.usertype = 0 and (t1.deleted = 0 or t1.deleted is null) and ((t2.isremark = 0 and (t2.takisremark is null or t2.takisremark = 0)) or t2.isremark in ('1', '5', '8', '9', '7')) and (t1.deleted = 0 or t1.deleted is null) and t2.islasttimes = 1 and (nvl(t1.currentstatus, -1) = -1 or (nvl(t1.currentstatus, -1) = 0 and t1.creater in ("+accountall_son+"))) and t1.workflowid in (select id from workflow_base where (isvalid = '1' or isvalid = '3'))";
                rs.executeSql(workflowSql);
                while(rs.next()){
                	%>
                	 <a href="#" onclick="openWorkFolw('<%=rs.getInt("requestid") %>')" class="media list-group-item">
                    <span class="media-body block m-b-none">
                    	<%=rs.getString("requestname") %><br>
                      <small class="text-muted"><%=rs.getString("createdate") %></small>
                    </span>
                  </a>
                	<%
                }
                %>
                </div>
                <footer class="panel-footer text-sm">
                  <a href="#" class="pull-right"><i class="icon-cog"></i></a>
                  <a href="#" onclick="openToDo();" data-toggle="modal">查看全部进度 ></a>
                </footer>
              </section>
            </section>
          </li>
           <%}%> 
		
		<!--主次账号切换 -->
		<%if(weaver.general.GCONST.getMOREACCOUNTLANDING()){
		List accounts =(List)session.getAttribute("accounts");
		if(accounts!=null&&accounts.size()>1){
			Iterator iter=accounts.iterator();
			int tmpCount = 0;
		%>
			<li class="hidden-xs">
            	<a>
					<img onclick="showAccoutList()" id="accoutImg"  src="/wui/theme/ecology8/page/images/hrminfo/accout_wev8.png" style="position:absolute;top:13px;cursor:pointer;">
						<div class="accoutList" id="accoutList" style="display: none;">
			        		<div style="height:10px;width:15px;z-index:101;top: 0px;position: absolute;background:url(/images/topnarrow.png) no-repeat;"></div>
			        		<div class="accoutListBox">
			        		<% while(iter.hasNext()){
			        			Account a=(Account)iter.next();
				            	String subcompanyname=SubCompanyComInfo.getSubCompanyname(""+a.getSubcompanyid());
				              	String departmentname=DepartmentComInfo.getDepartmentname(""+a.getDepartmentid());
				            	String jobtitlename=JobTitlesComInfo.getJobTitlesname(""+a.getJobtitleid()); 
				            	String userName = ResourceComInfo.getResourcename(""+a.getId()); 
				            %>
				            <div class="accountItem " userid="<%=a.getId() %>" onclick="changeAccount(this)">
				            	<div class="accountText">
				            		<font color="#363636" title="<%=userName %>"><%=userName%></font>&nbsp;&nbsp;&nbsp;&nbsp;<font color="#0071ca" title="<%=jobtitlename %>"><%=jobtitlename %></font>
										<br>
										<font color="#868686"  title="<%=subcompanyname +"/"+departmentname %>"><%=subcompanyname +"/"+departmentname %></font>
								</div >
				            	<div class="accountIcon">
				            		<%
				            		String userid = ""+user.getUID() ;
				            		if(userid.equals(a.getId()+"")){ %>
										<img style="width: 16px;height: 16px;vertical-align: middle;" src="/images/check.png">
									<%} %>
				            	</div>
								<div style="clear:both;"></div>
				            </div>
				            	<%if(++tmpCount < accounts.size()) {%>
								<div style="background-color:#d4d4d4;height:1px;width:188px;"></div>
								<%} %>
				            <%} %>
			        		</div>
			        	</div>
				</a>
			</li>
		<%
		}
		}%>


          <li class="dropdown">
            <a class="dropdown-toggle aside-sm dker" data-toggle="dropdown">
              <span class="thumb-sm avatar pull-left m-t-n-xs m-r-xs">
              <%
              rs.executeSql("select messagerurl,lastname from HrmResource where id ="+userId);
              if(rs.next()){
            	  messagerurl = rs.getString("messagerurl");
            	  lastname = rs.getString("lastname");
              }
              if(lastname==null||"".equals(lastname))
            	  lastname="系统管理员";
              if(messagerurl==null||messagerurl.equals("")){
            	  if(user.getSex().equals("0")) {
            		  messagerurl = "/messager/images/icon_m_wev8.jpg";
                  } else{
                	  messagerurl = "/messager/images/icon_w_wev8.jpg";
                  }
              }
              %>
               
            	 <img src="<%=messagerurl %>">
              </span>
              <%=lastname %> <b class="caret"></b>
            </a>	
             <ul class="dropdown-menu animated fadeInLeft"><%--
             <li><a href="home.html">中文</a></li>
              <li><a href="home.html">English</a></li>
                --%><li><div class="line"></div></li> 
              <li><a href="/hrm/resource/HrmResourceBase.jsp?isfromtab=true&id="+userId+"&fromHrmTab=1" target="_blank">设置</a></li>
              <li><a href="/hrm/resource/HrmResourceTotal.jsp?isfromtab=true&id=4" target="_blank">帮助</a></li>
              <li><a href="/login/Login.jsp" onclick="logout();">退出</a></li>
            </ul>
          </li>

        </ul>
        
      <%} %>    
      </div>
    </header>
<script language=javascript> 
function changeAccount(obj){
	window.location = "/bsdt/IdentityShift.jsp?shiftid="+$(obj).attr("userid");
}

function showAccoutList(){
	jQuery('#accoutList').toggle();
	if(jQuery("#accoutList").css("display")=="none"){
		jQuery(".accoutSelect").removeClass("accoutBg");
	}else{
		jQuery(".accoutSelect").addClass("accoutBg");
	}
}

jQuery("#accoutList").hover(function(){
 },function(){
 	jQuery('#accoutList').toggle();
 	jQuery(".accoutSelect").removeClass("accoutBg");
 });

</script>
 <style type="text/css">
 .accoutSelect{
			 	padding-top:5px;
			 	padding-left:10px;
			 	position:relative;
			 	
			 	width:110px;
			 	background-image: url("/images/ecology8/doc/down_sel_wev8.png");
			 	background-repeat: no-repeat;
			 	background-position: center right;
			 	height:20px;
			 	line-height: 20px;
			 }
			 
			.accoutBg{
				background: #adadad;
			}
        	.accoutList{
        		display:none;
        		padding-top:5px;
        		position:absolute;
        		top:35px;
        		width:200px;
        		z-index:100;
        		padding-bottom: 5px;
        	}
        	.accountItem{
        		height:65px;
        		cursor:pointer;
        	}
        	
        	.accoutListBox{
        		background: #ffffff;
        		border:1px solid #d4d4d4;
        		width:190px;
        		padding:0 5px;
        		top: 8px;
        		left:-18px;
        		position: absolute;
        		-moz-border-radius: 3px;
			    -webkit-border-radius: 3px;
			    border-radius:3px;
        	}
        	.accountText{
        		width:185px;
        		height: 56px;
        		margin-top:9px;
        		padding-left:5px;
        		line-height:28px;
        		white-space: nowrap;
        		overflow: hidden;
        		text-overflow:ellipsis;
        	}
        	.accountIcon{
        		width:20px;
        		height:20px;
        		right:5px;
        		position: absolute;
        		margin-top:-39px;
        	}
        	.accountContext{
        		float: right;
        		
        	}
 </style>   
