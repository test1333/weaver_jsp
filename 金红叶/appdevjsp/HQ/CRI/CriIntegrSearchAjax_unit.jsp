<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.file.ExcelStyle" %>
<%@ page import="weaver.file.ExcelSheet" %>
<%@ page import="weaver.file.ExcelRow" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.formmode.setup.ModeRightInfo" %>
<%@ page import="weaver.hrm.resource.ResourceComInfo" %>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page" />
<style type="text/css">
.rowcss:hover{
  background:#f8f8f8;
}
table{
	width:100%;
}
.xh{
	width:10px;
	text-align:center;
	padding:5px!important;
}
.td1{
	width:50px;
	text-align:center;
	padding:5px!important;
}
.td2{
	width:20px;
	text-align:center;
	font-weight:bold;
	background-color:#f8f8f8;
}
</style>
<%
String key = Util.null2String(request.getParameter("key"));
String nowdate=TimeUtil.getCurrentDateString();
String nowtime=TimeUtil.getCurrentTimeString();
String time = nowtime.substring(11,nowtime.length());
nowtime = nowtime.substring(11,16);
String userid=user.getUID()+"";
List<Map<String,String>> list=new ArrayList<Map<String,String>>();	

//公司名称	
rs.executeSql(" select * from uf_hq_cri_involcomp where Upper(gsmc) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	Map<String,String> map=new HashMap<String,String>();
	String id=rs.getString("id");		
	map.put("sadw",id);	
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11161, user.getLanguage()));
	list.add(map);
}

//统一社会信用代码/注册号	
rs.executeSql(" select id from uf_hq_cri_involcomp where Upper(zch)  like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	Map<String,String> map=new HashMap<String,String>();
	String id=rs.getString("id");		
	map.put("sadw",id);	
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11174, user.getLanguage()));
	list.add(map);
}

//单位类型	
rs.executeSql(" select id from uf_hq_cri_involcomp where dwlx in ( select selectvalue from workflow_selectitem where Upper(selectname) like '%'||Upper('"+key+"')||'%' and fieldid=11859 )  ");
while(rs.next()){
	Map<String,String> map=new HashMap<String,String>();
	String id=rs.getString("id");	
	map.put("sadw",id);	
	map.put("mzzd",SystemEnv.getHtmlLabelName(22880, user.getLanguage()));
	list.add(map);
}

//联系电话
rs.executeSql(" select id from uf_hq_cri_involcomp where Upper(lxdh)  like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	Map<String,String> map=new HashMap<String,String>();
	String id=rs.getString("id");	
	map.put("sadw",id);	
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11176, user.getLanguage()));
	list.add(map);
}

//注册地址	
rs.executeSql(" select id from uf_hq_cri_involcomp where Upper(dz)  like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	Map<String,String> map=new HashMap<String,String>();
	String id=rs.getString("id");	
	map.put("sadw",id);	
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11177, user.getLanguage()));
	list.add(map);
}

//实际运营地址	
rs.executeSql(" select id from uf_hq_cri_involcomp where Upper(sjyydz)  like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	Map<String,String> map=new HashMap<String,String>();
	String id=rs.getString("id");		
	map.put("sadw",id);	
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11190, user.getLanguage()));
	list.add(map);	
}

