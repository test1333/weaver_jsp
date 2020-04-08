<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/txrz/js/cw.js"></script>
<script type="text/javascript">
var ftlx = "#field6459";//分摊类型
var dqxz = "#field6460";//地区选择
var je = "#field6442";//金额
var sfyfp = "#field6809";//是否有发票  0 是     1 否
var fthzje="#field6598";//分摊汇总金额
var wshz = "#field6747";//未税汇总
var bmmc_dt7 = "#field6487_";//明细 7部门名称
var bl_dt7 = "#field6488_";//明细7 比例
var bmdm_dt7 = "#field6490_";//明细7   部门代码
var ftje_dt7 = "#field6489_";//明细7 
var skje = "#field6862";//收款金额


jQuery(document).ready(function () {
	showhide();
        var ftlx_valnew = jQuery(ftlx).val();
	var ftlx_valnew1 = jQuery(ftlx).val();
	var ftlx_valnew2 = jQuery(ftlx).val();
	var ftlx_valnew3 = jQuery(ftlx).val();
	var dqxz_valnew = jQuery(dqxz).val();
	jQuery("#field6846").bindPropertyChange(function(){
		jQuery(ftlx).val('');
		ftlx_valnew3 = '00';
		deldt3();
	})
		//----201903 
	jQuery("button[name=addbutton6]").live("click",function(){
		var ftlx_val = jQuery(ftlx).val();
		if(ftlx_val == '2'){
			var ind = jQuery("#indexnum6").val();
			for(var i = 0;i < ind;i++){
				if(jQuery(bl_dt7 + i).length>0){
					jQuery(bl_dt7 + i).attr("disabled","disabled");
				}
			}
			
		}		 
	});
	
	jQuery(ftlx).bindPropertyChange(function(){
		var ftlx_val = jQuery(ftlx).val();
		if(ftlx_valnew != '' &&  ftlx_valnew != null){
			deldt3();
		}	
		ftlx_valnew = ftlx_val;
		if(ftlx_val == "0"){
			jQuery("button[name=delbutton6]").hide();
			jQuery("button[name=addbutton6]").hide();
			jQuery(dqxz).val("");
			jQuery(dqxz+"span").html("");
			if(ftlx_valnew3 != '' &&  ftlx_valnew3 != null ){
				dodetail3();
			}
						
		}
		if(ftlx_val == "1"){
			jQuery("button[name=delbutton6]").hide();
			jQuery("button[name=addbutton6]").hide();
			if(ftlx_valnew2 != '' &&  ftlx_valnew2 != null ){
				jQuery(dqxz).val("");
				jQuery(dqxz+"span").html("");
				jQuery("#field6460_readonlytext").text("");	
			}
			ftlx_valnew2 = ftlx_val;	
                        ftlx_valnew3 = ftlx_val;	
		}
		if(ftlx_val == "2"){
			jQuery("button[name=delbutton6]").show();
			jQuery("button[name=addbutton6]").show();
			jQuery(dqxz).val("");
			jQuery(dqxz+"span").html("");
			var indexnum2=  jQuery("#indexnum6").val();
			for(var index=0;index <indexnum2;index++){
				if(jQuery(bmmc_dt7+index).length>0){
					jQuery(bmmc_dt7+index+"_browserbtn").removeAttr('disabled');
					jQuery(bl_dt7+index).removeAttr("readonly");
				}
				
			}
			ftlx_valnew3 = ftlx_val;					
		}		
	})
	jQuery(dqxz).bindPropertyChange(function(){
		var ftlx_val = jQuery(ftlx).val();
		var dqxz_val = jQuery(dqxz).val();		
		if(ftlx_val == "1"){
			if(dqxz_valnew != dqxz_val){
				deldt3();				
			}
			dqxz_valnew = dqxz_val;
			if(dqxz_val != ""){
				dodetail3();
			}
		}
	})
    
     //设置未税金额
    jQuery('#nodesnum4').bindPropertyChange(function () {
        setdetail0();
    })
	jQuery(wshz).bindPropertyChange(function(){
		setmoney();
	})
	
		_C.run2("field6745", function (p) {
		var sfyby_val = _C.v("field6745");//是否使用备用金
		if(sfyby_val == '0'){//0 是  1 否
			getBYYE();
			_C.v("field6611",'','');//
			_C.deleteRow(5);
			jQuery("#tab_6").attr('style', 'display:none;');
            jQuery("#tab_6_content").attr('style', 'display:none;');
		}else{
			_C.v("field6746",'','');//备用金余额
			_C.v("field6853",'','');//备用金库
			document.getElementById("tab_6").style.display='block';
			document.getElementById("tab_6_content").style.display='block';
		}
	})
	
	
	_C.run2("field6853", function (p) {
		var sfyby_val = _C.v("field6745");//是否使用备用金
		var byjk_val = _C.v("field6853");//备用金库
		if(byjk_val == '' || byjk_val.length<1){
			_C.v("field6746",'','');//备用金余额
			return ;
		}
		if(sfyby_val == '0'){//0 是  1 否
			getBYYE();
		}else{
			_C.v("field6746",'','');//备用金余额
			_C.v("field6853",'','');//备用金库
		}
	})
	
	
	checkCustomize = function(){
		
		var fplx = "#field6478_";//发票类型
		var n = 0;
		
        var fthzjeValue = jQuery(fthzje).val();
        var wshjValue = jQuery("#field6747").val();
           
        if(jQuery("#nodesnum6").val() === '0'){
            Dialog.alert("温馨提示：分摊明细表中无数据，请核对后重新提交。");
            return false;
        }

        if(fthzjeValue !== wshjValue){
            Dialog.alert("温馨提示：未税合计金额不等于分摊合计金额，请核对后重新提交。");
            return false;
        }
		// var sf_val = jQuery(sfyfp).val();
		// var nodenum = jQuery("#nodesnum6").val();
		// if(sf_val == '0' && Number(nodenum)>0){
			var je_val = jQuery(wshz).val();
			var fthzje_val = jQuery(fthzje).val();
			if(je_val == ""){
				je_val = "0";
			}
			if(fthzje_val == ""){
				fthzje_val = "0.00";
			}
			if(Number(je_val) != Number(fthzje_val)){
				alert("明细分摊金额汇总不等于未税总金额，请检查");
				return false;
				
			}
		// }
		//20190719
		var bxre = checkFybz();
		if(bxre == '0'){
			Dialog.alert("膳杂费明细  存在开始日期大于结束日期  请检查");
			return false;
		}else if(bxre == '1'){
			Dialog.alert("膳杂费明细  存在同一天时段颠倒  请检查");
			return false;
		}else if(bxre == '2'){
			Dialog.alert("膳杂费明细  存在报销金额 大于标准额度   请检查");
			return false;
		}

                //
		var sfyby_val = _C.v("field6745");//是否使用备用金、
		if(sfyby_val == '0'){//0 是  1 否
			var byed_val = _C.v("field6746");//
			var zje_val = jQuery("#field6791").val();//未税税额总和
			if(byed_val==""){
				byed_val = "0";
			}
			if(zje_val==""){
				zje_val = "0";
			}
			if(Number(byed_val)<Number(zje_val)){
				Dialog.alert("未税和税额总和大于备用金余额");
				return false;
			}		
		}
		var zje_vals = jQuery("#field6782").val();//未税税额总和---发票金额总和
		var jes = jQuery(je).val();//金额
		var skje_val = jQuery(skje).val();
		if(zje_vals==""){
			zje_vals = "0";
		}
		if(jes==""){
			jes = "0";
		}
		if(skje_val==""){
			skje_val = "0";
		}
		//0409
		var gl = jQuery("#field6611").val();
		if(sfyby_val == '1' && gl == ''){
			if(Number(skje_val) != Number(jes)){
				Dialog.alert("收款总额不等于 金额");
				return false;
			}
		}else if(gl.length>0&& gl !=''){
			var ybjr = jQuery("#field6449").val();
			if(Number(ybjr)>0){
				if(Number(skje_val) != Number(ybjr)){
					Dialog.alert("收款总额不等于 应补金额");
					return false;
				}
			}else{
				var indexs = jQuery("#nodesnum5").val();
				if(Number(indexs)>0){
					Dialog.alert("有应补金额时才可填写收款人明细!!!");
					return false;
				}
				
			}
		}
		
		//
		if(Number(zje_vals) != Number(jes)){
			Dialog.alert("未税和税额总额不等于 金额");
			return false;
		}
		
		
		var ckeckre = checkRep();
		if(!ckeckre){
			alert("发票号码有重复，请检查确认");
			return false;
		}
		var fps = checkFP();
		var isss = isEmptyObject(fps);
		if(!isss && fps.length>0){
			var fparr = unique4(fps);
			if(fparr.length >0){
				var rsu = checkFPs(fparr);
				if(!rsu){
					return false;
				}
			}
		}
		var indexnum7=jQuery("#indexnum6").val(); 
        for( var index=0;index<indexnum7;index++){
            if( jQuery(bmdm_dt7+index).length>0){
                var bmdm_dt7_val = jQuery(bmdm_dt7+index).val();
                if(bmdm_dt7_val == ""){
                	Dialog.alert("分摊明细部门代码不能为空，请检查");
                	return false; 
                }
            }
        }
		return true;
	}
	var jtsf = "field6457";//交通是否超标准
	var zssf = "field6467";//住宿是否超标准
	var czsm = "field6446";//超支申请说明：
	_C.run2(jtsf, function (p) {
		var indd = jQuery("#indexnum0").val();
		var a = 0;
		for(var i=0;i<indd;i++){
			if(jQuery("#field6457_"+i).length>0){
				var jtsf_val = jQuery("#field6457_"+i).val();
				if(jtsf_val == '0'){
					_C.rs(czsm,true);
					a++;
					break;
				}
			}
		}
		if(a<1){
			_C.rs(czsm,false);
		}
	})
	_C.run2(zssf, function (p) {
		var indd = jQuery("#indexnum1").val();
		var a = 0;
		for(var i=0;i<indd;i++){
			if(jQuery("#field6467_"+i).length>0){
				var zssf_val = jQuery("#field6467_"+i).val();
				if(zssf_val == '0'){
					_C.rs(czsm,true);
					a++;
					break;
				}
			}
		}
		if(a<1){
			_C.rs(czsm,false);
		} 
	})
	var ycbx = "field6447";
	_C.run2("field6783", function (p) {
		var retu = getMinDay();
		if(retu === '1'){
			Dialog.alert("出差结束时间不能大于申请时间，请修改！");
			_C.v("field6783","");
			_C.rs(ycbx,true);
		}
		
		if(!retu){
			_C.rs(ycbx,true);
		}else{
			_C.rs(ycbx,false);
		}
	})
	
})

  
    function setdetail0(){
        for(var i = 0;i<jQuery("#indexnum4").val();i++){
            (function(j){
                //发票类型
                jQuery("#field6478_"+j).bindPropertyChange(function () {
                    setWSJE(j)
                })

                //可抵扣金额
                jQuery("#field7061_"+j).bindPropertyChange(function () {
                    setWSJE(j)
                })
                //金额合计
                bindchange("#field6482_",setWSJE,j)
            })(i)
        }
    }
    
    function bindchange(id, fun,index) {
		var old_val = jQuery(id).val();
		setInterval(function() {
			var new_val = jQuery(id).val();
			if(old_val != new_val) {
				old_val = new_val;
				fun(index);}
			}, 100);
	}
    
    function setWSJE(index){
        var fplxValue = jQuery("#field6478_"+index).val();
        var jeheValue = jQuery("#field6482_"+index).val();
        var kdkjeValue = jQuery("#field7061_"+index).val();
            
        if(jeheValue > 0.00 && kdkjeValue >0.00){
                if(fplxValue === '3' || fplxValue === '4' || fplxValue === '5'){
                    jQuery("#field6595_"+index).val(jeheValue-kdkjeValue);
                    jQuery("#field6595_"+index).change();
                    setTimeout("doDetail('field6595', 2)",'1000');
                }else{
                    if(fplxValue !== '6'){
                            jQuery("#field6595_"+index).val("");
                    }
                    
                }
                
            }   
    }

