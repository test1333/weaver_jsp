<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
   var ajlx="#disfield14536";   //案件类型
   var sslx="#sslxyc1";//诉讼类型
   var ysajh="#sslxyc2";//一审案件
   var esajh="#sslxyc3";//二审案件
   var zclx="#zclxyc1";//仲裁类型

  jQuery(document).ready(function() {
      // alert("11");
       setTimeout('hideorshow( )',200);
  });
function hideorshow(){
//alert("22");
    var ajlx_valx=jQuery(ajlx).val();
      //alert(ajlx_valx);
      if(ajlx_valx==""){
      jQuery(sslx).hide();
      jQuery(ysajh).hide();
      jQuery(esajh).hide();
      jQuery(zclx).hide();
 }else if(ajlx_valx=="0"){
     jQuery(sslx).hide();
      jQuery(ysajh).hide();
      jQuery(esajh).hide();
      jQuery(zclx).show();

 }else{
 	 jQuery(sslx).show();
      jQuery(ysajh).show();
      jQuery(esajh).show();
      jQuery(zclx).hide();
}
}

</script>













































