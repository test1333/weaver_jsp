<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
       var dzlx ="#field5839";//调职类型
       var dzlx2 ="#disfield5839";//调职类型
       var sbsm="#field5856";//社保说明
       var bsqrgs ="#field7741";//被申请人公司
       var hgs ="#field5848";//后公司
       var tzlxbm ="#field7781";//调整类型编码
       var lx = "#field5882";//类型
       var lx2 = "#disfield5882";//类型
       var zwxlbm = "#field8336";//后职位序列编码
       var zwxlbm2 = "#field8330";//原职位序列编码
       var lxbm = "#field8343";//类型编码
       var szrq =  "#field5884";//述职日期
      var fbrq =  "#field5886";//发布日期
      var bz ="#field5888";//备注
      var szpd ="#field5885";//述职评定
       var szpd2 ="#disfield5885";//述职评定
      var wh ="#field5883";//文号

      var nrms ="#field5887";//内容描述
   
   function change(){
	   
        var zwxlbm_val= jQuery(zwxlbm).val();
        var zwxlbm2_val= jQuery(zwxlbm2).val();
        //alert("zwxlbm_val"+zwxlbm_val);
        if(zwxlbm_val==10){
             jQuery(lx).val("0");
             jQuery(lx2).val("0");
             jQuery(lxbm).val("1000");
             jQuery(lxbm+"span").text("1000");
               jQuery(bz).attr('disabled',false);
          jQuery(nrms).attr('disabled',false);		  
 jQuery(wh).attr('disabled',false);

             jQuery(szpd).attr('disabled',false);
         jQuery(szrq+"browser").attr('disabled',false);
          jQuery(fbrq+"browser").attr('disabled',false);
        jQuery(wh+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
        var needcheck = document.all("needcheck");
        if(needcheck.value.indexOf("field5883")<0){
        if(needcheck.value!='') needcheck.value+=",";
         needcheck.value+="field5883";
           }
 jQuery(szrq +"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
         needcheck = document.all("needcheck");
        if(needcheck.value.indexOf("field5884")<0){
        if(needcheck.value!='') needcheck.value+=",";
         needcheck.value+="field5884";
           }
 jQuery(fbrq+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
        needcheck = document.all("needcheck");
        if(needcheck.value.indexOf("field5886")<0){
        if(needcheck.value!='') needcheck.value+=",";
         needcheck.value+="field5886";
           }
 jQuery(szpd +"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
         needcheck = document.all("needcheck");
        if(needcheck.value.indexOf("field5885")<0){
        if(needcheck.value!='') needcheck.value+=",";
         needcheck.value+="field5885";
        }
        }else if(zwxlbm_val !=10&&zwxlbm2_val ==10){
             jQuery(lx).val("1");
             jQuery(lx2).val("1");
             jQuery(lxbm).val("2000");
             jQuery(lxbm+"span").text("2000");
             jQuery(bz).attr('disabled',false);
          jQuery(nrms).attr('disabled',false);
		   jQuery(wh).attr('disabled',false);
             jQuery(szpd).attr('disabled',false);
         jQuery(szrq+"browser").attr('disabled',false);
          jQuery(fbrq+"browser").attr('disabled',false);
          jQuery(wh+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
        var needcheck = document.all("needcheck");
        if(needcheck.value.indexOf("field5883")<0){
        if(needcheck.value!='') needcheck.value+=",";
         needcheck.value+="field5883";
           }
 jQuery(szrq +"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
        needcheck = document.all("needcheck");
        if(needcheck.value.indexOf("field5884")<0){
        if(needcheck.value!='') needcheck.value+=",";
         needcheck.value+="field5884";
           }
 jQuery(fbrq+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
         needcheck = document.all("needcheck");
        if(needcheck.value.indexOf("field5886")<0){
        if(needcheck.value!='') needcheck.value+=",";
         needcheck.value+="field5886";
           }
 jQuery(szpd +"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
         needcheck = document.all("needcheck");
        if(needcheck.value.indexOf("field5885")<0){
        if(needcheck.value!='') needcheck.value+=",";
         needcheck.value+="field5885";
           }

        }else if(zwxlbm_val !=10&&zwxlbm2_val !=10){
             jQuery(lx).val("");
             jQuery(lx2).val("");
             jQuery(lxbm).val("9999");
             jQuery(lxbm+"span").text("9999");
               jQuery(wh+"span").html("");
 jQuery(szrq +"span").html("");
 jQuery(szpd +"span").html("");
 jQuery(fbrq+"span").html("");
        var parastr = document.all('needcheck').value;
        parastr = parastr.replace(",field5883","");
        document.all('needcheck').value=parastr;
parastr = parastr.replace(",field5884","");
        document.all('needcheck').value=parastr;
parastr = parastr.replace(",field5885","");
        document.all('needcheck').value=parastr;
parastr = parastr.replace(",field5886","");
        document.all('needcheck').value=parastr;


             jQuery(bz).val("");
             jQuery(bz+"span").text("");
             jQuery(bz).attr('disabled',true);
              jQuery(nrms).val("");
             jQuery(nrms+"span").text("");
             jQuery(nrms).attr('disabled',true);
 jQuery(wh).val("");
             jQuery(wh+"span").text("");
             jQuery(wh).attr('disabled',true);

              jQuery(szpd).val("");
             jQuery(szpd2).val("");
             jQuery(szpd).attr('disabled',true);
             jQuery(szrq).val("");
           jQuery(szrq+"span").text("");
           jQuery(szrq+"browser").attr('disabled',true);
            jQuery(fbrq).val("");
           jQuery(fbrq+"span").text("");
           jQuery(fbrq+"browser").attr('disabled',true);

        }
   }


      jQuery(zwxlbm).bindPropertyChange(function () {
       change();

      })
	   jQuery(zwxlbm2).bindPropertyChange(function () {
       change();

      })

       jQuery(hgs).bindPropertyChange(function () {
       var bsqrgs_val= jQuery(bsqrgs).val();
       var hgs_val= jQuery(hgs).val();
       //alert("hgs_val="+hgs_val);
       var sfgsn ="";
       if(bsqrgs_val==hgs_val){
          sfgsn =1;
          //alert("sfgsn="+sfgsn);
       }else{
          sfgsn =0;
          //alert("sfgsn="+sfgsn);
       }

      if(sfgsn==1){
        //调整类型
        jQuery(dzlx).val("0");
        jQuery(dzlx2).val("0");
        //调整类型编码
         jQuery(tzlxbm).val("Z4");
         jQuery(tzlxbm+"span").text("Z4");
        //社保说明
        jQuery(sbsm).val("1");
        jQuery(sbsm+"span").html("");
        var parastr = document.all('needcheck').value;
        parastr = parastr.replace(",field5856","");
        document.all('needcheck').value=parastr;
      }else{
        //调整类型
        jQuery(dzlx).val("1");
        jQuery(dzlx2).val("1");
       //调整类型编码
         jQuery(tzlxbm).val("Z5");
         jQuery(tzlxbm+"span").text("Z5");
        //社保说明
        jQuery(sbsm).val("");
        jQuery(sbsm+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
        var needcheck = document.all("needcheck");
        if(needcheck.value.indexOf(sbsm)<0){
        if(needcheck.value!='') needcheck.value+=",";
         needcheck.value+="field5856";
           }
      }
});
</script>







