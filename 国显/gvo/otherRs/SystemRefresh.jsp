<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>	
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<%

    String multiRequestIds = Util.fromScreen(request.getParameter("multiRequestIds"),user.getLanguage());
	
	String sql = "";
	
	boolean isShow = false;
	
	StringBuffer buff = new StringBuffer();
	int tmp_flag = 0;
	int tmp_flag_error = 0;
	String showStr = "";
	if("YES".equals(multiRequestIds)){
		isShow = true;
		String tmp_sql = "";
		weaver.conn.RecordSetDataSource rsd = new weaver.conn.RecordSetDataSource("local_HR");
		
		tmp_sql = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'173587_8221','0136','2016/03/06','13:10','2016/03/09','21:30','36','L_009','0136','2016/02/19','拜访重点客户三星，推动项目开发进度')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'174489_8263','006983','2016/02/24','08:00','2016/03/01','17:00','56','L_009','006983','2016/02/20','跟踪TP生产状况 1.跟踪供应商厂内清洗状况（膜面&非膜面均要求清洗，目前厂商只清洗膜面）2.宝明先用厂内实验品玻璃首件生产30片，（首件需确认膜面附着力，做相关信赖性实验：镀膜后280摄氏度半小时高温烘烤，蚀刻完再切小片高温510摄氏度烘烤）')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'175831_8321','B0071','2016/02/24','08:30','2016/03/01','17:30','56','L_009','B0071','2016/02/23','出差深圳宝明，跟踪1.45英寸On-cell TP制作进度及品质。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'176129_8361','B0139','2016/02/25','08:30','2016/02/26','17:30','16','L_009','B0139','2016/02/23','出差至希盟厂商验收补强设备。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177134_8401','B0031','2016/02/21','08:00','2016/02/23','17:30','72','L_009','B0031','2016/02/24','TP供应商宝明稽核')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177746_8442','A0249','2016/03/01','08:30','2016/03/05','17:30','40','L_009','A0249','2016/02/25','V1-P2量产模组段邦定设备厂商考察、样品制作评估。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177857_8446','005469','2016/02/01','08:30','2016/02/29','17:30','232','L_009','1228','2016/02/25','客诉品检验')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177857_8447','006168','2016/02/21','08:30','2016/02/29','17:30','64','L_009','1228','2016/02/25','客诉品检验')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177946_8461','B0206','2016/02/29','08:30','2016/03/02','15:00','21.5','L_009','B0206','2016/02/25','前往深圳进行柔性激光设备及邦定设备Demo验证及技术调研')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177946_8462','B0130','2016/02/29','08:30','2016/03/04','15:30','38','L_009','B0206','2016/02/25','前往深圳进行柔性激光设备及邦定设备Demo验证及技术调研')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177973_8463','005559','2016/02/28','18:30','2016/03/04','15:00','37.5','L_009','005559','2016/02/25','1.前往深圳进行全自动COG邦定设备、全自动COF邦定设备高精度Demo验证及其他邦定设备考察；2.前往深圳进行1.2寸圆形手表产品生产所需半自动偏贴设备Demo验证；3.前往深圳元硕科技、鑫川智能等合作厂商实地教研及技术交流。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177973_8464','005949','2016/02/28','18:30','2016/03/02','15:00','21.5','L_009','005559','2016/02/25','1.前往深圳进行全自动COG邦定设备、全自动COF邦定设备高精度Demo验证及其他邦定设备考察；2.前往深圳进行1.2寸圆形手表产品生产所需半自动偏贴设备Demo验证；3.前往深圳元硕科技、鑫川智能等合作厂商实地教研及技术交流。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'167114_7921','005409','2016/02/01','08:30','2016/02/04','17:30','32','L_009','005409','2016/01/31','去惠州三星对产品全检')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'172926_8181','B0033','2016/03/06','08:30','2016/03/12','17:30','56','L_009','B0033','2016/02/18','LLO设备demo test及参加触摸技术展')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'173288_8201','B0206','2016/03/07','08:30','2016/03/11','17:30','40','L_009','B0206','2016/02/19','前往进行柔性激光设备（LLO、Cutting）Demo测试及技术调研')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'174458_8261','B0278','2016/02/24','08:30','2016/03/01','17:30','56','L_009','B0278','2016/02/20','跟进我司TP产品，在深圳宝明生产的状况。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177830_8444','3730','2016/02/01','08:30','2016/02/29','17:30','232','L_009','1228','2016/02/25','检验客诉品')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177746_8443','A0253','2016/03/01','08:30','2016/03/05','17:30','40','L_009','A0249','2016/02/25','V1-P2量产模组段邦定设备厂商考察、样品制作评估。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177973_8465','B0129','2016/02/28','18:30','2016/03/04','16:00','37.5','L_009','005559','2016/02/25','1.前往深圳进行全自动COG邦定设备、全自动COF邦定设备高精度Demo验证及其他邦定设备考察；2.前往深圳进行1.2寸圆形手表产品生产所需半自动偏贴设备Demo验证；3.前往深圳元硕科技、鑫川智能等合作厂商实地教研及技术交流。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178015_8466','0429','2016/02/26','08:30','2016/02/26','17:30','8','L_009','0429','2016/02/25','前往上海中兴送样00991，并技术沟通。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178175_8481','B0699','2016/02/29','08:30','2016/03/12','17:30','80','L_009','B0699','2016/02/26','北京鼎材公司ERP&OA项目实施')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178175_8482','B0722','2016/02/29','08:30','2016/03/12','17:30','80','L_009','B0699','2016/02/26','北京鼎材公司ERP&OA项目实施')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178837_8501','0187','2016/02/29','08:30','2016/03/04','17:30','40','L_009','0187','2016/02/26','到昆山办公')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178957_8502','B0015','2016/03/01','17:30','2016/03/04','17:30','24','L_009','005190','2016/02/26','1.监督及指导工程师完成全自动COG邦定设备、全自动COF邦定设备高精度Demo验证及其他邦定设备考察； 2.监督及指导工程师完成1.2寸圆形手表产品生产所需半自动偏贴设备Demo验证；  3.监督及指导工程师完成深圳元硕科')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179095_8521','0527','2016/02/22','08:30','2016/02/26','17:30','40','L_009','0527','2016/02/27','处理三星客户，处理15年底客户投诉；拜访材料供应商，解决近期HD材料供货问题。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'164032_7761','A0164','2016/02/23','06:50','2016/02/27','21:20','45','L_009','A0164','2016/01/27','台湾志圣热风炉更换新机出货前预验机，确认厂商技术能力与合作计划投入程度，主要检查厂商合作项目进展，设备制造进度是否按时，设备加工制造各项性能指标是否满足我司要求。并及时发现可能出现的问题，规避异常发生；以确保设备顺利出货，项目合作顺利进展。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'160826_7602','3447','2016/01/22','08:30','2016/01/22','17:30','8','L_009','3447','2016/01/21','拜访杭州信雅达、杭州维尔科技')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'168228_8001','B0254','2016/02/25','08:30','2016/02/27','17:30','24','L_009','B0254','2016/02/02','阳极刻蚀液厂商稽核（深圳新宙邦科技股份有限公司）')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'168551_8041','B0115','2016/02/21','07:00','2016/02/27','17:00','56','L_009','B0115','2016/02/03','新供应商导入：TP On-cell、偏光片、阳极刻蚀液、盖板玻璃各材料厂商体系稽核和现场审核')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'170431_8062','B0287','2016/02/22','08:30','2016/02/25','17:30','32','L_009','B0287','2016/02/15','新供应商导入：偏光片（三利谱、盛波）、盖板玻璃工艺流程及工艺能力现场审核')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'174204_8241','B0244','2016/02/21','08:30','2016/03/01','17:30','80','L_009','B0244','2016/02/20','出差深圳宝明，1.45inch on-cell产品生产跟线，相关不良处理，以便使产品出货满足我司要求；')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177830_8445','3639','2016/02/01','08:30','2016/02/29','17:30','232','L_009','1228','2016/02/25','检验客诉品')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'152270_7281','3447','2016/01/06','08:00','2016/01/07','18:00','16','L_009','3447','2016/01/07','拜访武汉天喻、武汉精测')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'164032_7762','A0115','2016/02/23','06:30','2016/02/27','21:20','45','L_009','A0164','2016/01/27','台湾志圣热风炉更换新机出货前预验机，确认厂商技术能力与合作计划投入程度，主要检查厂商合作项目进展，设备制造进度是否按时，设备加工制造各项性能指标是否满足我司要求。并及时发现可能出现的问题，规避异常发生；以确保设备顺利出货，项目合作顺利进展。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'174458_8262','B0706','2016/02/24','08:30','2016/03/01','17:30','56','L_009','B0278','2016/02/20','跟进我司TP产品，在深圳宝明生产的状况。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179396_8542','1936','2016/02/25','06:00','2016/02/25','23:59','18','L_009','1936','2016/02/29','拜访客户美图科技，推介我司5.0和5.5寸AMOLED.')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179706_8561','1607','2016/03/29','08:30','2016/03/04','17:30','40','L_009','1607','2016/02/29','拜访客户，跟进客户项目进度，了解客户需求！')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180452_8621','2360','2016/03/01','08:30','2016/03/04','17:30','32','L_009','2360','2016/03/01','拜访客户 了解客户情况')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181470_8663','B0395','2016/03/06','08:30','2016/03/09','17:30','32','L_009','B0395','2016/03/02',' 出差汕尾（信利），现场考察信利公司晶洲清洗设备，考察设备0.3玻璃运行情况（总计流片300片） ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182455_8708','0153','2016/03/01','08:30','2016/03/06','17:30','48','L_009','0153','2016/03/03','拜访TFT厂家莱宝高科，了解公司具体情况为后续合作打下基础。 拜访TFT背光厂家伟志，了解相关情况。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182992_8741','0436','2016/03/07','08:30','2016/03/10','17:30','32','L_009','0436','2016/03/04','站组搬到共青城，需要派人过去安装指导培养新人等')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183164_8746','005200','2016/03/07','13:30','2016/03/12','13:30','40','L_009','005200','2016/03/04','1、预先对7月全体干部爬山线路进行踩点，选择安全适合的活动线路 2、实地考察备选酒店实际情况，挑选适合舒适的住宿、会议环境 3、提前体验大部队交通线路，挑选优质的租车供应商')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183164_8762','C0075','2016/03/07','13:30','2016/03/12','13:30','40','L_009','005200','2016/03/04','1、预先对7月全体干部爬山线路进行踩点，选择安全适合的活动线路 2、实地考察备选酒店实际情况，挑选适合舒适的住宿、会议环境 3、提前体验大部队交通线路，挑选优质的租车供应商')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'185897_8881','B0091','2016/03/09','15:00','2016/03/10','17:30','10.5','L_009','B0341','2016/03/09','去南京中兴公司沟通样品')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'189273_9081','1607','2016/03/14','08:30','2016/03/18','17:30','40','L_009','1607','2016/03/15','拜访客户，推进项目进度，了解客户情况')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190520_9161','B0089','2016/03/14','08:30','2016/03/15','17:30','16','L_009','B0089','2016/03/16','前往化工厂参观DTRO设备运行状况，以便在氮磷零排放项目中考量该设备的可实施性')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182325_8706','1645','2016/03/03','16:30','2016/03/05','21:00','9','L_009','1645','2016/03/03','协助江西共青城模组设备调试')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182653_8721','005796','2016/03/05','08:30','2016/03/05','17:30','8','L_009','005796','2016/03/04','外出参加项目管理讲座')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182992_8743','005216','2016/03/07','08:30','2016/03/31','17:30','200','L_009','0436','2016/03/04','站组搬到共青城，需要派人过去安装指导培养新人等')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183164_8744','C0050','2016/03/07','13:30','2016/03/12','13:30','40','L_009','005200','2016/03/04','1、预先对7月全体干部爬山线路进行踩点，选择安全适合的活动线路2、实地考察备选酒店实际情况，挑选适合舒适的住宿、会议环境 3、提前体验大部队交通线路，挑选优质的租车供应商')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184527_8801','2360','2016/03/08','08:30','2016/03/11','17:30','32','L_009','2360','2016/03/07','拜访客户 了解客户情况')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'187385_8963','006377','2016/03/01','08:30','2016/03/25','17:30','200','L_009','0447','2016/03/11','激光修复产品')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'189370_9083','2360','2016/03/15','08:30','2016/03/18','17:30','32','L_009','2360','2016/03/15','拜访客户')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190807_9181','B0014','2016/03/10','10:00','2016/03/12','14:00','14','L_009','B0217','2016/03/17','深超光电、富士康电子工厂FS-ELLIOTT(复盛-易利达）空压机使用情况考察。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'191855_9242','2886','2016/03/07','08:30','2016/03/16','17:30','80','L_009','2886','2016/03/18','办理银行贷款')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179338_8541','B0104','2016/02/29','08:30','2016/03/07','17:30','48','L_009','B0104','2016/02/28','跟随主管熟悉北京分公司弱电事务。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179471_8544','B0520','2016/02/28','08:30','2016/02/28','08:30','0','L_009','B0312','2016/02/29','客户特品事业部点屏异常，现场支援调试')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179933_8582','2886','2016/02/22','08:30','2016/02/25','17:30','32','L_009','2886','2016/02/29','2月22日-2月23日，股东会 2月24-2月25日，太原办事')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180077_8584','0712','2016/03/01','08:30','2016/03/03','17:30','24','L_009','0712','2016/02/29','拜访供应商，学习交流TFT 产品知识')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180210_8602','007058','2016/02/27','08:30','2016/02/27','17:30','8','L_009','007058','2016/02/29','去天奕达确认改善低灰阶闪屏和水波纹现象')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181389_8661','3447','2016/03/01','08:00','2016/03/01','18:00','8','L_009','3447','2016/03/02','杭州立方、杭州老板厨具')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181894_8681','B0098','2016/03/03','07:30','2016/03/04','17:30','16','L_009','B0098','2016/03/03','校园招聘')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183403_8747','B0319','2016/02/29','08:30','2016/03/07','17:30','64','L_009','B0319','2016/03/05','1. 固安翌光弱电项目工作 2. 北京科技IT需求处理 3. 北京科技机房整理')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'185283_8841','B0061','2016/03/09','08:30','2016/03/11','18:00','24','L_009','B0061','2016/03/08','拜访客户 了解客户需求 了解VR&AR市场状况')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'185563_8861','0215','2016/03/09','08:30','2016/03/11','17:30','24','L_009','0215','2016/03/09','拜访客户，跟进1.45寸和5.5HD项目进度情况')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'185594_8862','B0091','2016/03/03','08:30','2016/03/03','20:40','10.5','L_009','B0091','2016/03/09','确认三星给中兴最新交货质量水平')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180255_8603','2212','2016/03/01','08:30','2016/03/04','17:30','96','L_009','2212','2016/02/29','银行沟通')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182028_8682','006719','2016/03/01','10:08','2016/03/02','19:00','16','L_009','006719','2016/03/03','1、查看上海SEMI展展位制作情况 2、去昆山维信诺拿样品带给供应商进行展位中墙面制作')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182653_8722','007124','2016/03/05','08:30','2016/03/05','17:30','8','L_009','005796','2016/03/04','外出参加项目管理讲座')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184080_8763','005352','2016/03/03','08:30','2016/03/04','17:30','16','L_009','005352','2016/03/07','参加人社局组织的南京-镇江线昆山专场校园招聘')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184325_8782','2888','2016/03/08','08:30','2016/03/08','17:30','8','L_009','2888','2016/03/07','拜访客户获取订单。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184639_8803','1607','2016/03/08','08:30','2016/03/11','17:30','32','L_009','1607','2016/03/08','拜访客户，了解客户项目情况，推广我司产品。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'186331_8901','B0444','2016/03/14','12:00','2016/03/15','17:30','12.5','L_009','B0444','2016/03/10','出差深圳客户纳米处 5.0FHD S4模组调试。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'187556_8982','B0136','2016/03/07','08:30','2016/03/12','17:30','40','L_009','B0322','2016/03/11','实施北京鼎材公司ERP/OA系统 讨论ERP业务流程、讨论OA业务流程、讨论ERP与OA系统集成流程')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184553_8802','0369','2016/03/09','08:30','2016/03/14','23:00','32','L_009','0369','2016/03/07','例行出差昆山、上海，福州拜访客户')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'187385_8962','2217','2016/03/01','08:30','2016/03/25','17:30','200','L_009','0447','2016/03/11','激光修复产品')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'188720_9041','B0061','2016/03/14','12:00','2016/03/16','18:00','22','L_009','B0061','2016/03/14','参加FPD展 收集信息')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179471_8543','B0312','2016/02/28','08:30','2016/02/28','08:30','0','L_009','B0312','2016/02/29','客户特品事业部点屏异常，现场支援调试')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180357_8604','0485','2016/03/01','08:30','2016/03/01','17:30','8','L_009','0485','2016/02/29','3月1日出差杭州拜访立方，老板等客户，了解蓝牙停车产品，家电产品情况。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181398_8662','3447','2016/02/24','08:30','2016/02/24','18:00','8','L_009','3447','2016/03/02','拜访南京悦控、南京全圣特科技')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'186331_8902','B0312','2016/03/14','12:00','2016/03/15','17:30','12.5','L_009','B0444','2016/03/10','出差深圳客户纳米处 5.0FHD S4模组调试。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'186934_8941','0039','2016/03/13','10:00','2016/03/15','23:00','16','L_009','0039','2016/03/11','省柔性平台检查 项目汇报')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180357_9042','0485','2016/03/09','08:30','2016/03/09','17:30','8','L_009','0485','2016/02/29','3月1日出差杭州拜访立方，老板等客户，了解蓝牙停车产品，家电产品情况。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'189519_9101','007132','2016/03/15','14:00','2016/03/18','17:30','27.5','L_009','007132','2016/03/15','分别拜访5家客户，并与其协商mura规格，争取签下限样')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179926_8581','2886','2016/02/28','07:00','2016/03/03','17:30','40','L_009','2886','2016/02/29','深圳办理贷款')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180002_8583','0789','2016/02/22','08:30','2016/02/26','17:30','40','L_009','0789','2016/02/29',' 拜访华南的重点客户！')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181218_8641','0215','2016/03/01','08:30','2016/03/04','17:30','32','L_009','0215','2016/03/02','拜访客户，跟进5.5HD项目进度情况；')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182452_8707','0153','2016/02/23','08:30','2016/03/10','17:30','64','L_009','0153','2016/03/03','接待韩国代理商Microdisplay和日本代理商Teidec。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182992_8742','1778','2016/03/07','08:30','2016/03/31','17:30','200','L_009','0436','2016/03/04','站组搬到共青城，需要派人过去安装指导培养新人等')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183554_8748','B0549','2016/03/07','08:30','2016/03/07','17:30','8.0','L_009','B0549','2016/03/05','与胜科纳米科技公司建立具体合作关系，了解其失效分析的设备水平及分析能力。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184322_8781','0153','2016/03/08','08:30','2016/03/08','17:30','8','L_009','0153','2016/03/07','拜访松下，增进双方的了解。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'187556_8981','B0322','2016/03/07','08:30','2016/03/12','17:30','40','L_009','B0322','2016/03/11','实施北京鼎材公司ERP/OA系统 讨论ERP业务流程、讨论OA业务流程、讨论ERP与OA系统集成流程')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'188890_9064','0215','2016/03/14','13:30','2016/03/18','17:30','36','L_009','0215','2016/03/14','拜访新客户，维护老客户关系，主推1.45寸、5.5HD产品')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190056_9141','007058','2016/03/12','08:30','2016/03/12','20:00','10','L_009','007058','2016/03/16','去上海协助豪成调试5.5HD新版IC的产品')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190109_9142','006393','2016/03/16','09:30','2016/03/17','17:30','15','L_009','006393','2016/03/16','拜访客户，支援展会')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190807_9203','B0217','2016/03/10','10:00','2016/03/12','14:00','14','L_009','B0217','2016/03/17','深超光电、富士康电子工厂FS-ELLIOTT(复盛-易利达）空压机使用情况考察。')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		
	}
   
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
<SCRIPT language="javascript"  defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src='/js/JSDateTime/WdatePicker.js?rnd="+Math.random()+"'></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "连接加密系统" ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">

