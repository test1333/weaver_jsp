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
.td1{
	width:50px;
	text-align:center;
	padding:5px!important;
}
.xh{
	width:10px;
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

//姓名	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);	
	map.put("mzzd",SystemEnv.getHtmlLabelName(25034, user.getLanguage()));
	list.add(map);
}

//性别
String xb="-1";
if("男".equals(key)){
	xb="0";
}
if("女".equals(key)){
	xb="1";
}
rs.executeSql(" select id from uf_hq_cri_involpers where xb = '"+xb+"' ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);	
	map.put("mzzd",SystemEnv.getHtmlLabelName(416, user.getLanguage()));
	list.add(map);	
}

//年龄	
rs.executeSql(" select id from uf_hq_cri_involpers where age = "+key+" ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(671, user.getLanguage()));
	list.add(map);
}

//身高	
rs.executeSql(" select id from uf_hq_cri_involpers where height ='"+key+"' ");
while(rs.next()){
	String id=rs.getString("id");
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(1826, user.getLanguage()));
	list.add(map);
}

//身份证号/护照号	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(sfzh) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11140, user.getLanguage()));
	list.add(map);
}

//国籍	
rs.executeSql(" select id from uf_hq_cri_involpers where gj in ( select id from uf__hq_cri_countrys where Upper(gj) like '%'||Upper('"+key+"')||'%'  )  ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();
	map.put("sary",id);
	map.put("mzzd",SystemEnv.getHtmlLabelName(465, user.getLanguage()));
	list.add(map);
}

//联系方式	
rs.executeSql(" select t2.mainid  from  uf_hq_cri_involpers_dt1  t2 where Upper(t2.nr) like '%'||Upper('"+key+"')||'%'  ");
while(rs.next()){
	String id=rs.getString("mainid");
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11191, user.getLanguage()));
	list.add(map);
}

//工号	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(gh) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(1933, user.getLanguage()));
	list.add(map);	
}

//身份类型
rs.executeSql(" select id from uf_hq_cri_involpers where  sflx in ( select selectvalue from workflow_selectitem where fieldid=11871 and Upper(selectname) like '%'||Upper('"+key+"')||'%' )   ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11142, user.getLanguage()));
	list.add(map);
}


//所属部门	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(ssbm) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(127064, user.getLanguage()));
	list.add(map);	
}

//职位	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(zw) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(357, user.getLanguage()));
	list.add(map);
}

//工作履历	
rs.executeSql(" select mainid from uf_hq_cri_involpers_dt3  where Upper(gzkssj) like '%'||Upper('"+key+"')||'%' or Upper(gzjssj) like '%'||Upper('"+key+"')||'%' or  Upper(gsmc) like '%'||Upper('"+key+"')||'%'  or  Upper(zw1) like '%'||Upper('"+key+"')||'%'   ");
while(rs.next()){
	String id=rs.getString("mainid");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11631, user.getLanguage()));
	list.add(map);
}

//是否兼职	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(sfjz) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11157, user.getLanguage()));
	list.add(map);
}

//个人不良记录	
rs.executeSql(" select mainid from uf_hq_cri_involpers_dt2  where grbljl in ( select selectvalue from workflow_selectitem where fieldid=11876 and Upper(selectname) like '%'||Upper('"+key+"')||'%' ) or  Upper(nr) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("mainid");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11159, user.getLanguage()));
	list.add(map);
}

//其他	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(qt) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(25740, user.getLanguage()));
	list.add(map);
}

//所属案件	
rs.executeSql(" select id from uf_hq_cri_involpers where  Upper(ssajbt)  like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");	
	Map<String,String> map=new HashMap<String,String>();		
	map.put("sary",id);		
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11151, user.getLanguage()));
	list.add(map);
}

//关联人员	
rs2.executeSql(" select wm_concat(id) as glrystr from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%'  ");
if(rs2.next()){
	String glrystr=rs2.getString("glrystr");
	if(!"".equals(glrystr)){
		String array[]=glrystr.split(",");
		for(int i=0;i<array.length;i++){
			rs.executeSql("  select id from uf_hq_cri_involpers where instr(','||glry||','  ,  "+"',"+array[i]+",'"+"  )>0 ");
			while(rs.next()){
				String id=rs.getString("id");		
				Map<String,String> map=new HashMap<String,String>();			
				map.put("sary",id);			
				map.put("mzzd",SystemEnv.getHtmlLabelName(-11152, user.getLanguage()));
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
	String sary=(String)maptemp.get("sary");
	String dcy="";
	String mzzd=(String)maptemp.get("mzzd");
	rs.executeSql(" insert into uf_ajzhss(formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,keywords,ajID,mzzd,ssrq,sssj,UUID,ssr,xmbh,xmmc,dcqdrq,dcy,sary) "+
		" values ('1004','1','0','"+nowdate+"','"+time+"','"+key+"','"+dataid+"','"+mzzd+"','"+nowdate+"','"+nowtime+"','"+str+"','"+userid+"','"+xmbh+"','"+xmmc+"','"+dcqdrq+"','"+dcy+"' ,'"+sary+"'  ) ");
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
		<td align="left"  colspan="3" style="font-weight:bold;padding-left:20px;"><input type="hidden" id="person" value="<%=str%>"/><%=SystemEnv.getHtmlLabelName(-11595, user.getLanguage())%><span style="color:#30b5ff;">:&nbsp;<%=list.size()%></span>&nbsp;<%=SystemEnv.getHtmlLabelName(-11603, user.getLanguage())%>!</td>
	</tr>
	<%if(list.size()>0){%>
	<tr>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(126028, user.getLanguage())%></td>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11125, user.getLanguage())%></td>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11582, user.getLanguage())%></td>
	</tr>
	 <%
		int num=0;
		rs.executeSql(" select t2.id, t2.xm , t1.mzzd from uf_ajzhss t1, uf_hq_cri_involpers t2  where t1.uuid='"+str+"' and t1.sary=t2.id  order by t1.xmbh desc ");
		while(rs.next()){
			String id=rs.getString("id");
			String xm=rs.getString("xm");
			String mzzd=rs.getString("mzzd");
		%>		
			<tr class='rowcss <%if(num>5){out.print("hiderowperson");}%>' >
				<td class='xh' align='center'><%=num+1%></td>
				<td class='td1' align='center'><a  target="_blank" href='/formmode/view/AddFormMode.jsp?type=0&modeId=847&formId=-146&billid=<%=id%>&opentype=0&customid=843&viewfrom=fromsearchlist'><%=xm%></a></td>
				<td class='td1' align='center'><%=mzzd%></td>
			</tr>
		 <%
			num=num+1;
		}	
		if(list.size()>5){
		%>	
			<tr class='rowcss'  >
				<td class='td1'  colspan="3" align='center' >
					<input  id='showALLperson' type="button" value="<%=SystemEnv.getHtmlLabelName(20234, user.getLanguage())%>..." class="e8_btn_top_first" title="<%=SystemEnv.getHtmlLabelName(20234, user.getLanguage())%>..."  onclick="showALLperson()"  style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"/>
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