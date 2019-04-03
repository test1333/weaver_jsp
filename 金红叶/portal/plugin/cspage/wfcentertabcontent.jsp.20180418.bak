<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>

<%@ page import="weaver.page.interfaces.*"%>
<%@ page import="weaver.page.interfaces.commons.*"%>

<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.User"%>

<%@ page import="weaver.general.*"%>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<% 
//
//	tab 为 tab页默认参数，请根据实际情况传值
	
//	此页面输出如下html代码，请保证class不要修改
	
//	wfcentericon1,wfcentericon2  数字根据顺序生成
	
//	url 请填写对应打开的连接

String tab = Util.null2String(request.getParameter("tab"),"1");
String lang = Util.null2String(request.getParameter("lang"),"7");
%>

<div id="container">	
	<div id="workCenterFlex" class='flexslider_' style="height: 255px;">
		<ul class='slides' style="height: 255px;">
			<%
		int count = 1;
		
		User user = HrmUserVarify.getUser (request , response);
		int departmentid = Util.getIntValue(resourceComInfo.getDepartmentID(""+user.getUID()), -1);
		int subcompanyid = Util.getIntValue(resourceComInfo.getSubCompanyID(""+user.getUID()), -1);
				
		rs.executeSql("select cjfl from uf_ksgzlm where id = '" + tab + "'");
		if(rs.next()){
			tab = rs.getString("cjfl");
		}
				 
		String sql = "";
		sql = "select u.wfid,u.cjurl,b.title from uf_ksgzlm u left join uf_ksgzlm_dt2 b on u.id = b.mainid"
			+" where u.sffc=1 and b.dyybq='名称' and b.title is not null and u.cjfl = '"+ tab +"' and b.lanid="+ lang
			+" and (((','||u.dfb||',') like '%,"+subcompanyid+",%' ) or ( (','||u.dbm||',') like '%,"+departmentid+",%') or ((','||to_char(u.drl)||',') like '%,"+user.getUID()
			+",%') or (exists(select h.id from hrmrolemembers h where (','||u.role||',') like ('%,'||h.roleid||',%') and h.resourceid="+user.getUID()+"))) order by u.xorder asc";
		rs.executeSql(sql);	
		while(rs.next()){
			String wfid = rs.getString("wfid");
			String cjurl = rs.getString("cjurl");
			String title = rs.getString("title");
			String tp = rs.getString("tp");
			String name = "";
			String cjms = "";
 			if(title.contains("|")){
 				String[] temp = title.split("\\|");
 				name = temp[0];
				if(temp.length > 1){
					cjms = temp[1];
				} 				
 			}
 			else{
 				name = rs.getString("title");
 			}
		
		//做成slider，每六个流程一组
		if(count%9 == 1){
		%>
			<li style="cursor: default;">
				<%
		}
		%>
				<div class="wrcenteritem">
					<%
						String pic = "background-image: url(/portal/plugin/images/opzm/icon.png);";
						//if(tp.length()!=0){
						//	String imgurl = "/weaver/weaver.file.FileDownload/?fileid=" + tp;
						//	pic = "background-image: url(" + imgurl + ");";
						//}						
					%>
					<div class="icon" style="<%=pic %>" id="wfcentericon1"></div>
					<div class="itemcontent">
						<div class="main">
						<%
							if(cjurl == null || cjurl.length() <= 0){
						%>
								<a href="/workflow/request/AddRequest.jsp?workflowid=<%=wfid %>" target="_blank"><%=name %></a>
						<%	
							}else{
						%>
								<a href="<%=cjurl %>" target="_blank"><%=name %></a>
						<%								
							}
						%>							
						</div>
						<div class="sub"><%=cjms %></div>
					</div>
				</div> <%
		if(count%9 == 0){
		%>
			</li>
			<%
		}
		%>
			<%
		count++;
		}
		%>
			<%
		if(count%9 != 0){
		%>
			</li>
			<%
		}
		%>
		</ul>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#workCenterFlex').flexslider({
			animation : "slide",
			slideshow : false
		});		
	})
</script>