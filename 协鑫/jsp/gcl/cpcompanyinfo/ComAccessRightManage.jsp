<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.docs.category.CategoryUtil" %>
<%@ page import="weaver.docs.category.security.AclManager" %>
<%@ page import="java.util.HashMap" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%@ include file="/systeminfo/init.jsp" %>

<%
String method = Util.null2String(request.getParameter("method"));
String from = Util.null2String(request.getParameter("from"));
String companyids = Util.null2String(request.getParameter("ids"));
//System.out.println("from:"+from);
//System.out.println("companyids:"+companyids);
int comid = Util.getIntValue(Util.null2String(request.getParameter("comid")));//公司id
int opertype = Util.getIntValue(Util.null2String(request.getParameter("opertype")));
String rid=Util.null2String(request.getParameter("rid"));//待批量的公司id
String rsid[]=rid.split(",");
List list=new ArrayList();
list.add(comid+"");
if("batchshare".equals(from)){
    rid=companyids;
    rsid=companyids.split(",");
}
for(int i=0;i<rsid.length;i++)
{
	if(!(rsid[i]+"").equals(comid+"")&&!"".equals(rsid[i]))
	{
		list.add(rsid[i]);
	}
}
AclManager am = new AclManager();

	/*if (!HrmUserVarify.checkUserRight("DocSecCategoryEdit:Edit", user) && !am.hasPermission(dirid, categorytype, user, AclManager.OPERATION_CREATEDIR)) {
		response.sendRedirect("/notice/noright.jsp");
		return;
	}*/
