<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var rzqd="#field11297"; //融资渠道
var dkyh="field9180"; //贷款银行
var nhdkll="field9183"; //年化贷款利率
var jzll="field9182"; //基准利率
var yrzje="field11302"; //已融资金额
var qdzjje="field11303"; //启动资金金额
/*
	如果融资渠道选择“银行贷款“，贷款银行、同期人民银行基准利率（年化）、年化贷款利率这三个字段必填，已融资金额，股东已投入启动资金金额字段不可以填
	如果融资渠道选择“股东投资“，已融资金额，股东已投入启动资金金额必输，贷款银行、同期人民银行基准利率（年化）、年化贷款利率不可填
	*/
      jQuery(rzqd).bindPropertyChange(function () {
           var rzqd_val=jQuery(rzqd).val();
           if(rzqd_val==0){
              jQuery("#"+dkyh).val("");
              jQuery("#"+dkyh+"span").text("");
              jQuery("#"+dkyh).show();
              jQuery("#"+dkyh+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+jzll).val("");
              jQuery("#"+jzll+"span").text("");
              jQuery("#"+jzll).show();
              jQuery("#"+jzll+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+nhdkll).val("");
              jQuery("#"+nhdkll+"span").text("");
              jQuery("#"+nhdkll).show();
              jQuery("#"+nhdkll+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+yrzje).val("");
              jQuery("#"+yrzje+"span").text("");
              jQuery("#"+yrzje).hide();

              jQuery("#"+qdzjje).val("");
              jQuery("#"+qdzjje+"span").text("");
              jQuery("#"+qdzjje).hide();

               var needcheck = document.all("needcheck");
              if(needcheck.value.indexOf(","+dkyh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=dkyh;
              }
              if(needcheck.value.indexOf(","+jzll)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=jzll;
              }
              if(needcheck.value.indexOf(","+nhdkll)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=nhdkll;
              }

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+yrzje,"");
               parastr = parastr.replace(","+qdzjje,"");
               document.all('needcheck').value=parastr;
            
           }else{

              jQuery("#"+dkyh).val("");
              jQuery("#"+dkyh+"span").text("");
              jQuery("#"+dkyh).hide();

              jQuery("#"+jzll).val("");
              jQuery("#"+jzll+"span").text("");
              jQuery("#"+jzll).hide();

              jQuery("#"+nhdkll).val("");
              jQuery("#"+nhdkll+"span").text("");
              jQuery("#"+nhdkll).hide();

              jQuery("#"+yrzje).val("");
              jQuery("#"+yrzje+"span").text("");
              jQuery("#"+yrzje).show();
              jQuery("#"+yrzje+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+qdzjje).val("");
              jQuery("#"+qdzjje+"span").text("");
              jQuery("#"+qdzjje).show();
              jQuery("#"+qdzjje+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

               var needcheck = document.all("needcheck");
              if(needcheck.value.indexOf(","+yrzje)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=yrzje;
              }
              if(needcheck.value.indexOf(","+qdzjje)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=qdzjje;
              }

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+dkyh,"");
               parastr = parastr.replace(","+jzll,"");
               parastr = parastr.replace(","+nhdkll,"");
               document.all('needcheck').value=parastr;

           }

      })
</script>

















