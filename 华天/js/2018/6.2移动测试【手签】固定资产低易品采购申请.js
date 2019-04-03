<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/htGroup/js/cw.js"></script>
<script type="text/javascript">

jQuery(document).ready(function () {
	getSummoney();        
})
function getSummoney(){
	var sumrmb = 0.0000;
	var summy = 0.0000;
	var sumry = 0.0000;
	var sumoy = 0.0000;
	var sslb1_val = jQuery("#"+t0.sslb1).val();
	var sslb2_val = jQuery("#"+t0.sslb2).val();
	var sslb3_val = jQuery("#"+t0.sslb3).val();
	var sslb4_val = jQuery("#"+t0.sslb4).val();
	var sslb5_val = jQuery("#"+t0.sslb5).val();
	
	var fl1_val = jQuery("#"+t0.fl1).val();
	var fl2_val = jQuery("#"+t0.fl2).val();
	var fl3_val = jQuery("#"+t0.fl3).val();
	var fl4_val = jQuery("#"+t0.fl4).val();
	var fl5_val = jQuery("#"+t0.fl5).val();
	
	var sl1_val = jQuery("#"+t0.sl01).val();
	var sl2_val = jQuery("#"+t0.sl02).val();
	var sl3_val = jQuery("#"+t0.sl03).val();
	var sl4_val = jQuery("#"+t0.sl04).val();
	var sl5_val = jQuery("#"+t0.sl05).val();
	
	var hl01_val = jQuery("#"+t0.hl01).val();
	var hl02_val = jQuery("#"+t0.hl02).val();
	var hl03_val = jQuery("#"+t0.hl03).val();
	var hl04_val = jQuery("#"+t0.hl04).val();
	var hl05_val = jQuery("#"+t0.hl05).val();
	
	var wbdj01_val = jQuery("#"+t0.wbdj01).val();
	var wbdj02_val = jQuery("#"+t0.wbdj02).val();
	var wbdj03_val = jQuery("#"+t0.wbdj03).val();
	var wbdj04_val = jQuery("#"+t0.wbdj04).val();
	var wbdj05_val = jQuery("#"+t0.wbdj05).val();
	var rowSpan01 = jQuery('#rowSpan01').parent();
	var rowSpan02 = jQuery('#rowSpan02').parent();
	var rowSpan03 = jQuery('#rowSpan03').parent();
	var rowSpannum1 = rowSpan01.attr('rowspan');
	var rowSpannum2 = rowSpan02.attr('rowspan');
	var rowSpannum3 = rowSpan03.attr('rowspan');
	if((sslb1_val == "0" && fl1_val == "")|| sslb1_val == "1" ){
		if(sl1_val != "" && hl01_val != "" && wbdj01_val != ""){
			if(hl01_val == "4"){
				sumrmb = accAdd(sumrmb,accMul(sl1_val,wbdj01_val)).toFixed(4);
			}else if(hl01_val == "3"){
				summy = accAdd(summy,accMul(sl1_val,wbdj01_val)).toFixed(4);
			}else if(hl01_val == "2"){
				sumoy = accAdd(sumoy,accMul(sl1_val,wbdj01_val)).toFixed(4);
			}else if(hl01_val == "1"){
				sumry = accAdd(sumry,accMul(sl1_val,wbdj01_val)).toFixed(4);
			}
		}
	}else{
		jQuery("#field28673_hide0").hide();
		jQuery("#field28673_hide").hide();
		rowSpannum1=rowSpannum1-1;
		rowSpannum2=rowSpannum2-1;
		rowSpannum3=rowSpannum3-1;
	}
	if((sslb2_val == "0" && fl2_val == "")||sslb2_val == "1"){
		if(sl2_val != "" && hl02_val != "" && wbdj02_val != ""){
			if(hl02_val == "4"){
				sumrmb = accAdd(sumrmb,accMul(sl2_val,wbdj02_val)).toFixed(4);
			}else if(hl02_val == "3"){
				summy = accAdd(summy,accMul(sl2_val,wbdj02_val)).toFixed(4);
			}else if(hl02_val == "2"){
				sumoy = accAdd(sumoy,accMul(sl2_val,wbdj02_val)).toFixed(4);
			}else if(hl02_val == "1"){
				sumry = accAdd(sumry,accMul(sl2_val,wbdj02_val)).toFixed(4);
			}
		}
	}else{
		jQuery("#field28674_hide0").hide();
		jQuery("#field28674_hide").hide();
		rowSpannum1=rowSpannum1-1;
		rowSpannum2=rowSpannum2-1;
		rowSpannum3=rowSpannum3-1;
	}
	

	if((sslb3_val == "0" && fl3_val == "")||sslb3_val == "1"){
		if(sl3_val != "" && hl03_val != "" && wbdj03_val != ""){
			if(hl03_val == "4"){
			sumrmb = accAdd(sumrmb,accMul(sl3_val,wbdj03_val)).toFixed(4);
			}else if(hl03_val == "3"){
				summy = accAdd(summy,accMul(sl3_val,wbdj03_val)).toFixed(4);
			}else if(hl03_val == "2"){
				sumoy = accAdd(sumoy,accMul(sl3_val,wbdj03_val)).toFixed(4);
			}else if(hl03_val == "1"){
				sumry = accAdd(sumry,accMul(sl3_val,wbdj03_val)).toFixed(4);
			}
		}
	}else{
		jQuery("#field28675_hide0").hide();
		jQuery("#field28675_hide").hide();
		rowSpannum1=rowSpannum1-1;
		rowSpannum2=rowSpannum2-1;
		rowSpannum3=rowSpannum3-1;
	}
	
	if((sslb4_val == "0" && fl4_val == "")||sslb4_val=="1"){
		if(sl4_val != "" && hl04_val != "" && wbdj04_val != ""){
			if(hl04_val == "4"){
				sumrmb = accAdd(sumrmb,accMul(sl4_val,wbdj04_val)).toFixed(4);
			}else if(hl04_val == "3"){
				summy = accAdd(summy,accMul(sl4_val,wbdj04_val)).toFixed(4);
			}else if(hl04_val == "2"){
				sumoy = accAdd(sumoy,accMul(sl4_val,wbdj04_val)).toFixed(4);
			}else if(hl04_val == "1"){
				sumry = accAdd(sumry,accMul(sl4_val,wbdj04_val)).toFixed(4);
			}
		}
	}else{
		jQuery("#field28676_hide0").hide();
		jQuery("#field28676_hide").hide();
		rowSpannum1=rowSpannum1-1;
		rowSpannum2=rowSpannum2-1;
		rowSpannum3=rowSpannum3-1;
	}
	
	if((sslb5_val == "0" && fl5_val == "")||sslb5_val == "1"){
		if(sl5_val != "" && hl05_val != "" && wbdj05_val != ""){
			if(hl05_val == "4"){
				sumrmb = accAdd(sumrmb,accMul(sl5_val,wbdj05_val)).toFixed(4);
			}else if(hl05_val == "3"){
				summy = accAdd(summy,accMul(sl5_val,wbdj05_val)).toFixed(4);
			}else if(hl05_val == "2"){
				sumoy = accAdd(sumoy,accMul(sl5_val,wbdj05_val)).toFixed(4);
			}else if(hl05_val == "1"){
				sumry = accAdd(sumry,accMul(sl5_val,wbdj05_val)).toFixed(4);
			}
		}
	}else{
		jQuery("#field28677_hide0").hide();
		jQuery("#field28677_hide").hide();
		rowSpannum1=rowSpannum1-1;
		rowSpannum2=rowSpannum2-1;
		rowSpannum3=rowSpannum3-1;
	}
	rowSpan01.attr('rowspan', rowSpannum1);
	rowSpan02.attr('rowspan', rowSpannum2);
	rowSpan03.attr('rowspan', rowSpannum3);
	
	var jehj_val = "";
	if(Number(sumrmb)>Number("0")){
		jehj_val = "  人民币："+sumrmb;
	}
	if(Number(summy)>Number("0")){
		jehj_val = jehj_val +"  美元："+summy;
	}
	if(Number(sumoy)>Number("0")){
		jehj_val = jehj_val +"  欧元："+sumoy;
	}
	if(Number(sumry)>Number("0")){
		jehj_val = jehj_val +"  日元："+sumry;
	}
	jQuery("#"+ t0.jehj+"_span").text(jehj_val);
	
}
function accAdd(arg1,arg2){ 
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
	try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
		m=Math.pow(10,Math.max(r1,r2)) 
		return (arg1*m+arg2*m)/m 
	} 

