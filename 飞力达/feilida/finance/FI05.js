
<script type="text/javascript">
      var zffs="#field10511";//支付方式
      var fkzh="field9888";//付款账号
      var fkzhmc="field9759";//付款账号名称
      var kh="field11290";//客户
      var pjh="field11292";//支票票据号
      jQuery(zffs).bindPropertyChange(function () {
           var zffs_val=jQuery(zffs).val();
           if(zffs_val=="B"){
              jQuery("#"+fkzh).val("");
              jQuery("#"+fkzh+"span").text("");
             jQuery("#out"+fkzh+"div").hide();
             jQuery("#"+fkzh+"_browserbtn").hide();
             jQuery("#"+fkzh+"spanimg").html("");

              jQuery("#"+fkzhmc).val("");
              jQuery("#"+fkzhmc+"span").text("");
              jQuery("#"+fkzhmc).hide();

              jQuery("#"+kh).val("");
              jQuery("#"+kh+"span").text("");
              jQuery("#out"+kh+"div").show();
             jQuery("#"+kh+"_browserbtn").show();
              jQuery("#"+kh+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+pjh).val("");
              jQuery("#"+pjh+"span").text("");
              jQuery("#"+pjh).show();
              jQuery("#"+pjh+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

               var needcheck = document.all("needcheck");
              if(needcheck.value.indexOf(","+kh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=kh;
              }
              if(needcheck.value.indexOf(","+pjh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=pjh;
              }

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+fkzh,"");
               parastr = parastr.replace(","+fkzhmc,"");
               document.all('needcheck').value=parastr;

           }else if(zffs_val=="O"){
              jQuery("#"+fkzh).val("");
              jQuery("#"+fkzh+"span").text("");
             jQuery("#out"+fkzh+"div").hide();
             jQuery("#"+fkzh+"_browserbtn").hide();
             jQuery("#"+fkzh+"spanimg").html("");

              jQuery("#"+fkzhmc).val("");
              jQuery("#"+fkzhmc+"span").text("");
              jQuery("#"+fkzhmc).hide();

              jQuery("#"+kh).val("");
              jQuery("#"+kh+"span").text("");
             jQuery("#out"+kh+"div").hide();
             jQuery("#"+kh+"_browserbtn").hide();
              jQuery("#"+kh+"spanimg").html("");

              jQuery("#"+pjh).val("");
              jQuery("#"+pjh+"span").text("");
              jQuery("#"+pjh).hide();
              jQuery("#"+pjh+"span").html("");

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+fkzh,"");
               parastr = parastr.replace(","+fkzhmc,"");
               parastr = parastr.replace(","+kh,"");
               parastr = parastr.replace(","+pjh,"");
               document.all('needcheck').value=parastr;

           }else if(zffs_val=="P"){
             jQuery("#"+fkzh).val("");
             jQuery("#"+fkzh+"span").text("");
             jQuery("#out"+fkzh+"div").show();
             jQuery("#"+fkzh+"_browserbtn").show();
              jQuery("#"+fkzh+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+fkzhmc).val("");
              jQuery("#"+fkzhmc+"span").text("");
              jQuery("#"+fkzhmc).show();

              jQuery("#"+kh).val("");
              jQuery("#"+kh+"span").text("");
             jQuery("#out"+kh+"div").hide();
             jQuery("#"+kh+"_browserbtn").hide();
              jQuery("#"+kh+"spanimg").html("");

              jQuery("#"+pjh).val("");
              jQuery("#"+pjh+"span").text("");
              jQuery("#"+pjh).hide();
              jQuery("#"+pjh+"span").html("");

               var needcheck = document.all("needcheck");
              if(needcheck.value.indexOf(","+fkzh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=fkzh;
              }

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+kh,"");
               parastr = parastr.replace(","+pjh,"");
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

              jQuery("#"+kh).val("");
              jQuery("#"+kh+"span").text("");
             jQuery("#out"+kh+"div").hide();
             jQuery("#"+kh+"_browserbtn").hide();
              jQuery("#"+kh+"spanimg").html("");

              jQuery("#"+pjh).val("");
              jQuery("#"+pjh+"span").text("");
              jQuery("#"+pjh).show();
              jQuery("#"+pjh+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

               var needcheck = document.all("needcheck");
              if(needcheck.value.indexOf(","+fkzh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=fkzh;
              }
              if(needcheck.value.indexOf(","+pjh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=pjh;
              }

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+kh,"");
               document.all('needcheck').value=parastr;
           }
      })

	var gysbh = "#field9891_"; //供应商编号
        var pzbh = "#field9772_";//凭证编号
	var pzgzrq = "#field9773_";//凭证过账日期
	var ybje = "#field11324_";//原币金额
        var bwbje = "#field11289_"; // 本位币金额
	var bz= "#field9774_"; // 币种
	var fprq = "#field10887_"; // 发票日期
	var fphm = "#field10888_"; // 发票号码
	var cn= "#field11461_"; //财年
	var pzhxms= "#field11462_"; // 凭证行项目数
	var wb = "#field9776_";//文本
	var bh ="#field9889_";//明细1供应商编号
	var gsdm="#field10226";
  var qran="#field12062span";
  var xz="#field12064_";
  var ybfkje ="#field11881_";//明细1原币付款金额
  var bwbfkje ="#field11323_";//明细1本位币付款金额
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
        setTimeout(' doData()',500);

	});

function doData(){
   jQuery(qran).html("<input type=button   style='width:70px' value='确认' onclick='checkdata2()' >");
}

function checkdata2(){

   var indexnum0 = jQuery("#indexnum0").val();
   for(var index1=0;index1<indexnum0;index1++){
      if(jQuery(bh+index1).length>0){
         jQuery(ybfkje+index1).val("");
          jQuery(bwbfkje+index1).val("");
          jQuery(ybfkje+index1+"span").text("");
          jQuery(bwbfkje+index1+"span").text("");
        
      }
   }

 var indexnum1 = jQuery("#indexnum1").val();
 for(var index=0;index<indexnum1;index++){
  
    if(jQuery(gysbh+index).length>0){
      if( jQuery(xz+index).attr("checked")){
        var ybje_val=jQuery(ybje+index).val();
        var bwbje_val=jQuery(bwbje+index).val();
        var gysbh_val=jQuery(gysbh+index).val();
        checkdata1(ybje_val,bwbje_val,gysbh_val);

      }
    }
 }
calSum(0);
}

function checkdata1(ybje2,bwbje2,gysbh2){
   var indexnum0 = jQuery("#indexnum0").val();
   for(var index1=0;index1<indexnum0;index1++){
      if(jQuery(bh+index1).length>0){
        if(jQuery(bh+index1).val() == gysbh2 ){
          var ybfkje_val=jQuery(ybfkje+index1).val();
          var bwbfkje_val=jQuery(bwbfkje+index1).val();
var  sum11=Number(ybfkje_val)+Number(ybje2);
var  sum22=Number(bwbfkje_val)+Number(bwbje2);
          jQuery(ybfkje+index1).val(Number(sum11).toFixed(2));
  jQuery(ybfkje+index1+"span").text(Number(sum11).toFixed(2));
          jQuery(bwbfkje+index1).val(Number(sum22).toFixed(2));
           jQuery(bwbfkje+index1+"span").text(Number(sum22).toFixed(2));
        }
      }
   }
}
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
       jQuery(ybfkje+index1).val("");
          jQuery(bwbfkje+index1).val("");
          jQuery(ybfkje+index1+"span").text("");
          jQuery(bwbfkje+index1+"span").text("");
      var bh_val=jQuery(bh+index1).val();
	    if(bh_val != ''){
		  gysid = gysid+falgg+bh_val;
		  falgg = ',';
	    }
	  }
     
   }
   if(gysid !=''){
   getdetail2(gysid);
   }
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
	xhr.open("GET","/feilida/finance/getFI05Info.jsp?id="+gysid+"&custom="+gsdm_val, false);
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
		  jQuery(pzgzrq+i).val(tmp_arr[2]);
	      jQuery(pzgzrq+i+"span").text(tmp_arr[2]);
		  jQuery(ybje+i).val(tmp_arr[3]);
	      jQuery(ybje+i+"span").text(tmp_arr[3]);
	      jQuery(bwbje+i).val(tmp_arr[4]);
	      jQuery(bwbje+i+"span").text(tmp_arr[4]);
	      jQuery(bz+i).val(tmp_arr[5]);
	      jQuery(bz+i+"span").text(tmp_arr[5]);
	      jQuery(fprq+i).val(tmp_arr[6]);
	      jQuery(fprq+i+"span").text(tmp_arr[6]);
		  jQuery(fphm+i).val(tmp_arr[7]);
	      jQuery(fphm+i+"span").text(tmp_arr[7]);
		  jQuery(cn+i).val(tmp_arr[8]);
	      jQuery(cn+i+"span").text(tmp_arr[8]);
		  jQuery(pzhxms+i).val(tmp_arr[9]);
	      jQuery(pzhxms+i+"span").text(tmp_arr[9]);
		  jQuery(wb+i).val(tmp_arr[10]);
	      jQuery(wb+i+"span").text(tmp_arr[10]);
		}
	   }
      }
     }
	 xhr.send(null);
   }
 }




</script>











