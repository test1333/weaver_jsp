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
		
		tmp_sql = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'173587_8221','0136','2016/03/06','13:10','2016/03/09','21:30','36','L_009','0136','2016/02/19','�ݷ��ص�ͻ����ǣ��ƶ���Ŀ��������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'174489_8263','006983','2016/02/24','08:00','2016/03/01','17:00','56','L_009','006983','2016/02/20','����TP����״�� 1.���ٹ�Ӧ�̳�����ϴ״����Ĥ��&��Ĥ���Ҫ����ϴ��Ŀǰ����ֻ��ϴĤ�棩2.�������ó���ʵ��Ʒ�����׼�����30Ƭ�����׼���ȷ��Ĥ�渽�����������������ʵ�飺��Ĥ��280���϶Ȱ�Сʱ���º濾��ʴ��������СƬ����510���϶Ⱥ濾��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'175831_8321','B0071','2016/02/24','08:30','2016/03/01','17:30','56','L_009','B0071','2016/02/23','�������ڱ���������1.45Ӣ��On-cell TP�������ȼ�Ʒ�ʡ�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'176129_8361','B0139','2016/02/25','08:30','2016/02/26','17:30','16','L_009','B0139','2016/02/23','������ϣ�˳������ղ�ǿ�豸��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177134_8401','B0031','2016/02/21','08:00','2016/02/23','17:30','72','L_009','B0031','2016/02/24','TP��Ӧ�̱�������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177746_8442','A0249','2016/03/01','08:30','2016/03/05','17:30','40','L_009','A0249','2016/02/25','V1-P2����ģ��ΰ�豸���̿��졢��Ʒ����������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177857_8446','005469','2016/02/01','08:30','2016/02/29','17:30','232','L_009','1228','2016/02/25','����Ʒ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177857_8447','006168','2016/02/21','08:30','2016/02/29','17:30','64','L_009','1228','2016/02/25','����Ʒ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177946_8461','B0206','2016/02/29','08:30','2016/03/02','15:00','21.5','L_009','B0206','2016/02/25','ǰ�����ڽ������Լ����豸����豸Demo��֤����������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177946_8462','B0130','2016/02/29','08:30','2016/03/04','15:30','38','L_009','B0206','2016/02/25','ǰ�����ڽ������Լ����豸����豸Demo��֤����������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177973_8463','005559','2016/02/28','18:30','2016/03/04','15:00','37.5','L_009','005559','2016/02/25','1.ǰ�����ڽ���ȫ�Զ�COG��豸��ȫ�Զ�COF��豸�߾���Demo��֤��������豸���죻2.ǰ�����ڽ���1.2��Բ���ֱ��Ʒ����������Զ�ƫ���豸Demo��֤��3.ǰ������Ԫ˶�Ƽ����δ����ܵȺ�������ʵ�ؽ��м�����������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177973_8464','005949','2016/02/28','18:30','2016/03/02','15:00','21.5','L_009','005559','2016/02/25','1.ǰ�����ڽ���ȫ�Զ�COG��豸��ȫ�Զ�COF��豸�߾���Demo��֤��������豸���죻2.ǰ�����ڽ���1.2��Բ���ֱ��Ʒ����������Զ�ƫ���豸Demo��֤��3.ǰ������Ԫ˶�Ƽ����δ����ܵȺ�������ʵ�ؽ��м�����������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'167114_7921','005409','2016/02/01','08:30','2016/02/04','17:30','32','L_009','005409','2016/01/31','ȥ�������ǶԲ�Ʒȫ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'172926_8181','B0033','2016/03/06','08:30','2016/03/12','17:30','56','L_009','B0033','2016/02/18','LLO�豸demo test���μӴ�������չ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'173288_8201','B0206','2016/03/07','08:30','2016/03/11','17:30','40','L_009','B0206','2016/02/19','ǰ���������Լ����豸��LLO��Cutting��Demo���Լ���������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'174458_8261','B0278','2016/02/24','08:30','2016/03/01','17:30','56','L_009','B0278','2016/02/20','������˾TP��Ʒ�������ڱ���������״����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177830_8444','3730','2016/02/01','08:30','2016/02/29','17:30','232','L_009','1228','2016/02/25','�������Ʒ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177746_8443','A0253','2016/03/01','08:30','2016/03/05','17:30','40','L_009','A0249','2016/02/25','V1-P2����ģ��ΰ�豸���̿��졢��Ʒ����������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177973_8465','B0129','2016/02/28','18:30','2016/03/04','16:00','37.5','L_009','005559','2016/02/25','1.ǰ�����ڽ���ȫ�Զ�COG��豸��ȫ�Զ�COF��豸�߾���Demo��֤��������豸���죻2.ǰ�����ڽ���1.2��Բ���ֱ��Ʒ����������Զ�ƫ���豸Demo��֤��3.ǰ������Ԫ˶�Ƽ����δ����ܵȺ�������ʵ�ؽ��м�����������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178015_8466','0429','2016/02/26','08:30','2016/02/26','17:30','8','L_009','0429','2016/02/25','ǰ���Ϻ���������00991����������ͨ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178175_8481','B0699','2016/02/29','08:30','2016/03/12','17:30','80','L_009','B0699','2016/02/26','�������Ĺ�˾ERP&OA��Ŀʵʩ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178175_8482','B0722','2016/02/29','08:30','2016/03/12','17:30','80','L_009','B0699','2016/02/26','�������Ĺ�˾ERP&OA��Ŀʵʩ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178837_8501','0187','2016/02/29','08:30','2016/03/04','17:30','40','L_009','0187','2016/02/26','����ɽ�칫')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'178957_8502','B0015','2016/03/01','17:30','2016/03/04','17:30','24','L_009','005190','2016/02/26','1.�ල��ָ������ʦ���ȫ�Զ�COG��豸��ȫ�Զ�COF��豸�߾���Demo��֤��������豸���죻 2.�ල��ָ������ʦ���1.2��Բ���ֱ��Ʒ����������Զ�ƫ���豸Demo��֤��  3.�ල��ָ������ʦ�������Ԫ˶��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179095_8521','0527','2016/02/22','08:30','2016/02/26','17:30','40','L_009','0527','2016/02/27','�������ǿͻ�������15��׿ͻ�Ͷ�ߣ��ݷò��Ϲ�Ӧ�̣��������HD���Ϲ������⡣')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'164032_7761','A0164','2016/02/23','06:50','2016/02/27','21:20','45','L_009','A0164','2016/01/27','̨��־ʥ�ȷ�¯�����»�����ǰԤ�����ȷ�ϳ��̼�������������ƻ�Ͷ��̶ȣ���Ҫ��鳧�̺�����Ŀ��չ���豸��������Ƿ�ʱ���豸�ӹ������������ָ���Ƿ�������˾Ҫ�󡣲���ʱ���ֿ��ܳ��ֵ����⣬����쳣��������ȷ���豸˳����������Ŀ����˳����չ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'160826_7602','3447','2016/01/22','08:30','2016/01/22','17:30','8','L_009','3447','2016/01/21','�ݷú������Ŵ����ά���Ƽ�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'168228_8001','B0254','2016/02/25','08:30','2016/02/27','17:30','24','L_009','B0254','2016/02/02','������ʴҺ���̻��ˣ����������Ƽ��ɷ����޹�˾��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'168551_8041','B0115','2016/02/21','07:00','2016/02/27','17:00','56','L_009','B0115','2016/02/03','�¹�Ӧ�̵��룺TP On-cell��ƫ��Ƭ��������ʴҺ���ǰ岣�������ϳ�����ϵ���˺��ֳ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'170431_8062','B0287','2016/02/22','08:30','2016/02/25','17:30','32','L_009','B0287','2016/02/15','�¹�Ӧ�̵��룺ƫ��Ƭ�������ס�ʢ�������ǰ岣���������̼����������ֳ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'174204_8241','B0244','2016/02/21','08:30','2016/03/01','17:30','80','L_009','B0244','2016/02/20','�������ڱ�����1.45inch on-cell��Ʒ�������ߣ���ز��������Ա�ʹ��Ʒ����������˾Ҫ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'177830_8445','3639','2016/02/01','08:30','2016/02/29','17:30','232','L_009','1228','2016/02/25','�������Ʒ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'152270_7281','3447','2016/01/06','08:00','2016/01/07','18:00','16','L_009','3447','2016/01/07','�ݷ��人�������人����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'164032_7762','A0115','2016/02/23','06:30','2016/02/27','21:20','45','L_009','A0164','2016/01/27','̨��־ʥ�ȷ�¯�����»�����ǰԤ�����ȷ�ϳ��̼�������������ƻ�Ͷ��̶ȣ���Ҫ��鳧�̺�����Ŀ��չ���豸��������Ƿ�ʱ���豸�ӹ������������ָ���Ƿ�������˾Ҫ�󡣲���ʱ���ֿ��ܳ��ֵ����⣬����쳣��������ȷ���豸˳����������Ŀ����˳����չ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'174458_8262','B0706','2016/02/24','08:30','2016/03/01','17:30','56','L_009','B0278','2016/02/20','������˾TP��Ʒ�������ڱ���������״����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179396_8542','1936','2016/02/25','06:00','2016/02/25','23:59','18','L_009','1936','2016/02/29','�ݷÿͻ���ͼ�Ƽ����ƽ���˾5.0��5.5��AMOLED.')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179706_8561','1607','2016/03/29','08:30','2016/03/04','17:30','40','L_009','1607','2016/02/29','�ݷÿͻ��������ͻ���Ŀ���ȣ��˽�ͻ�����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180452_8621','2360','2016/03/01','08:30','2016/03/04','17:30','32','L_009','2360','2016/03/01','�ݷÿͻ� �˽�ͻ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181470_8663','B0395','2016/03/06','08:30','2016/03/09','17:30','32','L_009','B0395','2016/03/02',' ������β�����������ֳ�����������˾������ϴ�豸�������豸0.3��������������ܼ���Ƭ300Ƭ�� ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182455_8708','0153','2016/03/01','08:30','2016/03/06','17:30','48','L_009','0153','2016/03/03','�ݷ�TFT���������߿ƣ��˽⹫˾�������Ϊ�����������»����� �ݷ�TFT���⳧��ΰ־���˽���������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182992_8741','0436','2016/03/07','08:30','2016/03/10','17:30','32','L_009','0436','2016/03/04','վ��ᵽ����ǣ���Ҫ���˹�ȥ��װָ���������˵�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183164_8746','005200','2016/03/07','13:30','2016/03/12','13:30','40','L_009','005200','2016/03/04','1��Ԥ�ȶ�7��ȫ��ɲ���ɽ��·���вȵ㣬ѡ��ȫ�ʺϵĻ��· 2��ʵ�ؿ��챸ѡ�Ƶ�ʵ���������ѡ�ʺ����ʵ�ס�ޡ����黷�� 3����ǰ����󲿶ӽ�ͨ��·����ѡ���ʵ��⳵��Ӧ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183164_8762','C0075','2016/03/07','13:30','2016/03/12','13:30','40','L_009','005200','2016/03/04','1��Ԥ�ȶ�7��ȫ��ɲ���ɽ��·���вȵ㣬ѡ��ȫ�ʺϵĻ��· 2��ʵ�ؿ��챸ѡ�Ƶ�ʵ���������ѡ�ʺ����ʵ�ס�ޡ����黷�� 3����ǰ����󲿶ӽ�ͨ��·����ѡ���ʵ��⳵��Ӧ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'185897_8881','B0091','2016/03/09','15:00','2016/03/10','17:30','10.5','L_009','B0341','2016/03/09','ȥ�Ͼ����˹�˾��ͨ��Ʒ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'189273_9081','1607','2016/03/14','08:30','2016/03/18','17:30','40','L_009','1607','2016/03/15','�ݷÿͻ����ƽ���Ŀ���ȣ��˽�ͻ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190520_9161','B0089','2016/03/14','08:30','2016/03/15','17:30','16','L_009','B0089','2016/03/16','ǰ���������ι�DTRO�豸����״�����Ա��ڵ������ŷ���Ŀ�п������豸�Ŀ�ʵʩ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182325_8706','1645','2016/03/03','16:30','2016/03/05','21:00','9','L_009','1645','2016/03/03','Э�����������ģ���豸����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182653_8721','005796','2016/03/05','08:30','2016/03/05','17:30','8','L_009','005796','2016/03/04','����μ���Ŀ������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182992_8743','005216','2016/03/07','08:30','2016/03/31','17:30','200','L_009','0436','2016/03/04','վ��ᵽ����ǣ���Ҫ���˹�ȥ��װָ���������˵�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183164_8744','C0050','2016/03/07','13:30','2016/03/12','13:30','40','L_009','005200','2016/03/04','1��Ԥ�ȶ�7��ȫ��ɲ���ɽ��·���вȵ㣬ѡ��ȫ�ʺϵĻ��·2��ʵ�ؿ��챸ѡ�Ƶ�ʵ���������ѡ�ʺ����ʵ�ס�ޡ����黷�� 3����ǰ����󲿶ӽ�ͨ��·����ѡ���ʵ��⳵��Ӧ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184527_8801','2360','2016/03/08','08:30','2016/03/11','17:30','32','L_009','2360','2016/03/07','�ݷÿͻ� �˽�ͻ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'187385_8963','006377','2016/03/01','08:30','2016/03/25','17:30','200','L_009','0447','2016/03/11','�����޸���Ʒ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'189370_9083','2360','2016/03/15','08:30','2016/03/18','17:30','32','L_009','2360','2016/03/15','�ݷÿͻ�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190807_9181','B0014','2016/03/10','10:00','2016/03/12','14:00','14','L_009','B0217','2016/03/17','���硢��ʿ�����ӹ���FS-ELLIOTT(��ʢ-�������ѹ��ʹ��������졣')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'191855_9242','2886','2016/03/07','08:30','2016/03/16','17:30','80','L_009','2886','2016/03/18','�������д���')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179338_8541','B0104','2016/02/29','08:30','2016/03/07','17:30','48','L_009','B0104','2016/02/28','����������Ϥ�����ֹ�˾��������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179471_8544','B0520','2016/02/28','08:30','2016/02/28','08:30','0','L_009','B0312','2016/02/29','�ͻ���Ʒ��ҵ�������쳣���ֳ�֧Ԯ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179933_8582','2886','2016/02/22','08:30','2016/02/25','17:30','32','L_009','2886','2016/02/29','2��22��-2��23�գ��ɶ��� 2��24-2��25�գ�̫ԭ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180077_8584','0712','2016/03/01','08:30','2016/03/03','17:30','24','L_009','0712','2016/02/29','�ݷù�Ӧ�̣�ѧϰ����TFT ��Ʒ֪ʶ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180210_8602','007058','2016/02/27','08:30','2016/02/27','17:30','8','L_009','007058','2016/02/29','ȥ���ȴ�ȷ�ϸ��Ƶͻҽ�������ˮ��������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181389_8661','3447','2016/03/01','08:00','2016/03/01','18:00','8','L_009','3447','2016/03/02','���������������ϰ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181894_8681','B0098','2016/03/03','07:30','2016/03/04','17:30','16','L_009','B0098','2016/03/03','У԰��Ƹ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183403_8747','B0319','2016/02/29','08:30','2016/03/07','17:30','64','L_009','B0319','2016/03/05','1. �̰����������Ŀ���� 2. �����Ƽ�IT������ 3. �����Ƽ���������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'185283_8841','B0061','2016/03/09','08:30','2016/03/11','18:00','24','L_009','B0061','2016/03/08','�ݷÿͻ� �˽�ͻ����� �˽�VR&AR�г�״��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'185563_8861','0215','2016/03/09','08:30','2016/03/11','17:30','24','L_009','0215','2016/03/09','�ݷÿͻ�������1.45���5.5HD��Ŀ�������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'185594_8862','B0091','2016/03/03','08:30','2016/03/03','20:40','10.5','L_009','B0091','2016/03/09','ȷ�����Ǹ��������½�������ˮƽ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180255_8603','2212','2016/03/01','08:30','2016/03/04','17:30','96','L_009','2212','2016/02/29','���й�ͨ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182028_8682','006719','2016/03/01','10:08','2016/03/02','19:00','16','L_009','006719','2016/03/03','1���鿴�Ϻ�SEMIչչλ������� 2��ȥ��ɽά��ŵ����Ʒ������Ӧ�̽���չλ��ǽ������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182653_8722','007124','2016/03/05','08:30','2016/03/05','17:30','8','L_009','005796','2016/03/04','����μ���Ŀ������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184080_8763','005352','2016/03/03','08:30','2016/03/04','17:30','16','L_009','005352','2016/03/07','�μ��������֯���Ͼ�-������ɽר��У԰��Ƹ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184325_8782','2888','2016/03/08','08:30','2016/03/08','17:30','8','L_009','2888','2016/03/07','�ݷÿͻ���ȡ������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184639_8803','1607','2016/03/08','08:30','2016/03/11','17:30','32','L_009','1607','2016/03/08','�ݷÿͻ����˽�ͻ���Ŀ������ƹ���˾��Ʒ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'186331_8901','B0444','2016/03/14','12:00','2016/03/15','17:30','12.5','L_009','B0444','2016/03/10','�������ڿͻ����״� 5.0FHD S4ģ����ԡ�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'187556_8982','B0136','2016/03/07','08:30','2016/03/12','17:30','40','L_009','B0322','2016/03/11','ʵʩ�������Ĺ�˾ERP/OAϵͳ ����ERPҵ�����̡�����OAҵ�����̡�����ERP��OAϵͳ��������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184553_8802','0369','2016/03/09','08:30','2016/03/14','23:00','32','L_009','0369','2016/03/07','���г�����ɽ���Ϻ������ݰݷÿͻ�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'187385_8962','2217','2016/03/01','08:30','2016/03/25','17:30','200','L_009','0447','2016/03/11','�����޸���Ʒ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'188720_9041','B0061','2016/03/14','12:00','2016/03/16','18:00','22','L_009','B0061','2016/03/14','�μ�FPDչ �ռ���Ϣ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179471_8543','B0312','2016/02/28','08:30','2016/02/28','08:30','0','L_009','B0312','2016/02/29','�ͻ���Ʒ��ҵ�������쳣���ֳ�֧Ԯ����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180357_8604','0485','2016/03/01','08:30','2016/03/01','17:30','8','L_009','0485','2016/02/29','3��1�ճ���ݰݷ��������ϰ�ȿͻ����˽�����ͣ����Ʒ���ҵ��Ʒ�����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181398_8662','3447','2016/02/24','08:30','2016/02/24','18:00','8','L_009','3447','2016/03/02','�ݷ��Ͼ��ÿء��Ͼ�ȫʥ�ؿƼ�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'186331_8902','B0312','2016/03/14','12:00','2016/03/15','17:30','12.5','L_009','B0444','2016/03/10','�������ڿͻ����״� 5.0FHD S4ģ����ԡ�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'186934_8941','0039','2016/03/13','10:00','2016/03/15','23:00','16','L_009','0039','2016/03/11','ʡ����ƽ̨��� ��Ŀ�㱨')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180357_9042','0485','2016/03/09','08:30','2016/03/09','17:30','8','L_009','0485','2016/02/29','3��1�ճ���ݰݷ��������ϰ�ȿͻ����˽�����ͣ����Ʒ���ҵ��Ʒ�����')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'189519_9101','007132','2016/03/15','14:00','2016/03/18','17:30','27.5','L_009','007132','2016/03/15','�ֱ�ݷ�5�ҿͻ���������Э��mura�����ȡǩ������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'179926_8581','2886','2016/02/28','07:00','2016/03/03','17:30','40','L_009','2886','2016/02/29','���ڰ������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'180002_8583','0789','2016/02/22','08:30','2016/02/26','17:30','40','L_009','0789','2016/02/29',' �ݷû��ϵ��ص�ͻ���')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'181218_8641','0215','2016/03/01','08:30','2016/03/04','17:30','32','L_009','0215','2016/03/02','�ݷÿͻ�������5.5HD��Ŀ���������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182452_8707','0153','2016/02/23','08:30','2016/03/10','17:30','64','L_009','0153','2016/03/03','�Ӵ�����������Microdisplay���ձ�������Teidec��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'182992_8742','1778','2016/03/07','08:30','2016/03/31','17:30','200','L_009','0436','2016/03/04','վ��ᵽ����ǣ���Ҫ���˹�ȥ��װָ���������˵�')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'183554_8748','B0549','2016/03/07','08:30','2016/03/07','17:30','8.0','L_009','B0549','2016/03/05','��ʤ�����׿Ƽ���˾�������������ϵ���˽���ʧЧ�������豸ˮƽ������������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'184322_8781','0153','2016/03/08','08:30','2016/03/08','17:30','8','L_009','0153','2016/03/07','�ݷ����£�����˫�����˽⡣')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'187556_8981','B0322','2016/03/07','08:30','2016/03/12','17:30','40','L_009','B0322','2016/03/11','ʵʩ�������Ĺ�˾ERP/OAϵͳ ����ERPҵ�����̡�����OAҵ�����̡�����ERP��OAϵͳ��������')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'188890_9064','0215','2016/03/14','13:30','2016/03/18','17:30','36','L_009','0215','2016/03/14','�ݷ��¿ͻ���ά���Ͽͻ���ϵ������1.45�硢5.5HD��Ʒ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190056_9141','007058','2016/03/12','08:30','2016/03/12','20:00','10','L_009','007058','2016/03/16','ȥ�Ϻ�Э�����ɵ���5.5HD�°�IC�Ĳ�Ʒ')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190109_9142','006393','2016/03/16','09:30','2016/03/17','17:30','15','L_009','006393','2016/03/16','�ݷÿͻ���֧Ԯչ��')";
		if (!rsd.executeSql(tmp_sql)) {
			tmp_flag_error++;
			buff.append(tmp_sql+"\n");
		}else{
			tmp_flag++;
		}
		tmp_sql  = "insert into cus_ats_leave(key_id,process_id,employee_code,leave_begin_date,leave_begin_time,leave_end_date,leave_end_time,leave_value,leave_type_code,create_by,create_dt,remark) values(newID(),'190807_9203','B0217','2016/03/10','10:00','2016/03/12','14:00','14','L_009','B0217','2016/03/17','���硢��ʿ�����ӹ���FS-ELLIOTT(��ʢ-�������ѹ��ʹ��������졣')";
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
String titlename = "���Ӽ���ϵͳ" ;
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
      <TH colSpan=4>ˢ�½���HR</TH>
    </TR>
    <TR class=Spacing style="height: 1px"> 
      <TD class=Line1 colSpan=4></TD>
    </TR>
    <TR style="height: 2px"><TD class=Line colSpan=3></TD></TR> 
    <tr> 
      <td>��ҪƵ�����</td>
      <td class=Field>
           <button onclick="doDelete(this)">���ˢ��</button>
      </td>
    <td></td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
	  <td>���ӵĽ��</td>
      <td class=Field>
    	<%if(isShow){
        	out.println("����������" + tmp_flag_error);
        	out.println("�ֱ��ǣ�" + buff.toString());
        	out.println("��ȷ������" + tmp_flag);
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
	if(confirm("ȷ��ˢ�£�")) {
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