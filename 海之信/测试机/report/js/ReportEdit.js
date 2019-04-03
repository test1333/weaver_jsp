//alert("测试22！");

jQuery(document).ready(function() {

	var DocumentName1 = "field7244";//文档名称（中文）
	var DocumentName2 = "field7245";//文档名称（英文）
	var DocumentName3 = "field7246";//文档名称（日文）

	var ReportCN = "#field6220";//中文报告
	var ReportEN = "#field6221";//英文报告
	var ReportJN = "#field6222";//日文报告

	var DocumentStatus1 = "#field7250";//文档状态（中文）其中：未定稿为0，已定稿为1，已作废为2
	var DocumentStatus2 = "#field7251";//文档状态（英文）
	var DocumentStatus3 = "#field7252";//文档状态（日文）

	var Number1 = "field7253";//出具份数（中文）
	var Number2 = "field7254";//出具份数（英文）
	var Number3 = "field7255";//出具份数（日文）


        var DocumentStatus1_val = jQuery(DocumentStatus1).val();
        var DocumentStatus2_val = jQuery(DocumentStatus2).val();
        var DocumentStatus3_val = jQuery(DocumentStatus3).val();
   
   		//alert("DocumentStatus1_val="+DocumentStatus1_val);
		
		//如果文档状态（中文）是已定稿，则为只读
		if (Number(DocumentStatus1_val)==1|Number(DocumentStatus1_val)==2) {
			//alert(11);
			document.getElementById(DocumentName1).readOnly=true;//文档名称（中文）
			//这是让浏览按钮失效的方法
			$("#field7258_browserbtn").attr('disabled',true);//中文报告
			$("#field7258_addbtn").attr('disabled',true);
			//document.getElementById("field6220").readOnly=true;
			document.getElementById(Number1).readOnly=true;//出具份数（中文）
			
		}

		//如果文档状态（英文）是已定稿，则为只读
		if (Number(DocumentStatus2_val)==1|Number(DocumentStatus2_val)==2) {
			//alert(2);
			document.getElementById(DocumentName2).readOnly=true;
			$("#field7259_browserbtn").attr('disabled',true);//英文报告
			$("#field7259_addbtn").attr('disabled',true);
			//document.getElementById(ReportEN).readOnly=true;
			document.getElementById(Number2).readOnly=true;
			//alert("DocumentStatus2_val="+DocumentStatus2_val);
		}

		//如果文档状态（日文）是已定稿，则为只读
		if (Number(DocumentStatus3_val)==1|Number(DocumentStatus3_val)==2) {
			//alert(3);
			document.getElementById(DocumentName3).readOnly=true;
			$("#field7260_browserbtn").attr('disabled',true);//日文报告
			$("#field7260_addbtn").attr('disabled',true);
			//document.getElementById(ReportJN).readOnly=true;
			document.getElementById(Number3).readOnly=true;
		}
});
