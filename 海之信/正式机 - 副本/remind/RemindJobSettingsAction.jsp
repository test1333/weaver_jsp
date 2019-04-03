<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@page import="weaver.hrm.User"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="seahonor.util.InsertUtil"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%!
public String[] getRes(String dates,String times,String num,String unit,String type ){
		int num_1 = 0;
		if("1".equals(type)){
			 num_1 = 0 - Integer.parseInt(num);
		}else{
			num_1 = Integer.parseInt(num);
		}
		
		String[] arr = {"",""};
		String tmp_1 = dates + "@" + times;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd@HH:mm:ss");
		try {
			Date date = sdf.parse(tmp_1);
			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			if("1".equals(unit)){
				calendar.add(Calendar.MINUTE,num_1);
			}else if("2".equals(unit)){
				calendar.add(Calendar.HOUR,num_1);
			}else if("3".equals(unit)){
				calendar.add(Calendar.DATE,num_1);
			}else if("4".equals(unit)){
				calendar.add(Calendar.MONTH,num_1);
			}
			
			tmp_1 = sdf.format(calendar.getTime());
			arr = tmp_1.split("@");
			return arr;
		} catch (ParseException e) {
			return arr;
		}
	}
%>	

<%
out.clear();
User user = HrmUserVarify.getUser (request , response) ;
String sql = "";
InsertUtil iu = new InsertUtil();
String operation = Util.null2String(request.getParameter("operation"));
String id = Util.null2String(request.getParameter("id"));

