<!--script代码，如果需要引用js文件，请使用与HTML中相同的方式。-->
<script type='text/javascript'src='/goodbaby/js/cw.js'></script>
<script type="text/javascript" >
	jQuery(document).ready(function(){
		var fprq="field15316";//发票日期
		var fkq="field16106";//付款期限
		var fp = "field15596";//发票
		_C.run2(fprq, function (p) {
			if(p.v.n != ''){
				var fp_val = _C.v(fp+p.r);
				var fprq_val = _C.v(fprq+p.r);
				var fkq_val = getFkq(fp_val,fprq_val);
				_C.v(fkq+p.r,fkq_val);
			}
			
		})
	
	})

	function getFkq(fpid,fprq){
		var fkqs = "";		
		var xhr=null;  
		if(window.ActiveXObject){//IE浏览器 
			xhr = new ActiveXObject("Microsoft.XMLHTTP"); 
		}else if(window.XMLHttpRequest){ 
			xhr=new XMLHttpRequest(); 
		} 
		if(null!=xhr){ 
			xhr.open("GET","/goodbaby/payment/GetFkq.jsp?fp="+fpid,false);
			xhr.onreadystatechange = function(){
			if(xhr.readyState==4){
				if(xhr.status==200){
					var text=xhr.responseText; 
					text =text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
					fkqs = addDate(fprq,text);
				} 
				} 
			} 
			xhr.send(null); 
		}		
		//alert(fkqs);
		return fkqs;
	}
	function addDate(date,days){
           if (days == undefined || days == '') {
               days = 1;
           }
		  // alert("date--"+date+"--days-"+days);
           var datess = new Date(date);
           datess.setDate(datess.getDate() + Number(days));
           var month = datess.getMonth() + 1;
           var day = datess.getDate();
		  // alert(datess.getFullYear() + '-' + getFormatDate(month) + '-' + getFormatDate(day));
           return datess.getFullYear() + '-' + getFormatDate(month) + '-' + getFormatDate(day);
	}
	function getFormatDate(arg){
            if (arg == undefined || arg == '') {
                return '';
            }
            var re = arg + '';
            if (re.length < 2) {
                re = '0' + re;
            }
            return re;
	}
</script>



