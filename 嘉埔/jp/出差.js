<script type="text/javascript">

    var sqr="#field6539";
    var reid="#field6671";
    var ccsj = "#field6544";
    var fhsj = "#field6545";

	jQuery(document).ready(function () {
        checkCustomize = function () {
            var sqr_val=jQuery(sqr).val();
            var reid_val=jQuery(reid).val();
            var ccsj_val = jQuery(ccsj).val();
            var fhsj_val = jQuery(fhsj).val();
            if(reid_val == ''){
              reid_val = '0';
            }
            if(ccsj_val !='' && fhsj_val !=''){
            var countnum=getCount(sqr_val,reid_val,ccsj_val,fhsj_val);
            if(Number(countnum)>0){
                alert("出差时间冲突，如有问题请联系管理员。");
                return false;
            }          
          }
          return true;
        }
     });

     function getCount(sqrval,reidval,ccsj_val,fhsj_val){
         var countnum='0';
        var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			xhr.open("GET","/jp/getInfo.jsp?sqr="+sqrval+"&reid="+reidval+"&ccsjval="+ccsj_val+"&fhsjval="+fhsj_val, false);
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');	
                            countnum = text;								                          
					     }	
				    }
			}
			xhr.send(null);			
		}
        return countnum;
     }
</script>