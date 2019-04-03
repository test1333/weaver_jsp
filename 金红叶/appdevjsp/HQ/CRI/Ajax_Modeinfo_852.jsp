<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil"%>
<%@ page import="weaver.workflow.webservices.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	User usertemp = HrmUserVarify.getUser (request , response) ;
	int userid=usertemp.getUID();
	BaseBean bs = new BaseBean();
	String opt = Util.null2String(request.getParameter("opt"));  
	String zt = Util.null2String(request.getParameter("zt"));  
	String billid = Util.null2String(request.getParameter("billid"));
	String dcy = Util.null2String(request.getParameter("dcy")); 
	String gdgz = Util.null2String(request.getParameter("gdgz")); 
	session.setAttribute("ztvalue",zt);

	if("opt".equals(opt)){
		rs.executeSql(" select * from uf_hq_cri_casedp where id = '"+billid+"' ");
		if(rs.next()){
			String rszt = rs.getString("zt");
			if(zt.equals(rszt)){				
				out.print("{\"resultzt\":\"500\"}");
			}else{
				String requestid = CreateWorkFlow(dcy,zt,billid,gdgz,userid);
				if(requestid.compareTo("0")>0){
					String resultzt = session.getAttribute("ztvalue").toString();
					out.print("{\"resultzt\":\""+resultzt+"\"}");
				}else{
					out.print("{\"resultzt\":\"100\"}");
				}
			}
		}
	}
%>

<%!
	public String CreateWorkFlow(String dcy,String zt, String billid,String gdgz,int userid){
		RecordSet rs = new RecordSet();
		String creatUser = String.valueOf(userid);
		String xmbh = "";
		String xmmc = "";
		String dcqdrq = "";
		String ajsyts = "";
		String jaz = "";
		String ajsyzs = "";
		String alpkrq = "";
		String fzcd = "";
		String rwly = "";
		rs.executeSql(" select * from uf_hq_cri_casedp where id = '"+billid+"' ");
		if(rs.next()){
			xmbh = rs.getString("xmbh");
			xmmc = rs.getString("xmmc");
			dcqdrq = rs.getString("dcqdrq");
			ajsyts = rs.getString("ajsyts");
			jaz = rs.getString("jaz");
			ajsyzs = rs.getString("ajsyzs");
			alpkrq = rs.getString("alpkrq");
			fzcd = rs.getString("fzcd");
			rwly = rs.getString("jbqd");
		}
		
		//主字段
		WorkflowRequestTableField[] wrti = new WorkflowRequestTableField[12]; //字段信息:12表示字段个数
		wrti[0] = new WorkflowRequestTableField(); 
		wrti[0].setFieldName("dcys");              //调查员
		wrti[0].setFieldValue(dcy);
		wrti[0].setView(true);
		wrti[0].setEdit(true);
		
		wrti[1] = new WorkflowRequestTableField(); 
		wrti[1].setFieldName("xmbh");              //项目编号
		wrti[1].setFieldValue(xmbh);
		wrti[1].setView(true);
		wrti[1].setEdit(true);
		
		wrti[2] = new WorkflowRequestTableField(); 
		wrti[2].setFieldName("xmmc");              //项目名称
		wrti[2].setFieldValue(xmmc);
		wrti[2].setView(true);
		wrti[2].setEdit(true);
		
		wrti[3] = new WorkflowRequestTableField(); 
		wrti[3].setFieldName("dcqdrq");            //调查启动日期
		wrti[3].setFieldValue(dcqdrq);
		wrti[3].setView(true);
		wrti[3].setEdit(true);
		
		wrti[4] = new WorkflowRequestTableField(); 
		wrti[4].setFieldName("ajsyts");            //案件所用天数
		wrti[4].setFieldValue(ajsyts);
		wrti[4].setView(true);
		wrti[4].setEdit(true);
		
		wrti[5] = new WorkflowRequestTableField(); 
		wrti[5].setFieldName("jaz");               //接案周
		wrti[5].setFieldValue(jaz);
		wrti[5].setView(true);
		wrti[5].setEdit(true);
		
		wrti[6] = new WorkflowRequestTableField(); 
		wrti[6].setFieldName("ajsyzs");            //案件所用周数
		wrti[6].setFieldValue(ajsyzs);
		wrti[6].setView(true);
		wrti[6].setEdit(true);
		
		wrti[7] = new WorkflowRequestTableField(); 
		wrti[7].setFieldName("alpkrq");            //奥林匹克日期
		wrti[7].setFieldValue(alpkrq);
		wrti[7].setView(true);
		wrti[7].setEdit(true);
		
		wrti[8] = new WorkflowRequestTableField(); 
		wrti[8].setFieldName("gdgz");              //股东关注
		wrti[8].setFieldValue(gdgz);
		wrti[8].setView(true);
		wrti[8].setEdit(true);
		
		wrti[9] = new WorkflowRequestTableField(); 
		wrti[9].setFieldName("fzcd");              //复杂程度
		wrti[9].setFieldValue(fzcd);
		wrti[9].setView(true);
		wrti[9].setEdit(true);
		
		wrti[10] = new WorkflowRequestTableField(); 
		wrti[10].setFieldName("rwly");              //任务来源
		wrti[10].setFieldValue(rwly);
		wrti[10].setView(true);
		wrti[10].setEdit(true);
		
		wrti[11] = new WorkflowRequestTableField(); 
		wrti[11].setFieldName("zt");                //状态
		wrti[11].setFieldValue(zt);
		wrti[11].setView(true);
		wrti[11].setEdit(true);
		
		WorkflowRequestTableRecord[] wrtri = new WorkflowRequestTableRecord[1];//主字段只有一行数据
		wrtri[0] = new WorkflowRequestTableRecord();
		wrtri[0].setWorkflowRequestTableFields(wrti);	
		
		WorkflowMainTableInfo wmi = new WorkflowMainTableInfo();
		wmi.setRequestRecords(wrtri);
		
		if("0".equals(zt)){
			zt = "HQ_CRI_案件开放";
		}else if("1".equals(zt)){
			zt = "HQ_CRI_案件结案";
		}else if("2".equals(zt)){
			zt = "HQ_CRI_案件搁置";
		}else if("3".equals(zt)){
			zt = "HQ_CRI_案件取消";
		}
		WorkflowBaseInfo wbi = new WorkflowBaseInfo();
		wbi.setWorkflowId("1103");                //工作流id
	    WorkflowRequestInfo wri = new WorkflowRequestInfo();//流程基本信息	
		wri.setCreatorId(creatUser);              //创建人id
		wri.setRequestLevel("0");                 //0正常，1重要，2紧急
		wri.setRequestName(zt);                   //流程标题
        wri.setMessageType("2");                  //短信提醒类型
	    wri.setWorkflowMainTableInfo(wmi);        //添加主字段数据
		wri.setWorkflowBaseInfo(wbi);
		wri.setRemark("");		
		WorkflowService workflowService = new WorkflowServiceImpl();
		String requestid=workflowService.doCreateWorkflowRequest(wri,1);
		return requestid;	
	}

%>
