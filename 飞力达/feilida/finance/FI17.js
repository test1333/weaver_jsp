<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
      var zffs="#field10628";//支付方式
      var fkzh="field9575";//付款账号
      var fkzhmc="field9337";//付款账号名称
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
	（1）请款理由：（字段组合出来，无需输入，月份+员工名称+借款，不能超过50个字符）
	（2）根据员工供应商编号自动带出员工未还款项明细；

    */

	var id_jk = "#field11921";//借款
    var id_ygmc = "#field9318";//员工姓名
	var id_qkrq = "#field9319";//请款日期
	var id_qkly = "#field9339";//请款理由

	var khbh = "#field9611_"; // 客户编号
	var pzbh= "#field9344_"; // 凭证编号
	var pzrq = "#field9345_"; // 凭证日期	
	var bz= "#field12081_"; // 币种
	var je= "#field9347_"; //金额
	var wb = "#field9348_";//文本
      var khbm="#field9573";
        var gsdm ="#field10238";
        var qkrq ="#field9319";
	jQuery(document).ready(function () {
		jQuery(khbm).bindPropertyChange(function (){ 
             var indexnum1=  jQuery("#indexnum0").val();
                if(indexnum1>0){
                      jQuery("[name = check_node_0]:checkbox").attr("checked", true);
                    deleteRow0(0);                                                               
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
			xhr.open("GET","/feilida/finance/getFI17Info.jsp?id="+khbm_val+"&custom="+gsdm_val+"&qkrq="+qkrq_val, false);
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');				
							var text_arr = text.split("@@@");
                            var length1=Number(text_arr.length)-1+Number(indexnum1);
							for(var i=indexnum1;i<length1;i++){                                                          
								addRow0(0);
								var tmp_arr = text_arr[i-indexnum1].split("###");							
								jQuery(khbh+i).val(tmp_arr[0]);							
								jQuery(khbh+i+"span").text(tmp_arr[0]);	
								jQuery(pzbh+i).val(tmp_arr[1]);							
								jQuery(pzbh+i+"span").text(tmp_arr[1]);
								jQuery(pzrq+i).val(tmp_arr[2]);							
								jQuery(pzrq+i+"span").text(tmp_arr[2]);
								jQuery(bz+i).val(tmp_arr[3]);							
								jQuery(bz+i+"span").text(tmp_arr[3]);
								jQuery(je+i).val(tmp_arr[4]);							
								jQuery(je+i+"span").text(tmp_arr[4]);
								jQuery(wb+i).val(tmp_arr[5]);							
								jQuery(wb+i+"span").text(tmp_arr[5]);																										
						}
					}	
				}
			}
			xhr.send(null);			
		}
	 })

    checkCustomize = function () {
        var isSuccess = true;
	var mon = new Date($(id_qkrq).val().replace(/-/g, "/")).Format("MM");//截取月份
	var ygmc = $(id_ygmc).innerText.toString();
	var jk = $(id_jk).val();
        

        $(id_qkly).val(mon +"月"+ ygmc + jk);
        return isSuccess;
    }
});
    


</script>


























