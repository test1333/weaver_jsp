<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
//明细字段1
var type_dt="#field11426_"; //移库维度
var ycdag="field11416_"; //移出柜号
var yrdag ="field11418_";  //移入档案柜
var d_val="#field11417_";   //移出档案
var j_val="#field11427_";   //移出卷宗
var j2_val="field11427_";   //移出卷宗
var d_num="#field12456_"; //档案卷宗数量
var d_state="#field11659_"; //档案状态
var d_state_2="#field12740_"; //卷宗状态
var link_num="#field11654_";
var d_num_2="#field12719_";

//明细字段2
var type_dt2="#field12066_"; //移库维度
var ycdag2="field12063_"; //移出柜号
var yrdag2 ="field12065_";  //移入档案柜
var d_val2="#field12064_";   //移出档案
var j_val2="#field12067_";   //移出卷宗
var j2_val2="field12067_";   //移出卷宗
var d_num2="#field12457_"; //档案卷宗数量
var d_state2="#field12071_"; //档案状态
var d_state2_2="#field12741_"; //卷宗状态
var link_num2="#field12068_";
var d_num2_2="#field12734_";

//主表字段
var type="#field11584";      //移库类型
var shuliang ="#field11586"; //移出箱数
var shuliang2 ="#field11585";  //移入箱数
var stockOut="#field11414";   //档案移出库
var stockIn="#field11415";     //档案移入库
var textval="#field11656";    //textval
var textval2="#field11658";  //textval2
var indexnum=0;
var max_lenx=100;

