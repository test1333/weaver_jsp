<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/txrz/js/cw.js"></script>
<script type="text/javascript">
var ftlx = "#field6459";//分摊类型
var dqxz = "#field6460";//地区选择
var je = "#field6442";//金额
var fthzje="#field6598";//分摊汇总金额
var bmmc_dt7 = "#field6487_";//明细 7部门名称
var bl_dt7 = "#field6488_";//明细7 比例
var bmdm_dt7 = "#field6490_";//明细7   部门代码
var ftje_dt7 = "#field6489_";//明细7 
jQuery(document).ready(function () {
	showhide();
	jQuery(ftlx).bindPropertyChange(function(){
		var ftlx_val = jQuery(ftlx).val();
		deldt3();
		if(ftlx_val == "0"){
			jQuery("button[name=delbutton6]").hide();
			jQuery("button[name=addbutton6]").hide();
			jQuery(dqxz).val("");
			jQuery(dqxz+"span").html("");
			dodetail3();
						
		}
		if(ftlx_val == "1"){
			jQuery("button[name=delbutton6]").hide();
			jQuery("button[name=addbutton6]").hide();
			jQuery(dqxz).val("");
			jQuery(dqxz+"span").html("");			
		}
		if(ftlx_val == "2"){
			jQuery("button[name=delbutton6]").show();
			jQuery("button[name=addbutton6]").show();
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
	jQuery(je).bindPropertyChange(function(){
		setmoney();
	})
	checkCustomize = function(){
		var je_val = jQuery(je).val();
		var fthzje_val = jQuery(fthzje).val();
		if(je_val == ""){
			je_val = "0";
		}
		if(fthzje_val == ""){
			fthzje_val = "0.00";
		}
		if(Number(je_val) != Number(fthzje_val)){
			alert("明细分摊金额汇总不等于金额，请检查");
			return false;
			
		}
		var ftlx_val = jQuery(ftlx).val();
		if(ftlx_val == "2"){
			var sumbl="0";
			var indexnum6=  jQuery("#indexnum6").val();
			for(var index=0;index <indexnum6;index++){
				if(jQuery(bmmc_dt7+index).length>0){
					var bl_dt7_val = jQuery(bl_dt7+index).val();
					if(bl_dt7_val == ""){
						bl_dt7_val = "0";
					}
					sumbl = accAdd(sumbl,bl_dt7_val);
				}
			}
			if(Number(sumbl)!=Number("1")){
				alert("明细分摊比例汇总不等于1，请检查");
				return false;
			}
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
	_C.run2("field6471", function (p) {
		var bz = _C.v("field6637"+p.r);
		var bx = _C.v("field6471"+p.r);
		if(bz.length>0){
			if(Number(bx)>Number(bz)){
				Dialog.alert("报销金额大于标准金额，请重新填写");
				_C.v("field6471"+p.r,'')
			}
		}
	})
	_C.run2("field6637", function (p) {
		var bz = _C.v("field6637"+p.r);
		var bx = _C.v("field6471"+p.r);
		if(bz.length>0){
			if(Number(bx)>Number(bz)){
				Dialog.alert("报销金额大于标准金额，请重新填写");
				_C.v("field6471"+p.r,'')
			}
		}
	})
	var sqrq = "field6430";//
	var jtrq = "field6452";
	var zsrq = "field6462";
	var szrq = "field6469";
	var qtrq = "field6474";
	var ycbx = "field6447";
	_C.run2(jtrq, function (p) {
		var jtrq_val = _C.v(jtrq+p.r);
		var retu = getMinDay(jtrq,zsrq,szrq,qtrq);
		if(!retu){
			_C.rs(ycbx,true);
		}else{
			_C.rs(ycbx,false);
		}
	})
	_C.run2(zsrq, function (p) {
		var zsrq_val = _C.v(zsrq+p.r);
		var retu = getMinDay(jtrq,zsrq,szrq,qtrq);
		if(!retu){
			_C.rs(ycbx,true);
		}else{
			_C.rs(ycbx,false);
		}
	})
	_C.run2(szrq, function (p) {
		var szrq_val = _C.v(szrq+p.r);
		var retu = getMinDay(jtrq,zsrq,szrq,qtrq);
		if(!retu){
			_C.rs(ycbx,true);
		}else{
			_C.rs(ycbx,false);
		}
	})
	_C.run2(qtrq, function (p) {
		var qtrq_val = _C.v(qtrq+p.r);
		var retu = getMinDay(jtrq,zsrq,szrq,qtrq);
		if(!retu){
			_C.rs(ycbx,true);
		}else{
			_C.rs(ycbx,false);
		}
	})
	
})
function setmoney(){
	var ftlx_val = jQuery(ftlx).val();
	var dqxz_val = jQuery(dqxz).val();	
	var je_val = jQuery(je).val();	
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
	if(ftlx_val !="2"){
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
	var ftlx_val = jQuery(ftlx).val();
	var dqxz_val = jQuery(dqxz).val();
	var indexnum2=  jQuery("#indexnum6").val();
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
       return ((arg1*m-arg2*m)/m).toFixed(n);
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
			_C.deleteRow(0);
			_C.deleteRow(2);
			jQuery("#tab_1").attr('style', 'display:none;');
            jQuery("#tab_1_content").attr('style', 'display:none;');
			jQuery("#tab_3").attr('style', 'display:none;');
            jQuery("#tab_3_content").attr('style', 'display:none;');
			jQuery("#tab_2").click();
			jQuery("#tab_2").click();
		   
		}else{
			document.getElementById("tab_1").style.display='block';
			document.getElementById("tab_1_content").style.display='block';
			document.getElementById("tab_3").style.display='block';
			document.getElementById("tab_3_content").style.display='block';
            jQuery("#tab_3").click();
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
	if (null!= xhr){
		xhr.open("GET","/txrz/checkFP.jsp?fps="+fps,false);
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
function getMinDay(jtrqs,zsrqs,szrqs,qtrqs){
	var ret = true;
	var sqrq = "field6430";//
	var sqrq_val = jQuery("#"+sqrq).val();
	var indnum0 = jQuery("#indexnum0").val(); 
	var indnum1 = jQuery("#indexnum1").val(); 
	var indnum2 = jQuery("#indexnum2").val(); 
	var indnum3 = jQuery("#indexnum3").val();
	for(var i = 0;i<indnum0;i++){
		if(jQuery("#"+jtrqs+"_"+i).length>0){
			var jt_val = jQuery("#"+jtrqs+"_"+i).val();
			if(jt_val<2){
				jt_val = sqrq_val;
			}
			var dd = getDayss(sqrq_val,jt_val);
			if(Number(dd)>21){
				return false;
			}
		}
	}
	for(var i = 0;i<indnum1;i++){
		if(jQuery("#"+zsrqs+"_"+i).length>0){
			var zsrq_val = jQuery("#"+zsrqs+"_"+i).val();
			if(zsrq_val.length<2){
				zsrq_val = sqrq_val;
			}
			var dd = getDayss(sqrq_val,zsrq_val);
			if(Number(dd)>21){
				return false;
			}
		}
	}
	for(var i = 0;i<indnum2;i++){
		if(jQuery("#"+szrqs+"_"+i).length>0){
			var szrq_val = jQuery("#"+szrqs+"_"+i).val();
			if(szrq_val.length<2){
				szrq_val = sqrq_val;
			}
			var dd = getDayss(sqrq_val,szrq_val);
			if(Number(dd)>21){
				return false;
			}
		}
	}
	for(var i = 0;i<indnum3;i++){
		if(jQuery("#"+qtrqs+"_"+i).length>0){
			var qtrq_val = jQuery("#"+qtrqs+"_"+i).val();
			if(qtrq_val.length<2){
				qtrq_val = sqrq_val;
			}
			var dd = getDayss(sqrq_val,qtrq_val);
			if(Number(dd)>21){
				return false;
			}
		}
	}
	return ret;
	
}
function isEmptyObject(e) {  
        var t;  
        for (t in e)  
            return !1;
        return !0;
}
</script>
