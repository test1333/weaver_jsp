package htkj.doc;

import weaver.interfaces.schedule.BaseCronJob;

public class LoadEmcDirJob extends BaseCronJob {

	/**
	 * 扫描表数据库： 10.160.1.7 sa/gemtek@ht123 扫描表： TBLfile【文件存储表】 表中字段是中文
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
