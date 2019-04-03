<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var clfs="#field11293"; //票据处理方式
var txrq="field9166"; //贴现/转让日期
var jzll="field9168"; //基准利率
var txlx="field9171"; //贴现利息
var txll="field9170"; //贴现利率
var bsr="field11294"; //背书人
var bbsr="field11295"; //被背书人
	/*
	如果选择票据贴现，同期银行基准利率（年化）、贴现利率、贴现利息金额栏位设为可选项。同时背书人、被背书人不可输入
	当选择票据为背书转让时，同期人民银行基准利率（年化）、贴现利息金额、贴现利率、贴现日期这四个字段不可输入且贴现日期为空，背书人及被背书人必输
	*/
       jQuery(clfs).bindPropertyChange(function () {
            var clfs_val=jQuery(clfs).val();
            if(clfs_val==0){
              jQuery("#"+bsr).val("");
              jQuery("#"+bsr+"span").text("");
               jQuery("#"+bsr).hide();

              jQuery("#"+bbsr).val("");
              jQuery("#"+bbsr+"span").text("");
               jQuery("#"+bbsr).hide();

              jQuery("#"+jzll).val("");
              jQuery("#"+jzll+"span").text("");
               jQuery("#"+jzll).show();

              jQuery("#"+txlx).val("");
              jQuery("#"+txlx+"span").text("");
               jQuery("#"+txlx).show();

              jQuery("#"+txll).val("");
              jQuery("#"+txll+"span").text("");
               jQuery("#"+txll).show();

              jQuery("#"+txrq).val("");
              jQuery("#"+txrq+"span").text("");
               jQuery("#"+txrq+"browser").show();

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+bsr,"");
               parastr = parastr.replace(","+bbsr,"");
               document.all('needcheck').value=parastr;

            }else{
              jQuery("#"+bsr).val("");
              jQuery("#"+bsr+"span").text("");
               jQuery("#"+bsr).show();
               jQuery("#"+bsr+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+bbsr).val("");
              jQuery("#"+bbsr+"span").text("");
               jQuery("#"+bbsr).show();
               jQuery("#"+bbsr+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+jzll).val("");
              jQuery("#"+jzll+"span").text("");
               jQuery("#"+jzll).hide();

              jQuery("#"+txlx).val("");
              jQuery("#"+txlx+"span").text("");
               jQuery("#"+txlx).hide();

              jQuery("#"+txll).val("");
              jQuery("#"+txll+"span").text("");
               jQuery("#"+txll).hide();

              jQuery("#"+txrq).val("");
              jQuery("#"+txrq+"span").text("");
               jQuery("#"+txrq+"browser").hide();

               var needcheck = document.all("needcheck");
              if(needcheck.value.indexOf(","+bsr)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=bsr;
              }
              if(needcheck.value.indexOf(","+bbsr)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=bbsr;
              }
            }
       })
</script>























































