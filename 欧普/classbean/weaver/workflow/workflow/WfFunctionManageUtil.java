package weaver.workflow.workflow;
/*
* Created on 2006-05-18
* Copyright (c) 2001-2006 泛微软件
* 泛微协同商务系统，版权所有。
* 
*/
import java.util.Calendar;
import java.util.HashMap;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.GCONST;
import weaver.general.Util;
import weaver.hrm.User;
import weaver.systeminfo.SystemEnv;
import weaver.workflow.monitor.Monitor;
import weaver.workflow.monitor.MonitorDTO;

/**
 * 流程设置
 * @version 1.0
 * @author xwj
 */
public class WfFunctionManageUtil extends BaseBean {

//	private String sv = "";
//	private String dv = "";
//	private String zc = ""; 
//	private String mc = "";
//	private String fw = "";
	private String rb = "0";
	private String ov = "";
	
	public String sqlStr = "";
	
	private int creater = -1;
	private int currentnodetype = -1;
	private int currentstatus = -1;//流程当前状态，0为暂停，1为撤销
	private int workflowid = -1;
	private int nodeid = -1;
	private int userid = -1;
	private int usertype = -1;
	private WorkflowComInfo wf = null;
	private boolean isoverrb = false ;//是否开启归档节点强制收回
	public WfFunctionManageUtil() {
		try {
			wf=new WorkflowComInfo();
		} catch (Exception ex) {
			//System.out.println(ex);
			writeLog(ex);
		}
	}

  /**
	* 通过流程节点id确定该节点上的操作人对该流程的各个管理权限
	* @param nodeid 节点ID
	* @param wfid  流程ID
	* @return HashMap 管理功能明细
	*/
	public HashMap wfFunctionManageByNodeid(int wfid, int nodeid) {
		HashMap map = new HashMap();
		RecordSet rs = new RecordSet();
		boolean isoverrb = false ;//是否开启归档节点强制收回
		boolean isoveriv = false ;//是否开启归档节点强制收回
		rs.executeSql("select isoverrb,isoveriv from workflow_base where id="+wfid);
		if(rs.next()){
			isoverrb = Util.null2String(rs.getString("isoverrb")).equals("1")?true:false;
			isoveriv = Util.null2String(rs.getString("isoveriv")).equals("1")?true:false;
		}
		boolean isendnode = false ;
		rs.executeSql("select isend from workflow_nodebase where id="+nodeid);
		if(rs.next()){
			if(rs.getString("1").equals("1")){
				isendnode = true ;
			}
		}
		sqlStr = "select * from workflow_function_manage where workflowid = " + wfid + " and operatortype = " + nodeid;
		rs.executeSql(sqlStr);
		if(rs.next()){
			if(isendnode&&!isoverrb){
				rb = "0";
			}else{
				rb = rs.getString("retract");
			}
			ov = rs.getString("pigeonhole");
		}
		map.put("rb",rb);
		map.put("ov",ov);
		return map;

	}

	/**
	 * 通过流程节点id确定该节点上的操作人对该流程的各个管理权限（废弃）
	 * @param nodeid 节点ID
	 * @param wfid  流程ID
	 * @return HashMap 管理功能明细
	 */
	public HashMap wfFunctionMonitorByNodeid(String wfid, String userid) {
		HashMap map = new HashMap();
		RecordSet rs = new RecordSet();
		sqlStr = "select * from workflow_monitor_bound where workflowid = '" + wfid + "' and monitorhrmid = '" + userid +"'";
		rs.executeSql(sqlStr);
		if(rs.next()){
			rb = rs.getString("isForceDrawBack");//强制归档
			ov = rs.getString("isForceOver");//强制收回
		}
		map.put("rb",rb);
		map.put("ov",ov);
		return map;
	}

  /**
	* 确定流程监控人对该流程的各个管理权限
	* @param wfid
	* @return HashMap 管理功能明细
	*/
	public HashMap wfFunctionManageAsMonitor(int wfid) {
		return wfFunctionManageByNodeid(wfid, -1);

	}

