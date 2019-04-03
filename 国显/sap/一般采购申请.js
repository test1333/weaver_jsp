<script type="text/javascript" src="/gvo/getNoJs/GetNum.js"></script>
<script>	
	var wlbh_dt1="field7367_";
	var wlxykc_dt1="field32828_";//最新即时库存
	var aqdh_dt1="field32829_";//最新安全库存
	var wql_dt1="field32830_";//最新未清pro
	jQuery(document).ready(function () {
		//alert("1");
		window.setTimeout("getcginfo ()", 1000);
	 });	
	function getcginfo(){
		var indexnum0=  jQuery("#indexnum0").val();
		var flag="";
		var wlbhs="";
		var gcs="";
		for(var index=0;index<indexnum0;index++){
			if(jQuery("#"+wlbh_dt1+index).length>0){
			var wlbh_dt1_val = jQuery("#"+wlbh_dt1+index).val();
			if(wlbh_dt1 !=''){
		       wlbhs=wlbhs+flag+wlbh_dt1_val;
		       gcs=gcs+flag+'G001';
		       flag=",";
		       }
			}
		}
		if(wlbhs !=''){
		dosapfunction(wlbhs,gcs);
      	}
	
       }
      function dosapfunction(wlbhs,gcs){
      	  var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {				
					xhr.open("GET","/gvo/sap/GetplwlxxInfo.jsp?MATNR="+wlbhs+"&gc="+gcs, false);
					xhr.onreadystatechange = function () {

							if (xhr.readyState == 4) {
								if (xhr.status == 200) {
									var text = xhr.responseText;
									text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');	
									var text_arr = text.split("@@@");
		                                              var length1=text_arr.length-1;
									for(var i=0;i<length1;i++){                                                          
									 var tmp_arr = text_arr[i].split("###");
									 var wlbh_val=tmp_arr[0];
									 var aqdh_val=tmp_arr[1];
									 var wlxykc_val=tmp_arr[2];
									 var wql_val=tmp_arr[3];
									 //alert(wlbh_val+" "+aqdh_val+" "+wlxykc_val+" "+wql_val);	
									updatenum(wlbh_val,aqdh_val,wlxykc_val,wql_val);	
																												
								}
							}	
						}
					}
					xhr.send(null);			
				}	    
      }
     function updatenum(wlbh_val,aqdh_val,wlxykc_val,wql_val){
     	var indexnum0=  jQuery("#indexnum0").val();
      	for(var index=0;index<indexnum0;index++){
			if(jQuery("#"+wlbh_dt1+index).length>0){
				var wlbh_dt1_val = jQuery("#"+wlbh_dt1+index).val();
		      	if(wlbh_dt1_val == wlbh_val){
		      		jQuery("#"+aqdh_dt1+index).val(aqdh_val);
		      		jQuery("#"+aqdh_dt1+index+"span").text(aqdh_val);
		      		jQuery("#"+wlxykc_dt1+index).val(wlxykc_val);
		      		jQuery("#"+wlxykc_dt1+index+"span").text(wlxykc_val);
		      		jQuery("#"+wql_dt1+index).val(wql_val);
		      		jQuery("#"+wql_dt1+index+"span").text(wql_val);
		    		}
			}
		}
     }
</script>