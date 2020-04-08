<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<head>

<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
</head>





<script type="text/javascript">
window.cardCollapse = function() {
    $('tr.wea-zd-start').click(function() {
      var $start = $(this);
      var $end = $start.next();
      while ($end.attr('class') != 'wea-zd-end') {
        $end.toggle();
        $end = $end.next();
      }
    })
  }
    /*
    *  TODO
     *  请在此处编写javascript代码
     */

$(document).ready(function(){
  $(".Inputstyle").css('width','100%');
 cardCollapse();
});

window.onload = function(){
  $(".Inputstyle").css('width','100%');
}

</script>











































































































































































































































<style>

body{
 background:#f3f3f3
}

.Inputstyle{
  border:none;
   text-align:right !important;

 
}
.excelMainTable textarea{
 width:100%;
}

input.InputStyle, input.Inputstyle, input.inputStyle, input.inputstyle,.excelMainTable input[type="text"],.excelMainTable input[type="password"], .e8_innerShowContent,.excelMainTable textarea, .sbHolder{

  border:none;
  width: 100%!important;


}

input.InputStyle, input.Inputstyle, input.inputStyle, input.inputstyle, .excelMainTable input[type="text"], .excelMainTable input[type="password"], .e8_innerShowContent, .excelMainTable textarea, .sbHolder{
  text-align: right !important;

}
.excelMainTable{
width: 100% !important;
}
 .form_out_content{
 margin: 0px !important;
}


/*圆角样式*/

td{
 padding:0px;
}
.ysyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-top-right-radius:9px;
}
.zxyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-bottom-left-radius:9px;
}
.yxyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-bottom-right-radius:9px;
}
.zsyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-top-left-radius:9px;
}


</style>


</style>



