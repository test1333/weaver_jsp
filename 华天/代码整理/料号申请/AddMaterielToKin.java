package htkj.materiel;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class AddMaterielToKin implements Action {

	BaseBean log = new BaseBean();

	public String execute(RequestInfo info) {
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		RecordSet rs_detail = new RecordSet();
		String sql_detail = "";
		String tableName = "";
		String lh = "";// 料号
		String zxfl = "";// 最小分类
		String dm = "";// 代码
		String pm = "";// 品名
		String gz = "";// 规格
		String xh = "";// 型号
		String dw = "";// 单位
		String wlsx ="";//物料属性
		String cpjyfs = "";//产品检验方式
		
		String sql = "Select tablename,id From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id=" + workflow_id + ")";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		String mainId = "";
		sql = "select id from " + tableName + " where requestid= " + requestid;
		//log.writeLog("开始新增物料sql" + sql);
		rs.executeSql(sql);
		if (rs.next()) {
			mainId = Util.null2String(rs.getString("id"));
		}
		String deatilid="";
		sql = "select * from " + tableName + "_dt1 where mainid=" + mainId;
		rs.executeSql(sql);
		while (rs.next()) {
			String fitemid = "";
			deatilid = Util.null2String(rs.getString("id"));
			lh = Util.null2String(rs.getString("lh")).replaceAll("&nbsp;", " ").replaceAll("&nbsp", " ");
			zxfl = Util.null2String(rs.getString("zxfl")).replaceAll("&nbsp;", " ").replaceAll("&nbsp", " ");
			dm = Util.null2String(rs.getString("dm")).replaceAll("&nbsp;", " ").replaceAll("&nbsp", " ");
			pm = Util.null2String(rs.getString("pm")).replaceAll("&nbsp;", " ").replaceAll("&nbsp", " ");
			gz = Util.null2String(rs.getString("gz")).replaceAll("&nbsp;", " ").replaceAll("&nbsp", " ");
			xh = Util.null2String(rs.getString("xh")).replaceAll("&nbsp;", " ").replaceAll("&nbsp", " ");
			dw = Util.null2String(rs.getString("dw")).replaceAll("&nbsp;", " ").replaceAll("&nbsp", " ");
			wlsx = Util.null2String(rs.getString("wlsx"));
			cpjyfs = Util.null2String(rs.getString("cpjyfs"));
			fitemid = Util.null2String(rs.getString("FItemID"));
			
			if("0".equals(wlsx)){
				wlsx = "1";//外购
			}else if("1".equals(wlsx)){
				wlsx = "2";//自制
			}else{
				wlsx = "0";
			}
			if("0".equals(cpjyfs)){
				cpjyfs = "353";//抽检
			}else if("1".equals(cpjyfs)){
				cpjyfs = "352";//免检
			}else if("2".equals(cpjyfs)){
				cpjyfs = "351";//全捡
			}else{
				cpjyfs = "0";
			}
			if(!"".equals(fitemid)){
				updateInfo(fitemid,lh,wlsx);
			}else{
				fitemid = getFitemId();
				t_ICItemCustom(fitemid,lh,xh);
				InsertTItem(fitemid,zxfl,dm,pm);
				InsertTICItemCore(fitemid,gz,pm,dm,zxfl);
				InsertTICItemBase(fitemid,dw,zxfl,pm,wlsx);
				InsertTicitemMaterial(fitemid);
				InsertTICItemQuality(fitemid,cpjyfs);
				updateTICItem(fitemid,wlsx,cpjyfs);
			}
			sql_detail = "update "+tableName+"_dt1 set FItemID='"+fitemid+"',lhold='"+lh+"' where id="+deatilid;
			rs_detail.executeSql(sql_detail);
			
		}
		

		return SUCCESS;
	}
	

	/**
	 * 获取金蝶fitemid
	 */
	public String getFitemId() {
		String fitemid = "";
		RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		String sql = "select FMaxNum  from ICMaxNum where FTableName='t_Item'";
		log.writeLog("获取金蝶idsql: " + sql);
		rsd.executeSql(sql);
		if (rsd.next()) {
			fitemid = Util.null2String(rsd.getString("FMaxNum"));
		}
		sql = "update ICMaxNum set FMaxNum=FMaxNum+1 where FTableName='t_Item'";
		rsd.executeSql(sql);
		return fitemid;
	}
	

	/**
	 * 获取金蝶FParentID or FFullName (1:FParentID,2:FFullName)
	 */
	public String getFParentID(String zxfl,String flag) {
		String FParentID = "";
		String FFullName ="";
		int count = hasFParentID(zxfl);
		if (count > 0) {
			RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
			String sql = "select FItemID,FFullName from t_Item where FNumber='" + zxfl
					+ "' and FDeleted=0 and FItemClassID=4";
			log.writeLog("获取金蝶FParentIDsql: " + sql);
			rsd.executeSql(sql);
			if (rsd.next()) {
				FParentID = Util.null2String(rsd.getString("FItemID"));
				FFullName = Util.null2String(rsd.getString("FFullName"));
			}
		}
		if("2".equals(flag)){
			return FFullName;
		}
		return FParentID;
	}
	
	

	/**
	 * 判断FParentID是否存在
	 */
	public int hasFParentID(String zxfl) {
		int count = 0;
		RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		String sql = "  select count(1) as count from t_Item where FNumber='"
				+ zxfl + "' and FDeleted=0 and FItemClassID=4";
		log.writeLog("判断FParentID是否存在sql: " + sql);
		rsd.executeSql(sql);
		if (rsd.next()) {
			count = rsd.getInt("count");
		}
		return count;
	}
	
	/**
	 * 判断料号是否存在
	 */
	public int hasLHID(String lh) {
		int count = 0;
		RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		String sql = " select COUNT(1) as count from t_ICItemCustom where  F_101 ='"+lh+"'";
		log.writeLog("判断料号是否存在sql: " + sql);
		rsd.executeSql(sql);
		if (rsd.next()) {
			count = rsd.getInt("count");
		}
		return count;
	}
	

	/**
	 * 往金蝶t_Item插入数据
	 */

	public void InsertTItem(String fitemid,String zxfl,String dm,String pm) {
	  String FNumber = zxfl + "." + dm;
	  String FN[]=FNumber.split("[.]");
	  int FLevel = FN.length;
	  String FParentID = getFParentID(zxfl,"1");
	  String FFullName = getFParentID(zxfl,"2")+"_"+pm;
	  RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
	  String sql="insert into t_Item(fitemid,FItemClassID,FExternID,FNumber,FParentID,FLevel,FDetail,FName,FUnUsed,FBrNo,FFullNumber," +
	  		"FDiff,FDeleted,FShortNumber,FFullName,UUID,FGRCommonID,FSystemType,FUseSign,FAccessory,FGrControl,FHavePicture) " +
	  		"values("+fitemid+",4,-1,'"+FNumber+"',"+FParentID+","+FLevel+",1,'"+pm+"',0,'0','"+FNumber+"',0,1,'"+dm+"','"+FFullName+"',newId(),-1,1,0,0,-1,0)";
	 log.writeLog("往金蝶t_Item插入数据sql: " + sql);
	  rsd.executeSql(sql);
	}
	
	
	/**
	 * 往金蝶T_ICItemCore插入数据
	 */
	public void InsertTICItemCore(String fitemid,String gz,String pm,String dm,String zxfl){
		 RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		 String FNumber = zxfl + "." + dm;
		 String FParentID = getFParentID(zxfl,"1");
		 String sql="insert into T_ICItemCore(FItemID,FModel,FName,FDeleted,FShortNumber,FNumber,FParentID,FBrNo,FTopID,FForSale,FOrderPrice,FPerWastage)" +
		  		"values("+fitemid+",'"+gz+"','"+pm+"',1,'"+dm+"','"+FNumber+"',"+FParentID+",'0',0,0,0,0)";
		  log.writeLog("往金蝶T_ICItemCore插入数据sql: " + sql);
		  rsd.executeSql(sql);	
	
	}
	
	
	/**
	 * 往金蝶t_ICItemBase插入数据
	 */
	public void InsertTICItemBase(String fitemid,String dw,String zxfl,String pm,String wlsx){
		 RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		 String sql = "select FUnitGroupID from t_MeasureUnit where fitemid="+dw;
		 rsd.executeSql(sql);
		 String FUnitGroupID = "";
		 if(rsd.next()){
			 FUnitGroupID = Util.null2String(rsd.getString("FUnitGroupID"));
		 }
		 String FFullName = getFParentID(zxfl,"2")+"_"+pm;
		 sql="insert into t_ICItemBase(FItemID,FErpClsID,FUnitID,FUnitGroupID,FDefaultLoc,FSPID,FSource,FQtyDecimal," +
		 		"FLowLimit,FHighLimit,FSecInv,FUseState,FIsEquipment,FIsSparePart,FFullName,FSecUnitID,FOrderUnitID,FSaleUnitID," +
		 		"FStoreUnitID,FProductUnitID,FAuxClassID,FTypeID,FSerialClassID,FDefaultReadyLoc,FSPIDReady) " +
		  		"values("+fitemid+","+wlsx+","+dw+","+FUnitGroupID+",null,0,0,4,0.0000000000,1000.0000000000,0.0000000000,341,0,0,'"+FFullName+"',0,"+dw+","+dw+","+dw+","+dw+",0,0,0,0,0)";
		  log.writeLog("往金蝶t_ICItemBase插入数据sql: " + sql);
		  rsd.executeSql(sql);	
	
	}
	
	
	/**
	 * 往金蝶t_icitemMaterial插入数据 测试：76,1109,1526,1553,1090
	 */
	public void InsertTicitemMaterial(String fitemid){
		 RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		
		 String sql="insert into t_icitemMaterial(FItemID,FOrderRector,FPOHghPrcMnyType,FPOHighPrice,FWWHghPrc,FWWHghPrcMnyType,FSOLowPrc," +
		 		"FSOLowPrcMnyType,FIsSale,FProfitRate,FSalePrice,FBatchManager,FISKFPeriod,FKFPeriod,FTrack,FPlanPrice,FPriceDecimal,FAcctID," +
		 		"FSaleAcctID,FCostAcctID,FAPAcctID,FGoodSpec,FCostProject,FIsSnManage,FStockTime,FBookPlan,FBeforeExpire,FTaxRate,FAdminAcctID," +
		 		"FIsSpecialTax,FSOHighLimit,FSOLowLimit,FOIHighLimit,FOILowLimit,FCheckCycUnit,FStockPrice,FClass,FDepartment,FCBBmStandardID," +
		 		"FCBRestore,FPickHighLimit,FPickLowLimit)" +
		  		"values("+fitemid+",0,1,0,0,1,0,1,0,0,0,0,0,0,76,0,8,1106,1526,1553,1090,0,0,0,0,0,0,17,0,0,0,0,0,0,0,0,0,0,0,1,0,0)";
		  log.writeLog("往金蝶T_ICItemCore插入数据sql: " + sql);
		  rsd.executeSql(sql);	
	
	}
	/**
	 * 往金蝶T_ICItemQuality插入数据 测352，9999
	 */
	public void InsertTICItemQuality(String fitemid,String cpjyfs){
		 RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		
		 String sql="insert into T_ICItemQuality(FItemID,FInspectionLevel,FInspectionProject,FProChkMde ,FWWChkMde,FSOChkMde,FWthDrwChkMde,FStkChkMde," +
		 		"FOtherChkMde,FStkChkPrd,FStkChkAlrm,FIdentifier,FSampStdCritical,FSampStdStrict,FSampStdSlight)" +
		  		"values("+fitemid+",352,0,"+cpjyfs+",352,352,352,352,352,9999,0,0,'0','0','0')";
		  log.writeLog("往金蝶T_ICItemCore插入数据sql: " + sql);
		  rsd.executeSql(sql);	
	
	}
	
	/**
	 * 往金蝶t_ICItemCustom插入数据
	 */
	public void t_ICItemCustom (String fitemid,String lh,String xh){
		 RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		 int count=hasLHID(lh);
		 int count1 = 0;
		 if(count < 1){
		  String sql="select COUNT(1) as count from t_ICItemCustom where FItemID="+fitemid;
		  rsd.executeSql(sql);	
		  if(rsd.next()){
			  count1 = rsd.getInt("count");
		  }
		  if(count1 >0){
			  sql="update t_ICItemCustom set F_101='"+lh+"' ,F_103 = '"+xh+"' where fitemid="+fitemid;
		  }else{
			  sql="insert into t_ICItemCustom(FItemID,F_101,F_103)values("+fitemid+",'"+lh+"','"+xh+"')"; 
		  }			 		
		  log.writeLog("往金蝶t_ICItemCustom插入数据sql: " + sql);
		  rsd.executeSql(sql);	
		 }
	
	}
	/**
	 * 往金蝶TICItem 控制类型erp,存货代码
	 */
	public void updateTICItem (String fitemid,String wlsx,String cpjyfs){
		 RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");		
		 String sql="update t_ICItem set  FCtrlType='14039' ,FAcctID = '1106',FErpClsID="+wlsx+",FProChkMde="+cpjyfs+" where FItemID="+fitemid;
		 rsd.executeSql(sql);			 	
	}
	/**
	 * 校验物料名称,规格,型号是否重复
	 */
	public int checkData(String pm,String gg,String xh){
		int count=0;
		RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		String sql="select COUNT(1) as count from t_ICItemCustom a ,t_ICItem b where a.FItemID=b.FItemID and b.fname='"+pm+"' and b.FModel='"+gg+"' and a.F_103='"+xh+"'";
	    log.writeLog("校验sql"+sql);
		rsd.executeSql(sql);
	    if(rsd.next()){
	    	count = rsd.getInt("count");
	    }
	    return count;
	}
	
	public void updateInfo(String fitemid,String lh,String wlsx ){
		RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		String sql="update t_ICItemCustom set F_101 = '"+lh+"' where fitemid="+fitemid;
		rsd.executeSql(sql);
		sql="update t_ICItem set  FErpClsID="+wlsx+" where FItemID="+fitemid;
		rsd.executeSql(sql);
		
	}

	public int checkzxfl(String lsm){
		int count=0;
		RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		String sql="select COUNT(1) as count from t_item  where FNumber='"+lsm+"'";
		rsd.executeSql(sql);
		if(rsd.next()){
			count = rsd.getInt("count");
		}
		return count;
		
	}
	

}
