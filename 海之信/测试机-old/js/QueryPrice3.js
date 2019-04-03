alert(333);
jQuery(document).ready(function(){
    var supplier_str = "#field6685_"; 
    var url_str = "#field6686_";
    var indexnum1 = "#indexnum1";
    alert(indexnum1);
    jQuery("#indexnum1").bindPropertyChange(function () { 
        alert(123);
		//获取当前的行标
        var _rowindex = parseInt(document.getElementById("indexnum0").value) - 1;
        alert("_rowindex="+_rowindex); 
		bindMXBZ(_rowindex);
                
	});
});


function bindMXBZ(index){
	 $(supplier_str+index).bindPropertyChange(function () { 
             var requestid_val = jQuery("#requestid").val();   
             var supplier_val = jQuery(supplie_str+index).val(); 
 
             var tmp_val = "<a href='xxxx.jsp?requestid='"+requestid_val+"&supplier="+supplier_val+" target='_blank'>点击查看询价信息</a>";
             jQuery(url_str+index).val(tmp_val);
            jQuery(url_str+index).text(tmp_val);
                    
	});
}
