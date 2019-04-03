	
var tsmc = "#field7564";//图书名称


// 书名
	var book_id = jQuery("#tmp_bookid").val();
	
	if(book_id.length>0){
//		alert();
			jQuery.post("/gvo/jsBooks/getBookInfo.jsp",{'id':book_id},function(data){
//                alert(data);
				data = data.replace(/\n/g,"").replace(/\r/g,"");
                eval('var obj ='+data);
                var bookID = obj.bookID;
                var bookName = obj.bookName;
                jQuery(tsmc).val(bookID);
                jQuery(tsmc+"span").html(bookName);
			});
//		alert("book_id2 = " + book_id);
	}


jQuery(document).ready(function(){
	// 借书次数
	var jscs = "#field8053";
	var tszt = "#field8925";
	
	checkCustomize = function(){ 
		var jscs_val = jQuery(jscs).val();
		var tszt_val = jQuery(tszt).val();
		var result = true; 
//		alert(tszt_val);
		if(Number(tszt_val)!=0){
			result = false; 
			window.top.Dialog.alert("该图书当前为非空闲状态");
		}
		if(Number(jscs_val)>=Number(3)){
			result = false; 
			window.top.Dialog.alert("个人借书不可超过3本");
		}
		return result;
	}
});
