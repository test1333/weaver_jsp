﻿var gsrq = "field13023_";//归属日期_明细表

setTimeout('yourFunction1()',1000);

function yourFunction1(){
	for(var i=0;i<200;i++){
	    if(jQuery("#"+gsrq+i).length>0){
	         checkM1(i);
	    }else{
	    	i=201;
	    }
	}
}


function checkM(){
	var nowRow = parseInt($G("indexnum0").value) - 1;		
	checkM1(nowRow);
	checkM2(nowRow);
}

function checkM1(index){
	jQuery("#"+gsrq+index).bindPropertyChange(function(){ 
		check_date();
	});      
}

function checkM2(index){
	check_date();
}

function check_date(){
	var nowRow = parseInt($G("indexnum0").value)-1;
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