function setmoney(){
	var ftlx_val = jQuery(ftlx).val();
	var dqxz_val = jQuery(dqxz).val();	
	var je_val = jQuery(wshz).val();	
	if(je_val == ""){
		je_val = "0";
	}
	if(ftlx_val == "0" ||(ftlx_val == "1" && dqxz_val != "")){
		var nowsum = "0";
		var count = 1;
		var nodesnum2 = jQuery("#nodesnum6").val();
		var indexnum2=  jQuery("#indexnum6").val();
		for(var index=0;index <indexnum2;index++){
			if(jQuery(bmmc_dt7+index).length>0){
				var bl_val = jQuery(bl_dt7+index).val();
				if(bl_val == ""){
					bl_val = "0";
				}
				var ftfy_val = accMul(je_val,bl_val).toFixed(2);
				if(count == nodesnum2){
					ftfy_val = accSub(je_val,nowsum);
					
				}else{
					nowsum = accAdd(ftfy_val,nowsum);
					
				}
				jQuery(ftje_dt7+index).val(ftfy_val);
				jQuery(ftje_dt7+index+"span").html("");
				count= count+1;
			}
			
		}
		calSum(6);
		jQuery(fthzje).val(je_val);
	}
}
function showhide(){
	var ftlx_val = jQuery(ftlx).val();
	if(ftlx_val !="2" && (ftlx_val =='' || ftlx_val == null)){
		jQuery("button[name=delbutton6]").hide();
		jQuery("button[name=addbutton6]").hide();
		var indexnum2=  jQuery("#indexnum6").val();
		for(var index=0;index <indexnum2;index++){
			if(jQuery(bmmc_dt7+index).length>0){
				jQuery(bmmc_dt7+index+"_browserbtn").attr('disabled',true);
				jQuery(bl_dt7+index).attr("readonly", "readonly");
			}
			
		}
	}
	
}
function dodetail3(){
	var ftxs = "#field6846";//分摊形式
	var st = new Date().getTime();
	var ftlx_val = jQuery(ftlx).val();
	var dqxz_val = jQuery(dqxz).val();
	var indexnum2 =  jQuery("#indexnum6").val();
	var ftxs_val =  jQuery(ftxs).val();
    var xhr = null;
	if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}
	if (null != xhr) {			
		xhr.open("GET","/txrz/get_ft_detail.jsp?ftlx="+ftlx_val+"&dqxz="+dqxz_val+"&type="+ftxs_val+"&st="+st, false);
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					var text = xhr.responseText;
					text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
					var text_arr = text.split("@@@");
                    var length1=Number(text_arr.length)-1+Number(indexnum2);
					for(var i=indexnum2;i<length1;i++){                                                          
						addRow6(6);
						var tmp_arr = text_arr[i-indexnum2].split("###");					
						jQuery(bmmc_dt7+i).val(tmp_arr[1]);							
						jQuery(bmmc_dt7+i+"span").text(tmp_arr[2]);
						jQuery(bmmc_dt7+i+"_browserbtn").attr('disabled',true);
						jQuery(bl_dt7+i).val(tmp_arr[3]);		
						jQuery(bl_dt7+i+"span").html("");	
						jQuery(bl_dt7+i).attr("readonly", "readonly");
						jQuery(bmdm_dt7+i).val(tmp_arr[0]);								
						jQuery(bmdm_dt7+i+"span").text(tmp_arr[0]);													
					}
				}	
			}
		}
		xhr.send(null);			
	}
	setmoney();
}
function accAdd(arg1,arg2){
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
    m=Math.pow(10,Math.max(r1,r2))
    return (arg1*m+arg2*m)/m
}

