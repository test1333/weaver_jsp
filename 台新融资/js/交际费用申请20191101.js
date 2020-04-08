<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/txrz/js/cw.js"></script>
<script type="text/javascript">
var ftlx = "#field6356";//分摊类型
var dqxz = "#field6338";//地区选择
var je = "#field6331";//金额
var blhz  = "#field6735";//未税金额合计
var sfyfp = "#field6808";//是否有发票  0 是     1 否
var fthzje="#field6359";//分摊汇总金额
var bmmc_dt3 = "#field6350_";//明细 3部门名称
var bl_dt3 = "#field6351_";//明细3 比例
var bmdm_dt3 = "#field6352_";//明细3 部门代码
var ftje_dt3 = "#field6355_";//明细3  分摊金额
var skje = "#field6861";//收款金额
jQuery(document).ready(function () {
	showhide();
         var ftlx_valnew = jQuery(ftlx).val();
         var ftlx_valnew1 = jQuery(ftlx).val();
         var ftlx_valnew2 = jQuery(ftlx).val();
         var ftlx_valnew3 = jQuery(ftlx).val();
	var dqxz_valnew = jQuery(dqxz).val();
	jQuery("#field6845").bindPropertyChange(function(){
		jQuery(ftlx).val('');
		ftlx_valnew3 = '00';
		deldt3();
	})
	
	
	//----201903
jQuery("button[name=addbutton2]").live("click",function(){
		var ftlx_val = jQuery(ftlx).val();
		if(ftlx_val == '2'){
			var ind = jQuery("#indexnum2").val(); 
			for(var i=0;i<ind;i++){
				if(jQuery(bmmc_dt3+i).length>0){
					jQuery(bl_dt3+i).attr("readonly","readonly");
				}
			}
			
		}		 
	});
	
	///
	
	
	
	
	jQuery(ftlx).bindPropertyChange(function(){
		var ftlx_val = jQuery(ftlx).val();
		if(ftlx_valnew != '' &&  ftlx_valnew != null){
			deldt3();
		}
                ftlx_valnew = ftlx_val;
		if(ftlx_val == "0"){
			jQuery("button[name=delbutton2]").hide();
			jQuery("button[name=addbutton2]").hide();
			jQuery(dqxz).val("");
			jQuery(dqxz+"span").html("");
            jQuery("#field6338_readonlytext").text("");
			if(ftlx_valnew3 != '' &&  ftlx_valnew3 != null ){
				dodetail3();
			}
			ftlx_valnew3 = ftlx_val;
						
		}
		if(ftlx_val == "1"){
			jQuery("button[name=delbutton2]").hide();
			jQuery("button[name=addbutton2]").hide();
			if(ftlx_valnew2 != '' &&  ftlx_valnew2 != null ){
				jQuery(dqxz).val("");
				jQuery(dqxz+"span").html("");
				jQuery("#field6338_readonlytext").text("");	
			}
			ftlx_valnew2 = ftlx_val;
                        ftlx_valnew3 = ftlx_val;				
		}
		if(ftlx_val == "2"){
			jQuery("button[name=delbutton2]").show();
			jQuery("button[name=addbutton2]").show();
                        ftlx_valnew3 = ftlx_val;
			jQuery(dqxz).val("");
			jQuery(dqxz+"span").html("");
                        jQuery("#field6338_readonlytext").text("");	
			var indexnum2=  jQuery("#indexnum2").val();
			for(var index=0;index <indexnum2;index++){
				if(jQuery(bmmc_dt3+index).length>0){
					// jQuery(bmmc_dt3+index+"_browserbtn").attr('disabled',false);
					jQuery(bmmc_dt3+index+"_browserbtn").removeAttr('disabled');
					jQuery(bl_dt3+index).removeAttr("readonly");
					// jQuery(bl_dt3+index).attr("readonly", "readonly");
				}
			}				
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
	
	jQuery("#field6735").bindPropertyChange(function(){//未税金额合计
		setmoney();
	})
    
    //设置未税金额
    jQuery('#nodesnum1').bindPropertyChange(function () {
        setdetail0();
    })
	
	_C.run2("field6730", function (p) {
		var sfyby_val = _C.v("field6730");//是否使用备用金
		if(sfyby_val == '0'){//0 是  1 否
			var byjk_val = _C.v("field6852");//备用金库
			getBYYE();
			_C.v("field6625",'','');//
			_C.deleteRow(0);
			jQuery("#mx1").hide();
		}else{
			_C.v("field6731",'','');//备用金余额
			_C.v("field6852",'','');//备用金库
			jQuery("#mx1").show();
		}
	})
	_C.run2("field6852", function (p) {
		var sfyby_val = _C.v("field6730");//是否使用备用金
		var byjk_val = _C.v("field6852");//备用金库
		if(byjk_val == '' || byjk_val.length<1){
			_C.v("field6731",'','');//备用金余额
			return ;
		}
		if(sfyby_val == '0'){//0 是  1 否
			getBYYE();
		}else{
			_C.v("field6731",'','');//备用金余额
			_C.v("field6852",'','');//备用金库
		}
	})	
	checkCustomize = function(){
        var fplx = "#field6354_";//发票类型
		var n = 0;
		
		
		
        var blhzValue = jQuery(blhz).val();
        var fthzjeValue = jQuery(fthzje).val();
        if(blhzValue !== fthzjeValue){
            Dialog.alert("温馨提示：分摊总金额不等于未税总金额,请核对后重新提交。");
            return false;
        }
        
        if(jQuery("#nodesnum2").val() === '0'){
            Dialog.alert("温馨提示：分摊明细表无数据请核对后重新提交。");
            return false;
        }
        
        
		// var sf_val = jQuery(sfyfp).val();
		// var nodenum = jQuery("#nodesnum2").val();
		// if(sf_val == '0' && Number(nodenum)>0){
			var je_val = jQuery(blhz).val();
			var fthzje_val = jQuery(fthzje).val();
			if(je_val == ""){
				je_val = "0";
			}
			if(fthzje_val == ""){
				fthzje_val = "0";
			}
			if(Number(je_val) != Number(fthzje_val)){
				alert("明细分摊金额汇总不等于未税总金额，请检查");
				return false;
				
			}
		// }
		
		var sfyby_val = _C.v("field6730");//是否使用备用金、
		if(sfyby_val == '0'){//0 是  1 否
			var byed_val = _C.v("field6731");//
			var zje_val = jQuery("#field6790").val();//未税税额总和
			if(byed_val==""){
				byed_val = "0";
			}
			if(zje_val==""){
				zje_val = "0";
			}
			if(Number(byed_val)<Number(zje_val)){
				Dialog.alert("未税和税额总额大于备用金余额");
				return false;
			}		
		}
		var zje_vals = jQuery("#field6790").val();//未税税额总和
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
		var gl = jQuery("#field6625").val();
		if(sfyby_val == '1' && gl == ''){
			if(Number(skje_val) != Number(jes)){
				Dialog.alert("收款总额不等于 金额");
				return false;
			}
		}else if(gl.length>0&& gl !=''){
			var ybjr = jQuery("#field6334").val();
			if(Number(ybjr)>0){
				if(Number(skje_val) != Number(ybjr)){
					Dialog.alert("收款总额不等于 应补金额");
					return false;
				}
			}else{
				var indexs = jQuery("#nodesnum0").val();
				if(Number(indexs)>0){
					Dialog.alert("有应补金额时才可填写收款人明细!!!");
					return false;
				}
				
			}
		}
		
		//
		
		if(Number(zje_vals) != Number(jes)){
			Dialog.alert("发票总额不等于 金额");
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
		return true;
	}
})

    function setdetail0(){
        for(var i = 0;i<jQuery("#indexnum1").val();i++){
            (function(j){
                //发票类型
                jQuery("#field6354_"+j).bindPropertyChange(function () {
                    setWSJE(j)
                })

                //可抵扣金额
                jQuery("#field7065_"+j).bindPropertyChange(function () {
                    setWSJE(j)
                })
                //金额合计
                bindchange("#field6349_",setWSJE,j)
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
        var fplxValue = jQuery("#field6354_"+index).val();
        var jeheValue = jQuery("#field6349_"+index).val();
        var kdkjeValue = jQuery("#field7065_"+index).val();
            
        if(jeheValue > 0.00 && kdkjeValue >0.00){
                if(fplxValue === '3' || fplxValue === '4' || fplxValue === '5'){
                    jQuery("#field6601_"+index).val(jeheValue-kdkjeValue);
                    jQuery("#field6601_"+index).change();
                    setTimeout("doDetail('field6601', 2)",'1000');
                }else{
                     if(fplxValue !== '6'){
                            jQuery("#field6601_"+index).val("");
                    }
                }
                
            }   
    }

function setmoney(){
	var ftlx_val = jQuery(ftlx).val();
	var dqxz_val = jQuery(dqxz).val();	
	var je_val = jQuery("#field6735").val();	
	if(je_val == ""){
		je_val = "0";
	}
	if(ftlx_val == "0" ||(ftlx_val == "1" && dqxz_val != "")){
		var nowsum = "0";
		var count = 1;
		var nodesnum2 = jQuery("#nodesnum2").val();
		var indexnum2=  jQuery("#indexnum2").val();
		for(var index=0;index <indexnum2;index++){
			if(jQuery(bmmc_dt3+index).length>0){
				var bl_val = jQuery(bl_dt3+index).val();
				if(bl_val == ""){
					bl_val = "0";
				}
				var ftfy_val = accMul(je_val,bl_val).toFixed(2);
				if(count == nodesnum2){
					ftfy_val = accSub(je_val,nowsum);
					
				}else{
					nowsum = accAdd(ftfy_val,nowsum);
					
				}
				jQuery(ftje_dt3+index).val(ftfy_val);
				jQuery(ftje_dt3+index+"span").html("");
				count= count+1;
			}
			
		}
		calSum(2);
		jQuery(fthzje).val(je_val);
	}
}
function showhide(){
	var ftlx_val = jQuery(ftlx).val();
	if(ftlx_val !="2" && (ftlx_val =='' || ftlx_val == null)){
		jQuery("button[name=delbutton2]").hide();
		jQuery("button[name=addbutton2]").hide();
		var indexnum2=  jQuery("#indexnum2").val();
		for(var index=0;index <indexnum2;index++){
			if(jQuery(bmmc_dt3+index).length>0){
				jQuery(bmmc_dt3+index+"_browserbtn").attr('disabled',true);
				jQuery(bl_dt3+index).attr("readonly", "readonly");
			}
			
		}
	}
	
}
function dodetail3(){
	var ftxs = "#field6845";//分摊形式
	var st = new Date().getTime();
	var ftlx_val = jQuery(ftlx).val();
	var dqxz_val = jQuery(dqxz).val();
	var indexnum2 =  jQuery("#indexnum2").val();
	var ftxs_val = jQuery(ftxs).val();
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
						addRow2(2);
						var tmp_arr = text_arr[i-indexnum2].split("###");					
						jQuery(bmmc_dt3+i).val(tmp_arr[1]);							
						jQuery(bmmc_dt3+i+"span").text(tmp_arr[2]);
						jQuery(bmmc_dt3+i+"_browserbtn").attr('disabled',true);
						jQuery(bl_dt3+i).val(tmp_arr[3]);		
						jQuery(bl_dt3+i+"span").val(tmp_arr[3]);	
						jQuery(bl_dt3+i).attr("readonly", "readonly");
						jQuery(bmdm_dt3+i).val(tmp_arr[0]);								
						jQuery(bmdm_dt3+i+"span").text(tmp_arr[0]);										
					}
				}	
			}
		}
		xhr.send(null);			
	}
	setmoney();
	
}
function deldt3(){
	var nodesnum2 = jQuery("#nodesnum2").val();
	if(nodesnum2 >0){
		jQuery("[name = check_node_2]:checkbox").attr("checked", true);
		adddelid(2,bmmc_dt3);
		removeRow0(2);
	}
	
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
function getBYYE(){
	var hrid = _C.v("field6324");
	var byjk_val1 = _C.v("field6852");//备用金库
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
						_C.v("field6731",text,text);//备用金余额
					}
				}	
			}
		}
		xhr.send(null);			
	}
	
}
//////////////
function checkFP(){
	var indexd = jQuery("#indexnum1").val();
	var nodenums = jQuery("indexnum1").val();
	var fphm = "#field6600_";
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
///////////////
function checkFPs(fps){
	var re = true;
	var xhr = null;  
	var rid = jQuery("#field6739").val();
	if(window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP"); 
	}else if (window.XMLHttpRequest){ 
		xhr =new XMLHttpRequest(); 
	}
	var st = new Date().getTime();
	if (null!= xhr) { 
		xhr.open("GET","/txrz/checkFP.jsp?fps="+fps+"&rid="+rid+"&st="+st,false);
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4){ 
				if(xhr.status==200){ 
					var text= xhr.responseText; 
					text=text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
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
function isEmptyObject(e) {  
        var t;  
        for (t in e)  
            return !1;
        return !0;
}
function checkRep(){
	var fphm = "#field6600_";
	var resu = true ;
	var aa = 0;
	var indexd = jQuery("#indexnum1").val();
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
</script>


