<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
      var zffs="#field10594";//支付方式
      var fkzh="field9885";//付款账号
      var fkzhmc="field9824";//付款账号名称
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
	（1）请款理由：（字段组合出来，包括月份+客户简称+代垫税金，需要自动出来，不能超过50个字符） 
	（2）明细表根据主表选择的客户自动带出逾期未收款项（到期还没有收回的应收账款）（数据源来自于ECC）

    */

    var id_ddsj = "#field11190"; //代垫税金
    var id_khjc = "#field11803";//客户简称
	var id_qkrq = "#field9820";//请款日期
	var id_qkly = "#field10453";//请款理由
var khbh = "#field9887_"; // 客户编号
	var pzbh= "#field9837_"; // 凭证编号
	var pzrq = "#field9838_"; // 凭证日期
	var dqr = "#field10889_"; // 到期日
	var je= "#field14081_"; //金额
	var bz= "#field9839_"; // 币种
	var wb = "#field9841_";//文本
      var khbm="#field10811";
        var gsdm ="#field12443";
        var qkrq ="#field9820";
	jQuery(document).ready(function () {
		jQuery(khbm).bindPropertyChange(function (){ 
             var indexnum1=  jQuery("#nodesnum1").val();
                if(indexnum1>0){
                      jQuery("[name = check_node_1]:checkbox").attr("checked", true);
                    deleteRow1(1);                                                               
                }  
			var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var khbm_val = jQuery(khbm).val();
                        var gsdm_val = jQuery(gsdm).val();
                        var qkrq_val = jQuery(qkrq).val();
                        indexnum1 = jQuery("#indexnum1").val();
			xhr.open("GET","/feilida/finance/getFI03Info.jsp?id="+khbm_val+"&custom="+gsdm_val+"&qkrq="+qkrq_val, false);
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
							var text_arr = text.split("@@@");
                                                         var length1=Number(text_arr.length)-1+Number(indexnum1);
							for(var i=indexnum1;i<length1;i++){                                                          
								addRow1(1);
								var tmp_arr = text_arr[i-indexnum1].split("###");							
								jQuery(khbh+i).val(tmp_arr[0]);							
								jQuery(khbh+i+"span").text(tmp_arr[0]);	
								jQuery(pzbh+i).val(tmp_arr[1]);							
								jQuery(pzbh+i+"span").text(tmp_arr[1]);
								jQuery(pzrq+i).val(tmp_arr[2]);							
								jQuery(pzrq+i+"span").text(tmp_arr[2]);
								jQuery(dqr+i).val(tmp_arr[3]);							
								jQuery(dqr+i+"span").text(tmp_arr[3]);
								jQuery(je+i).val(tmp_arr[4]);							
								jQuery(je+i+"span").text(tmp_arr[4]);
								jQuery(bz+i).val(tmp_arr[5]);							
								jQuery(bz+i+"span").text(tmp_arr[5]);
								jQuery(wb+i).val(tmp_arr[6]);							
								jQuery(wb+i+"span").text(tmp_arr[6]);																										
						}
					}	
				}
			}
			xhr.send(null);			
		}
	 })
	 
   checkCustomize = function () {
        var isSuccess = true;
	var mon = new Date($(id_qkrq).val().replace(/-/g, "/")).Format("MM");
	var khjc = $(id_khjc).val();
	var ddsj = $(id_ddsj).val();	
        $(id_qkly).val(mon + "月" + khjc + ddsj);

            /*
            列表中，只要有行，就提示 “该供应商有未收款项，不准许提交代垫”
            */
            var trs = $("#oTable1 tr");
            if (trs.length > 3) {
                window.top.Dialog.alert("该供应商有未收款项，不准许提交代垫！");
                isSuccess = false;
                return false;

            }


        return isSuccess;
    }
 });

 
    

</script>









































