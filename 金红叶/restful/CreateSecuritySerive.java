package opple.sso;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;

import weaver.conn.RecordSet;
import weaver.general.Util;

/**
 * @author sunyy
 * @version 1.0 /2017-10-24
 */
@Path("/step1")
public class CreateSecuritySerive {
	/**
	 * ���ݴ��빤�ż�ϵͳ��ʶ���ɶ�Ӧ��token ͬʱ��tokenд��ϵͳ��¼��
	 * @param userCode Ա������
	 * @param type ϵͳ��ʶ
	 * @param other Ԥ���ֶ�
	 * @return token
	 */
	@GET
	@Path("/get/{userCode}/{type}/{other}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)  
	public String getSingleToken(@PathParam("userCode") String userCode,@PathParam("type") String type,@PathParam("other") String other){
		//��ǰʱ��
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime = df.format(new Date());
		String token = "";
		String id = "";
		RecordSet rs = new RecordSet(); 
		
		//�����Ƿ�Ϊ�ڼ�¼ϵͳ
		int isExist = 0;
		String sql = " select count(1) as isExist from uf_ks_data_sys where type ='"+type+"' ";
		rs.execute(sql);
		if(rs.next()){
			isExist = rs.getInt("isExist");
		}
		if(isExist==0){
			return "{status:'E',token:''}";
		}
		
		sql=" select id,token from uf_ks_data_token where type = '" + type + "' and usercode = '" + userCode + "' " +
				"	and round((to_date('"+nowTime+"', 'yyyy-mm-dd hh24:mi:ss') - to_date(updateTime,'yyyy-mm-dd hh24:mi:ss'))*24*60,0)<=10 " +
				"  order by updateTime desc ";
		rs.execute(sql);
		if(rs.next()){
			id = Util.null2String(rs.getString("id"));
			token = Util.null2String(rs.getString("token"));
		}
		if(token.length() > 0){
			rs.execute(" update uf_ks_data_token set updateTime='"+nowTime+"',remark='"+other+"' where id ="+id);
		}else{
			String str = userCode + type + other;
			KsEncryptionKdt tx = new KsEncryptionKdt();
			token = tx.getResourceCode(str);			
			rs.execute(" insert into uf_ks_data_token(type,createTime,usercode,token,updateTime,remark)" +
					"	values ('"+type+"','"+nowTime+"','"+userCode+"','"+token+"','"+nowTime+"','"+other+"') ");					
		}
		
		return "{status:'S',token:'"+token+"'}";
	}

}