//法人	
rs2.executeSql(" select wm_concat(id) as frstr from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
if(rs2.next()){
	String frstr=rs2.getString("frstr");
	if(!"".equals(frstr)){
		String array[]=frstr.split(",");
		for(int i=0;i<array.length;i++){
			rs.executeSql(" select id from uf_hq_cri_involcomp t1  where  instr(','||t1.fr||',' , "+"',"+array[i]+",'"+" )>0  ");
			while(rs.next()){
				Map<String,String> map=new HashMap<String,String>();
				String id=rs.getString("id");		
				map.put("sadw",id);		
				map.put("mzzd",SystemEnv.getHtmlLabelName(-11183, user.getLanguage()));
				list.add(map);		
			}
		}
	}
}

//股东
rs2.executeSql(" select wm_concat(id) as gdstr from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
if(rs2.next()){
	String gdstr=rs2.getString("gdstr");
	if(!"".equals(gdstr)){
		String array[]=gdstr.split(",");
		for(int i=0;i<array.length;i++){
			rs.executeSql(" select id from uf_hq_cri_involcomp t1 where  instr(','||t1.gd||',' , "+"',"+array[i]+",'"+" )>0  ");
			while(rs.next()){
				Map<String,String> map=new HashMap<String,String>();
				String id=rs.getString("id");	
				map.put("sadw",id);		
				map.put("mzzd",SystemEnv.getHtmlLabelName(28421, user.getLanguage()));
				list.add(map);
			}
		}
	}
}


//组织机构代码
rs.executeSql(" select id from uf_hq_cri_involcomp where Upper(zzjgdm)  like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	Map<String,String> map=new HashMap<String,String>();
	String id=rs.getString("id");	
	map.put("sadw",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(27324, user.getLanguage()));
	list.add(map);
}

//联系人	
rs2.executeSql(" select wm_concat(id) as lxrstr from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
if(rs2.next()){
	String lxrstr=rs2.getString("lxrstr");
	if(!"".equals(lxrstr)){
		String array[]=lxrstr.split(",");
		for(int i=0;i<array.length;i++){
			rs.executeSql(" select id from uf_hq_cri_involcomp t1  where  instr(','||t1.lxr||',' , "+"',"+array[i]+",'"+" )>0  ");
			while(rs.next()){
				Map<String,String> map=new HashMap<String,String>();
				String id=rs.getString("id");		
				map.put("sadw",id);			
				map.put("mzzd",SystemEnv.getHtmlLabelName(-11185, user.getLanguage()));
				list.add(map);
			}
		}
	}
}

//联系方式
rs.executeSql(" select id from uf_hq_cri_involcomp where Upper(lxfs)  like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	Map<String,String> map=new HashMap<String,String>();
	String id=rs.getString("id");		
	map.put("sadw",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(24982, user.getLanguage()));
	list.add(map);
}

//备注	
rs.executeSql(" select id from uf_hq_cri_involcomp where Upper(bz)  like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	Map<String,String> map=new HashMap<String,String>();
	String id=rs.getString("id");		
	map.put("sadw",id);
	map.put("mzzd",SystemEnv.getHtmlLabelName(26408, user.getLanguage()));
	list.add(map);
}

//所属人员	
rs2.executeSql(" select wm_concat(id) as ssryrstr from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
if(rs2.next()){
	String ssryrstr=rs2.getString("ssryrstr");
	if(!"".equals(ssryrstr)){
		String array[]=ssryrstr.split(",");
		for(int i=0;i<array.length;i++){
			rs.executeSql(" select id from uf_hq_cri_involcomp t1  where  instr(','||t1.ssry||',' , "+"',"+array[i]+",'"+"  )>0  ");
			while(rs.next()){
				Map<String,String> map=new HashMap<String,String>();
				String id=rs.getString("id");			
				map.put("sadw",id);			
				map.put("mzzd",SystemEnv.getHtmlLabelName(-11186, user.getLanguage()));
				list.add(map);
			}
		}
	}
}

//所属案件	
rs2.executeSql(" select wm_concat(id) as ssajstr from uf_hq_cri_casedp where Upper(xmmc) like '%'||Upper('"+key+"')||'%'  ");
if(rs2.next()){
	String ssajstr=rs2.getString("ssajstr");
	if(!"".equals(ssajstr)){
		String array[]=ssajstr.split(",");
		for(int i=0;i<array.length;i++){
			rs.executeSql(" select id from uf_hq_cri_involcomp t1 where  instr(','||t1.ssaj||',' ,"+"',"+array[i]+",'"+" )>0  ");
			while(rs.next()){
				Map<String,String> map=new HashMap<String,String>();
				String id=rs.getString("id");		
				map.put("sadw",id);			
				map.put("mzzd",SystemEnv.getHtmlLabelName(-11151, user.getLanguage()));
				list.add(map);		
			}
		}
	}
}

//其他关联人员	
rs2.executeSql(" select wm_concat(id) as qtglrystr from uf_hq_cri_involpers where Upper(name) like '%'||Upper('"+key+"')||'%' ");
if(rs2.next()){
	String qtglrystr=rs2.getString("qtglrystr");
	if(!"".equals(qtglrystr)){
		String array[]=qtglrystr.split(",");
		for(int i=0;i<array.length;i++){
			rs.executeSql(" select id from uf_hq_cri_involcomp t1 where  instr(','||t1.qtglry||',' , "+"',"+array[i]+",'"+" )>0  ");
			while(rs.next()){
				Map<String,String> map=new HashMap<String,String>();
				String id=rs.getString("id");		
				map.put("sadw",id);			
				map.put("mzzd",SystemEnv.getHtmlLabelName(-11187, user.getLanguage()));
				list.add(map);		
			}
		}
	}
}


//关联单位	
rs2.executeSql(" select wm_concat(id) as gldwstr from uf_hq_cri_involcomp where Upper(gsmc) like '%'||Upper('"+key+"')||'%'  ");
if(rs2.next()){
	String gldwstr=rs2.getString("gldwstr");
	if(!"".equals(gldwstr)){
		String array[]=gldwstr.split(",");
		for(int i=0;i<array.length;i++){
			rs.executeSql(" select id from uf_hq_cri_involcomp t1 where  instr(','||t1.gldw||',' , "+"',"+array[i]+",'"+" )>0  ");
			while(rs.next()){
				Map<String,String> map=new HashMap<String,String>();
				String id=rs.getString("id");		
				map.put("sadw",id);			
				map.put("mzzd",SystemEnv.getHtmlLabelName(-11188, user.getLanguage()));
				list.add(map);		
			}
		}
	}
}


//其他关联案件
rs2.executeSql(" select wm_concat(id) as qtglajstr from uf_hq_cri_casedp where Upper(xmmc) like '%'||Upper('"+key+"')||'%'  ");
if(rs2.next()){
	String qtglajstr=rs2.getString("qtglajstr");
	if(!"".equals(qtglajstr)){
		String array[]=qtglajstr.split(",");
		for(int i=0;i<array.length;i++){
			rs.executeSql(" select id from uf_hq_cri_involcomp t1 where  instr(','||t1.qtglaj||',' , "+"',"+array[i]+",'"+" )>0  ");
			while(rs.next()){
				Map<String,String> map=new HashMap<String,String>();
				String id=rs.getString("id");			
				map.put("sadw",id);			
				map.put("mzzd",SystemEnv.getHtmlLabelName(-11154, user.getLanguage()));
				list.add(map);
			}
		}
	}
}

UUID uuid = UUID.randomUUID();  
String str = uuid.toString();  
for(int i=0;i<list.size();i++){
	Map<String,String> maptemp=(Map<String,String>)list.get(i);
	String dataid="";
	String xmbh="";
	String xmmc="";
	String dcqdrq="";
	String dcy="";
	String mzzd=(String)maptemp.get("mzzd");
	String sadw=(String)maptemp.get("sadw");
	rs.executeSql(" insert into uf_ajzhss(formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,keywords,ajID,mzzd,ssrq,sssj,UUID,ssr,xmbh,xmmc,dcqdrq,dcy,sadw) "+
		" values ('1004','1','0','"+nowdate+"','"+time+"','"+key+"','"+dataid+"','"+mzzd+"','"+nowdate+"','"+nowtime+"','"+str+"','"+userid+"','"+xmbh+"','"+xmmc+"','"+dcqdrq+"','"+dcy+"' ,'"+sadw+"'  ) ");
	rs.executeSql(" select max(id) as maxid from uf_ajzhss ");
	if(rs.next()){
		int maxid=rs.getInt("maxid");
		ModeRightInfo rightinfo = new ModeRightInfo();
		rightinfo.editModeDataShare(1,1004,maxid);
	}
}

%>
 <table border="1px" bordercolor="#e6e6e6" cellspacing="0px" style="border-collapse:collapse">
	<tr>
		<td align="left"  colspan="3" style="font-weight:bold;padding-left:20px;"><input type="hidden" id="unit" value="<%=str%>"/><%=SystemEnv.getHtmlLabelName(-11595, user.getLanguage())%><span style="color:#30b5ff;">:&nbsp;<%=list.size()%></span>&nbsp;<%=SystemEnv.getHtmlLabelName(-11603, user.getLanguage())%>!</td>
	</tr>
	<%if(list.size()>0){%>
	<tr>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(126028, user.getLanguage())%></td>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11126, user.getLanguage())%></td>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11582, user.getLanguage())%></td>
	</tr>
	 <%
		int num=0;
		rs.executeSql(" select t2.id, t2.gsmc , t1.mzzd from uf_ajzhss t1, uf_hq_cri_involcomp t2 where t1.uuid='"+str+"' and t1.sadw=t2.id  order by xmbh desc ");
		while(rs.next()){
			String id=rs.getString("id");
			String gsmc=rs.getString("gsmc");
			String mzzd=rs.getString("mzzd");
		%>		
			<tr class='rowcss <%if(num>5){out.print("hiderowunit");}%>' >
				<td class='xh' align='center'><%=num+1%></td>
				<td class='td1' align='center'><a  target="_blank" href='/formmode/view/AddFormMode.jsp?type=0&modeId=845&formId=-145&billid=<%=id%>&opentype=0&customid=842&viewfrom=fromsearchlist'><%=gsmc%></a></td>
				<td class='td1' align='center'><%=mzzd%></td>
			</tr>
		 <%
			num=num+1;
		}	
		if(list.size()>5){
		%>	
			<tr class='rowcss'  >
				<td class='td1'  colspan="3" align='center' >
					<input  id='showALLunit' type="button" value="<%=SystemEnv.getHtmlLabelName(20234, user.getLanguage())%>..." class="e8_btn_top_first" title="<%=SystemEnv.getHtmlLabelName(20234, user.getLanguage())%>..."  onclick="showALLunit()"  style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"/>
				</td>
			</tr>
		<%
		}
	}
		%>		
</table>
<%!
public String getLastname(String dcy){
	String dcyname="";
	if(!"".equals(dcy.trim())){
		RecordSet rs=new RecordSet();
		rs.executeSql(" select wm_concat(lastname) dcyname from hrmresource where workcode in ("+dcy+") ");
		if(rs.next()){
			dcyname=rs.getString("dcyname");
		}
	}
	return dcyname;
}
%>