package feilida;

import weaver.general.BaseBean;
import weaver.interfaces.schedule.BaseCronJob;

import com.ibm.icu.text.SimpleDateFormat;

public class HrmSynchronization extends BaseCronJob{
	
	public void execute() {
		
		java.util.Date utilDate = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		//分部同步
		HrmSynchronizationFunctions hrm = new HrmSynchronizationFunctions();
		String str1 = hrm.getSub("1",formatter.format(utilDate));
		hrm.doSub(str1);
		
		//部门同步
		String str2 = hrm.getSub("2",formatter.format(utilDate));
		hrm.doDep(str2);
		hrm.excDep();
		
		//岗位同步
		String str3 = hrm.getSub("3",formatter.format(utilDate));
		hrm.doJob(str3);
		
		//人员同步
		String str4 = hrm.getSub("4",formatter.format(utilDate));
		hrm.doHrm(str4);
		
		//次账号同步
		String str5 = hrm.getSub("3",formatter.format(utilDate));
		hrm.minorJob(str5);
		
		//人员更新
		String str6 = hrm.getSub("4",formatter.format(utilDate));
		hrm.upHrm(str6);
		
		//人员缓存清除
		hrm.addCache();
		
		//公司部门封存
		hrm.hrmSealed();

		               
	}

}
