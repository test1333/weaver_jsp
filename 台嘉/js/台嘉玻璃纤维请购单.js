<script type="text/javascript">
var qgj_dt1 = "#field6576_";//明细1前购价
var sjdqgj_dt1 = "#field6577_";//明细1上年度前购价
var qgj1_dt1 = "#field6612_";//明细1前购价1
var sjdqgj1_dt1 = "#field6613_";//明细1上年度前购价1
jQuery(document).ready(function () {
	setTimeout(setCheck,1000);
	setTimeout(doreadonly,1000);
	
})

function doreadonly(){
	var indexnum0 = jQuery("#indexnum0").val();
	for(var index=0;index<indexnum0;index++){
		if(jQuery(qgj_dt1+index).length>0){
			bindchange(index);
		}
		
	}
	
}

function bindchange(index){
	 jQuery(qgj1_dt1+index).bindPropertyChange(function(){    
		var qgj1_dt1_val = jQuery(qgj1_dt1+index).val();
		if(qgj1_dt1_val == "" || Number(qgj1_dt1_val)==Number("0") ){
			jQuery(qgj_dt1+index).removeAttr("readonly");			
		}else{
			jQuery(qgj_dt1+index).attr("readonly", "readonly");
		}
	})
	jQuery(sjdqgj1_dt1+index).bindPropertyChange(function(){    
		var sjdqgj1_dt1_val = jQuery(sjdqgj1_dt1+index).val();
		if(sjdqgj1_dt1_val == "" || Number(sjdqgj1_dt1_val)==Number("0") ){
			jQuery(sjdqgj_dt1+index).removeAttr("readonly");			
		}else{
			jQuery(sjdqgj_dt1+index).attr("readonly", "readonly");
		}
	})
	
}

function setCheck(){
	var index1 = jQuery("#indexnum0").val();
	for(var i=0;i<index1;i++){
		checksl(i);
		getMincs(i);
	}
}

function checksl(ind){
	var sl_1 = "#field6409_";//明细1 数量
	var sl_2 = "#field6427_";//明细2 数量
	jQuery(sl_1+ind).bindPropertyChange(function () {
		jQuery(sl_2+ind).val(jQuery(sl_1+ind).val());
		jQuery(sl_2+ind+"span").text(jQuery(sl_1+ind).val());
	})
}