function accMul(arg1,arg2)
{
  var m=0,s1=arg1.toString(),s2=arg2.toString();
  try{m+=s1.split(".")[1].length}catch(e){}
  try{m+=s2.split(".")[1].length}catch(e){}
  return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)
}
function accSub(arg1,arg2){
   var r1,r2,m,n;
    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
     try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
       m=Math.pow(10,Math.max(r1,r2));
       //动态控制精度长度
       n=(r1>=r2)?r1:r2;
       return ((arg1*m-arg2*m)/m).toFixed(2);
}
function deldt3(){
	var nodesnum2 = jQuery("#nodesnum6").val();
	if(nodesnum2 >0){
		jQuery("[name = check_node_6]:checkbox").attr("checked", true);
		adddelid(6,bmmc_dt7);
		removeRow0(6);
	}
	
}
function adddelid(dtid,fieldidqf){
    var ids_dt1="";
              var flag1="";
            var indexnum0=  jQuery("#indexnum"+dtid).val();
            for(var index=0;index <indexnum0;index++){
                 if(jQuery(fieldidqf+index).length>0){
                      var pp=document.getElementsByName('dtl_id_'+dtid+'_'+index)[0].value;
                      ids_dt1=ids_dt1+flag1+pp;
                      flag1=",";
                }
           }
               var deldtlid0_val=jQuery("#deldtlid"+dtid).val();
               if(deldtlid0_val !=""){
                   deldtlid0_val=deldtlid0_val+","+ids_dt1;         
           }else{
                  deldtlid0_val=ids_dt1;
          }
               jQuery("#deldtlid"+dtid).val(deldtlid0_val);   
}
function removeRow0(groupid,isfromsap){
    try{
var flag = false;
    var ids = document.getElementsByName("check_node_"+groupid);
    for(i=0; i<ids.length; i++) {
        if(ids[i].checked==true) {
            flag = true;
            break;
        }
    }
    if(isfromsap){flag=true;}
    if(flag) {
        if(isfromsap || _isdel()){
        var oTable=document.getElementById("oTable"+groupid)
        var len = document.forms[0].elements.length;
        var curindex=parseInt($G("nodesnum"+groupid).value);
        var i=0;
        var rowsum1 = 0;
        var objname = "check_node_"+groupid;
        for(i=len-1; i >= 0;i--) {
            if (document.forms[0].elements[i].name==objname){
                rowsum1 += 1;
            }
        }
        rowsum1=rowsum1+2;
        for(i=len-1; i>=0; i--) {
            if(document.forms[0].elements[i].name==objname){
                if(document.forms[0].elements[i].checked==true){
                    var nodecheckObj;
                        var delid;
                    try{
                              if(jQuery(oTable.rows[rowsum1].cells[0]).find("[name='"+objname+"']").length>0){                                   
                                  delid = jQuery(oTable.rows[rowsum1].cells[0]).find("[name='"+objname+"']").eq(0).val();

                        }
                    }catch(e){}
                    //记录被删除的旧记录 id串
                    if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
                        if($G("deldtlid"+groupid).value!=''){
                            //老明细
                            $G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
                        }else{
                            //新明细
                            $G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
                        }
                    }
                    //从提交序号串中删除被删除的行
                    var submitdtlidArray=$G("submitdtlid"+groupid).value.split(',');
                    $G("submitdtlid"+groupid).value="";
                    var k;
                    for(k=0; k<submitdtlidArray.length; k++){
                        if(submitdtlidArray[k]!=delid){
                            if($G("submitdtlid"+groupid).value==''){
                                $G("submitdtlid"+groupid).value = submitdtlidArray[k];
                            }else{
                                $G("submitdtlid"+groupid).value += ","+submitdtlidArray[k];
                            }
                        }
                    }
                    oTable.deleteRow(rowsum1);

                    curindex--;
                }
                rowsum1--;
            }
        }
        $G("nodesnum"+groupid).value=curindex;
            calSum(groupid);
}
}else{
        alert('请选择需要删除的数据');
        return;
    }    }catch(e){}
    try{
        var indexNum = jQuery("span[name='detailIndexSpan0']").length;
        for(var k=1; k<=indexNum; k++){
            jQuery("span[name='detailIndexSpan0']").get(k-1).innerHTML = k;
        }
    }catch(e){}
}
function _isdel(){
    return true;
}

