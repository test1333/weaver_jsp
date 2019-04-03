<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var lx = "#field17794";     //费用承担方   下拉框属性
var rqid = "#field18152";
jQuery(document).ready(function(){
    showhide();                               //方法名称
    jQuery(lx).bind("change",function(){
      showhide();
   });
   jQuery("#yhzhbg").html("<a href=\"javascript:showInfo(\'0\')\">银行账户变更</a>");
   jQuery("#gslcbg").html("<a href=\"javascript:showInfo(\'1\')\">公司理财变更</a>");
   jQuery("#gwkbg").html("<a href=\"javascript:showInfo(\'2\')\">公务卡变更</a>");
   jQuery("#xjkbg").html("<a href=\"javascript:showInfo(\'3\')\">现金卡变更</a>");
  });
function showhide(){
    var lx_val = jQuery(lx).val();
    if(lx_val == ""){
      jQuery("#ycmx1").hide();	          //隐藏行   行id：ycmx1
      jQuery("#ycmx2").hide();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").hide();
      jQuery("#ycmx5").hide();	          
      jQuery("#ycmx6").hide();
      jQuery("#ycmx7").hide();
      jQuery("#ycmx8").hide();
      jQuery("#ycmx9").hide();
      jQuery("#ycmx10").hide();
      jQuery("#ycmx11").hide();	          
      jQuery("#ycmx12").hide();
    }else if(lx_val == "0"){
      jQuery("#ycmx1").show();	          //隐藏行   行id：ycmx1
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").hide();
      jQuery("#ycmx5").hide();	          
      jQuery("#ycmx6").hide();
      jQuery("#ycmx7").hide();
      jQuery("#ycmx8").hide();
      jQuery("#ycmx9").hide();
      jQuery("#ycmx10").hide();
      jQuery("#ycmx11").hide();	          
      jQuery("#ycmx12").hide();
    }else if(lx_val == "1"){
      jQuery("#ycmx1").hide();	          //隐藏行   行id：ycmx1
      jQuery("#ycmx2").hide();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").show();
      jQuery("#ycmx5").show();	          
      jQuery("#ycmx6").show();
      jQuery("#ycmx7").hide();
      jQuery("#ycmx8").hide();
      jQuery("#ycmx9").hide();
      jQuery("#ycmx10").hide();
      jQuery("#ycmx11").hide();	          
      jQuery("#ycmx12").hide();
    }else if(lx_val == "2"){
      jQuery("#ycmx1").hide();	          //隐藏行   行id：ycmx1
      jQuery("#ycmx2").hide();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").hide();
      jQuery("#ycmx5").hide();	          
      jQuery("#ycmx6").hide();
      jQuery("#ycmx7").show();
      jQuery("#ycmx8").show();
      jQuery("#ycmx9").show();
      jQuery("#ycmx10").hide();
      jQuery("#ycmx11").hide();	          
      jQuery("#ycmx12").hide();
    }else if(lx_val == "3"){
      jQuery("#ycmx1").hide();	          //隐藏行   行id：ycmx1
      jQuery("#ycmx2").hide();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").hide();
      jQuery("#ycmx5").hide();	          
      jQuery("#ycmx6").hide();
      jQuery("#ycmx7").hide();
      jQuery("#ycmx8").hide();
      jQuery("#ycmx9").hide();
      jQuery("#ycmx10").show();
      jQuery("#ycmx11").show();	          
      jQuery("#ycmx12").show();
    }else if(lx_val == "4"){
      jQuery("#ycmx1").show();	          //隐藏行   行id：ycmx1
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").hide();
      jQuery("#ycmx5").hide();	          
      jQuery("#ycmx6").hide();
      jQuery("#ycmx7").show();
      jQuery("#ycmx8").show();
      jQuery("#ycmx9").show();
      jQuery("#ycmx10").hide();
      jQuery("#ycmx11").hide();	          
      jQuery("#ycmx12").hide();
    }else if(lx_val == "5"){
      jQuery("#ycmx1").show();	          //隐藏行   行id：ycmx1
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").show();
      jQuery("#ycmx5").show();	          
      jQuery("#ycmx6").show();
      jQuery("#ycmx7").hide();
      jQuery("#ycmx8").hide();
      jQuery("#ycmx9").hide();
      jQuery("#ycmx10").hide();
      jQuery("#ycmx11").hide();	          
      jQuery("#ycmx12").hide();
    }else if(lx_val == "6"){
      jQuery("#ycmx1").hide();	          //隐藏行   行id：ycmx1
      jQuery("#ycmx2").hide();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").show();
      jQuery("#ycmx5").show();	          
      jQuery("#ycmx6").show();
      jQuery("#ycmx7").show();
      jQuery("#ycmx8").show();
      jQuery("#ycmx9").show();
      jQuery("#ycmx10").hide();
      jQuery("#ycmx11").hide();	          
      jQuery("#ycmx12").hide();
    }else if(lx_val == "7"){
      jQuery("#ycmx1").show();	          //隐藏行   行id：ycmx1
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").show();
      jQuery("#ycmx5").show();	          
      jQuery("#ycmx6").show();
      jQuery("#ycmx7").show();
      jQuery("#ycmx8").show();
      jQuery("#ycmx9").show();
      jQuery("#ycmx10").show();
      jQuery("#ycmx11").show();	          
      jQuery("#ycmx12").show();
    }
} 
function showInfo(type) {
        var rqid_val=jQuery(rqid).val();
		if(rqid_val == '' || rqid_val == '0'){
				alert("请先保存流程再进行创建");
				return;
		}
	    var url="";
		if(type == '0'){
		  url="/formmode/view/AddFormMode.jsp?modeId=269&formId=-428&type=1&field17945="+rqid_val;
		}else if(type == '1'){
		  url="/formmode/view/AddFormMode.jsp?modeId=272&formId=-432&type=1&field18014="+rqid_val;
		}else if(type == '2'){
		  url="/formmode/view/AddFormMode.jsp?modeId=270&formId=-431&type=1&field18016="+rqid_val;	
		}else if(type == '3'){
		  url="/formmode/view/AddFormMode.jsp?modeId=271&formId=-430&type=1&field18011="+rqid_val;	
		}
		window.open(url);
		
}  
</script>