function getMincs(inde){
	var dj1 = "#field6415_";//单价1
	var dj2 = "#field6419_";//单价2
	var dj3 = "#field6423_";//单价3
	
	var jg1 = "#field6584_";//价格1
	var jg2 = "#field6585_";//价格2
	var jg3 = "#field6586_";//价格3
	var slv1 = "#field6565_";//税率小数1 浏览按钮
	var slv2 = "#field6566_";//税率2 浏览按钮
	var slv3 = "#field6567_";//税率3 浏览按钮
	
	var cs1 = "#field6414_";//厂商1
	var cs2 = "#field6418_";//厂商2
	var cs3 = "#field6422_";//厂商3
	
	// var minCs = "#field6426_";//最小厂商
	// var minDj = "#field6573_";//最小单价
	jQuery(cs1+inde).bind('change',function(){
		var jg1_val = jQuery(jg1+inde).val();
		var jg2_val = jQuery(jg2+inde).val();
		var jg3_val = jQuery(jg3+inde).val();
		var cs1_val = jQuery(cs1+inde).val();
		var cs2_val = jQuery(cs2+inde).val();
		var cs3_val = jQuery(cs3+inde).val();
		getAndSet(jg1_val,cs1_val,jg2_val,cs2_val,jg3_val,cs3_val,inde);
		
	})
	jQuery(dj1+inde).bind('change',function(){
		var jg1_val = jQuery(jg1+inde).val();
		var jg2_val = jQuery(jg2+inde).val();
		var jg3_val = jQuery(jg3+inde).val();
		var cs1_val = jQuery(cs1+inde).val();
		var cs2_val = jQuery(cs2+inde).val();
		var cs3_val = jQuery(cs3+inde).val();
		getAndSet(jg1_val,cs1_val,jg2_val,cs2_val,jg3_val,cs3_val,inde);
		
	})
	jQuery(jg1+inde).bindPropertyChange(function(){
		var jg1_val = jQuery(jg1+inde).val();
//alert(jg1_val);
		var jg2_val = jQuery(jg2+inde).val();
		var jg3_val = jQuery(jg3+inde).val();
		var cs1_val = jQuery(cs1+inde).val();
		var cs2_val = jQuery(cs2+inde).val();
		var cs3_val = jQuery(cs3+inde).val();
		getAndSet(jg1_val,cs1_val,jg2_val,cs2_val,jg3_val,cs3_val,inde);
		
	})
	jQuery(cs2+inde).bind('change',function(){
		var jg1_val = jQuery(jg1+inde).val();
		var jg2_val = jQuery(jg2+inde).val();
		var jg3_val = jQuery(jg3+inde).val();
		var cs1_val = jQuery(cs1+inde).val();
		var cs2_val = jQuery(cs2+inde).val();
		var cs3_val = jQuery(cs3+inde).val();
		getAndSet(jg1_val,cs1_val,jg2_val,cs2_val,jg3_val,cs3_val,inde);
		
	})
	jQuery(dj2+inde).bind('change',function(){
		var jg1_val = jQuery(jg1+inde).val();
		var jg2_val = jQuery(jg2+inde).val();
		var jg3_val = jQuery(jg3+inde).val();
		var cs1_val = jQuery(cs1+inde).val();
		var cs2_val = jQuery(cs2+inde).val();
		var cs3_val = jQuery(cs3+inde).val();
		getAndSet(jg1_val,cs1_val,jg2_val,cs2_val,jg3_val,cs3_val,inde);
		
	})
	jQuery(jg2+inde).bindPropertyChange(function(){
		var jg1_val = jQuery(jg1+inde).val();
		var jg2_val = jQuery(jg2+inde).val();
		var jg3_val = jQuery(jg3+inde).val();
		var cs1_val = jQuery(cs1+inde).val();
		var cs2_val = jQuery(cs2+inde).val();
		var cs3_val = jQuery(cs3+inde).val();
		getAndSet(jg1_val,cs1_val,jg2_val,cs2_val,jg3_val,cs3_val,inde);
		
	})
	jQuery(cs3+inde).bind('change',function(){
		var jg1_val = jQuery(jg1+inde).val();
		var jg2_val = jQuery(jg2+inde).val();
		var jg3_val = jQuery(jg3+inde).val();
		var cs1_val = jQuery(cs1+inde).val();
		var cs2_val = jQuery(cs2+inde).val();
		var cs3_val = jQuery(cs3+inde).val();
		getAndSet(jg1_val,cs1_val,jg2_val,cs2_val,jg3_val,cs3_val,inde);
		
	})
	jQuery(dj3+inde).bind('change',function(){
		var jg1_val = jQuery(jg1+inde).val();
		var jg2_val = jQuery(jg2+inde).val();
		var jg3_val = jQuery(jg3+inde).val();
		var cs1_val = jQuery(cs1+inde).val();
		var cs2_val = jQuery(cs2+inde).val();
		var cs3_val = jQuery(cs3+inde).val();
		getAndSet(jg1_val,cs1_val,jg2_val,cs2_val,jg3_val,cs3_val,inde);
		
	})
	jQuery(jg3+inde).bindPropertyChange(function(){
		var jg1_val = jQuery(jg1+inde).val();
		var jg2_val = jQuery(jg2+inde).val();
		var jg3_val = jQuery(jg3+inde).val();
		var cs1_val = jQuery(cs1+inde).val();
		var cs2_val = jQuery(cs2+inde).val();
		var cs3_val = jQuery(cs3+inde).val();
		getAndSet(jg1_val,cs1_val,jg2_val,cs2_val,jg3_val,cs3_val,inde);
		
	})
}
function getAndSet(dj1_val,cs1_val,dj2_val,cs2_val,dj3_val,cs3_val,inde){
	
	var minCs = "#field6426_";//最小厂商
	var minDj = "#field6573_";//最小单价
	var slv1 = "#field6568_";//税率小数1
	var slv2 = "#field6569_";//税率2
	var slv3 = "#field6570_";//税率3
	var minslv = "#field6587_";//最小税率
	var slv1_val = jQuery(slv1+inde).val();
	var slv2_val = jQuery(slv2+inde).val();
	var slv3_val = jQuery(slv3+inde).val();
	//alert("dj1_val-----"+dj1_val+"----dj2_val---"+dj2_val+"----dj3_val---"+dj3_val+"----cs1_val--"+cs1_val+"----cs2_val--"+cs2_val+"----cs3_val--"+cs3_val);
	//alert("slv1_val-----"+slv1_val+"----slv2_val---"+slv2_val+"----slv3_val---"+slv3_val);
	var n1 = 0;
	var n2 = 0;
	var n3 = 0;
	if(Number(dj1_val)>0&&cs1_val.length>0&&dj1_val.length>0){
		n1 = 1 ;
	}
	if(Number(dj2_val)>0&&cs2_val.length>0&&dj2_val.length>0){
		n2 = 2 ;
	}
	if(dj3_val.length>0&&cs3_val.length>0&&Number(dj3_val)>0){
		n3 = 3 ;
	}
	if(n1>0&&n2>0&&n3>0){
		var rs = getM(dj1_val,dj2_val,dj3_val);
		if(rs == '1'){
			jQuery(minCs+inde).val(cs1_val);
			jQuery(minCs+inde+"span").text(cs1_val);
			jQuery(minDj+inde).val(dj1_val);
			jQuery(minDj+inde+"span").text(dj1_val);
			jQuery(minslv+inde).val(slv1_val);
			jQuery(minslv+inde+"span").text(slv1_val);
		}else if(rs == '2'){
			jQuery(minCs+inde).val(cs2_val);
			jQuery(minCs+inde+"span").text(cs2_val);
			jQuery(minDj+inde).val(dj2_val);
			jQuery(minDj+inde+"span").text(dj2_val);
			jQuery(minslv+inde).val(slv2_val);
			jQuery(minslv+inde+"span").text(slv2_val);
		}else if(rs == '3'){
			jQuery(minCs+inde).val(cs3_val);
			jQuery(minCs+inde+"span").text(cs3_val);
			jQuery(minDj+inde).val(dj3_val);
			jQuery(minDj+inde+"span").text(dj3_val);
			jQuery(minslv+inde).val(slv3_val);
			jQuery(minslv+inde+"span").text(slv3_val);
		}		
	}else if(n1>0&&n2>0){
		if(Number(dj1_val)>=Number(dj2_val)){
			jQuery(minCs+inde).val(cs2_val);
			jQuery(minCs+inde+"span").text(cs2_val);
			jQuery(minDj+inde).val(dj2_val);
			jQuery(minDj+inde+"span").text(dj2_val);
			jQuery(minslv+inde).val(slv2_val);
			jQuery(minslv+inde+"span").text(slv2_val);
		}else{
			jQuery(minCs+inde).val(cs1_val);
			jQuery(minCs+inde+"span").text(cs1_val);
			jQuery(minDj+inde).val(dj1_val);
			jQuery(minDj+inde+"span").text(dj1_val);
			jQuery(minslv+inde).val(slv1_val);
			jQuery(minslv+inde+"span").text(slv1_val);
		}
	}else if(n1>0&&n3>0){
		if(Number(dj1_val)>=Number(dj3_val)){
			jQuery(minCs+inde).val(cs3_val);
			jQuery(minCs+inde+"span").text(cs3_val);
			jQuery(minDj+inde).val(dj3_val);
			jQuery(minDj+inde+"span").text(dj3_val);
			jQuery(minslv+inde).val(slv3_val);
			jQuery(minslv+inde+"span").text(slv3_val);
		}else{
			jQuery(minCs+inde).val(cs1_val);
			jQuery(minCs+inde+"span").text(cs1_val);
			jQuery(minDj+inde).val(dj1_val);
			jQuery(minDj+inde+"span").text(dj1_val);
			jQuery(minslv+inde).val(slv1_val);
			jQuery(minslv+inde+"span").text(slv1_val);
		}
	}else if(n2>0&&n3>0){
		if(Number(dj2_val)>=Number(dj3_val)){
			jQuery(minCs+inde).val(cs3_val);
			jQuery(minCs+inde+"span").text(cs3_val);
			jQuery(minDj+inde).val(dj3_val);
			jQuery(minDj+inde+"span").text(dj3_val);
			jQuery(minslv+inde).val(slv3_val);
			jQuery(minslv+inde+"span").text(slv3_val);
		}else{
			jQuery(minCs+inde).val(cs2_val);
			jQuery(minCs+inde+"span").text(cs2_val);
			jQuery(minDj+inde).val(dj2_val);
			jQuery(minDj+inde+"span").text(dj2_val);
			jQuery(minslv+inde).val(slv2_val);
			jQuery(minslv+inde+"span").text(slv2_val);
		}
	}else if(n1>0){
		jQuery(minCs+inde).val(cs1_val);
		jQuery(minCs+inde+"span").text(cs1_val);
		jQuery(minDj+inde).val(dj1_val);
		jQuery(minDj+inde+"span").text(dj1_val);
		jQuery(minslv+inde).val(slv1_val);
		jQuery(minslv+inde+"span").text(slv1_val);
	}else if(n2>0){
		jQuery(minCs+inde).val(cs2_val);
		jQuery(minCs+inde+"span").text(cs2_val);
		jQuery(minDj+inde).val(dj2_val);
		jQuery(minDj+inde+"span").text(dj2_val);
		jQuery(minslv+inde).val(slv2_val);
		jQuery(minslv+inde+"span").text(slv2_val);
	}else if(n3>0){
		jQuery(minCs+inde).val(cs3_val);
		jQuery(minCs+inde+"span").text(cs3_val);
		jQuery(minDj+inde).val(dj3_val);
		jQuery(minDj+inde+"span").text(dj3_val);
		jQuery(minslv+inde).val(slv3_val);
		jQuery(minslv+inde+"span").text(slv3_val);
	}else{
		jQuery(minCs+inde).val('');
		jQuery(minCs+inde+"span").text('');
		jQuery(minDj+inde).val('');
		jQuery(minDj+inde+"span").text('');
		jQuery(minslv+inde).val('');
		jQuery(minslv+inde+"span").text('');
	}
jQuery("#field6427_"+inde).blur();	
}



function getM(m,n,k){
	if(Number(m)<=Number(n)&&Number(m)<=Number(k)){
		return '1';
	}else if(Number(n)<=Number(m)&&Number(n)<=Number(k)){
		return '2';
	}else if(Number(k)<=Number(m)&&Number(k)<=Number(n)){
		return '3';
	}
}



</script>