// js数值相乘
function accMul(arg1,arg2) 
{ 
	var m=0,s1=arg1.toString(),s2=arg2.toString(); 
	try{m+=s1.split(".")[1].length}catch(e){} 
	try{m+=s2.split(".")[1].length}catch(e){} 
	return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m) 
} 


    
var t0 = {
    _index: 0,
	jehj: 'field41788',/** 金额合计-integer**/
    sqbm: 'field28534' /** 申请部门-integer**/,
    sqr: 'field28535' /** 申请人-integer**/,
    sqrq: 'field28536' /** 申请日期-char(10)**/,
    sqnr: 'field28537' /** 申请内容-varchar2(4000)**/,
    xnzb: 'field28538' /** 性能指标具体要求-varchar2(4000)**/,
    xypz: 'field28539' /** 现有配置情况说明-varchar2(4000)**/,
    byx: 'field28540' /** 投资的必要性-varchar2(4000)**/,
    xg: 'field28541' /** 投资所达到的效果-varchar2(4000)**/,
    bmzgld: 'field28542' /** 部门主管领导-varchar2(12)**/,
    bmld: 'field28543' /** 部门领导-varchar2(12)**/,
    IEzgld: 'field28544' /** IE主管领导-varchar2(12)**/,
    IEbmldyj: 'field28545' /** IE部门领导意见-varchar2(12)**/,
    qkls: 'field28546' /** 情况落实-varchar2(4000)**/,
    jdap: 'field28547' /** 进度安排-varchar2(4000)**/,
    sszgld: 'field28548' /** 实施主管领导-varchar2(12)**/,
    ssbmld: 'field28549' /** 实施部门领导-varchar2(12)**/,
    zjlyj: 'field28550' /** 总经理意见-varchar2(4000)**/,
    zjlqm: 'field28551' /** 总经理签名-varchar2(12)**/,
    ghzgld: 'field28552' /** 规划主管领导-varchar2(12)**/,
    ghbmld: 'field28553' /** 规划部门领导-varchar2(12)**/,
    dszqm: 'field28554' /** 董事长签名-varchar2(12)**/,
    dszyj: 'field28555' /** 董事长意见-varchar2(4000)**/,
    bh: 'field28556' /** 编号-varchar2(20)**/,
    fgsmc: 'field28557' /** 分公司名称-integer**/,
    xgfj: 'field28558' /** 相关附件-varchar2(4000)**/,
    tzgl: 'field28559' /** 投资归类-integer**/,
    tzys: 'field28560' /** 投资预算-number(15,2)**/,
    bb: 'field28561' /** 币 别-integer**/,
    bbzj: 'field28577' /** 本币总计-number(15,4)**/,
    wbzj: 'field28578' /** 外币总计-number(15,4)**/,
    bz05: 'field28579' /** 币种（本币总计）-integer**/,
    bz07: 'field28584' /** 币种（本币）-integer**/,
    sblx01: 'field28585' /** 设备类型01-varchar2(999)**/,
    sblx02: 'field28586' /** 设备类型02-varchar2(999)**/,
    sblx03: 'field28587' /** 设备类型03-varchar2(999)**/,
    sblx04: 'field28588' /** 设备类型04-varchar2(999)**/,
    sblx05: 'field28589' /** 设备类型05-varchar2(999)**/,
    ggxh01: 'field28590' /** 规格型号01-varchar2(999)**/,
    ggxh02: 'field28591' /** 规格型号02-varchar2(999)**/,
    ggxh03: 'field28592' /** 规格型号03-varchar2(999)**/,
    ggxh04: 'field28593' /** 规格型号04-varchar2(999)**/,
    ggxh05: 'field28594' /** 规格型号05-varchar2(999)**/,
    sl01: 'field28595' /** 数量01-integer**/,
    sl02: 'field28596' /** 数量02-integer**/,
    sl03: 'field28597' /** 数量03-integer**/,
    sl04: 'field28598' /** 数量04-integer**/,
    sl05: 'field28599' /** 数量05-integer**/,
    jq01: 'field28600' /** 交期01-varchar2(20)**/,
    jq02: 'field28601' /** 交期02-varchar2(20)**/,
    jq03: 'field28602' /** 交期03-varchar2(20)**/,
    jq04: 'field28603' /** 交期04-varchar2(20)**/,
    jq05: 'field28604' /** 交期05-varchar2(20)**/,
    bbdj01: 'field28605' /** 单价（本币）01-number(15,4)**/,
    bbdj02: 'field28606' /** 单价（本币）02-number(15,4)**/,
    bbdj03: 'field28607' /** 单价（本币）03-number(15,4)**/,
    bbdj04: 'field28608' /** 单价（本币）04-number(15,4)**/,
    bbdj05: 'field28609' /** 单价（本币）05-number(15,4)**/,
    wbdj01: 'field28610' /** 单价（外币）01-number(15,4)**/,
    wbdj02: 'field28611' /** 单价（外币）02-number(15,4)**/,
    wbdj03: 'field28612' /** 单价（外币）03-number(15,4)**/,
    wbdj04: 'field28613' /** 单价（外币）04-number(15,4)**/,
    wbdj05: 'field28614' /** 单价（外币）05-number(15,4)**/,
    sblx1: 'field28615' /** 设备类型1-varchar2(999)**/,
    sblx2: 'field28616' /** 设备类型2-varchar2(999)**/,
    sblx3: 'field28617' /** 设备类型3-varchar2(999)**/,
    sblx4: 'field28618' /** 设备类型4-varchar2(999)**/,
    sblx5: 'field28619' /** 设备类型5-varchar2(999)**/,
    ggxh1: 'field28620' /** 规格型号1-varchar2(999)**/,
    ggxh2: 'field28621' /** 规格型号2-varchar2(999)**/,
    ggxh3: 'field28622' /** 规格型号3-varchar2(999)**/,
    ggxh4: 'field28623' /** 规格型号4-varchar2(999)**/,
    ggxh5: 'field28624' /** 规格型号5-varchar2(999)**/,
    sl1: 'field28625' /** 数量1-integer**/,
    sl2: 'field28626' /** 数量2-integer**/,
    sl3: 'field28627' /** 数量3-integer**/,
    sl4: 'field28628' /** 数量4-integer**/,
    sl5: 'field28629' /** 数量5-integer**/,
    xqrq1: 'field28630' /** 需求日期1-char(10)**/,
    xqrq2: 'field28631' /** 需求日期2-char(10)**/,
    xqrq3: 'field28632' /** 需求日期3-char(10)**/,
    xqrq4: 'field28633' /** 需求日期4-char(10)**/,
    xqrq5: 'field28634' /** 需求日期5-char(10)**/,
    bz08: 'field28635' /** 币种（外币）-integer**/,
    bz06: 'field28636' /** 币种（外币总计）-integer**/,
    xx: 'field28637' /** 1-number(15,4)**/,
    kk: 'field28638' /** 2-number(15,4)**/,
    san: 'field28639' /** 3-number(15,4)**/,
    si: 'field28640' /** 4-number(15,4)**/,
    wu: 'field28641' /** 5-number(15,4)**/,
    liu: 'field28642' /** 6-number(15,4)**/,
    qi: 'field28643' /** 7-number(15,4)**/,
    ba: 'field28644' /** 8-number(15,4)**/,
    jiu: 'field28645' /** 9-number(15,4)**/,
    shi: 'field28646' /** 10-number(15,4)**/,
    ssbmgcs: 'field28647' /** 实施部门工程师-clob**/,
    dw01: 'field28648' /** 单位01-varchar2(15)**/,
    dw02: 'field28649' /** 单位02-varchar2(15)**/,
    dw03: 'field28650' /** 单位03-varchar2(15)**/,
    dw04: 'field28651' /** 单位04-varchar2(15)**/,
    dw05: 'field28652' /** 单位05-varchar2(15)**/,
    qgfl: 'field28653' /** 请购分类-integer**/,
    dw1: 'field28654' /** 单位1-varchar2(10)**/,
    dw2: 'field28655' /** 单位2-varchar2(10)**/,
    dw3: 'field28656' /** 单位3-varchar2(10)**/,
    dw4: 'field28657' /** 单位4-varchar2(10)**/,
    dw5: 'field28658' /** 单位5-varchar2(10)**/,
    ssbmfj: 'field28659' /** 实施部门附件-varchar2(4000)**/,
    cwfzyj: 'field28660' /** 常务副总意见-varchar2(999)**/,
    ssgcs: 'field28661' /** 实施工程师-integer**/,
    rq1: 'field28662' /** 董事长签核日期-char(10)**/,
    sj1: 'field28663' /** 董事长签核时间-char(5)**/,
    lb01: 'field28664' /** 类 别01-integer**/,
    lb02: 'field28665' /** 类 别02-integer**/,
    lb03: 'field28666' /** 类 别03-integer**/,
    lb04: 'field28667' /** 类 别04-integer**/,
    lb05: 'field28668' /** 类 别05-integer**/,
    sm: 'field28669' /** 说明-varchar2(999)**/,
    yfxmmc: 'field28670' /** 研发项目名称-varchar2(999)**/,
    sfwtsfgs: 'field28671' /** 是否为天水分公司-integer**/,
    sfwzdbm: 'field28672' /** 是否为指定部门-integer**/,
    sslb1: 'field28673' /** 所属类别1-integer**/,
    sslb2: 'field28674' /** 所属类别2-integer**/,
    sslb3: 'field28675' /** 所属类别3-integer**/,
    sslb4: 'field28676' /** 所属类别4-integer**/,
    sslb5: 'field28677' /** 所属类别5-integer**/,
    gzzx: 'field28678' /** 工作中心-browser.ht_gzzx**/,
    cbzx: 'field28679' /** 成本中心-browser.ht_cbzx**/,
  //  superDept: 'field28680' /** 一级部门-integer**/,
    assetType: 'field28681' /** 请购分类(hide)-browser.assetType**/,
    hl01: 'field28682' /** 汇率01-browser.ht_rate**/,
    hl02: 'field28683' /** 汇率02-browser.ht_rate**/,
    hl03: 'field28684' /** 汇率03-browser.ht_rate**/,
    hl04: 'field28685' /** 汇率04-browser.ht_rate**/,
    hl05: 'field28686' /** 汇率05-browser.ht_rate**/,
    hasPrinted: 'field28687' /** 是否打印-integer**/,
    hasAsset: 'field28688' /** 是否含有非低易品-integer**/,
    isOver5k: 'field28689' /** 单价是否超5k-integer**/,
    fl1: 'field28690' /** 低易品分类1-integer**/,
    fl2: 'field28691' /** 低易品分类2-integer**/,
    fl3: 'field28692' /** 低易品分类3-integer**/,
    fl4: 'field28693' /** 低易品分类4-integer**/,
    fl5: 'field28694' /** 低易品分类5-integer**/,
    flownum1: 'field34156' /** 低易品编号-varchar2(500)**/,
    flownum2: 'field34157' /** 货架等编号-varchar2(500)**/,
    yfxmmcdyp: 'field35184' /** 研发项目名称低易品-varchar2(999)**/,
    yfxmmchj: 'field35185' /** 研发项目名称货架-varchar2(999)**/,
    tzglhj: 'field35186' /** 投资归类货架-integer**/,
    tzgldyp: 'field35187' /** 投资归类低易品-integer**/
}
</script>












