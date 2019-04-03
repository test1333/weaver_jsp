package APPDEV.HQ.DECODE;

import java.io.StringReader;

import oracle.sql.CLOB;
import sun.misc.BASE64Decoder;
import weaver.conn.ConnStatement;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;

public class EncodeUtil {
	public static final String ENCODE_KEY="ddpYENbNURw="; 
	public String encode(String oldValue) {
		BaseBean log = new BaseBean();
		String key = ENCODE_KEY;
		String value = "";
		if (!"".equals(oldValue)) {
			byte[] inputData = oldValue.getBytes();
			try {
				inputData = DESCoder.encrypt(inputData, key);
				value = DESCoder.encryptBASE64(inputData);
			} catch (Exception e) {
				log.writeLog("加解密失败");
				value = "";
			}

		}
		return value;
	}
	public void doOther(String fieldID,String fieldName,String tableName,String key, String keyValue){
		BaseBean log= new BaseBean();
		String fieldValue="";
		String jmfieldValue="";
		String sql="";
		RecordSet rs = new RecordSet();
		sql = "select "+fieldName+" from " + tableName + " where "+key+" = '" + keyValue + "'";
		log.writeLog("开始加解密" + sql);
		rs.executeSql(sql);
		if (rs.next()) {
			fieldValue = Util.null2String(rs.getString(fieldName));
		}
		if(!"".equals(fieldValue)){
			jmfieldValue = encode(fieldValue);
		}else{
			jmfieldValue = "";
		}
		sql = "update " + tableName + " set "+fieldName+"='" + jmfieldValue + "' where "+key+"='"+keyValue+"'";
		
		rs.executeSql(sql);
	}
	
	public void doClob(String fieldID,String fieldName,String tableName,String key, String keyValue){
		
		BaseBean log= new BaseBean();
		String fieldValue="";
		String jmfieldValue="";
		String sql="";
		ConnStatement cn = null;
		sql = "select "+fieldName+" from " + tableName + " where "+key+"='"+keyValue+"'";
		log.writeLog("开始加解密" + sql);
		try {
			CLOB cb = null;
		    cn = new ConnStatement();
			cn.setStatementSql(sql);
			cn.executeQuery();
			if(cn.next()){
				cb = cn.getClob(fieldName);
			}
			fieldValue = cb.getSubString(1, (int) cb.length());
			cn.close();
		} catch (Exception e) {
			cn.close();
		}
		
		
		String tmp="EC_field"+fieldID;
		//log.writeLog("msdh" + msdh);
		if (!"".equals(fieldValue)) {
			jmfieldValue = encode(fieldValue);
			jmfieldValue="<div id='"+tmp+"'>"+jmfieldValue+"</div>";
		} else {
			jmfieldValue = "";
		}
		//log.writeLog("jmmsdh" + jmfieldValue);
		try {
			cn = new ConnStatement();
			sql = "update " + tableName + " set "+fieldName+"=? where  "+key+"='"+keyValue+"'";
			cn.setStatementSql(sql);
			StringReader reader = new StringReader(jmfieldValue);  
			cn.setCharacterStream(1, reader, jmfieldValue.length());
			cn.executeUpdate();
			cn.close();
		} catch (Exception e) {
			cn.close();
		}
	}

	public String decode(String oldValue){
		if("".equals(oldValue)){
			return "";
		}
		 BaseBean log = new BaseBean();
		 String key = ENCODE_KEY;
		 byte[] inputData;
		 byte[] outputData;
		 String outputStr = "";  
		try {
			inputData = new BASE64Decoder().decodeBuffer(oldValue);
			outputData = DESCoder.decrypt(inputData, key);  
			outputStr = new String(outputData);
		} catch (Exception e) {
			log.writeLog("解密失败 oldValue:"+oldValue);
		}
		return outputStr;
	}
	
	public String decodeCLOB(String oldValue){

		 BaseBean log = new BaseBean();
		 //log.writeLog("开始解密oldValue"+oldValue);
		if("".equals(oldValue)){
			return "";
		}
		 String jmstr=oldValue.substring(oldValue.indexOf(">")+1, oldValue.lastIndexOf("<"));
		 String key = ENCODE_KEY;
		 byte[] inputData;
		 byte[] outputData;
		 String outputStr = "";  
		try {
			inputData = new BASE64Decoder().decodeBuffer(jmstr);
			outputData = DESCoder.decrypt(inputData, key);  
			outputStr = new String(outputData);
		} catch (Exception e) {
			log.writeLog("解密失败 oldValue:"+oldValue);
		}
		return outputStr;
}
	
