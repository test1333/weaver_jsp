<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
      var zffs="#field10712";//支付方式
      var fkzh="field9897";//付款账号
      var fkzhmc="field9856";//付款账号名称
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
    /*
	 需求一：
	（1）请款理由：（字段组合出来，无需输入，日期+供应商/客户名称，不能超过50个字符）

    */

  
	var id_qkrq = "#field9852";//请款日期
	var id_qkly = "#field10721";//请款理由

    checkCustomize = function () {
        var isSuccess = true;
	var str = new Date($(id_qkrq).val().replace(/-/g, "/")).Format("MM");//截取月份
	
	str=str+$("td[name='td_khjc']").find("span").text();
	
	
        

        $(id_qkly).val(str);
        return isSuccess;
    }

    



    jQuery(document).ready(function () {
       
        
    });



</script>








