package htkj.doc;

import weaver.interfaces.schedule.BaseCronJob;

public class LoadEmcDirJob extends BaseCronJob {

	/**
	 * ɨ������ݿ⣺ 10.160.1.7 sa/gemtek@ht123 ɨ��� TBLfile���ļ��洢�� �����ֶ�������
	 * 
	 */
	@Override
	public void execute() {
	CreateUtil cu = new CreateUtil();
	try {
		cu.createDir();
		cu.getRoles();
		cu.getTBLfile();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}

	

}
