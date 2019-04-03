package feilida;

import weaver.general.BaseBean;
import weaver.interfaces.schedule.BaseCronJob;

import com.ibm.icu.text.SimpleDateFormat;

public class HrmSynchronization extends BaseCronJob{
	
	public void execute() {
		
		java.util.Date utilDate = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		//�ֲ�ͬ��
		HrmSynchronizationFunctions hrm = new HrmSynchronizationFunctions();
		String str1 = hrm.getSub("1",formatter.format(utilDate));
		hrm.doSub(str1);
		
		//����ͬ��
		String str2 = hrm.getSub("2",formatter.format(utilDate));
		hrm.doDep(str2);
		hrm.excDep();
		
		//��λͬ��
		String str3 = hrm.getSub("3",formatter.format(utilDate));
		hrm.doJob(str3);
		
		//��Աͬ��
		String str4 = hrm.getSub("4",formatter.format(utilDate));
		hrm.doHrm(str4);
		
		//���˺�ͬ��
		String str5 = hrm.getSub("3",formatter.format(utilDate));
		hrm.minorJob(str5);
		
		//��Ա����
		String str6 = hrm.getSub("4",formatter.format(utilDate));
		hrm.upHrm(str6);
		
		//��Ա�������
		hrm.addCache();
		
		//��˾���ŷ��
		hrm.hrmSealed();

		               
	}

}
