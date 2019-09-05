package gcl.doc.workflow;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;

public class DocUtil {
    BaseBean log = new BaseBean();
    String tablename = getBillTableName("CY");
    String wftablename = getWfTableName("CY");
    String tablenamemj = getBillTableName("MJ");
    String tablenamejjcd = getBillTableName("JJCD");

    public String getModeId(String tableName) {
        RecordSet rs = new RecordSet();
        String formid = "";
        String modeid = "";
        String sql = "select id from workflow_bill where tablename='" + tableName + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            formid = Util.null2String(rs.getString("id"));
        }
        sql = "select id from modeinfo where  formid=" + formid;
        rs.executeSql(sql);
        if (rs.next()) {
            modeid = Util.null2String(rs.getString("id"));
        }
        return modeid;
    }

    //测试机角色id = 306413 正式机角色id = 682918
    public String getCYButton(String requestid, String billid) {
        BaseBean log = new BaseBean();
        log.writeLog("billid=======" + billid);
        String[] temp = new String[0];
        if (billid.length() > 0) {
            temp = billid.split("\\+");
        }
        String id = temp[0];
        String ryid = temp[1];
        log.writeLog("id=======" + id);
        log.writeLog("ryid=======" + ryid);
        String buttonStr = "";
        int count = 0;
        RecordSet rs = new RecordSet();
//        String sql = "select count(1) as no from HrmRoleMembers where roleid=306413  and resourceid=" + ryid;
//        rs.executeSql(sql);
//        if (rs.next()) {
//            count = rs.getInt("no");
//        }
        String cyblr = "";
        String sql = "select * from " + tablename + " where id=" + id;
        rs.executeSql(sql);
        if (rs.next()) {
            cyblr = Util.null2String(rs.getString("bcjzzcyr"));
        }
        if(ryid.equals(cyblr)){
            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"sw('" + id + "')\" style='width:50px' value='收文'></input><br/>";
            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"cy('" + id + "')\" style='width:50px' value='传阅'></input><br/>";
            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"ycy('" + id + "')\" style='width:50px' value='已传阅'></input>";


//            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"cy('" + id + "')\" style='width:50px' value='传阅'></input>";
//            buttonStr = buttonStr + "&nbsp;&nbsp;" + "<input type=\"button\" id=\"but1\" onclick=\"ycy('" + id + "')\" style='width:50px' value='已传阅'></input>";
//            buttonStr = buttonStr + "&nbsp;&nbsp;" + "<input type=\"button\" id=\"but1\" onclick=\"sw('" + id + "')\" style='width:50px' value='收文'></input>";

        }
//        if (count > 0) {
//            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"cy('" + id + "')\" style='width:50px' value='传阅'></input>";
//            buttonStr = buttonStr + "&nbsp;&nbsp;" + "<input type=\"button\" id=\"but1\" onclick=\"ycy('" + id + "')\" style='width:50px' value='已传阅'></input>";
//        }
        return buttonStr;
    }

    /**
     * 已传阅列表按钮
     *
     * @param requestid
     * @param billid
     * @return
     */
    public String getCYButtonForDo(String requestid, String billid) {
        BaseBean log = new BaseBean();
        log.writeLog("billid=======" + billid);
        String[] temp = new String[0];
        if (billid.length() > 0) {
            temp = billid.split("\\+");
        }
        String id = temp[0];
        String ryid = temp[1];
        log.writeLog("id=======" + id);
        log.writeLog("ryid=======" + ryid);
        String buttonStr = "";
        int count = 0;
        RecordSet rs = new RecordSet();
//        String sql = "select count(1) as no from HrmRoleMembers where roleid=306413  and resourceid=" + ryid;
//        rs.executeSql(sql);
//        if (rs.next()) {
//            count = rs.getInt("no");
//        }
        String cyblr = "";
        String sql = "select * from " + tablename + " where id=" + id;
        rs.executeSql(sql);
        if (rs.next()) {
            cyblr = Util.null2String(rs.getString("bcjzzcyr"));
        }
        if(ryid.equals(cyblr)){
            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"sw('" + id + "')\" style='width:50px' value='收文'></input><br/>";
            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"cy('" + id + "')\" style='width:50px' value='传阅'></input>";

//            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"cy('" + id + "')\" style='width:50px' value='传阅'></input>";
//            buttonStr = buttonStr + "&nbsp;&nbsp;" +  "<input type=\"button\" id=\"but1\" onclick=\"sw('" + id + "')\" style='width:50px' value='收文'></input>";
        }
//        if (count > 0) {
//            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"cy('" + id + "')\" style='width:50px' value='传阅'></input>";
//        }
        return buttonStr;
    }

    /**
     * 删除流程
     *
     * @param requestid
     * @return
     */
    public String deleteRequest(String requestid, String ryid) {
        BaseBean log = new BaseBean();
        log.writeLog("billid=======" + ryid);

        String buttonStr = "";
        int count = 0;
        RecordSet rs = new RecordSet();
//        String sql = "select count(1) as no from HrmRoleMembers where roleid=306413  and resourceid=" + ryid;
//        rs.executeSql(sql);
//        if (rs.next()) {
//            count = rs.getInt("no");
//        }
        String cyblr = "";
        String sql = "select * from " + wftablename + " where requestid=" + requestid;
        rs.executeSql(sql);
        if (rs.next()) {
            cyblr = Util.null2String(rs.getString("CYZLCFQR"));
        }
        log.writeLog("sql=======" + sql);
        if(ryid.equals(cyblr)){
            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"deleterq('" + requestid + "')\" style='width:50px' value='删除'></input>";
        }
//        if (count > 0) {
//            buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"deleterq('" + requestid + "')\" style='width:50px' value='删除'></input>";
//        }
        return buttonStr;
    }

    /**
     * 获取表明
     *
     * @param type
     * @return
     */
    public String getBillTableName(String type) {
        RecordSet rs = new RecordSet();
        String billTableName = "";
        String sql = "select billtablename from doc_table_map where type='" + type + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            billTableName = Util.null2String(rs.getString("billtablename"));
        }
        return billTableName;
    }

    /**
     * 获取流程id
     *
     * @param type
     * @return
     */
    public String getWfid(String type) {
        RecordSet rs = new RecordSet();
        String wfid = "";
        String sql = "select WORKFLOWID from doc_table_map where type='" + type + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            wfid = Util.null2String(rs.getString("WORKFLOWID"));
        }
        return wfid;
    }

    /**
     * 传阅效率报表
     * 添加查看下下级按钮
     *
     * @param billid
     * @return
     */
    public String getEfficiencyButton(String requestid, String billid) {
        String buttonStr = "";
        buttonStr = buttonStr + "<input type=\"button\" id=\"but1\" onclick=\"shownext('" + billid + "'," + requestid + ")\" style='width:75px' value='查看下下级'></input>";
//		buttonStr = buttonStr + "&nbsp;&nbsp;"+"<input type=\"button\" id=\"but1\" onclick=\"ycy('"+billid+"')\" style='width:50px' value='已传阅'></input>";
        return buttonStr;
    }

    /**
     * 获取流程id
     *
     * @param type
     * @return
     */
    public String getWfTableName(String type) {
        RecordSet rs = new RecordSet();
        String tablename = "";
        String wfid = "";
        String sql = "select WORKFLOWID from doc_table_map where type='" + type + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            wfid = Util.null2String(rs.getString("WORKFLOWID"));
        }
        sql = " Select tablename From Workflow_bill Where id in (" + " Select formid From workflow_base Where id= " + wfid + ")";
        rs.execute(sql);
        if (rs.next()) {
            tablename = Util.null2String(rs.getString("tablename"));
        }
        return tablename;
    }
    /**
     * 描 述：采用分页的方式处理SQL 使用in的条件中超过1000条数据报 ORA-01795:列表中的最大表达式数为1000 问题
     *(每1000行做一次分页)
     *
     * @param ids
     * @return
     * @author xu_chang
     * @createDate 2015-10-28
     */
    /*public  StringBuffer appendWHERE(String ids)
    {
        StringBuffer where = new StringBuffer();

        //处理SQL 使用in的条件中超过1000条数据报 ORA-01795:列表中的最大表达式数为1000 问题
        String[] idss = ids.split(",");
        int count = idss.length / 1000;//循环数(相当于分页的页数)
//        System.out.println(count);
        log.writeLog("count======" + idss.length);
        int remainder = idss.length % 1000;//余数
        if (remainder == 0)
        {
            //余数为0直接取结果
            count = idss.length / 1000;
        }
        else
        {
            //有余数进1
            count = idss.length / 1000 + 1;
        }

        //参数 1000相当于每页显示1000行
        for (int i = 0; i < count; i++)
        {
            Set<String> set = new HashSet<String>();
            for (int j = (i * 1000); j < 1000 * (i + 1); j++)
            {
                //不能超过总页数
                if (j + 1 > idss.length)
                    break;

                set.add(idss[j]);
            }

            String setIds = converToSetString(set);
            if (i == 0)
            {
                where.append("REQUESTID IN " + setIds + " \n");
            }
            else
            {
                where.append("OR REQUESTID IN " + setIds + " \n");

            }

        }

        return where;
    }
    /**
     * 描 述：将set集合转换为带()的set集合string
     *
     * @param set
     * @return
     * @author xu_chang
     * @createDate 2015-10-28
     */
    /*public static String converToSetString(Set<String> set)
    {
        return set.toString().replace("[", "(").replace("]", ")");
    }*/

}
