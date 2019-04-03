<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

int formid = Util.getIntValue(request.getParameter("formid"));	
int billid = Util.getIntValue(request.getParameter("billid"));
int zs=-1;   
rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("zs".equals(fieldname.toLowerCase()) && "uf_hq_cri_weeklytra_dt1".equals(detailtable) ){
		zs=fieldid;
	}
}

String durrdate = TimeUtil.getCurrentDateString();
Calendar c = Calendar.getInstance();   
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
Date date = null;   
try{   
	date = sdf.parse(durrdate);  
}catch(Exception e){  
	e.printStackTrace();
}   
c.setTime(date);
date  = c.getTime();
int re = TimeUtil.getWeekOfYear(date);

%>

<script type="text/javascript">

jQuery(document).ready(function(){
		
	all_browse_bind("#indexnum0",function(){
		JSZS();
	})
	
	var indexnum0 = jQuery("#indexnum0").val()*1.0;
	if(indexnum0 > 0){
		JSZS();
	}	
		
})

function JSZS(){
	var nf = "<%=durrdate%>";
	var nfs = nf.split("-")[0];
	var zs = "<%=re%>";
	var yearweek = nfs+zs;
	jQuery("input[name^='field<%=zs%>_']").each(function(){
		var id=this.id.split("_")[1];
		var zsval = jQuery("#field<%=zs%>_"+id).val();
		if(zsval==""){
			jQuery("#field<%=zs%>_"+id).val(yearweek);
		}
	});
}
	
function all_browse_bind( id ,func_browse){	
    var id_val_last=jQuery(id).val();
    setInterval(function(){
        var id_val = jQuery(id).val();
        if( id_val != id_val_last){
           func_browse();
        }
        id_val_last = id_val;
    },50);
}
	
</script>