jQuery(document).ready(function () {
	_C.run2("field6432", function (p) {
		var tabs = [tab_1, tab_2, tab_3, tab_4, tab_5, tab_6];
		var cclx_val = _C.v("field6432");
		var tab_1 = '#tab_1';
		var tab_2 = '#tab_2';
		var tab_3 = '#tab_3';
		var tab_4 = '#tab_4';
		var tab_5 = '#tab_5';
		var tab_6 = '#tab_6';
		if(cclx_val == '0'){
			_C.deleteRow(1);
			_C.deleteRow(2);
			jQuery("#tab_2").attr('style', 'display:none;');
            jQuery("#tab_2_content").attr('style', 'display:none;');
			jQuery("#tab_3").attr('style', 'display:none;');
            jQuery("#tab_3_content").attr('style', 'display:none;');
			jQuery("#tab_1").click();
			jQuery("#tab_1").click();
		   
		}else{
			document.getElementById("tab_2").style.display='block';
			document.getElementById("tab_2_content").style.display='block';
			document.getElementById("tab_3").style.display='block';
			document.getElementById("tab_3_content").style.display='block';
            jQuery("#tab_3").click();
			jQuery("#tab_2").click();
jQuery("#tab_1").click();
			
		}
	})
})

/////
function checkFP(){
	var indexd = jQuery("#indexnum4").val();
	var nodenums = jQuery("nodesnum4").val();
	var fphm = "#field6594_";
	var b = 0;
	for(var i=0;i<indexd;i++){
		if(jQuery( fphm + i).length>0){
			var fphm_val = jQuery(fphm+i).val(); 
			if(fphm_val.length>0){
				b++;
			}
		}
	}
	var arr=new Array(b);
	var a = 0;
	for(var i=0;i<indexd;i++){
		if(jQuery( fphm + i).length>0){
			var fphm_val = jQuery(fphm+i).val();
			if(fphm_val.length>0){
				arr[a] = fphm_val;
				a++;
			}
		}
	}
	return arr;
}

