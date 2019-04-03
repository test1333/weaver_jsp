var gsrq = "field13468_";//归属日期_明细表

setTimeout('myFunction_gsrq()',1000);

function myFunction_gsrq(){
	for(var i=0;i<200;i++){
	    if(jQuery("#"+gsrq+i).length>0){
	         checkP1(i);
	    }else{
	    	i=201;
	    }
	}
}


function checkP(){
	var nowRow = parseInt($G("indexnum1").value) - 1;		
	checkP1(nowRow);
	checkP2(nowRow);
}

function checkP1(index){
	jQuery("#"+gsrq+index).bindPropertyChange(function(){ 
		check_date();
	});      
}

function checkP2(index){
	check_date();
}

function check_date(){
	var nowRow = parseInt($G("indexnum1").value)-1;
	for (var i=0;i<nowRow;i++)
	{
		if(jQuery("#"+gsrq+i).length>0)
		{
			var gsrq_i = jQuery("#"+gsrq+i).val();
			if (gsrq_i.length>0)
			{   
				for (var j=i+1;j<=nowRow;j++)
				{
					jQuery("#"+gsrq+j).val(gsrq_i);
					document.all(gsrq+j+"span").innerHTML = gsrq_i;
				}
				i=nowRow;
			}
			else
			{
				for (var j=i+1;j<=nowRow;j++)
				{					 
					jQuery("#"+gsrq+j).val("");
					document.all(gsrq+j+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"; 
				}
				i=nowRow;
			}
				
		}
	}
}