if (method.equals("add")) {
    opertype = Util.getIntValue(Util.null2String(request.getParameter("opertype")));
    int permtype = Util.getIntValue(Util.null2String(request.getParameter("permtype")));
    int seclevel = Util.getIntValue(Util.null2String(request.getParameter("seclevel")));
	int tempComrright=opertype;//1是公司资源管理区后台维护权限|2是公司资源管理区证照维护权限..
	int tempPermtype=permtype;//1,部门+安全级别,3表示安全级别,6分部+安全级别,2角色+安全级别+级别,4用户类型+安全级别|5人力资源
	int tempSeclevel=seclevel;//安全级别数量
	int tempSubcomid=-1;//分部id
	int tempDepid=-1;//部门id
	int tempRoleId=-1;//角色id
	int tempRoleLevel=-1;//角色级别
	int tempUserId=-1;//用户id
	int tempUserType=0;//用户种类	
	String temcomallright= Util.null2String(request.getParameter("comallright"));//是否为全局的公司资料模块权限,1是全局的，0不是全局的

	

    switch (permtype) {
        case 1:
        /* for TD.4240 edited by wdl(增加多部门) */
        int ismutil = Util.getIntValue(Util.null2o(request.getParameter("mutil")));
        if(ismutil!=0) {
            String tempStrs[] = Util.TokenizerString2(Util.null2String(request.getParameter("departmentid")),",");
            for(int k=0;k<tempStrs.length;k++){
                int departmentid = Util.getIntValue(Util.null2o(tempStrs[k]));
                if(departmentid>0){
                    tempDepid=departmentid;  
                    
                    for(int j=0;j<list.size();j++)
                    {
	                    String sql="insert into cpcominforight (comid,comrright,permtype,seclevel,subcomid,depid,roleid,userid,rolelevel,usertype,comallright) values ";               
	                    sql+="("+list.get(j)+","+tempComrright+","+permtype+","+seclevel+","+tempSubcomid+","+tempDepid+","+tempRoleId+","+tempUserId+","+tempRoleLevel+","+tempUserType+","+temcomallright+")";
                        System.out.println("sql:"+sql);
	                    RecordSet.executeSql(sql);                    
                	}
				}
            }

            
        } else {	
        		 	for(int j=0;j<list.size();j++)
                    {
	        			String sql="insert into cpcominforight (comid,comrright,permtype,seclevel,subcomid,depid,roleid,userid,rolelevel,usertype,comallright) values ";               
	           	 		tempDepid = Util.getIntValue(Util.null2String(request.getParameter("departmentid")));
	                    sql+="("+list.get(j)+","+tempComrright+","+permtype+","+seclevel+","+tempSubcomid+","+tempDepid+","+tempRoleId+","+tempUserId+","+tempRoleLevel+","+tempUserType+","+temcomallright+")";
	                    RecordSet.executeSql(sql);
                    }
        }
        /* end */
        break;

        case 6:
            int ismutilsub = Util.getIntValue(Util.null2o(request.getParameter("mutil")));
            if(ismutilsub!=0) {
                String tempStrs[] = Util.TokenizerString2(Util.null2String(request.getParameter("subcompanyid")),",");
                for(int k=0;k<tempStrs.length;k++){
                    int subcompanyid = Util.getIntValue(Util.null2o(tempStrs[k]));
                    if(subcompanyid>0){
                    	 for(int j=0;j<list.size();j++)
                    	{
	                    	String sql="insert into cpcominforight (comid,comrright,permtype,seclevel,subcomid,depid,roleid,userid,rolelevel,usertype,comallright) values ";               
							tempSubcomid=subcompanyid;
		                    sql+="("+list.get(j)+","+tempComrright+","+permtype+","+seclevel+","+tempSubcomid+","+tempDepid+","+tempRoleId+","+tempUserId+","+tempRoleLevel+","+tempUserType+","+temcomallright+")";
	                    	RecordSet.executeSql(sql);
                    	}
	                   
					}
                }

                
            } else {
			
			  for(int j=0;j<list.size();j++)
              {
	  				String sql="insert into cpcominforight (comid,comrright,permtype,seclevel,subcomid,depid,roleid,userid,rolelevel,usertype,comallright) values ";               
	                int subcompanyid = Util.getIntValue(Util.null2String(request.getParameter("subcompanyid")));
					tempSubcomid=subcompanyid;
		            sql+="("+comid+","+tempComrright+","+permtype+","+seclevel+","+tempSubcomid+","+tempDepid+","+tempRoleId+","+tempUserId+","+tempRoleLevel+","+tempUserType+","+temcomallright+")";
	                RecordSet.executeSql(sql);
               }
	                    
                
            }
            break;
        
        case 2:        
       			    int roleid = Util.getIntValue(Util.null2String(request.getParameter("roleid")));
        		    int rolelevel = Util.getIntValue(Util.null2String(request.getParameter("rolelevel")));
				    tempRoleId=roleid;
		            tempRoleLevel=rolelevel;
		             for(int j=0;j<list.size();j++)
             		 {		         
					    String sql="insert into cpcominforight (comid,comrright,permtype,seclevel,subcomid,depid,roleid,userid,rolelevel,usertype,comallright) values ";               
					    sql+="("+list.get(j)+","+tempComrright+","+permtype+","+seclevel+","+tempSubcomid+","+tempDepid+","+tempRoleId+","+tempUserId+","+tempRoleLevel+","+tempUserType+","+temcomallright+")";
	                    RecordSet.executeSql(sql);   
                     }      
        		    break;
        case 3:
        		 for(int j=0;j<list.size();j++)
             		 {	
		        		String sql="insert into cpcominforight (comid,comrright,permtype,seclevel,subcomid,depid,roleid,userid,rolelevel,usertype,comallright) values ";               
					 	sql+="("+list.get(j)+","+tempComrright+","+permtype+","+seclevel+","+tempSubcomid+","+tempDepid+","+tempRoleId+","+tempUserId+","+tempRoleLevel+","+tempUserType+","+temcomallright+")";
		                RecordSet.executeSql(sql);
                	}
        		break;
        case 4:
        	 for(int j=0;j<list.size();j++)
             {	
	        		String sql="insert into cpcominforight (comid,comrright,permtype,seclevel,subcomid,depid,roleid,userid,rolelevel,usertype,comallright) values ";               
	        		int usertype = Util.getIntValue(Util.null2String(request.getParameter("usertype")));
					tempUserType=usertype;
	     		 	sql+="("+list.get(j)+","+tempComrright+","+permtype+","+seclevel+","+tempSubcomid+","+tempDepid+","+tempRoleId+","+tempUserId+","+tempRoleLevel+","+tempUserType+","+temcomallright+")";
	                RecordSet.executeSql(sql);
              }
        break;
        case 5:
        String[] tmpuserid = Util.TokenizerString2(Util.null2String(request.getParameter("userid")),",");
        int userid = 0;
        for(int i=0;tmpuserid!=null&&tmpuserid.length>0&&i<tmpuserid.length;i++){
        	userid = Util.getIntValue(tmpuserid[i]);
        	if(userid>0){
        	
        	for(int j=0;j<list.size();j++)
             {	
        		String sql="insert into cpcominforight (comid,comrright,permtype,seclevel,subcomid,depid,roleid,userid,rolelevel,usertype,comallright) values ";               
				tempUserId=userid;
				sql+="("+list.get(j)+","+tempComrright+","+permtype+","+seclevel+","+tempSubcomid+","+tempDepid+","+tempRoleId+","+tempUserId+","+tempRoleLevel+","+tempUserType+","+temcomallright+")";
                RecordSet.executeSql(sql);
              }
              
			}
        }
        
        break;
    }
    

      //out.println("<SCRIPT language='JavaScript'>");
	  //out.println("parent.location.href='/strateOperat/resDir/resDirAccessRightList.jsp?dirid=="+dirid+"';");
	  //out.println("parent.location.reload();");
	  //out.println("</SCRIPT>");
      out.println("<SCRIPT type='text/javascript'>");
	 out.println("window.parent.returnValue='1';window.parent.close();");
	  out.println("</SCRIPT>"); 
} else if (method.equals("delete")) {//删除权限
  

	String ids = Util.null2String(request.getParameter("ids"));
	String showjsp=Util.null2String(request.getParameter("showjsp"));
    int id = Util.getIntValue(Util.null2String(request.getParameter("id")));

	
    if(ids!=null&&!"".equals(ids)){
    	String[] tids = Util.TokenizerString2(ids,",");
    	for(int i=0;tids!=null&&tids.length>0&&i<tids.length;i++){
			RecordSet.executeSql("delete from cpcominforight where id="+tids[i]);
		}
    } else {
		RecordSet.executeSql("delete from cpcominforight where id="+id);
    }
    if("1".equals(showjsp))
    {
    	
    	response.sendRedirect("/cpcompanyinfo/CommanagerTreeRight.jsp");
    }else
    {
    	response.sendRedirect("/cpcompanyinfo/Comcheckright.jsp?comid="+comid);
    }
}
	
%>

