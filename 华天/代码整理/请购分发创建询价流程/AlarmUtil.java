package htkj.alarm;

import weaver.conn.RecordSet;

public class AlarmUtil {
	public String getCanCheck(String id){
		 RecordSet rs = new RecordSet();
		 int count=0;
		 String sql="select count(1) as count from uf_alarm_info  where status=0 and id="+id;
		 rs.executeSql(sql);
		 if(rs.next()){
			 count = rs.getInt("count");
		 }
		 if(count >0){
			 return "true";
		 }
         
		 return "false";
    }
	
	public String getCanBack(String id){
		 RecordSet rs = new RecordSet();
		 int count=0;
		 String sql="select count(1) as count from uf_data_qinggou  where status=1 and id="+id;
		 rs.executeSql(sql);
		 if(rs.next()){
			 count = rs.getInt("count");
		 }
		 if(count >0){
			 return "true";
		 }
        
		 return "false";
   }
	
	
}
