var sqcjkc = "#field11565";//图书名称


// 书名
	var book_id = jQuery("#tmp_bookid").val();
	if(book_id.length>0){
		//alert(book_id);
			jQuery.post("/gvo/jsPeixun/getKCInfo.jsp",{'id':book_id},function(data){
//                alert(data);
				data = data.replace(/\n/g,"").replace(/\r/g,"");
                eval('var obj ='+data);
                var bookID = obj.bookID;
                var bookName = obj.bookName;
                jQuery(sqcjkc).val(bookID);
                jQuery(sqcjkc+"span").html(bookName);
			});
//		alert("book_id2 = " + book_id);
	}


jQuery(document).ready(function(){
	//  剩余名额
	var syme = "#field11055";
	checkCustomize = function(){
		var syme_val = jQuery(syme).val();
		var result = true;
		if(Number(syme_val) < 1){
			result = false;
			window.top.Dialog.alert("该课程在本公司名额已满！");
		}
		return result;
                //alert("测试完成！");
	}
});