<FORM id=weaver name=weaver style="MARGIN-TOP: 0px" name=right method=post action="SystemRefresh.jsp" >
  <input type="hidden" name="multiRequestIds" value="">
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="35%"> <COL width="30%"><TBODY> 
    <TR class=Title
      <TH colSpan=4>刷新进入HR</TH>
    </TR>
    <TR class=Spacing style="height: 1px"> 
      <TD class=Line1 colSpan=4></TD>
    </TR>
    <TR style="height: 2px"><TD class=Line colSpan=3></TD></TR> 
    <tr> 
      <td>不要频繁点击</td>
      <td class=Field>
           <button onclick="doDelete(this)">点击刷新</button>
      </td>
    <td></td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
	  <td>连接的结果</td>
      <td class=Field>
    	<%if(isShow){
        	out.println("错误条数：" + tmp_flag_error);
        	out.println("分别是：" + buff.toString());
        	out.println("正确条数：" + tmp_flag);
          }
        %>
      </td>
          <td></td>
    </tr>

    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    </TBODY> 
  </TABLE>
</FORM>
</td>
</tr>
</TABLE>
</td>	
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
<Script language=javascript>

function doDelete(obj){
	if(confirm("确认刷新！")) {
		weaver.multiRequestIds.value = "YES";
		weaver.submit();
		obj.disabled=true;
	}
}
</script>
<SCRIPT language=VBS>
sub onShowMould(tdname,inputename)
	
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&document.all(inputename).value)
	if NOT isempty(id) then
		document.all(tdname).innerHtml = id(1)
		document.all(inputename).value=id(0)
	end if
end sub

sub onShowTime(spanname,inputename)
	returntime = window.showModalDialog("/systeminfo/Clock.jsp",,"dialogHeight:360px;dialogwidth:275px")
	document.all(spanname).innerHtml = returntime
	document.all(inputename).value=returntime
end sub
</script> 
<SCRIPT language="javascript"  src="/js/datetime.js"></script>
<SCRIPT language="javascript"  src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>