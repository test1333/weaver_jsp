<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var wllb="#field23431" //物料类别
var glgdzcqglc= "field23434"; //关联固定资产请购流程
var xmmc= "field27946"; //项目名称
var xmbh="field23436"; //项目编号
var account="#field24471"  //金额

var bcbxje = "#field24469"; //本次报销金额
var bcfkje = "#field24470";//本次付款金额

var zhu_ys = "#field24457"; //付款类别 主表
var mingx_ys = "field24485_"; //付款类别 明细表

var xmmcfk="#field42707";//项目名称费控	
var xmsyje="#field42708";//项目剩余金额

function getaccount()
{
	var bcbxje_val = jQuery(bcbxje).val().replace(/,/gi,'');
        var bcfkje_val = jQuery(bcfkje).val().replace(/,/gi,'');
      //alert("报销"+bcbxje_val +"付款"+bcfkje_val +"");
    if (Number(bcbxje_val)>Number(bcfkje_val))
	{
	    jQuery(account).val(bcbxje_val);
	}
	else
	{
	    jQuery(account).val(bcfkje_val);
	}
}

jQuery(bcbxje).bindPropertyChange(function(){
	 getaccount();
});

jQuery(bcfkje).bindPropertyChange(function(){
	 getaccount();
});


jQuery("button[name=addbutton0]").live("click",function(){
      var indexnum0=jQuery("#indexnum0").val();
	        for(var index =0;index <indexnum0;index ++){     
		   if(jQuery("#"+mingx_ys+index).length>0){
            jQuery("#"+mingx_ys+index).bindPropertyChange(function(){
				cal_check();
			});	
		}     
      } 
});

jQuery("button[name=delbutton0]").live("click",function(){
	var indexnum1 = jQuery("#nodesnum1").val();
		if (indexnum1 > 0) {
			jQuery("[name = check_node_1]:checkbox").attr("checked", true);
			deleteRow1(1);
		}
		cal_check();
});


function cal_check(){
    var flag0 = "0";
	var flag1 = "0";
	var flag2 = "0";	
	

	for(var i=0;i<100;i++){
		if(jQuery("#"+mingx_ys+i).length>0)
		{
			var temp = jQuery("#"+mingx_ys+i).val();
            if (temp==0)
			{
				flag0++;
			}
			else if(temp==1)
			{
				flag1++;
			}
			else if(temp==2)
			{
				flag2++;
			}
		}
    }
	if (flag1>0)
    {
		jQuery(zhu_ys+"span").val("报销");
		jQuery(zhu_ys).val("1");
	}
	else if (flag2>0 && flag1==0)
	{
		jQuery(zhu_ys+"span").val("付款且报销");
		jQuery(zhu_ys).val("2");
	}
	else
	{
		jQuery(zhu_ys+"span").val("付款");
		jQuery(zhu_ys).val("0");
	}
}
jQuery(document).ready(function(){
	 checkCustomize = function () {
		 var xmmcfk_val = jQuery(xmmcfk).val();
		 
		 if(xmmcfk_val !=""){
	        var bcfkje_val = jQuery(bcfkje).val().replace(/,/g,'');
	        var xmsyje_val = jQuery(xmsyje).val().replace(/,/g,'');
	        if(bcfkje_val == ""){
	          bcfkje_val = "0";	
	        }
	         if(xmsyje_val == ""){
	          xmsyje_val = "0";	
	        }
	        if(Number(bcfkje_val)>Number(xmsyje_val)){
	            alert("本次付款金额不能大于项目剩余金额，请检查");
	            return false;	
	        }
	     }
	 	 return true;
	 }
	
});
</script>