if(operation.equals("saveorupdate")) {
	String titleUrl = Util.null2String(request.getParameter("titleUrl"));
	titleUrl = titleUrl.replace("###", "&");
	titleUrl = titleUrl.replace("##", "?");
	titleUrl = titleUrl.replace("#", "/");
	
	
	String remarks = Util.null2String(request.getParameter("remarks"));
	String uqid = Util.null2String(request.getParameter("uqid"));
	String creator = Util.null2String(request.getParameter("creator"));
	String title = Util.null2String(request.getParameter("title"));
	// 是否启用
	String over_active = Util.null2String(request.getParameter("over_active"));
	
	// 常量 字段
	String remindtimetype = Util.null2String(request.getParameter("remindtimetype"));
	// 日期字段 
	String dateField = Util.null2String(request.getParameter("dateField"));
	// 时间字段
	String timeField = Util.null2String(request.getParameter("dateField"));
	// 相关表名
	String tableName = Util.null2String(request.getParameter("tableName"));
	// 条件 infowhere
	String infowhere = Util.null2String(request.getParameter("infowhere"));
	// 条件停止 stopID
	String stopID = Util.null2String(request.getParameter("stopID"));
	// 固定值  关联字段值
	String selStopInfo = Util.null2String(request.getParameter("selStopInfo"));
	// 中止条件关联值
	String stopUqID = Util.null2String(request.getParameter("stopUqID"));
	
	// 提醒类型 即时提醒 到期提醒 循环提醒
	String remindHZ = Util.null2String(request.getParameter("remindHZ"));
	String deDate = Util.null2String(request.getParameter("deDate"));
	String deTime = Util.null2String(request.getParameter("deTime"));
	// 提前-->延迟
	String incrementway = Util.null2String(request.getParameter("incrementway"));
	// 整数常量
	String incrementnum = Util.null2String(request.getParameter("incrementnum"));
	// 分、小时、天
	String incrementunit = Util.null2String(request.getParameter("incrementunit"));
	// 发布范围
	String areaType = Util.null2String(request.getParameter("areaType"));
	// 提醒人关系
	String LeadType = Util.null2String(request.getParameter("LeadType"));

	String relatedid1 = Util.null2String(request.getParameter("relatedid1"));
	String relatedid2 = Util.null2String(request.getParameter("relatedid2"));
	String relatedid3 = Util.null2String(request.getParameter("relatedid3"));
	String relatedid4 = Util.null2String(request.getParameter("relatedid4"));
	// 安全级别
	String level = Util.null2String(request.getParameter("level"));
	if("".equals(level))	level = "10";
	// 循环类型
	String triggertype = Util.null2String(request.getParameter("triggertype"));
	
	// 时长
	String triggercycletime = Util.null2String(request.getParameter("triggercycletime"));
	String weeks = Util.null2String(request.getParameter("weekval"));
	String months = Util.null2String(request.getParameter("monthval"));
	String days = Util.null2String(request.getParameter("dayval"));
	
	sql = "select NEWID() AS UQID";
	rs.executeSql(sql);		
	if(rs.next()){
		uqid = rs.getString("UQID");
	}

	Map<String,String> mapStr = new HashMap<String,String>();
	mapStr.put("waySys","0");
	mapStr.put("is_active","0");
	mapStr.put("level",level);
	mapStr.put("uqid",uqid);
	// titleUrl  <a href='javascript:openNewInfo('http://www.baidu.com');'>test</a>
//	String titleUrl_1 = "<a href=''javascript:openNewInfo(''" + titleUrl + "'');''>"+title+"</a>";
	
	mapStr.put("titleUrl",titleUrl);
	
	mapStr.put("stopID",stopID);
	mapStr.put("selStopInfo",selStopInfo);
	mapStr.put("stopUqID",stopUqID);
	
	mapStr.put("created_time","##CONVERT(varchar(100),GETDATE(),21)");
	if("".equals(over_active)){ 
		over_active = "0";
	}
	mapStr.put("over_active",over_active);
	mapStr.put("title",title);
	if("".equals(creator) || "1".equals(creator) ){
		creator = "3";
	}
	
	mapStr.put("creater",creator);
	mapStr.put("remindHZ",remindHZ);
	mapStr.put("remarks",remarks);
	mapStr.put("LeadType",LeadType);

	if("1".equals(remindHZ)){  // 即时提醒
		mapStr.put("reDate","##CONVERT(varchar(10), GETDATE(), 23)");
		mapStr.put("reTime","##CONVERT(varchar(10), GETDATE(), 24)");
	}else if("2".equals(remindHZ)){  // 到期循环
		
		mapStr.put("deDate",deDate);
		mapStr.put("deTime",deTime);
		
		mapStr.put("incrementway",incrementway);
		mapStr.put("incrementnum",incrementnum);
		mapStr.put("incrementunit",incrementunit);
		// 循环方式
		mapStr.put("triggertype",triggertype);
		mapStr.put("triggercycletime",triggercycletime);
		mapStr.put("weeks",weeks);
		mapStr.put("months",months);
		mapStr.put("days",days);
		if("1".equals(incrementway)){  // 提前
			mapStr.put("lsDate",deDate);
			mapStr.put("lsTime",deTime);
			// 计算提醒的开始日期和时间
		}
		
		mapStr.put("remindtimetype",remindtimetype);
		if("2".equals(remindtimetype)){ 
			mapStr.put("dateField",dateField);
			mapStr.put("timeField",timeField);
			mapStr.put("tableName",tableName);
			mapStr.put("infowhere",infowhere);
			mapStr.put("reDate","##CONVERT(varchar(10), GETDATE(), 23)");
			mapStr.put("reTime","##CONVERT(varchar(10), GETDATE(), 24)");
		}
		
		
		String tmp_st_date = "";
		String tmp_st_time = "";
		// 计算提醒的开始日期和时间
		String arr[] = getRes(deDate,deTime,incrementnum,incrementunit,incrementway);
		tmp_st_date = arr[0];
		tmp_st_time = arr[1];
			
		mapStr.put("reDate",tmp_st_date);
		mapStr.put("reTime",tmp_st_time);
		
		
	}else{  // 循环  从现在开始

		mapStr.put("deDate",deDate);
		mapStr.put("deTime",deTime);
		
		mapStr.put("incrementway",incrementway);
		mapStr.put("incrementnum",incrementnum);
		mapStr.put("incrementunit",incrementunit);
		// 循环方式
		mapStr.put("triggertype",triggertype);
		mapStr.put("triggercycletime",triggercycletime);
		mapStr.put("weeks",weeks);
		mapStr.put("months",months);
		mapStr.put("days",days);
		if("1".equals(incrementway)){  // 提前
			mapStr.put("lsDate",deDate);
			mapStr.put("lsTime",deTime);
			// 计算提醒的开始日期和时间
		}
		
		mapStr.put("remindtimetype",remindtimetype);
		if("2".equals(remindtimetype)){ 
			mapStr.put("dateField",dateField);
			mapStr.put("timeField",timeField);
			mapStr.put("tableName",tableName);
			mapStr.put("infowhere",infowhere);
			mapStr.put("reDate","##CONVERT(varchar(10), GETDATE(), 23)");
			mapStr.put("reTime","##CONVERT(varchar(10), GETDATE(), 24)");
		}
		
		
		String tmp_st_date = "";
		String tmp_st_time = "";
		// 计算提醒的开始日期和时间
		String arr[] = getRes(deDate,deTime,incrementnum,incrementunit,incrementway);
		tmp_st_date = arr[0];
		tmp_st_time = arr[1];
			
		mapStr.put("reDate",tmp_st_date);
		mapStr.put("reTime",tmp_st_time);
	}
	// 提醒范围
	mapStr.put("areaType",areaType);
	if("1".equals(areaType)){
		mapStr.put("areaVal",relatedid1);
	}else if("2".equals(areaType)){
		mapStr.put("areaVal",relatedid2);
	}else if("3".equals(areaType)){
		mapStr.put("areaVal",relatedid3);
	}else if("4".equals(areaType)){
		mapStr.put("areaVal",relatedid4);
	}
	iu.insert(mapStr, "uf_remindRecord");
}
%>
<script type="text/javascript">
	alert("处理完成!");
	var dialog = parent.getDialog(window);
	//var parentWin = parent.getParentWindow(window);
	//parentWin.location="/workflow/workflow/ListWorkTypeTab.jsp";
	//parentWin.closeDialog();
	//window.close();
	dialog.close();

</script>