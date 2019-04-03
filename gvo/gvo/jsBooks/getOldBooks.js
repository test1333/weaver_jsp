
var tsmc_1 = "#field8647";//图书名称
var csxz_1 = "#field8649";//藏书性质
var tsszd_1 = "#field8945";//图书所在地
var tsbh_1 = "#field15588";//图书编号
var sslb_1 = "#field15589";//所属类别


// 书名
	
	
    if(jQuery("#tmp_bookid").length>0){
	 var book_id = jQuery("#tmp_bookid").val();
	if(book_id.length>0){
		jQuery.post("/gvo/jsBooks/getBackBookInfo.jsp",{'id':book_id},function(data){
                
		data = data.replace(/\n/g,"").replace(/\r/g,"");
	//	alert(data);
                eval('var obj ='+data);
                var bookID = obj.bookID;
                var bookName = obj.bookName;
                var csxz2 = obj.csxz;
                var tsszd2 = obj.tsszd;
                var tsbh2 = obj.tsbh;
                var sslb2 = obj.sslb;
                
//                alert(tsszd2);
//alert(tsbh2);
//alert(sslb2);
                jQuery(tsmc_1).val(bookID);
                jQuery(tsmc_1+"span").html(bookName);
                jQuery(csxz_1).val(csxz2);	
		jQuery(csxz_1+"span").html(csxz2);	
		jQuery(tsszd_1).val(tsszd2);
		jQuery(tsszd_1+"span").html(tsszd2);
				
		jQuery(tsbh_1).val(tsbh2);
		jQuery(tsbh_1+"span").html(tsbh2);
		jQuery(sslb_1).val(sslb2);
		jQuery(sslb_1+"span").html(sslb2);
	});
//		alert("book_id2 = " + book_id);
	}
}

jQuery(document).ready(function(){
//alert();
	// 归还 >> 已经提交的 不能再提交
//	alert("123");
	checkCustomize = function(){ 
//		alert("456");
		var result = true; 
		var tmp_bookid = jQuery(tsmc_1).val();
		var flag_x = calBooks(tmp_bookid);
		
	//	alert("flag_x = " + flag_x);
		if(flag_x=="1"){
			alert("无图书归还！");
			result = false; 
		}else if(flag_x=="2"){
			alert("已经申请归还！");
			result = false; 
		}
		return result;
	}
	
	
	var tsmc = "field8647";
		
	 jQuery("#"+tsmc).parent().find(".Browser").removeAttr("onclick").bind("click",function(){onBooks();}); 

	 function onBooks() {
	//	alert("12313");
		var inputid = "field8647";
		var spanid = "field8647span";
		var csxz = "field8649";
		var tsszd = "field8945";
		var tsbh = "field15588";//图书编号
		var sslb = "field15589";//所属类别

		var sqr = "field8641";
		var id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/gvo/books/BackBooksBrowser.jsp?sqrid="+jQuery("#"+sqr).val());		
							 if (id1) {
					var ids = id1.id;
					var names = id1.name;
					var csxz1 = id1.csxz;
					var tsszd1 = id1.tsszd;
					var tsbh1 = id1.tsbh;
					var sslb1 = id1.sslb;
					
					
//					alert(tsszd1);
					if (ids.length > 0) {
						jQuery("#" + inputid).val(ids);
						jQuery("#" + spanid).html(names);
						jQuery("#" + csxz).val(csxz1);
						jQuery("#" + csxz+"span").html(csxz1);
						jQuery("#" + tsszd).val(tsszd1);
						jQuery("#" + tsszd+"span").html(tsszd1);
						jQuery("#" + tsbh).val(tsbh1);
						jQuery("#" + tsbh+"span").html(tsbh1);
						jQuery("#" + sslb).val(sslb1);
						jQuery("#" + sslb+"span").html(sslb1);
						
						
						
						
					} else {
						jQuery("#" + inputid).val("");
						jQuery("#" + spanid).html("");
						jQuery("#" + csxz).val("");
						jQuery("#" + csxz+"span").html("");
						jQuery("#" + tsszd).val("");
						jQuery("#" + tsszd+"span").html("");
						jQuery("#" + tsbh).val("");
						jQuery("#" + tsbh+"span").html("");
						jQuery("#" + sslb).val("");
						jQuery("#" + sslb+"span").html("");
					}
				}
	}
});

	function calBooks(tmp_bookid) {
		var res = "0";
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器  
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var timestamp=new Date().getTime();
			var postStr = "ranTime="+timestamp+"&id="+tmp_bookid;
		//		alert("12233 = " + postStr );
			xhr.open("GET","/gvo/jsBooks/isCommitBook.jsp?"+postStr, false);
				
			xhr.onreadystatechange =	function () {
						
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					var text = xhr.responseText;
					text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//		alert("text = " + text);		
					res = text;
				}
						}
					}
				xhr.send(null);
			}
		return res;
	}
