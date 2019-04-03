<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var ftlx = "#field6524";//分摊类型
var dqxz = "#field6525";//地区选择
var je = "#field6510";//金额
var fthzje="#field6527";//分摊汇总金额
var bmmc_dt3 = "#field6538_";//明细 3部门名称
var bl_dt3 = "#field6539_";//明细3 比例
var bmdm_dt3 = "#field6540_";//明细3   部门代码
jQuery(document).ready(function () {
	showhide();
	jQuery(ftlx).bindPropertyChange(function(){
		var ftlx_val = jQuery(ftlx).val();
		deldt3();
		if(ftlx_val == "0"){
			jQuery("button[name=delbutton2]").hide();
			jQuery("button[name=addbutton2]").hide();
			jQuery(dqxz).val("");
			jQuery(dqxz+"span").html("");
			dodetail3();
						
		}
		if(ftlx_val == "1"){
			jQuery("button[name=delbutton2]").hide();
			jQuery("button[name=addbutton2]").hide();
			jQuery(dqxz).val("");
			jQuery(dqxz+"span").html("");			
		}
		if(ftlx_val == "2"){
			jQuery("button[name=delbutton2]").show();
			jQuery("button[name=addbutton2]").show();
			jQuery(dqxz).val("");
			jQuery(dqxz+"span").html("");					
		}		
	})
	jQuery(dqxz).bindPropertyChange(function(){
		var ftlx_val = jQuery(ftlx).val();
		var dqxz_val = jQuery(dqxz).val();		
		if(ftlx_val == "1"){
			deldt3();	
			if(dqxz_val != ""){
				dodetail3();
			}
		}
	})
	checkCustomize = function(){
		var je_val = jQuery(je).val();
		var fthzje_val = jQuery(fthzje).val();
		if(je_val == ""){
			je_val = "0";
		}
		if(fthzje_val == ""){
			fthzje_val = "0";
		}
		if(Number(je_val) != Number(fthzje_val)){
			alert("明细分摊金额汇总不等于金额，请检查");
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
function showhide(){
	var ftlx_val = jQuery(ftlx).val();
	if(ftlx_val !="2"){
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
	var ftlx_val = jQuery(ftlx).val();
	var dqxz_val = jQuery(dqxz).val();
	var indexnum2=  jQuery("#indexnum2").val();
    var xhr = null;
	if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}
	if (null != xhr) {			
		xhr.open("GET","/txrz/get_ft_detail.jsp?ftlx="+ftlx_val+"&dqxz="+dqxz_val, false);
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
						jQuery(bl_dt3+i+"span").html("");	
						jQuery(bl_dt3+i).attr("readonly", "readonly");
						jQuery(bmdm_dt3+i).val(tmp_arr[0]);								
						jQuery(bmdm_dt3+i+"span").text(tmp_arr[0]);													
					}
				}	
			}
		}
		xhr.send(null);			
	}
	
}
function deldt3(){
	var nodesnum2 = jQuery("#nodesnum2").val();
	if(nodesnum2 >0){
		jQuery("[name = check_node_2]:checkbox").attr("checked", true);
		adddelid(2,bmmc_dt3);
		removeRow0(2);
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
/////
function checkFP(){
	var indexd = jQuery("#indexnum0").val();
	var nodenums = jQuery("nodesnum0").val();
	var fphm = "#field6529_";
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
		  
	}
	  return ree;
}

///

function checkFPs(fps){
	var re = true;
	var xhr = null;  
	if(window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP"); 
	}else if (window.XMLHttpRequest){ 
		xhr =new XMLHttpRequest(); 
	}
	if (null!= xhr) { 
		xhr.open("GET","/txrz/checkFP.jsp?fps="+fps,false);
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

</script>


