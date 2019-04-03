<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONException"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="tmc.SopRelevance" %>
<%@ page import="java.net.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="ln.LN"%>
<%@ page import="weaver.hrm.settings.RemindSettings" %>
<%@ page import="org.apache.commons.logging.Log"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>
<%@ page import="weaver.workflow.workflow.TestWorkflowCheck" %>
<%@ page import="weaver.systeminfo.template.UserTemplate"%>
<%@ page import="weaver.systeminfo.setting.*" %>
<%@ page import="weaver.login.LicenseCheckLogin"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs"  class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs3" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs4" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs5" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs6" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs7" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs8" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs9" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs0" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rsd" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs11" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs12" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs13" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs14" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs15" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs16" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs17" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs18" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs19" class="weaver.conn.RecordSet" scope="page" />
<html>
<script type="text/javascript" src="/appdevjsp/HQ/SOP/jquery-3.2.1.min.js"></script>
<%
    String tmp_province = Util.null2String(request.getParameter("province"));
	String tmp_city = Util.null2String(request.getParameter("city"));
	String tmp_town = Util.null2String(request.getParameter("town"));
	String tmp_kong = Util.null2String(request.getParameter("kong"));
	String tmp_name = Util.null2String(request.getParameter("nodeid"));
	//获取查询节点
	List<String> list = new ArrayList<String>();
	if(!"".equals(tmp_province)&&!"一级".equals(tmp_province)){
		//本身
		String sql_oneq = "select * from uf_sop_relation where name = '"+tmp_province+"'";
		rs11.executeSql(sql_oneq);
		while(rs11.next()){
			String tmp_id = Util.null2String(rs11.getString("id"));
			if (!list.contains(tmp_id)) {
				list.add(tmp_id);
				// 下级id
				String sql="";
				if(!"".equals(tmp_city)&&!"二级".equals(tmp_city)){
					sql = " select id,relation from uf_sop_relation where name = '"+tmp_city+"' and relation like '%"+ tmp_id + "%'";
				}else{
					sql = " select id,relation from uf_sop_relation where relation like '%"+ tmp_id + "%'";
				}
				rs.executeSql(sql);
				while (rs.next()) {
					String id_one = Util.null2String(rs.getString("id"));
					String super_sub = Util.null2String(rs.getString("relation"));
					if (!list.contains(id_one)&&(","+super_sub+",").contains(","+tmp_id+",")) {
						list.add(id_one);
						
						if(!"".equals(id_one)){
							String sql_one_two="";
							if(!"".equals(tmp_town)&&!"三级".equals(tmp_town)){
								sql_one_two = "select id,relation from uf_sop_relation where  name = '"+tmp_town+"' and relation like '%"+ id_one + "%'";
							}else{
								sql_one_two = "select id,relation from uf_sop_relation where relation like '%"+ id_one + "%'";
							}
							rs5.execute(sql_one_two);
							while(rs5.next()){
								String id_one_two = Util.null2String(rs5.getString("id"));
								String super_two_two = Util.null2String(rs5.getString("relation"));
								String[] emp_super_three = super_two_two.split(",");
								for (int j = 0; j < emp_super_three.length; j++) {
									String emp_super_there = emp_super_three[j];
									if (!list.contains(id_one_two)&&(","+emp_super_there+",").contains(","+id_one+",")) {
										list.add(id_one_two);
											
										if(!"".equals(id_one_two)){
											String sql_one_three="";
											if(!"".equals(tmp_kong)&&!"四级".equals(tmp_kong)){
												sql_one_three = "select id,relation from uf_sop_relation where name = '"+tmp_kong+"' and relation like '%"+ id_one_two + "%'";
											}else{
												sql_one_three = "select id,relation from uf_sop_relation where relation like '%"+ id_one_two + "%'";
											}
											rs6.execute(sql_one_three);
											while(rs6.next()){
												String id_one_three = Util.null2String(rs6.getString("id"));
												String super_two_three = Util.null2String(rs6.getString("relation"));
												String[] emp_super_five = super_two_three.split(",");
												for (int k = 0; k < emp_super_five.length; k++) {
													String emp_super_nigth = emp_super_five[k];
													if (!list.contains(id_one_three)&&(","+emp_super_nigth+",").contains(","+id_one_two+",")) {
														list.add(id_one_three);
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}	
		}	
	}else if(!"".equals(tmp_name)){
			String sql_one = "select * from uf_sop_relation where name = '" + tmp_name + "'";
			rs1.executeSql(sql_one);
			while (rs1.next()) {
				String id_one = Util.null2String(rs1.getString("id"));
				// 获取查询节点
				list.add(id_one);
				
				// 下级
				String sql_two = " select id,relation from uf_sop_relation where relation like '%"+ id_one + "%'";
				rs2.executeSql(sql_two);
				while (rs2.next()) {
					String id_two = Util.null2String(rs2.getString("id"));
					String super_two = Util.null2String(rs2.getString("relation"));
					if (!list.contains(id_two)&& ("," + super_two + ",").contains("," + id_one+ ",")) {
						list.add(id_two);
						// 下级的下级
						if (!"".equals(id_two)) {
							String sql_three = "select id,relation from uf_sop_relation where relation like '%"+ id_two + "%'";
							rs3.execute(sql_three);
							while (rs3.next()) {
								String id_three = Util.null2String(rs3.getString("id"));
								String super_three = Util.null2String(rs3.getString("relation"));
								String[] emp_super_three = super_three.split(",");
								for (int j = 0; j < emp_super_three.length; j++) {
									String sub_super_there = emp_super_three[j];
									if (!list.contains(id_three)&& ("," + sub_super_there + ",").contains("," + id_two+ ",")) {
										list.add(id_three);
										// 下级的下级的下级
										if (!"".equals(id_three)) {
											String sql_four = "select id,relation from uf_sop_relation where relation like '%"+ id_three + "%'";
											rs4.execute(sql_four);
											while (rs4.next()) {
												String id_four = Util.null2String(rs4.getString("id"));
												String super_four = Util.null2String(rs4.getString("relation"));
												String[] emp_super_four = super_four.split(",");
												for (int k = 0; k < emp_super_four.length; k++) {
													String sub_super_four = emp_super_four[k];
													if (!list.contains(id_four)&& (","+ sub_super_four + ",").contains(","+ id_three+ ",")) {
														list.add(id_four);
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}

				// 上級
				sql_one = "select * from uf_sop_relation where id=" + id_one;
				rs1.execute(sql_one);
				while (rs1.next()) {
					String super_one = Util.null2String(rs1.getString("relation"));
					String level_one = Util.null2String(rs1.getString("tlevel"));
					String[] emp_super_one = super_one.split(",");
					for (int i = 0; i < emp_super_one.length; i++) {
						String sub_super_one = emp_super_one[i];
						if (!list.contains(emp_super_one)) {
							list.add(sub_super_one);

							// 上級的上級
							if (!"".equals(sub_super_one)) {
								String sql_five = "select relation from uf_sop_relation where id in("+ sub_super_one + ")";
								rs5.execute(sql_five);
								while (rs5.next()) {
									String super_five = Util.null2String(rs5.getString("relation"));
									String[] emp_super_five = super_five.split(",");
									for (int j = 0; j < emp_super_five.length; j++) {
										String sub_super_five = emp_super_five[j];
										if (!list.contains(sub_super_five)) {
											list.add(sub_super_five);

											// 上級的上級的上級
											if (!"".equals(sub_super_five)) {
												String sql_six = "select relation from uf_sop_relation where id in("+ sub_super_five + ")";
												rs6.execute(sql_six);
												while (rs6.next()) {
													String super_six = Util.null2String(rs6.getString("relation"));
													String[] emp_super_six = super_six.split(",");
													for (int k = 0; k < emp_super_six.length; k++) {
														String sub_super_six = emp_super_six[k];
														if (!list.contains(sub_super_six)) {
															list.add(sub_super_six);
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		} else {
		// 所有id
		String sql = " select id from uf_sop_relation ";
		rs1.executeSql(sql);
		while (rs1.next()) {
			String nodeid = Util.null2String(rs1.getString("id"));
			list.add(nodeid);
		}
	}
	String tmp_list="-1";
	for(int i = 0;i < list.size();i++){
		tmp_list+=","+list.get(i);
	}
	
	JSONObject json = new JSONObject();
	JSONArray jnodes = new JSONArray();
	JSONArray jedges = new JSONArray();

	int count =1;
	Map<Integer,Integer> map = new HashMap<Integer,Integer>();
	String sql2 = " select * from uf_sop_relation where id in ("+tmp_list+") order by tlevel,id " ;
	rs2.executeSql(sql2);
	while(rs2.next()){	
		JSONObject nodes = new JSONObject();	
		int nodeid = rs2.getInt("id");
		String name= Util.null2String(rs2.getString("name"));	
		int level  = rs2.getInt("tlevel");

		nodes.put("nodeid", count);
		nodes.put("level", level);
		nodes.put("name", name);
		jnodes.put(nodes);
		map.put(nodeid,count);
		count++;
		
		String super_tmp = Util.null2String(rs2.getString("relation"));	
		int nodeid_tmp_one = rs2.getInt("id");
		String[] super_sub = super_tmp.split(",");
		for(int i=0;i<super_sub.length;i++){		
			JSONObject edges = new JSONObject();
			int super_tmp_one=Integer.valueOf(super_sub[i]).intValue();
			if(super_tmp_one!=nodeid_tmp_one){
				edges.put("to", map.get(nodeid_tmp_one));
				edges.put("from", map.get(super_tmp_one));
			}		
			jedges.put(edges);		
		}
	}	
    json.put("nodes",jnodes);
	json.put("edges",jedges);  
	JSONObject json_xlks = new JSONObject();
	JSONArray xlk = new JSONArray();
	List<String> list_xlk = new ArrayList<String>();
		String sql_xlk = "select name as name_xlk ,id as id_xlk from uf_sop_relation where tlevel = 0";
		rs7.executeSql(sql_xlk);
		while(rs7.next()){
			JSONObject json_xlk = new JSONObject();
			String id_xlk = Util.null2String(rs7.getString("id_xlk"));
			String name_xlk = Util.null2String(rs7.getString("name_xlk"));
			list_xlk.add(name_xlk);
		//	out.print("name_xlk"+name_xlk);
			
			String sql_xlk_one = "select id,relation ,tlevel,name from uf_sop_relation where relation like '%"+ id_xlk + "%'";
			rs8.executeSql(sql_xlk_one);
			while(rs8.next()){
				String id_xlk_one = Util.null2String(rs8.getString("id"));
				String name_xlk_one = Util.null2String(rs8.getString("name"));
				list_xlk.add(id_xlk_one);
			//	out.print("name_xlk_one"+name_xlk_one);
				
				String sql_xlk_two = "select id,relation ,tlevel,name from uf_sop_relation where relation like '%"+ id_xlk_one + "%'";
				rs9.executeSql(sql_xlk_two);
				while(rs9.next()){
					String id_xlk_two = Util.null2String(rs9.getString("id"));
					String name_xlk_two = Util.null2String(rs9.getString("name"));
					list_xlk.add(id_xlk_two);
				//	out.print("name_xlk_two"+name_xlk_two);
					
					String sql_xlk_three = "select id,relation ,tlevel,name from uf_sop_relation where relation like '%"+ id_xlk_two + "%'";
					rs0.executeSql(sql_xlk_three);
					while(rs0.next()){
						String id_xlk_three = Util.null2String(rs0.getString("id"));
						String name_xlk_three = Util.null2String(rs0.getString("name"));
						list_xlk.add(id_xlk_three);
					//	out.print("name_xlk_three"+name_xlk_three);
					}
				}	
			}
			
			json_xlk.put("name",name_xlk);
			xlk.put(json_xlk);
		}
	json_xlks.put("xlk",xlk);
	int maxcount=0;
	sql2=" select nvl(max(count),0) as maxcount from (select tlevel,count(1) as count from uf_sop_relation where id in ("+tmp_list+") group by tlevel)";
	rs2.executeSql(sql2);
	if(rs2.next()){
		maxcount = rs2.getInt("maxcount");
	}
	int alllength=maxcount*100;
	if (alllength <1000){
		alllength=1000;
	}
	String srkey="";
	String srvalue="";
		JSONObject jsonmap = new JSONObject();
		JSONArray arrmap = new JSONArray();
		SopRelevance soprel= new SopRelevance();
 		Map<String,String> srmap=soprel.getAllMap();
 		Iterator<String> it = srmap.keySet().iterator();
		while(it.hasNext()){
	   	   JSONObject mapnode = new JSONObject();
		   srkey = it.next();
		   srvalue = srmap.get(srkey);

			mapnode.put("key",srkey);
			mapnode.put("value",srvalue);
			arrmap.put(mapnode);	
	   }
	   jsonmap.put("maps",arrmap);
	String jsonstr=jsonmap.toString();
	//自动补全
	List<String> list_hhh = new ArrayList<String>();
		String sql_wqe = "select * from uf_sop_relation";
		rs19.executeSql(sql_wqe);
		while(rs19.next()){
			String name111 = Util.null2String(rs19.getString("name"));
			list_hhh.add("'"+name111+"'");
		}	
%>
<head>
<!-- <script type="text/javascript" src="../js/jquery.js"></script> 
<script type="text/javascript" src="../js/jquery.cityselect.js"></script> -->
    <title>Workflow Relation</title>
    <style type="text/css">
        body {
            font: 10pt sans;
        }
        #mynetwork {
            width: <%=alllength%>px;
            height:100%;
			margin:0 auto;
        }
    </style>
	<link rel="stylesheet" type="text/css" href="/appdevjsp/HQ/SOP/auto.css" />
	<script src="/appdevjsp/HQ/SOP/auto.js"></script>
    <script type="text/javascript" src="/appdevjsp/HQ/SOP/vis.js"></script>
	<script type="text/javascript" src="/appdevjsp/HQ/SOP/jquery.min.js"></script>
    <link href="vis-network.min.css" rel="stylesheet" type="text/css"/>
    <script  language="JavaScript" type="text/javascript">  
	
	    //下拉框
		var xlks;
		function Dsy() {
			xlks = {};
		}
		Dsy.prototype.add = function (id, iArray) {
			xlks[id] = iArray;
		}
		Dsy.prototype.Exists = function (id) {
			if (typeof(xlks[id]) == "undefined") return false;
			return true;
		}
 
		function change(v) {
			var str = "0";
			for (i = 0; i < v; i++) { 
			str += ("_" + (document.getElementById(s[i]).selectedIndex - 1));
			};
			var ss = document.getElementById(s[v]);
			with (ss) {
				length = 0;
				options[0] = new Option(opt0[v], opt0[v]);
					if (v && document.getElementById(s[v - 1]).selectedIndex > 0 || !v) {
						if (dsy.Exists(str)) {
							ar = xlks[str];
							for (i = 0; i < ar.length; i++)options[length] = new Option(ar[i], ar[i]);
							if (v)options[0].selected = true;
						}
					}
					if (++v < s.length) {change(v);}
			}
		}
	var dsy = new Dsy();
   	       var tmp_jsonmap=<%=jsonstr%>;
			var datamap = tmp_jsonmap.maps;
			$.each(datamap, function(i, value) {
			//节点		
	      	var mapkey= this.key;
			var mapval =this.value.split(",");
	              dsy.add(mapkey, mapval);
			});
	

		
		var s = ["s1", "s2", "s3","s4"];
		var opt0 = ["一级", "二级", "三级","四级"];
		function setup() {
			for (i = 0; i < s.length - 1; i++)
			document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ");promptinfo();");
			
			change(0);
			
		}	
		function changeDefaultValue(){
			var js_province="<%=tmp_province%>";
			var js_city="<%=tmp_city%>";
			var js_town="<%=tmp_town%>";
			var js_kong="<%=tmp_kong%>";
			
			if(js_province != "一级"&&js_province != ""){
				
				document.getElementById("s1").value=js_province;
				change(1);
			}
			
			if(js_city != "二级"&&js_city != ""){
				document.getElementById("s2").value=js_city;
				change(2);
			}
			if(js_town != "三级"&&js_town != ""){
				
				document.getElementById("s3").value=js_town;
				change(3);
			}
			if(js_kong != "四级"&&js_kong != ""){
			
				document.getElementById("s4").value=js_kong;
				change(4);
			}
		}
		
		var nodes = null;
        var edges = null;
        var network = null;
        var directionInput = document.getElementById("direction");
        function destroy() {
            if (network !== null) {
                network.destroy();
                network = null;
            }
        }
        function draw() {
            destroy();
            nodes = [];
            edges = [];
            var connectionCount = [];
			var tst = <%=json.toString()%>;
			var datat = tst.nodes;
			$.each(datat, function(i, value) {
			//节点		
	      	var id_val= this.nodeid;
			var name_val =this.name;
	      	var level_val = this.level; 
				nodes.push({id: id_val, label: String(name_val)});
				nodes[id_val-1]["level"] = level_val;	
			});
		  //节点关系
			var datas = tst.edges;
		  	$.each(datas, function(i, value) {
	      	var to_val= this.to;
	      	var from_val = this.from; 
				edges.push({from: from_val, to: to_val});		
			});
            // create a network
            var container = document.getElementById('mynetwork');
            var data = {
                nodes: nodes,
                edges: edges
            };
            var options = {
                edges: {
                    smooth: {
                        type: 'cubicBezier',
                        forceDirection: (directionInput.value == "UD" || directionInput.value == "DU") ? 'vertical' : 'horizontal',
                        roundness: 0.4
                    }
                },
                layout: {
                    hierarchical: {
                        direction: directionInput.value
                    }
                },
                physics:false
            };
            network = new vis.Network(container, data, options);

            // add event listeners
            network.on('select', function (params) {
                document.getElementById('selection').innerHTML = 'Selection: ' + params.nodes;
            });
        }
		function nodeSearching() {
			
			document.shareip.submit();
		}
		function Searching() {
			
			document.formkk.submit();
		}
	$(document).ready(function(){
		var array=<%=list_hhh%>;
			
		var autoComplete = new AutoComplete("input","auto",array);
		document.getElementById("input").onkeyup = function(event){
			autoComplete.start(event);
		}
		});
	//	document.formkk.submit(); 
    </script>   
</head>
<body onload=" setup(); draw();  promptinfo();changeDefaultValue();"  >
<form name="shareip" action="/appdevjsp/HQ/SOP/Topology_two.jsp" method="post">
		<p>
		<select class="select" name="province" id="s1" style= "height:30px;width:100px">
			<option></option>
		</select>
		<select class="select" name="city" id="s2" style= "height:30px;width:100px">
			<option></option>
		</select>
		<select class="select" name="town" id="s3" style= "height:30px;width:100px">
			<option></option>
		</select>
		<select class="select" name="kong" id="s4" style= "height:30px;width:100px">
			<option></option>
		</select>
		  <input id="address" name="address" type="hidden" value="" />
		<input id="dosearch" type="button" style= "color:#FF0000;height:30px;width:80px" value="查询" onclick="nodeSearching() " />
		</form>

		<script>
			function promptinfo(){
				var address = document.getElementById('address').value;
				var s1 = document.getElementById('s1').value;
				var s2 = document.getElementById('s2').value;
				var s3 = document.getElementById('s3').value;
				var s4 = document.getElementById('s4').value;
				address=""+s1+ s2 + s3 + s4;
				return address;
			}
		</script>
		<form name="formkk" action="">
		<input type="button" id="btn-UD" value="上-->下" style= "height:30px;width:80px ">
		<input type="button" id="btn-LR" value="左-->右" style= "height:30px;width:80px">
		<input type="dosearch_text" id="input" class="auto-inp" name="nodeid">
		<input id="dosearch" type="button" style= "color:#FF0000;height:30px;width:80px" value="查询" onclick="Searching() " />
		<div class="auto hidden" id="auto"></div>
		<input type="hidden" id='direction' value="UD">
		</p>
	</form>

<div id="mynetwork" ></div>
	<p id="selection"></p>
	<script language="JavaScript">
		var directionInput = document.getElementById("direction"); 
		var btnUD = document.getElementById("btn-UD");
		btnUD.onclick = function () {
			directionInput.value = "UD";
			draw();
		};

		var btnLR = document.getElementById("btn-LR");
		btnLR.onclick = function () {
			directionInput.value = "LR";
			draw();
		};

	</script>
</body>
</html>