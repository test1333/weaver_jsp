
<script type="text/javascript">
      var zffs="#field10877";//支付方式
      var fkzh="field9893";//付款账号
      var fkzhmc="field9792";//付款账号名称
      jQuery(zffs).bindPropertyChange(function () {
           var zffs_val=jQuery(zffs).val();
           if(zffs_val=="O"){
              jQuery("#"+fkzh).val("");
              jQuery("#"+fkzh+"span").text("");
              jQuery("#out"+fkzh+"div").hide();
              jQuery("#"+fkzh+"_browserbtn").hide();
              jQuery("#"+fkzh+"spanimg").html("");

              jQuery("#"+fkzhmc).val("");
              jQuery("#"+fkzhmc+"span").text("");
              jQuery("#"+fkzhmc).hide();

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+fkzh,"");
               parastr = parastr.replace(","+fkzhmc,"");
               document.all('needcheck').value=parastr;

           }else{
              jQuery("#"+fkzh).val("");
              jQuery("#"+fkzh+"span").text("");
              jQuery("#out"+fkzh+"div").show();
              jQuery("#"+fkzh+"_browserbtn").show();
              jQuery("#"+fkzh+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+fkzhmc).val("");
              jQuery("#"+fkzhmc+"span").text("");
              jQuery("#"+fkzhmc).show();

              var needcheck = document.all("needcheck");
              if(needcheck.value.indexOf(","+fkzh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=fkzh;
              }
              if(needcheck.value.indexOf(","+fkzhmc)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=fkzhmc;
              }


           }
      })

	var gysbh = "#field9896_"; //供应商编号
    var pzbh = "#field9805_";//凭证编号
	var ybje = "#field9807_";//原币金额
	var bz= "#field9808_"; // 币种
	var pzrq = "#field12042_"; // 凭证日期
	var wb = "#field9809_";//文本
	var bh ="#field9894_";//明细1供应商编号
    var gsdm = "#field12449";
	jQuery("button[name=addbutton0]").live("click",function(){
      var indexnum0=jQuery("#indexnum0").val();
      for(var index =0;index <indexnum0;index ++){     
		   if(jQuery(bh+index).length>0){
            bindchange(index); 
			}     
      } 

    });
	jQuery("button[name=delbutton0]").live("click",function(){
		var indexnum1 = jQuery("#nodesnum1").val();
			if (indexnum1 > 0) {
				jQuery("[name = check_node_1]:checkbox").attr("checked", true);
				deleteRow1(1);
			}
			 getData1();
	}); 

	jQuery(document).ready(function () {
		 var nodesnum0=jQuery("#nodesnum0").val();
		  var indexnum0=jQuery("#indexnum0").val();
		 if(nodesnum0>0){
			 for(var index=0;index<indexnum0;index++){
				 if(jQuery(bh+index).length>0){
				 bindchange(index)
				 }
			 }
		 }
      

	});
 function bindchange(index){

	 jQuery(bh+index).bindPropertyChange(function () {
			var indexnum1 = jQuery("#nodesnum1").val();
			if (indexnum1 > 0) {
				jQuery("[name = check_node_1]:checkbox").attr("checked", true);
				deleteRow1(1);
			}
			 getData1();

		})

 }
 function getData1(){
 var indexnum0=jQuery("#indexnum0").val();
   var gysid='';
   var falgg='';
   for(var index1=0;index1<indexnum0;index1++){
	  if(jQuery(bh+index1).length>0){ 
      var bh_val=jQuery(bh+index1).val();
	  if(bh_val != ''){
		  gysid = gysid+falgg+bh_val;
		  falgg = ',';
	  }
	  }
     
   }
   getdetail2(gysid);
 }
 function getdetail2(gysid){
   var indexnum1=  jQuery("#indexnum1").val();
   var xhr = null;
   if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
   } else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
   }
   if (null != xhr) {
    var gsdm_val=jQuery(gsdm).val();
	xhr.open("GET","/feilida/finance/getFI06Info.jsp?id="+gysid+"&custom="+gsdm_val, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
		var text = xhr.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum1);
		for(var i=indexnum1;i<length1;i++){
		  addRow1(1);
		  var tmp_arr = text_arr[i-indexnum1].split("###");
		  jQuery(gysbh+i).val(tmp_arr[0]);
		  jQuery(gysbh+i+"span").text(tmp_arr[0]);
	      jQuery(pzbh+i).val(tmp_arr[1]);
	      jQuery(pzbh+i+"span").text(tmp_arr[1]);
		  jQuery(ybje+i).val(tmp_arr[2]);
	      jQuery(ybje+i+"span").text(tmp_arr[2]);
	      jQuery(bz+i).val(tmp_arr[3]);
	      jQuery(bz+i+"span").text(tmp_arr[3]);
		   jQuery(pzrq+i).val(tmp_arr[4]);
	      jQuery(pzrq+i+"span").text(tmp_arr[4]);
		  jQuery(wb+i).val(tmp_arr[5]);
	      jQuery(wb+i+"span").text(tmp_arr[5]);
		}
	   }
      }
     }
	 xhr.send(null);
   }
 }




</script>








