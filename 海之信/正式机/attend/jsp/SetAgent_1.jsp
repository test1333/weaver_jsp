<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="seahonor.util.InsertUtil" %>
<%@ page import="java.util.*,weaver.hrm.appdetach.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs3" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs4" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs6" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="DocViewer" class="weaver.docs.docs.DocViewer" scope="page" />
<jsp:useBean id="wfAgentCondition" class="weaver.workflow.request.wfAgentCondition" scope="page" />
<%
    String sql = "";
    String ids = request.getParameter("id");
    int userid = user.getUID();
    String tableName = "";
    String tableNameSet = "";
    String currentid = "";
    String workflowid = "";
    String tmp_agent = "";
    int num_SetFirst = 0;
    int num_SetSecond = 0;
    int usertype = Util.getIntValue(request.getParameter("usertype"), 0);
    Boolean isAgentFirst = false;
    Boolean isAgentSecond = false;
    boolean flag = true; 
    String infoKey = "";
    out.print("ids="+ids+"0");
    if(!"".equals(ids)){
        //获取需要操作的记录
    	String tmp_ids = ids + "0";
        sql = " select id,authorizer,agentFirst,agentSecond,agentWorkflow,requestid,status from uf_start_Authorize "
            +" where id in("+tmp_ids+") and authorizer= "+userid;
        rs.executeSql(sql);
        out.print("sql1="+sql);
        while(rs.next()){
            String uf_id = Util.null2String(rs.getString("id"));
            String empid = Util.null2String(rs.getString("authorizer"));
            String agentFirst = Util.null2String(rs.getString("agentFirst"));
            String agentSecond = Util.null2String(rs.getString("agentSecond"));
            String agentWorkflow = Util.null2String(rs.getString("agentWorkflow"));
            String requestid = Util.null2String(rs.getString("requestid"));
            String status = Util.null2String(rs.getString("status"));
 
                String isCountermandRunning="y";
                String aid=request.getParameter("aid");
           
                try{
                    //收回流转中的代理 对于老数据不做处理, 当一个代理人又是操作者本身时很难区分
                    if("y".equals(isCountermandRunning)){
                        rs6.executeSql("select agentuid from workflow_agentConditionSet where bagentuid='"+empid+"' and agenttype=1 ");
                        out.print("|rs6");
                        //将所有收回
                        while(rs6.next()){
                            aid=Util.getIntValues(rs6.getString("agentuid"));
                            String updateSQL = "";
                            rs1.executeSql("select * from workflow_currentoperator where isremark in ('0','1','5','7','8','9')  and userid = " + aid + " and agentorbyagentid = " + empid + " and agenttype = '2'");//td2302 xwj
                                while(rs1.next()){
                                    int wfcoid = Util.getIntValue(rs1.getString("id"));
                                    String tmprequestid=rs1.getString("requestid");
                                    String tmpisremark=rs1.getString("isremark");
                                    int tmpgroupid=rs1.getInt("groupid");
                                    int currentnodeid = rs1.getInt("nodeid");//流程当前所在节点
        
                                    int tmpuserid=rs1.getInt("userid");
                                    String tmpusertype=rs1.getString("usertype");
                                    int tmppreisremark=Util.getIntValue(rs1.getString("preisremark"),0);
                                    int upcoid = 0;
                                    rs2.execute("select id from workflow_currentoperator where requestid = " + tmprequestid + " and isremark = '2' and userid = " + rs1.getString("agentorbyagentid") + " and agenttype = '1' and agentorbyagentid = " + tmpuserid +" and usertype=0 and groupid="+tmpgroupid+" and nodeid="+currentnodeid);
                                    if(rs2.next()){
                                        upcoid = Util.getIntValue(rs2.getString("id"));
                                        updateSQL = "update workflow_currentoperator set isremark = '" + tmpisremark + "',preisremark='"+tmppreisremark+"', agenttype ='0', agentorbyagentid = -1  where id="+upcoid;
                                        //应该只更新当前节点的代理关系，已经经过的节点不用更新
                                        rs2.executeSql(updateSQL);  //被代理人重新获得任务
                                        //失效的代理人删除
                                        rs2.executeSql("delete workflow_currentoperator where id="+wfcoid);//td2302 xwj
                                        rs2.executeSql("update workflow_forward set beforwardid = " + upcoid + " where requestid="+tmprequestid+" and beforwardid="+wfcoid);
                                        rs2.executeSql("update workflow_forward set forwardid = " + upcoid + " where requestid="+tmprequestid+" and forwardid="+wfcoid);
                                    }
                                    PoppupRemindInfoUtil.updatePoppupRemindInfo(tmpuserid,10,tmpusertype,Util.getIntValue(tmprequestid));
                                    PoppupRemindInfoUtil.updatePoppupRemindInfo(tmpuserid,0,tmpusertype,Util.getIntValue(tmprequestid));
                                    //add by fanggsh 20060519 TD4346 begin 流程代理收回导致操作人查不到流程
                                    rs3.executeSql("select id from workflow_currentoperator where requestid ="+tmprequestid+" and userid="+tmpuserid+" and usertype="+usertype+" order by id desc ");
                                    if(rs3.next()){
                                        rs2.executeSql("update workflow_currentoperator set islasttimes=1 where requestid=" +tmprequestid + " and userid=" + tmpuserid + " and id = " + rs3.getString("id"));
                                    }
                                    //add by fanggsh 20060519 TD4346 end
                    
                                    //回收代理人文档权限
        
                                    rs2.executeSql("select distinct docid,sharelevel from Workflow_DocShareInfo where requestid="+tmprequestid+" and userid="+aid+" and beAgentid="+empid);
                                    boolean hasrow=false;
                                    ArrayList docslist=new ArrayList();
                                    ArrayList sharlevellist=new ArrayList();
                                    while(rs2.next()){
                                        hasrow=true;
                                        docslist.add(rs2.getString("docid"));
                                        sharlevellist.add(rs2.getString("sharelevel"));
                                    }
                                    if(hasrow){
                                        rs2.executeSql("delete Workflow_DocShareInfo where requestid="+tmprequestid+" and userid="+aid+" and beAgentid="+empid);
                                    }
                                    for(int j=0;j<docslist.size();j++){
                                        rs3.executeSql("select Max(sharelevel) sharelevel from Workflow_DocShareInfo where docid="+docslist.get(j)+" and userid="+aid);
                                        if(rs3.next()){
                                            int sharelevel=Util.getIntValue(rs3.getString("sharelevel"),0);
                                            if(sharelevel>0){
                                                res.executeSql("update DocShare set sharelevel="+sharelevel+" where sharesource=1 and docid="+docslist.get(j)+" and userid="+aid+" and sharelevel>"+sharelevel);
                                            }else{
                                                res.executeSql("delete DocShare where sharesource=1 and docid="+docslist.get(j)+" and userid="+aid);
                                            }
                                        }else{
                                            res.executeSql("delete DocShare where sharesource=1 and docid="+docslist.get(j)+" and userid="+aid);
                                        }
                                        //重新赋予被代理人文档权限
                                        res.executeSql("update DocShare set sharelevel="+sharlevellist.get(j)+" where sharesource=1 and docid="+docslist.get(j)+" and userid="+empid);
                                        DocViewer.setDocShareByDoc((String)docslist.get(j));
                                    }   
                                    //end by mackjoe
                                }
                        }
                    }
                    
                    //设置无效状态
        
                wfAgentCondition.SetbackAgent(""+empid,""+aid);
                    
                //通过默认的工作流提醒 
                //TODO
                }catch(Exception e){
                    flag = false;
                }
                if(flag){
                    sql = " update uf_start_Authorize set status = 0 where id= "+uf_id;
                    res.executeSql(sql);
                    infoKey = "3";
                }else{
                    infoKey = "4";
                }
            }
}
    
    response.sendRedirect("/seahonor/attend/jsp/SH_Set_Agent_info_1.jsp?infoKey="+infoKey+" ");
%>
