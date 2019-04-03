<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var tzlx ="#field5923";//调整类型
    var cyhjs="#field10205";//调整类型
    var yzw ="#field5961_";//原职位
    var xzzw ="#field5964_";//新增职位
    var zwbm = "#field5962_";//职务编码
    var tzq = "#field5918_";//调整前
    var jz = "#field5921_";//兼职
    var lwg = "#field5922_";//劳务工
    var max_len =100;
/*
	需求一：
1、主表中增加字段“差异合计数”，差异合计数=明细表中的差异累计。
2、调整类型不通控制子表中的原有逻辑取消（建议备份保存），变更新的需求。
明细表中的每一行数据中“原有职位”和“新增职位”这两个字段只允许一个有值，选择“原有职位”的时候清空“新增职位”和“职位编码”（保存原有职位和对应原有职位对应的职位编码）；选择“新增职位”的时候清空“原有职位”和“职位编码”（保存新增职位和对应新增职位对应的职位编码）。
流程提交的时候，判断如下：
差异合计数>0时候，调整类型为只能选择新增编制；差异合计数=0的时候调整类型为只能为调整编制。差异合计数<0不容许提交

	*/
  jQuery(document).ready(function() {
    checkCustomize = function() {
        for(var index =0;index <100;index ++){
           if(jQuery(zwbm+index).length>0){
              var xzzw_val = jQuery(xzzw+index).val();
              var yzw_val = jQuery(yzw +index).val();
              if(xzzw_val != "" && yzw_val != ""){
                alert("新增职位和原有职位两个只能填写一个，请重新填写");
                  jQuery(xzzw+index).val("");
                  jQuery(xzzw+index+"span").text("");
                   jQuery(zwbm+index).val("")
                  jQuery(yzw+index).val("");
                  jQuery(yzw+index+"span").text("");
                 return false;
              }
           }else{
             index = 101;
           }
        }
        var cyhjs_val =  jQuery(cyhjs).val();
       var tzlx_val =jQuery(tzlx).val();
        if(Number(cyhjs_val )>Number('0') && tzlx_val != '0'){
          alert("请变更调整类型");
          return false;
        }
         if(Number(cyhjs_val ) == Number('0') && tzlx_val != '1'){
          alert("请变更调整类型");
          return false;
        }
         if(Number(cyhjs_val ) < Number('0') ){
          alert("差异合计数不能小于0");
          return false;
        }
      return true;
    }

 });
  

</script>