	public void updateHistoryInfo(String formid,String newFieldName,String oldFieldName,String newFieldType,String oldFieldType){
		RecordSet rs = new RecordSet();
		String tableName = "";
		String mainId="";
		String fieldValue="";
		String sql="select tablename from workflow_bill where id="+formid;
		rs.executeSql(sql);
		if(rs.next()){
			tableName = rs.getString("tablename");
		}
		sql="select id from "+tableName;
		rs.executeSql(sql);
		while(rs.next()){
			mainId = Util.null2String(rs.getString("id"));
			if("0".equals(oldFieldType)){
				fieldValue=getDataClob(tableName,oldFieldName,"id",mainId);
			}else{
				fieldValue=getDataOther(tableName,oldFieldName,"id",mainId);
			}
			
			if("0".equals(newFieldType)){
				updateClob(tableName,newFieldName,fieldValue,"id",mainId,formid);
			}else{
				updateOther(tableName,newFieldName,fieldValue,"id",mainId);
			}
		}
			
	}
	
	public  String getDataOther(String tableName,String fieldName,String key,String keyValue){
		RecordSet rs = new RecordSet();
		String fieldValue="";
		String sql="select "+fieldName+" from "+tableName+" where "+key+"='"+keyValue+"'";
		rs.execute(sql);
		if(rs.next()){
			fieldValue = Util.null2String(rs.getString(fieldName)); 
			
		}
		if(!"".equals(fieldValue)){
			fieldValue = encode(fieldValue);
		}else{
			fieldValue = "";
		}
		return fieldValue;
		
	}
	public  String getDataClob(String tableName,String fieldName,String key,String keyValue){
		RecordSet rs = new RecordSet();
		ConnStatement cn = null;
		String fieldValue="";
		
		String sql="select "+fieldName+" from "+tableName+" where "+key+"='"+keyValue+"'";
		try {
			CLOB cb = null;
		    cn = new ConnStatement();
			cn.setStatementSql(sql);
			cn.executeQuery();
			if(cn.next()){
				cb = cn.getClob(fieldName);
			}
			fieldValue = cb.getSubString(1, (int) cb.length());
			cn.close();
		} catch (Exception e) {
			cn.close();
		}
		
		//log.writeLog("msdh" + msdh);
		if (!"".equals(fieldValue)) {
			fieldValue = encode(fieldValue);
		} else {
			fieldValue = "";
		}
		
		
		return fieldValue;
		
	}
	public void updateOther(String tableName,String fieldName,String fieldValue,String key,String keyValue ){
		RecordSet rs = new RecordSet();
		String sql = "update " + tableName + " set "+fieldName+"='" + fieldValue + "' where "+key+"='"+keyValue+"'";	
		rs.executeSql(sql);
	}
	
	public void updateClob(String tableName,String fieldName,String fieldValue,String key,String keyValue,String formid ){
		String fieldID = "";
		RecordSet rs = new RecordSet();
		String sql="select id from workflow_billfield where billid='"+formid+"' and fieldname='"+fieldName+"' and detailtable is null";
		rs.executeSql(sql);
		if(rs.next()){
			fieldID = Util.null2String(rs.getString("id"));
		}
		String tmp="EC_field"+fieldID;
		String jmfieldValue="<div id='"+tmp+"'>"+fieldValue+"</div>";
		ConnStatement cn = null;
		try {
			cn = new ConnStatement();
			sql = "update " + tableName + " set "+fieldName+"=? where  "+key+"='"+keyValue+"'";
			cn.setStatementSql(sql);
			StringReader reader = new StringReader(jmfieldValue);  
			cn.setCharacterStream(1, reader, jmfieldValue.length());
			cn.executeUpdate();
			cn.close();
		} catch (Exception e) {
			cn.close();
		}
	}
//	public String encodeCLOB(String oldValue) {
//		BaseBean log = new BaseBean();
//		String jmstr = oldValue.substring(oldValue.indexOf(">") + 1,
//				oldValue.lastIndexOf("<"));
//		String key = "ddpYENbNURw=";
//		String value = "";
//		if (!"".equals(jmstr)) {
//			byte[] inputData = jmstr.getBytes();
//			try {
//				inputData = DESCoder.encrypt(inputData, key);
//				value = DESCoder.encryptBASE64(inputData);
//			} catch (Exception e) {
//				log.writeLog("加解密失败");
//				value = "";
//			}
//
//		}
//		value = oldValue.substring(0, oldValue.indexOf(">") + 1)
//				+ value
//				+ oldValue.substring(oldValue.lastIndexOf("<"),
//						oldValue.length());
//		return value;
//	}
//
//	public String ClobToString(CLOB cb) {
//		String result="";
//		Reader inStream=null;
//		try {
//			inStream=cb.getCharacterStream();
//			char[] c = new char[(int) cb.length()];
//			  inStream.read(c);
//			  result = new String(c);
//			  inStream.close();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			 
//		}
//		 try {
//			inStream.close();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return result;
//	}
}