jQuery(document).ready(function() {
                        var type_x = jQuery(type).val();
                        if(Number(type_x)==0){
                             document.getElementById("$addbutton0$").style.display=""; 
                             document.getElementById("$delbutton0$").style.display=""; 
                             document.getElementById("$addbutton1$").style.display="none"; 
                             document.getElementById("$delbutton1$").style.display="none"; 
                           }else if(Number(type_x)==1){
                             document.getElementById("$addbutton1$").style.display=""; 
                             document.getElementById("$delbutton1$").style.display=""; 
                             document.getElementById("$addbutton0$").style.display="none"; 
                             document.getElementById("$delbutton0$").style.display="none";

                           }else{
                             document.getElementById("$addbutton1$").style.display="none"; 
                             document.getElementById("$delbutton1$").style.display="none"; 
                             document.getElementById("$addbutton0$").style.display="none"; 
                             document.getElementById("$delbutton0$").style.display="none";
                           }
    jQuery(type).bindPropertyChange(function () {
                        var type_val = jQuery(type).val();
                        if(Number(type_val)==0){
                             document.getElementById("$addbutton0$").style.display=""; 
                             document.getElementById("$delbutton0$").style.display=""; 
                             document.getElementById("$addbutton1$").style.display="none"; 
                             document.getElementById("$delbutton1$").style.display="none"; 
                             for(var indexnum=0;indexnum<max_lenx;indexnum++){
                             if(jQuery("#"+ycdag2+indexnum).length>0){
                               jQuery("[name = check_node_1]:checkbox").attr("checked", true);
                               deleteRow1(1); 
                             }
                             } 
                        }else{
                             document.getElementById("$addbutton1$").style.display=""; 
                             document.getElementById("$delbutton1$").style.display=""; 
                             document.getElementById("$addbutton0$").style.display="none"; 
                             document.getElementById("$delbutton0$").style.display="none";
                             for(var indexnum1=0;indexnum1<max_lenx;indexnum1++){ 
                             if(jQuery("#"+ycdag+indexnum1).length>0){
                               jQuery("[name = check_node_0]:checkbox").attr("checked", true);
                               deleteRow0(0); 
                             } 
                           }
                       }
              jQuery(stockOut).val("");
              jQuery(stockOut+"span").text("");
              jQuery(stockOut+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery(stockIn).val("");
              jQuery(stockIn+"span").text("");
              jQuery(stockIn+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

    });

    jQuery(stockOut).bindPropertyChange(function () {
      for(var i=0;i<=max_lenx;i++){
              jQuery(shuliang).val(0);
              jQuery(shuliang+"span").text(0);

              jQuery("#"+ycdag+i).val("");
              jQuery("#"+ycdag+i+"span").text("");
              jQuery("#"+ycdag+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+ycdag2+i).val("");
              jQuery("#"+ycdag2+i+"span").text("");
              jQuery("#"+ycdag2+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery(d_val+i).val("");
              jQuery(d_val+i+"span").text("");
              jQuery(d_val+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery(j_val+i).val("");
              jQuery(j_val+i+"span").text("");
              jQuery(j_val+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery(d_val2+i).val("");
              jQuery(d_val2+i+"span").text("");
              jQuery(d_val2+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery(j_val2+i).val("");
              jQuery(j_val2+i+"span").text("");
              jQuery(j_val2+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
        }
    });

    jQuery(stockIn).bindPropertyChange(function () {
      for(var i=0;i<=max_lenx;i++){
              jQuery(shuliang2).val(0);
              jQuery(shuliang2+"span").text(0);

              jQuery("#"+yrdag+i).val("");
              jQuery("#"+yrdag+i+"span").text("");
              jQuery("#"+yrdag+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+yrdag2+i).val("");
              jQuery("#"+yrdag2+i+"span").text("");
              jQuery("#"+yrdag2+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery(d_val+i).val("");
              jQuery(d_val+i+"span").text("");
              jQuery(d_val+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery(j_val+i).val("");
              jQuery(j_val+i+"span").text("");
              jQuery(j_val+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery(d_val2+i).val("");
              jQuery(d_val2+i+"span").text("");
              jQuery(d_val2+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery(j_val2+i).val("");
              jQuery(j_val2+i+"span").text("");
              jQuery(j_val2+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

        }
    });


setTimeout('bindcount()',1000);
setTimeout('bind()',1000); //首次加载
setTimeout('bindcount2()',1000); //首次加载
setTimeout('bind2()',1000); 

//删除绑定
jQuery("button[name=delbutton0]").live("click",function(){
changedata();
changedata1();
});

//删除绑定
jQuery("button[name=delbutton1]").live("click",function(){
changedata2();
changedata3();
});

//新增绑定
jQuery("button[name=addbutton0]").live("click",function(){
  var indexnum00=jQuery("#indexnum0").val();
    for(var index =0;index <indexnum00;index ++){
     
            bindchange(index);
      
    } 

});

//新增绑定
jQuery("button[name=addbutton1]").live("click",function(){
    var indexnum11=jQuery("#indexnum1").val();
    for(var index =0;index <indexnum11;index ++){
        
            bindchange2(index);
      
    } 

});

checkCustomize = function() {
  var result = true;
  var res = true;
    for(var a=0;a<100;a++){
                  var d_num_val = jQuery(d_num+a).val();
                  var d_state_val = jQuery(d_state+a).val();
                  var d_state_val_2 = jQuery(d_state_2+a).val();
                  if(Number(d_num_val)==0){
                        alert("您所创建的流程存在明细列表存在档案没有卷宗的现象。请检查！");
                        result = false;
                        break;
                  }
                  if(Number(d_state_val)>0||Number(d_state_val_2)>0){
                        alert("您移库的档案明细中，存在尚未归还的档案，应该待出借的档案归还入库后方可进行移库提交。");
                        result = false;
                        break;
                  }
      if(res){
              for(var yet=a+1;yet<max_lenx;yet++){
               if(jQuery(d_val+yet).length>0){
                var d_val_val = jQuery(d_val+a).val();
                var d_val_val2 = jQuery(d_val+yet).val();
                if(d_val_val==d_val_val2){
                  alert("您移库的档案明细中，已申请的档案或卷宗存在重复申请的现象，请认真检查后提交。");
                  result = false;
                  res= false;
                  break;
            }         
          }
        }
        }
                }

    for(var b=0;b<100;b++){
                  var d_num_val2 = jQuery(d_num2+b).val();
                  var d_state_val2 = jQuery(d_state2+b).val();
                  var d_state_val2_2 = jQuery(d_state2_2+b).val();
                  if(Number(d_num_val2)==0){
                        alert("您所创建的流程存在明细列表存在档案没有卷宗的现象。请检查！");
                        result = false;
                        break;
                  }
                  if(Number(d_state_val2)>0||Number(d_state_val2_2)>0){
                        alert("您移库的档案明细中，存在尚未归还的档案，应该待出借的档案归还入库后方可进行移库提交。");
                        result = false;
                        break;
                  }
      if(res){
                for(var yet2=b+1;yet2<max_lenx;yet2++){
               if(jQuery(d_val2+yet2).length>0){
                var d_val_val2 = jQuery(d_val2+b).val();
                var d_val_val22 = jQuery(d_val2+yet2).val();
                if(d_val_val2==d_val_val22){
                  alert("您移库的档案明细中，已申请的档案或卷宗存在重复申请的现象，请认真检查后提交。");
                  result = false;
                  res= false;
                  break;
            }
            }         
          }
        }
                }
    return result;
}
});

function bindcount(){
for(var index =0;index <=100;index ++){
        if(jQuery("#"+ycdag+index).length>0){
            bindchange(index);
        }else{
        index  = 101;
        }
    } 
}

function bindcount2(){
for(var index =0;index <=100;index ++){
        if(jQuery("#"+ycdag2+index).length>0){
            bindchange2(index);
        }else{
        index  = 101;
        }
    } 
}

function bind(){
for(var index =0;index <=100;index ++){
    if(jQuery("#"+ycdag+index).length>0){
        changelink(index);
      }
    } 
}
function bind2(){
for(var index =0;index <=100;index ++){
      if(jQuery("#"+ycdag2+index).length>0){
        changelink2(index);
      }
    } 
}

function bindchange(index){
       jQuery("#"+ycdag+index).bindPropertyChange(function () {
          var type_dt_val=jQuery(type_dt+index).val();
          changetype(index,type_dt_val);
          changedata();
       })
       jQuery("#"+yrdag+index).bindPropertyChange(function () {
          changedata1();
       })
       jQuery(type_dt+index).bindPropertyChange(function () {
          var type_dt_val=jQuery(type_dt+index).val();
          changetype(index,type_dt_val);
       })
              jQuery(d_num+index).bindPropertyChange(function () {
         var type_dt_val=jQuery(type_dt+index).val();
         changetype3(index,type_dt_val);
         changelink(index)
       })
}

function bindchange2(index){
       jQuery("#"+ycdag2+index).bindPropertyChange(function () {
          var type_dt_val=jQuery(type_dt2+index).val();
          changetype2(index,type_dt_val);
          changedata2();
       })
       jQuery("#"+yrdag2+index).bindPropertyChange(function () {
          changedata3();
       })
       jQuery(type_dt2+index).bindPropertyChange(function () {
          var type_dt_val=jQuery(type_dt2+index).val();
          changetype2(index,type_dt_val);
       })
      jQuery(d_num2+index).bindPropertyChange(function () {
         var type_dt_val=jQuery(type_dt+index).val();
         changetype4(index,type_dt_val);
        changelink2(index)
       })
}

function changelink(index){
        var link_val=jQuery(d_num+index).val();
        var link_val2=jQuery(d_num_2+index).val();
        var billid_val=jQuery(d_val+index).val();
        var billid_val2=jQuery("#"+ycdag+index).val();
      jQuery(link_num+index+"span").html('<a href = "/formmode/search/CustomSearchBySimpleIframe.jsp?customid=126&isfromTab=1&check_con=11348&con11348_colname=archBelong&con11348_htmltype=3&con11348_type=161&con11348_opt=1&con11348_value='+billid_val+'&con11348_name=__random__D346723D8BCF07F95F2B03F22DC0FF24&con11348_opt1=&con11348_value1=&field11348='+billid_val+'" target="_blank">'+link_val2+'</a>'+' / '+'<a href = "/formmode/search/CustomSearchBySimpleIframe.jsp?customid=126&isfromTab=1&check_con=11348&con11348_colname=archBelong&con11348_htmltype=3&con11348_type=161&con11348_opt=1&con11348_value='+billid_val+'&con11348_name=__random__F9A7970393F2FA96C86BC521A8DD8641&con11348_opt1=&con11348_value1=&field11348='+billid_val+'&check_con=11355&con11355_colname=cabBelong&con11355_htmltype=3&con11355_type=161&con11355_opt=1&con11355_value='+billid_val2+'&con11355_name=__random__EDDDBC8775216326BA76A8A56A2433D1&con11355_opt1=&con11355_value1=&field11355='+billid_val2+'" target="_blank">'+link_val+'</a>');
}

function changelink2(index){
          var link_val=jQuery(d_num2+index).val();
        var link_val2=jQuery(d_num2_2+index).val();
        var billid_val=jQuery(d_val2+index).val();
        var billid_val2=jQuery("#"+ycdag2+index).val();
      jQuery(link_num2+index+"span").html('<a href = "/formmode/search/CustomSearchBySimpleIframe.jsp?customid=126&isfromTab=1&check_con=11348&con11348_colname=archBelong&con11348_htmltype=3&con11348_type=161&con11348_opt=1&con11348_value='+billid_val+'&con11348_name=__random__D346723D8BCF07F95F2B03F22DC0FF24&con11348_opt1=&con11348_value1=&field11348='+billid_val+'" target="_blank">'+link_val2+'</a>'+' / '+'<a href = "/formmode/search/CustomSearchBySimpleIframe.jsp?customid=126&isfromTab=1&check_con=11348&con11348_colname=archBelong&con11348_htmltype=3&con11348_type=161&con11348_opt=1&con11348_value='+billid_val+'&con11348_name=__random__D346723D8BCF07F95F2B03F22DC0FF24&con11348_opt1=&con11348_value1=&field11348='+billid_val+'&check_con=11355&con11355_colname=cabBelong&con11355_htmltype=3&con11355_type=161&con11355_opt=1&con11355_value='+billid_val2+'&con11355_name=__random__EDDDBC8775216326BA76A8A56A2433D1&con11355_opt1=&con11355_value1=&field11355='+billid_val2+'" target="_blank">'+link_val+'</a>');
}


function changetype(index,type_dt_val){
              jQuery(d_val+index).val("");
              jQuery(d_val+index+"span").text("");
              jQuery(d_val+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
              if(Number(type_dt_val)==0){
                jQuery(j_val+index).val("");
                jQuery(j_val+index+"span").text("");
                jQuery(j_val+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
                document.getElementById(j2_val+index+"_readonlytext").style.display="none"; 
              }

}

function changetype2(index,type_dt_val){
              jQuery(d_val2+index).val("");
              jQuery(d_val2+index+"span").text("");
              jQuery(d_val2+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
              if(Number(type_dt_val)==0){
                jQuery(j_val2+index).val("");
                jQuery(j_val2+index+"span").text("");
                jQuery(j_val2+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
                document.getElementById(j2_val2+index+"_readonlytext").style.display="none";
              }
}

function changetype3(index,type_dt_val){
              if(Number(type_dt_val)==1){
                jQuery(j_val+index).val("");
                jQuery(j_val+index+"span").text("");
                jQuery(j_val+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
              }

}
function changetype4(index,type_dt_val){
              if(Number(type_dt_val)==1){
                jQuery(j_val2+index).val("");
                jQuery(j_val2+index+"span").text("");
                jQuery(j_val2+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
              }
}


function changedata(){
  var indexnum000=jQuery("#indexnum0").val();
         jQuery(textval).val("");
         jQuery(shuliang).val(0);
         jQuery(shuliang+"span").text(0);
             for(var index1 =0;index1 <indexnum000;index1 ++){
               if(jQuery("#"+ycdag+index1).length<=0){
                 continue;
               }   
                      var textval_val =  jQuery(textval).val();
                      var ycdag_val=jQuery("#"+ycdag+index1).val();
                      var bool = textval_val.indexOf("#"+ycdag_val+"#");
                          if (Number(bool) >=Number(0)){
                           }else{
                                 if(ycdag_val != ""){
                                 textval_val +="#"+ycdag_val+"#";
                                 jQuery(textval).val(textval_val);
                                 var shuliang_val =jQuery(shuliang).val();
                                 var sl_val=Number(shuliang_val)+Number(1);
                                  jQuery(shuliang).val(sl_val);
                                 jQuery(shuliang+"span").text(sl_val);
                                }
                         }
         }
}

function changedata1(){
  var indexnum000=jQuery("#indexnum0").val();
         jQuery(textval2).val("");
         jQuery(shuliang2).val(0);
 jQuery(shuliang2+"span").text(0);
             for(var index2 =0;index2 <indexnum000;index2 ++){
                if(jQuery("#"+yrdag+index2).length<=0){
                 continue;
               }
                      var textval_val2 =  jQuery(textval2).val();
                      var yrdag_val=jQuery("#"+yrdag+index2).val();
                      var bool2 = textval_val2.indexOf("#"+yrdag_val+"#");
                          if (Number(bool2) >=Number(0)){
                           }else{
                                 if(yrdag_val != ""){
                                 textval_val2 +="#"+yrdag_val+"#";
                                 jQuery(textval2).val(textval_val2);
                                 var shuliang_val2 =jQuery(shuliang2).val();
                                 var sl_val2=Number(shuliang_val2)+Number(1);
                                  jQuery(shuliang2).val(sl_val2);
                                 jQuery(shuliang2+"span").text(sl_val2);
                                }
                         }
         }
}
function changedata2(){
    var indexnum111=jQuery("#indexnum1").val();
         jQuery(textval).val("");
         jQuery(shuliang).val(0);
         jQuery(shuliang+"span").text(0);
             for(var index1 =0;index1 <indexnum111;index1 ++){
               if(jQuery("#"+ycdag2+index1).length<=0){
                 continue;
               }
                      var textval_val =  jQuery(textval).val();
                      var ycdag_val=jQuery("#"+ycdag2+index1).val();
                      var bool = textval_val.indexOf("#"+ycdag_val+"#");
                          if (Number(bool) >=Number(0)){
                           }else{
                                 if(ycdag_val != ""){
                                 textval_val +="#"+ycdag_val+"#";
                                 jQuery(textval).val(textval_val);
                                 var shuliang_val =jQuery(shuliang).val();
                                 var sl_val=Number(shuliang_val)+Number(1);
                                  jQuery(shuliang).val(sl_val);
                                 jQuery(shuliang+"span").text(sl_val);
                                }
                         }
         }
}

function changedata3(){
  var indexnum111=jQuery("#indexnum1").val();
         jQuery(textval2).val("");
         jQuery(shuliang2).val(0);
 jQuery(shuliang2+"span").text(0);
             for(var index2 =0;index2 <indexnum111;index2 ++){
                if(jQuery("#"+yrdag2+index2).length<=0){
                 continue;
               }
                      var textval_val2 =  jQuery(textval2).val();
                      var yrdag_val=jQuery("#"+yrdag2+index2).val();
                      var bool2 = textval_val2.indexOf("#"+yrdag_val+"#");
                          if (Number(bool2) >=Number(0)){
                           }else{
                                 if(yrdag_val != ""){
                                 textval_val2 +="#"+yrdag_val+"#";
                                 jQuery(textval2).val(textval_val2);
                                 var shuliang_val2 =jQuery(shuliang2).val();
                                 var sl_val2=Number(shuliang_val2)+Number(1);
                                  jQuery(shuliang2).val(sl_val2);
                                 jQuery(shuliang2+"span").text(sl_val2);
                                }
                         }
         }
}
</script>


















