    /**
     * 判断是否显示退回到创建节点删除按钮
     * @param requestid
     * @param workflowid
     * @return
     */
    public boolean IsShowDelButtonByReject(int requestid,int workflowid){
        boolean showit=false;
        RecordSet rs=new RecordSet();
        sqlStr="select ShowDelButtonByReject from workflow_base where id="+workflowid+" and ( ShowDelButtonByReject='1' or ((ShowDelButtonByReject is null or ShowDelButtonByReject !='1') and not EXISTS(select 1 from workflow_requestlog where logtype!='1' and requestid="+requestid+")))";
        rs.executeSql(sqlStr);
        if(rs.next()){
            showit=true;
        }
        return showit;
    }
    /**
     * 判断是否有暂停流程的权限
     * 流程不为暂停或者撤销状态，当前用户为流程发起人或者系统管理员，并且流程状态不为创建和归档（废弃）
     * @param currentstatus
     * @param creater
     * @param user
     * @param currentnodetype
     * @return
     */
    public boolean haveStopright(int currentstatus,int creater,User user,String currentnodetype,int requestid,boolean issooperator)
    {
    	Monitor monitor = new Monitor();
    	RecordSet rs = new RecordSet();
    	rs.execute("select creater,workflowid,currentstatus,currentnodetype from workflow_requestbase where requestid = " + requestid);
    	rs.next();
    	int creater_temp = rs.getInt(1);
    	String workflowid_temp = rs.getString(2);
    	int currentstatus_temp = rs.getInt(3);
    	String currentnodetype_temp = rs.getString(4);
    	MonitorDTO monitorInfo = monitor.getMonitorInfo(user.getUID()+"", creater_temp+"", workflowid_temp);

    	return haveStopright2(currentstatus_temp, creater, user,currentnodetype_temp, requestid, monitorInfo.getIssooperator(),workflowid_temp);
   }
    /**
     * 判断是否有撤销流程的权限
     * 流程不为撤销状态，当前用户为流程发起人或者系统管理员，并且流程状态不为创建和归档（废弃）
     * @param currentstatus
     * @param creater
     * @param user
     * @param currentnodetype
     * @return
     */
    public boolean haveCancelright(int currentstatus,int creater,User user,String currentnodetype,int requestid,boolean issooperator){
    	Monitor monitor = new Monitor();
    	RecordSet rs = new RecordSet();
    	rs.execute("select creater,workflowid,currentstatus,currentnodetype from workflow_requestbase where requestid = " + requestid);
    	rs.next();
    	int creater_temp = rs.getInt(1);
    	String workflowid_temp = rs.getString(2);
    	int currentstatus_temp = rs.getInt(3);
    	String currentnodetype_temp = rs.getString(4);
    	MonitorDTO monitorInfo = monitor.getMonitorInfo(user.getUID()+"", creater_temp+"", workflowid_temp);

    	return haveCancelright2(currentstatus_temp, creater, user,currentnodetype_temp, requestid, monitorInfo.getIssooperator(),workflowid_temp);
    }
    /**
     * 判断是否有启用的权限
     * 流程为暂停或者撤销状态，当前用户为系统管理员，并且流程状态不为创建和归档（废弃）
     * @param currentstatus
     * @param creater
     * @param user
     * @param currentnodetype
     * @return
     */
    public boolean haveRestartright(int currentstatus,int creater,User user,String currentnodetype,int requestid,boolean issooperator){
    	Monitor monitor = new Monitor();
    	RecordSet rs = new RecordSet();
    	rs.execute("select creater,workflowid,currentstatus,currentnodetype from workflow_requestbase where requestid = " + requestid);
    	rs.next();
    	int creater_temp = rs.getInt(1);
    	String workflowid_temp = rs.getString(2);
    	int currentstatus_temp = rs.getInt(3);
    	String currentnodetype_temp = rs.getString(4);
    	MonitorDTO monitorInfo = monitor.getMonitorInfo(user.getUID()+"", creater_temp+"", workflowid_temp);

    	return haveRestartright2(currentstatus_temp, creater, user, currentnodetype_temp, requestid, monitorInfo.getIssooperator(),workflowid_temp);
    }
    
    
    /**
     * 判断是否有暂停流程的权限
     * 流程不为暂停或者撤销状态，当前用户为流程发起人或者系统管理员，并且流程状态不为创建和归档
     * @param currentstatus
     * @param creater
     * @param user
     * @param currentnodetype
     * @return
     */
    public boolean haveStopright2(int currentstatus,int creater,User user,String currentnodetype,int requestid,boolean issooperator,String workflowid)
    {
    	String isOpenWorkflowStopOrCancel=GCONST.getWorkflowStopOrCancel();//是否开启流程暂停或取消设置
    	if(isOpenWorkflowStopOrCancel.equals("1")){
    	int formid = 0;
        int isbill = 0;
    	if(requestid>0){
    		formid = Util.getIntValue(wf.getFormId(workflowid),0);
			isbill = Util.getIntValue(wf.getIsBill(workflowid),0);
    	}
    	return (currentstatus!=0&&currentstatus!=1)&&(creater==user.getUID()||issooperator)&&!currentnodetype.equals("0")&&!currentnodetype.equals("3")&&!((formid==158||formid==156)&&isbill==1);
     }else
    	 return false;
   }
    /**
     * 判断是否有撤销流程的权限
     * 流程不为撤销状态，当前用户为流程发起人或者系统管理员，并且流程状态不为创建和归档
     * @param currentstatus
     * @param creater
     * @param user
     * @param currentnodetype
     * @return
     */
    public boolean haveCancelright2(int currentstatus,int creater,User user,String currentnodetype,int requestid,boolean issooperator,String workflowid)
    {
    	String isOpenWorkflowStopOrCancel=GCONST.getWorkflowStopOrCancel();//是否开启流程暂停或取消设置
    	if(isOpenWorkflowStopOrCancel.equals("1")){
    	int formid = 0;
        int isbill = 0;
    	if(requestid>0){
    		formid = Util.getIntValue(wf.getFormId(workflowid),0);
			isbill = Util.getIntValue(wf.getIsBill(workflowid),0);
    	}
    	return currentstatus!=1&&(creater==user.getUID()||issooperator)&&!currentnodetype.equals("0")&&!currentnodetype.equals("3")&&!((formid==158||formid==156)&&isbill==1);
      }else
    	  return false;
    }
    /**
     * 判断是否有启用的权限
     * 流程为暂停或者撤销状态，当前用户为系统管理员，并且流程状态不为创建和归档
     * @param currentstatus
     * @param creater
     * @param user
     * @param currentnodetype
     * @return
     */
    public boolean haveRestartright2(int currentstatus,int creater,User user,String currentnodetype,int requestid,boolean issooperator,String workflowid)
    {
    	String isOpenWorkflowStopOrCancel=GCONST.getWorkflowStopOrCancel();//是否开启流程暂停或取消设置
    	if(isOpenWorkflowStopOrCancel.equals("1")){
    	int formid = 0;
        int isbill = 0;
    	if(requestid>0){
    		formid = Util.getIntValue(wf.getFormId(workflowid),0);
			isbill = Util.getIntValue(wf.getIsBill(workflowid),0);
    	}
    	return currentstatus>-1&&(issooperator)&&!currentnodetype.equals("0")&&!currentnodetype.equals("3")&&!((formid==158||formid==156)&&isbill==1);
       }else
    	   return false;
    }
    /**
     * 判断流程是否处于可操作状态
     * @param requestid
     * @return
     */
    public boolean haveOtherOperationRight(int requestid)
    {
    	boolean flag = true;
    	RecordSet rs = new RecordSet();
    	if(requestid>0)
    	{
			rs.executeSql("select currentnodetype,currentstatus from workflow_requestbase where requestid = "+ requestid);
			if (rs.next()) 
			{
				String currentstatus = Util.null2String((rs.getString("currentstatus")));
				if ("1".equals(currentstatus)||"0".equals(currentstatus)) 
				{
					flag = false;
				}
			}
    	}
		return flag;
    }
    public boolean setStopOperation(int requestid,User user)
    {
    	RecordSet RecordSet = new RecordSet();
    	String sql = "";
    	//获取流程信息
    	this.getRequestBaseInfo(requestid, user);
        boolean haveStopright = this.haveStopright(currentstatus, creater, user, ""+currentnodetype, requestid, false);
        if(haveStopright)
        {
        	//为了屏蔽暂停的流程在查询结果集中，将除流程发起人本人外的其他操作者的操作状态更新为无效状态
        	sql = "update workflow_currentoperator set lastisremark=isremark,isremark='' where userid!="+creater+" and requestid="+requestid;
        	RecordSet.executeSql(sql);
        	//为了防止流程发起人可以继续操作流程，将流程发起人的操作状态更新为已操作
        	sql = "update workflow_currentoperator set lastisremark=isremark,isremark=2 where userid="+creater+" and requestid="+requestid;
        	RecordSet.executeSql(sql);
        	//将流程更新为20387
        	sql = "update workflow_requestbase set laststatus=status,status='"+SystemEnv.getHtmlLabelName(20387, user.getLanguage())+"',currentstatus=0 where requestid="+requestid;
        	RecordSet.executeSql(sql);
        	this.saveOtherOperator(""+requestid,""+workflowid,""+nodeid,""+userid,""+usertype,"s");
        }
        return true;
    }
    /**
     * 撤销流程
     * @param requestid
     * @param user
     * @return
     */
    public boolean setCancelOperation(int requestid,User user)
    {
    	RecordSet RecordSet = new RecordSet();
    	//获取流程信息
    	this.getRequestBaseInfo(requestid, user);
    	String sql = "";
        boolean haveCancelright = this.haveCancelright(currentstatus, creater, user, ""+currentnodetype, requestid, false);
        if(haveCancelright)
        {
        	if(currentstatus!=0)
        	{
	        	//如果之前没有做暂停、撤销操作，则直接更新所有的isremark数据
	        	sql = "update workflow_currentoperator set lastisremark=isremark,isremark='' where requestid="+requestid;
	        	RecordSet.executeSql(sql);
	        	//将流程更新为撤销
	        	sql = "update workflow_requestbase set laststatus=status,status='"+SystemEnv.getHtmlLabelName(16210, user.getLanguage())+"',currentstatus=1 where requestid="+requestid;
	        	RecordSet.executeSql(sql);
        	}
        	else if(currentstatus==0)
        	{
        		//如果之前有做暂停操作，那么把创建人本人的isremark数据更新为c
            	sql = "update workflow_currentoperator set isremark='' where userid="+creater+" and requestid="+requestid;
            	RecordSet.executeSql(sql);
	        	//将流程更新为撤销
	        	sql = "update workflow_requestbase set status='"+SystemEnv.getHtmlLabelName(16210, user.getLanguage())+"',currentstatus=1 where requestid="+requestid;
	        	RecordSet.executeSql(sql);
        	}
        	this.saveOtherOperator(""+requestid,""+workflowid,""+nodeid,""+userid,""+usertype,"c");
        }
        return true;
    }
    /**
     * 启用流程
     * @param requestid
     * @param user
     * @return
     */
    public boolean setRestartOperation(int requestid,User user)
    {
    	Calendar today = Calendar.getInstance();
    	String CurrentDate = Util.add0(today.get(Calendar.YEAR), 4)+ "-"+ Util.add0(today.get(Calendar.MONTH) + 1, 2)+ "-"+ Util.add0(today.get(Calendar.DAY_OF_MONTH), 2);
    	String CurrentTime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2)+ ":"+ Util.add0(today.get(Calendar.MINUTE), 2)+ ":"+ Util.add0(today.get(Calendar.SECOND), 2);
    	RecordSet RecordSet = new RecordSet();
    	String sql = "";
    	//获取流程信息
    	this.getRequestBaseInfo(requestid, user);
        boolean haveRestartright = this.haveRestartright(currentstatus, creater, user, ""+currentnodetype, requestid, false);
        if(haveRestartright)
        {
        	//启用流程
        	sql = "update workflow_currentoperator set isremark=lastisremark,lastisremark='0' where requestid="+requestid;
        	RecordSet.executeSql(sql);
	        //将流程更新为原始状态
	        sql = "update workflow_requestbase set status=laststatus,currentstatus=-1 where requestid="+requestid;
        	RecordSet.executeSql(sql);
        	//将还在待办事宜中，并且未超时的流程的接收日期和时间修改为当前日期和时间
        	sql = "update workflow_currentoperator set RECEIVEDATE='"+CurrentDate+"',RECEIVETIME='"+CurrentTime+"' where requestid="+requestid+
	        	  "   and ((isremark = '0' and (isprocessed is null or (isprocessed <> '2' and isprocessed <> '3'))) or isremark = '1' or "+
	        	  "		        isremark = '8' or isremark = '9' or isremark = '7') and islasttimes = 1";
        	RecordSet.executeSql(sql);
        	//将已经查看的操作时间给更新为当前时间
        	sql = "update workflow_currentoperator set operatedate='"+CurrentDate+"',operatetime='"+CurrentTime+"' where requestid="+requestid+
		      	  "   and ((isremark = '0' and (isprocessed is null or (isprocessed <> '2' and isprocessed <> '3'))) or isremark = '1' or "+
		      	  "		        isremark = '8' or isremark = '9' or isremark = '7') and islasttimes = 1 and (viewtype=-2 or (viewtype=-1 and operatedate is not null)) ";
        	RecordSet.executeSql(sql);
        	
        	this.saveOtherOperator(""+requestid,""+workflowid,""+nodeid,""+userid,""+usertype,"r");
        }
        return true;
    }
    /**
     * 获取流程信息
     * @param requestid
     * @param user
     */
    private void getRequestBaseInfo(int requestid,User user)
    {
    	RecordSet RecordSet = new RecordSet();
    	String sql = " select creater,currentnodetype,currentstatus,workflowid,currentnodeid from workflow_requestbase b where b.requestid="+requestid;
    	creater = -1;
    	currentnodetype = -1;
    	currentstatus = -1;//流程当前状态，0为暂停，1为撤销
    	workflowid = -1;
    	nodeid = -1;
    	userid = user.getUID();
        usertype = (user.getLogintype().equals("1")) ? 0 : 1;
    	RecordSet.executeSql(sql);
        if(RecordSet.next()) 
        {
        	creater = Util.getIntValue(RecordSet.getString("creater"));
        	currentnodetype = Util.getIntValue(RecordSet.getString("currentnodetype"));
        	currentstatus = Util.getIntValue(RecordSet.getString("currentstatus"),-1);
        	workflowid = Util.getIntValue(RecordSet.getString("workflowid"),-1);
        	nodeid = Util.getIntValue(RecordSet.getString("currentnodeid"),-1);
        }
    }
    /**
     * 保存对流程进行暂停，撤销，启用日志
     * @param requestid
     * @param userid
     * @param usertype
     * @param isremark
     */
    public void saveOtherOperator(String requestid,String workflowid,String nodeid,String userid,String usertype,String isremark)
    {
    	RecordSet rs = new RecordSet();
    	if("".equals(nodeid))
    	{
	    	String sql = "select b.workflowid,b.currentnodeid from workflow_requestbase b where b.requestid = "+requestid;
	    	rs.executeSql(sql);
	    	if(rs.next())
	    	{
	    		workflowid = rs.getString("workflowid");
	    		nodeid = rs.getString("currentnodeid");
	    	}
    	}
    	Calendar today = Calendar.getInstance();
		String CurrentDate = Util.add0(today.get(Calendar.YEAR), 4)+ "-"+ Util.add0(today.get(Calendar.MONTH) + 1, 2)+ "-"+ Util.add0(today.get(Calendar.DAY_OF_MONTH), 2);
		String CurrentTime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2)+ ":"+ Util.add0(today.get(Calendar.MINUTE), 2)+ ":"+ Util.add0(today.get(Calendar.SECOND), 2);
		if(!workflowid.equals("")&&!requestid.equals(""))
		{
	    	StringBuffer logsql = new StringBuffer();
	    	logsql.append("insert into workflow_otheroperator ");
	    	logsql.append("	  (REQUESTID, ");
	    	logsql.append("	   USERID, ");
	    	logsql.append("	   USERTYPE, ");
	    	logsql.append("	   NODEID, ");
	    	logsql.append("	   ISREMARK, ");
	    	logsql.append("	   WORKFLOWID, ");
	    	logsql.append("	   SHOWORDER, ");
	    	logsql.append("	   RECEIVEDATE, ");
	    	logsql.append("	   RECEIVETIME, ");
	    	logsql.append("	   VIEWTYPE, ");
	    	logsql.append("	   OPERATEDATE, ");
	    	logsql.append("	   OPERATETIME) ");
	    	logsql.append("	 values( ");
	    	logsql.append(requestid+",");
	    	logsql.append(userid+",");
	    	logsql.append(usertype+",");
	    	logsql.append(nodeid+",");
	    	logsql.append("'"+isremark+"',");
	    	logsql.append(workflowid+",");
	    	logsql.append("1,");
	    	logsql.append("'"+CurrentDate+"',");
	    	logsql.append("'"+CurrentTime+"',");
	    	logsql.append("1,");
	    	logsql.append("'"+CurrentDate+"',");
	    	logsql.append("'"+CurrentTime+"'");
	    	logsql.append(")");
			rs.executeSql(logsql.toString());
		}
    }
}