function unique4(arr){
	var ree = "";
	var b = 0;
	var hash=[];
	for (var i = 0; i < arr.length; i++) {
		for (var j = i+1; j < arr.length; j++) {
			if(arr[i]===arr[j]){
				++i;
			}
		}
		var st = arr[i];
		if(st.length>0){
			hash.push(arr[i]);
		}
	}
	for(var k=0;k<hash.length;k++){
		if(b<1){
			ree = hash[k];
		}else{
			ree = ree + "," + hash[k];
		}
		b++
		  
	}
	  return ree;
}
/////
function checkFPs(fps){
	var re = true;
	var xhr = null;  
	if(window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP"); 
	}else if (window.XMLHttpRequest){ 
		xhr =new XMLHttpRequest(); 
	}
	var rid = jQuery("#field6648").val();
	var st = new Date().getTime();
	if (null!= xhr) { 
		xhr.open("GET","/txrz/checkFP.jsp?fps="+fps+"&rid="+rid+"&st="+st,false);
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4){ 
				if(xhr.status==200){
					var text= xhr.responseText; 
					text=text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
					//alert(text+"---------@");
					if(text.indexOf("@@@@@@")<0){
						Dialog.alert(text+" 号码已存在发票库");
						re =  false;
					}
				}
			}
		}
		xhr.send(); 
	}
	return re; 
}
function getDayss(sDate,eDate){
	var date1=new Date(sDate);
	var date2=new Date(eDate);
	var date3 = date1.getTime() - date2.getTime();
	if(date3<0){
		date3 = 0-date3;
	}
	var days = Math.floor(date3/(24*3600*1000));
	return days;
}
function getMinDay(){
	var ret = true;
	var ccjsrq = "#field6783";//出差结束时间
	var sqrq = "field6430";//申请日期
	var ccjsrq_v = jQuery(ccjsrq).val();
	var sqrq_val = jQuery("#"+sqrq).val();
	
	if(ccjsrq_v.length<2){
		ccjsrq_v = sqrq_val;
	}
	// alert(sqrq_val+"--"+ccjsrq_v)
	if(new Date(ccjsrq_v).getTime() > new Date(sqrq_val).getTime()){
		return '1';
	}
	var dd = getDayss(sqrq_val,ccjsrq_v);
	if(Number(dd)>14){
		return false;
	}
	return ret;
	
}
function isEmptyObject(e) {  
        var t;  
        for (t in e)  
            return !1;
        return !0;
}
function getBYYE(){
	var hrid = _C.v("field6431");
	var byjk_val1 = _C.v("field6853");//备用金库
	var xhr = null;
	if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}
	var st = new Date().getTime();
	if (null != xhr) {			
		xhr.open("GET","/txrz/getByed.jsp?byjk="+byjk_val1+"&st="+st, false);
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					var text = xhr.responseText;
					text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
					if(text.indexOf("######")<0){
						_C.v("field6746",text,text);//备用金余额
					}
				}	
			}
		}
		xhr.send(null);			
	}
	
}
function checkRep(){
	var fphm = "#field6594_";
	var resu = true ;
	var aa = 0;
	var indexd = jQuery("#indexnum4").val();
	for(var i=0;i<indexd;i++){
		if(jQuery(fphm+i).length>0){
			var fphm_vals = jQuery(fphm+i).val();
			if(fphm_vals.length>0){
				for(var j=0;j<indexd;j++){
					if(i!=j){
						if(jQuery(fphm+j).length>0){
							var fphm_valnew = jQuery(fphm+j).val();
							if(fphm_valnew.length>0){
								if(fphm_valnew == fphm_vals){
									aa++
									break;
								}
							}
						}
					}
				}	
			}
			if(aa>0){
				resu = false;
				break;
			}
		}
	}	
	return resu;
}
///////20190719  
function checkFybz(){
	var ksrq3 = "#field7036_";//开始日期
	var kssd3 = "#field7038_";//开始的上下午
	var jsrq3 = "#field7037_";//结束日期
	var jssd3 = "#field7039_";//结束的上下午   0上午  1 下午
	var bzed3 = "#field7103_";//标准额度显示字段
	var bxed3 = "#field6471_";//报销额度
	var cclx = "#field6432";//出差类型 
	var cclx_v = jQuery(cclx).val();
	var nod = jQuery("#indexnum2").val();
	for(var i=0;i<nod;i++){
		if(jQuery(ksrq3+i).length>0){
			var ksrq3_val = jQuery(ksrq3+i).val();
			var kssd3_val = jQuery(kssd3+i).val();
			var jsrq3_val = jQuery(jsrq3+i).val();
			var jssd3_val = jQuery(jssd3+i).val();
			var bzed3_val = jQuery(bzed3+i).val();
			var bxed3_val = jQuery(bxed3+i).val();
			if(ksrq3_val>jsrq3_val){//开始日期  大于 结束日期 
				return '0';
			}
			if(ksrq3_val == jsrq3_val && kssd3_val == '1' && (jssd3_val == '0' || jssd3_val == '2' )){// 同一天  时段颠倒
				return '1';
			}
			if(ksrq3_val == jsrq3_val && kssd3_val == '2' && jssd3_val == '0' ){// 同一天  时段颠倒
				return '1';
			}
			if(cclx_v =='2'){
				continue;
			}
			var date1=new Date(jsrq3_val);    //结束日期
			var date2=new Date(ksrq3_val);    //开始日期
			var date3=date1.getTime()-date2.getTime(); //时间差秒
			if(bxed3_val.length<1){
				bxed3_val = '0';
			}
			if(Number(bzed3_val) < Number(bxed3_val) && ksrq3_val != jsrq3_val){
				return '2';
			}
		}	
	}	
	return '3';
}
</script>





