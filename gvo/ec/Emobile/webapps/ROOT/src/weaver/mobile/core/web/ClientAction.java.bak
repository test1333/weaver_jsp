package weaver.mobile.core.web;

import io.rong.util.CodeUtil;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Actions;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.stereotype.Controller;

import weaver.mobile.core.AttendanceService;
import weaver.mobile.core.ImageUtil;
import weaver.mobile.core.MD5v2;
import weaver.mobile.core.MobileManager;
import weaver.mobile.core.MobileService;
import weaver.mobile.core.MobileUtil;
import weaver.mobile.core.PluginService;
import weaver.mobile.core.PushNotificationService;
import weaver.mobile.core.WeaverOpenfireUtil;
import weaver.mobile.core.WeaverRongUtil;
import weaver.mobile.core.bean.ClientInfo;
import weaver.mobile.core.bean.MobileComponent;
import weaver.mobile.core.bean.MobileFunction;
import weaver.mobile.core.bean.MobileModule;
import weaver.mobile.core.bean.MobilePlugin;
import weaver.mobile.core.bean.MobilePluginUser;
import weaver.mobile.core.bean.MobilePushDevice;
import weaver.mobile.core.bean.MobileUser;
import weaver.mobile.core.bean.MobileUserConfig;
import weaver.mobile.core.bean.MobileUserGroup;
import weaver.mobile.core.bean.MobileUserUpload;
import weaver.mobile.core.bean.WorkCenterCategory;
import com.opensymphony.xwork2.ActionSupport;

@Namespace("/")
@Controller("clientAction")
public class ClientAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {
	
	public static final String MOBILE_MAP_KEY_SERVER_URL = "mobile.plugin.server.url";

	private static final long serialVersionUID = -1644124674361591838L;

	public Logger logger = Logger.getLogger(this.getClass().getName());
	
	@Resource
	private MobileService mobileService;

	@Resource
	private PluginService pluginService;
	
	@Resource
	private AttendanceService attendanceService;
	
	@Resource
	private PushNotificationService pushNotificationService;
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	private Map<String,Object> data;
	private String path;
	private String url;
	
	private int module;
	//private int model;
	
	private int scope;
	private int moduleid;
	
	private String method;
	
	private String keyword;
	
	private String message;
	
	
	private String uploadID;
	
	
	private InputStream file;
	private String contentType;
	private String fileName;
	private int contentLength;
	
	private String userid;
	private String  userName;
	private String   portraitUri;
	
	
	private File[] uploadFile;
	private String[] uploadKey;
	private String[] uploadFileName;
	private String[] uploadContentType;
	private String[] uploadFileDuration;
	

	@Action(value="client", interceptorRefs=@InterceptorRef("defaultStack"),results={
		@Result(name="json", type="json", params={"root","data"}),
		@Result(name="page", location="/WEB-INF/plugin/${path}"),
		@Result(name="toDetail", location="${url}", type="redirect"),
		@Result(name="data", type="stream",params={"contentType","${contentType}","contentLength","${contentLength}","contentDisposition","attachment;filename=\"${fileName}\"","inputName","file","bufferSize","4096"})
	})
	public String client(){
		try {
			data = new HashMap<String,Object>();
			
			if(moduleid==0&&scope>0) moduleid=scope;
			if(scope==0&&moduleid>0) scope=moduleid;


			
			//登录
			if(method.equals("login")) {
				return login();
			}
			
			if(method.equals("toDetail")) {
				return toDetail();
			}
			
			if(method.equals("verifyuser")) {
				return verifyUser();
			}

			if(method.equals("verifysession")) {
				return verifySession();
			}
			
			if(method.equals("getupload")) {
				return getupload();
			}
			
			//取得系统设置
			if(method.equals("getconfig")) {
				return getConfig();
			}
			
			if(method.equals("pullmsg")) {
				return pullMessage();
			}
			
		ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
			
          //通过sessionkey检查是否登录及超时
			String sessionkey = request.getSession().getId();
			if(!ci.getSessionId().equals(sessionkey)||ci.getMobileUser()==null) {
				data.put("errorno", "005");
				data.put("error", getText("005"));
				return "json";
			}
			
			//数据同步
			if("syncData".equals(method)) {
				return syncData();
			}
			
			//登出
			if(method.equals("logout")) {
				return logout();
			}
			
			//设备登陆唯一性检测
			if(!checkDevice()) {
				data.put("errorno", "129");
				data.put("error", getText("129"));
				
				return "json";
			}
			
			//取得模块设置
			if(method.equals("getmodules")) {
				return getModules();
			}

			//取得相关模块的列表数据
			if(method.equals("getwfpages")||method.equals("getwf")||method.equals("getadrpages")||method.equals("getdocpages")||method.equals("getdoc")||method.equals("getlist")) {
				return getList();
			}
			
			//取得相关模块相关数据查看页面URL
			if(method.equals("getpage")) {
				return getPage();
			}

			//跳转页面
			if(method.equals("redirect")) {
				return redirect();
			}

			//取得相关模块的未读数字
			if(method.equals("getcount")) {
				return getCount();
			}
			
			//提交页面
			if(method.equals("postpage")) {
				return postPage();
			}
			
			
			//取得用户数据
			if(method.equals("getuser")) {
				return getUser();
			}
			
			//取得可以切换的主从账号列表
			if(method.equals("getrelaccount")) {
				return getRelaccount();
			}
			
			//切换账号
			if(method.equals("chgaccount")) {
				return chgAccount();
			}
			
			//取得数据
			if(method.equals("getjson")) {
				return getJSON();
			}
			
			//发送数据
			if(method.equals("postjson")) {
				return postJSON();
			}
			
			//上传数据
			if(method.equals("upload")) {
				return upload();
			}
			
			if(method.equals("delupload")) {
				return delupload();
			}
			
			if("clearPush".equals(method)) {
				return clearPush();
			}
			
			if("checkin".equals(method)) {
				return checkIn();
			}
			
			if("getworkcenter".equals(method)) {
				return getWorkCenter();
			}
			
			if("modelpushsetting".equals(method)){
				return modelPushSetting();
			}
			
			if("group".equals(method)){
				return groupManager();
			}
			
			if("gettoken".equals(method)){
				return getToken(userid, userName, portraitUri);
			}
			
			if("getopenfiretoken".equals(method)){
				return getOpenfireToken(userid, userName, portraitUri);
			}
			
		} catch(Exception e) {
			logger.error("", e);
		}
		return null;
	}
	
	private String getOpenfireToken(String userid,String userName,String portraitUri){
		try{
				String token = WeaverOpenfireUtil.getInstanse().getToken(userid, userName, portraitUri);
			    data.put("token",token);
		}catch(Exception e){
			logger.error("", e);
		}
		return "json";
	}
	
	private String getToken(String userid,String userName,String portraitUri){
		try{
			String token = WeaverRongUtil.getInstanse().getToken(userid, userName, portraitUri);
			data.put("token",token);
		}catch(Exception e){
			logger.error("", e);
		}
		return "json";
	}
	
	private String clearPush() {
		ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		MobileUser user = ci.getMobileUser();
		pushNotificationService.clearPush(user);
		data.put("result",true);
		return "json";
	}

	private String logout() {
		MobileManager.getInstance().removeClientInfo(request);
		data.put("result",true);
		return "json";
	}
	
	private String toDetail() {
		request.setAttribute("iscasforwf", "true");
		message = mobileService.login(request,response);

		if(StringUtils.isNotEmpty(message)&&!message.equals("101")) {
			data.put("errorno", message);
			data.put("error", this.getText(message));
		} else {
			try {
				url = URLDecoder.decode(url,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return "toDetail";
		}
		return "json";
	}

	/**
	 * 客户端登录
	 * 
	 * 3.0/2.0
	 * 
	 * client.do?method=login&loginid=ywy&password=1&udid=xxx&language=zh&isneedmoulds=1&clienttype=ipad&clientver=3.0
	 * 
	 * {"sessionkey":"D5774E3F7E62E41B3C95F4D47F518563","headpic":"/messager/usericon/loginid20100126102914.jpg","createworkflow":"1","modules":[
	 * {"module":"1","scope":"4","count":"?","iconname":"icontab_todolist","unread":"?","label":"待办留言"},
	 * {"module":"2","scope":"5","count":"?","iconname":"icontab_news","unread":"?","label":"新闻中心"},
	 * {"module":"3","scope":"2","count":"?","iconname":"icontab_notice","unread":"?","label":"通知公告"},
	 * {"module":"6","scope":"1","count":"?","iconname":"icontab_addressbook","unread":"?","label":"通讯名单"},
	 * {"module":"7","scope":"11","count":"?","iconname":"icontab_processedworkflow","unread":"?","label":"办结事宜"},
	 * {"module":"8","scope":"6","count":"?","iconname":"icontab_handledworkflow","unread":"?","label":"已办事宜"},
	 * {"module":"9","scope":"7","count":"?","iconname":"icontab_myrequest","unread":"?","label":"我的请求"},
	 * {"module":"10","scope":"3","count":"?","iconname":"icontab_ccworkflow","unread":"?","label":"抄送流程"},
	 * {"module":"11","scope":"12","count":"?","iconname":"icontab_blog","unread":"?","label":"工作微博"}
	 * ]}
	 * 
	 * {"error":"密码错误"}
	 * 
	 * 4.0
	 * 
	 * client.do?method=login&loginid=ywy&password=1&udid=xxx&language=zh&country=cn&clienttype=ipad&clientver=4.0&token=xxx&authcode=xxx&isneedmoulds=1&clientos=&clientosver
	 * 
	 * {"sessionkey":"D5774E3F7E62E41B3C95F4D47F518563","headpic":"/messager/usericon/loginid20100126102914.jpg","createworkflow":"1","groups":[
	 * {"id":"1","name":"工作流","description":"工作流相关","showorder":"1","iconname":"icontab_todolist"},
	 * {"id":"2","name":"文档","description":"文档相关","showorder":"2","iconname":"icontab_news"},
	 * {"id":"3","name":"日程","description":"日程","showorder":"3","iconname":"icontab_notice"},
	 * {"id":"4","name":"会议","description":"会议","showorder":"4","iconname":"icontab_notice"},
	 * {"id":"5","name":"通讯录","description":"通讯录相关","showorder":"5","iconname":"icontab_notice"},
	 * {"id":"6","name":"工作微博","description":"工作微博","showorder":"6","iconname":"icontab_notice"},
	 * {"id":"7","name":"其他","description":"?","showorder":"7","iconname":"icontab_notice"}
	 * ],
	 * "modules":[
	 * {"id":"4","module":"1","scope":"4","count":"?","iconname":"icontab_todolist","unread":"?","label":"待办留言","group":"1"},
	 * {"id":"5","module":"2","scope":"5","count":"?","iconname":"icontab_news","unread":"?","label":"新闻中心","group":"2"},
	 * {"id":"2","module":"3","scope":"2","count":"?","iconname":"icontab_notice","unread":"?","label":"通知公告","group":"2"},
	 * {"id":"1","module":"6","scope":"1","count":"?","iconname":"icontab_addressbook","unread":"?","label":"通讯名单","group":"5"},
	 * {"id":"11","module":"7","scope":"11","count":"?","iconname":"icontab_processedworkflow","unread":"?","label":"办结事宜","group":"1"},
	 * {"id":"6","module":"8","scope":"6","count":"?","iconname":"icontab_handledworkflow","unread":"?","label":"已办事宜","group":"1"},
	 * {"id":"7","module":"9","scope":"7","count":"?","iconname":"icontab_myrequest","unread":"?","label":"我的请求","group":"1"},
	 * {"id":"3","module":"10","scope":"3","count":"?","iconname":"icontab_ccworkflow","unread":"?","label":"抄送流程","group":"1"},
	 * {"id":"12","module":"11","scope":"12","count":"?","iconname":"icontab_blog","unread":"?","label":"工作微博","group":"6"}
	 * ]}
	 * 
	 * {"error":"密码错误"}
	 * 
	 */
	private String login() {
		try {
			String isneedmoulds = StringUtils.defaultIfEmpty(request.getParameter("isneedmoulds"),"");
			
			message = mobileService.login(request,response);

			if(StringUtils.isNotEmpty(message)&&!message.equals("101")) {
				data.put("errorno", message);
				data.put("error", this.getText(message));
			} else {
				ClientInfo ci = MobileManager.getInstance().getClientInfo(request);

				String sessionKey = ci.getSessionId();
				data.put("sessionkey", sessionKey);
				
				MobileUser user = ci.getMobileUser();
				Map<String,Object> userdata = ci.getUserData();

				String headerpic = "";
				if(userdata!=null&&userdata.get("headerpic")!=null) {
					headerpic = (String) userdata.get("headerpic");
				}
				data.put("headpic", headerpic);
				
				String createworkflow = MobileManager.getInstance().isShowCreate()?"1":"0";
				data.put("createworkflow", createworkflow);
				
				List<Map<String,String>> navigation = mobileService.getMobileNavigation(user.getLanguageid());
//				String navigation = JSONArray.fromObject(mobileService.getMobileNavigation()).toString();
				data.put("navigation", navigation);
				
				String version = MobileManager.getInstance().getVersion();
				data.put("version", StringUtils.defaultIfEmpty(version, "4.0"));
				
				String hrmorgshow = "true";
				String hrmorgbtnshow = MobileManager.getInstance().getSetting("hrmorgbtnshow");
				if(hrmorgbtnshow!=null){
					if(hrmorgbtnshow.equals("1")){
						hrmorgshow = "false";
					}
					if(hrmorgbtnshow.equals("2")){
						hrmorgshow = "false";
						for(MobileUserGroup mug:user.getGroups()){
							if(mug.getId()==999999){
								 hrmorgshow = "true";
								break;
							}
						}
					}
				}
				data.put("hrmorgshow", hrmorgshow);
				
				String allpeople = "true";
				String allPeopleshow = MobileManager.getInstance().getSetting("allPeopleshow");
				if(allPeopleshow!=null){
					if(allPeopleshow.equals("1")){
						allpeople = "false";
					}
				}
				data.put("allPeopleshow", allpeople);
				
				String issameDepartment = "true";
				String sameDepartment = MobileManager.getInstance().getSetting("sameDepartment");
				if(sameDepartment!=null){
					if(sameDepartment.equals("1")){
						issameDepartment = "false";
					}
				}
				data.put("sameDepartmentshow", issameDepartment);
				
				String iscommonGroup = "true";
				String commonGroup = MobileManager.getInstance().getSetting("commonGroup");
				if(commonGroup!=null){
					if(commonGroup.equals("1")){
						iscommonGroup = "false";
					}
				}
				data.put("commonGroupshow", iscommonGroup);
				
				String isgroupChat = "true";
				String groupChat = MobileManager.getInstance().getSetting("groupChat");
				if(groupChat!=null){
					if(groupChat.equals("1")){
						isgroupChat = "false";
					}
				}
				data.put("groupChatshow", isgroupChat);
				
				String mysubshow = "true";
				String subordinateshow = MobileManager.getInstance().getSetting("mysubordinateshow");
				if(subordinateshow!=null){
					if(subordinateshow.equals("1")){
						mysubshow = "false";
					}
				}
				data.put("mysubordinateshow", mysubshow);
				
				String creategroupchat = MobileManager.getInstance().getSetting("mobile.client.creategroupchat");
				data.put("creategroupchat", StringUtils.defaultIfEmpty(creategroupchat, "1"));
				
				String udid = MobileManager.getInstance().getSetting("rongAppUDID");//ecology生成
//				if(udid==null||udid.equals("")){
//					udid = MobileManager.getInstance().getSetting("mobile.rong.udid");//本地缓存
//				}else{
//					mobileService.saveSystemProp("mobile.rong.udid", udid);
//				}
				if(udid!=null&&!udid.equals("")){
					data.put("ryudid", udid);
				}else{
					String udidNew = MobileManager.getInstance().getSetting("rongAppUDIDNew");
//					if(udidNew==null||udidNew.equals("")){
//						udidNew = MobileManager.getInstance().getSetting("mobile.rong.udidNew");//本地缓存
//					}else{
//						mobileService.saveSystemProp("mobile.rong.udidNew", udidNew);
//					}
					data.put("ryudidNew", udidNew);
					String rongAppKey = MobileManager.getInstance().getSetting("rongAppKey");
//					if(rongAppKey==null||rongAppKey.equals("")){
//						rongAppKey = MobileManager.getInstance().getSetting("mobile.rong.rongAppKey");//本地缓存
//					}else{
//						mobileService.saveSystemProp("mobile.rong.rongAppKey", rongAppKey);
//					}
					data.put("rongAppKey", rongAppKey);
				}
				/*
				 * 先取出开启openfire标识符，若为true，则向手机端传送标识符，domain，及访问openfire服务的地址等参数
				 */
				String openfireModule = MobileManager.getInstance().getSetting("openfireModule");
				
				if(openfireModule != null && "true".equals(openfireModule)){
					data.put("openfireModule", openfireModule);
					String openfireDomain = MobileManager.getInstance().getSetting("openfireDomain");
					data.put("openfireDomain", openfireDomain);
					String openfireMobileClientUrl = MobileManager.getInstance().getSetting("openfireMobileClientUrl");
					data.put("openfireHost", openfireMobileClientUrl);
//					data.put("openfireHost", "192.168.50.49");
				}
				
				if(isneedmoulds.equals("1")) {
					
					List<Map<String,String>> groups = mobileService.getModuleGroups(user);
					if(groups==null) groups = new ArrayList<Map<String,String>>();
					data.put("groups", groups);
				
					List<Map<String,String>> modules = mobileService.getModules(user);
					if(modules==null) modules = new ArrayList<Map<String,String>>();
					data.put("modules", modules);
					
					List<Map<String,String>> messagetypes = mobileService.getMobileMessageTypesforPush(user);
					if(messagetypes==null) messagetypes = new ArrayList<Map<String,String>>();
					data.put("messagetypes", messagetypes);
					List<Map<String,String>> quicknews = mobileService.getQuicknews(user);
					if(quicknews==null) quicknews = new ArrayList<Map<String,String>>();
					for(Map<String,String> quicknew : quicknews) {
						String label = quicknew.get("label");
						if(StringUtils.isEmpty(label)) continue;
						quicknew.put("label", getText(label));
					}
					data.put("quicknews", quicknews);
//					
//					MobilePlugin mainPlugin = MobileManager.getInstance().getMobileMainPlugin();
//					List<Map<String, String>> wctmodules = new ArrayList<Map<String, String>>();
//					List<Integer> mcids = new ArrayList<Integer>();
//					for (MobileModule mm : MobileManager.getInstance().getMobileModule()) {
//						if(!mainPlugin.getId().equals(mm.getPluginCode())) continue;
//						if(!"1".equals(mm.getVisible())) continue;
//						if (!mobileService.getUserHasPermission(user, mm, "read")) continue;
//						if(mm.getComponent() == null) continue;
//						WorkCenterCategory wcc = mm.getComponent().getWorkCenterCategory();
//						if(wcc == null) continue;			
//						int wccid = wcc.getId();
//						
//						if(mcids.contains(wccid)) continue;
//						mcids.add(wccid);
//						
//						Map<String, String> map = new HashMap<String, String>();
//						map.put("categoryid", ""+wccid);
//						map.put("categoryname", wcc.getName());
//						wctmodules.add(map);
//					}
//					
//					data.put("wctmodules", wctmodules);
				}
			}
		} catch(Exception e) {
			logger.error("", e);
		}

		return "json";
	}
	
	
	private String verifyUser() {
		try {
			String loginid = StringUtils.defaultIfEmpty(request.getParameter("loginid"),"");
			String password = StringUtils.defaultIfEmpty(request.getParameter("password"),"");
			String verifyid = StringUtils.defaultIfEmpty(request.getParameter("verifyid"),"");
			
			message = mobileService.verifyuser(loginid, password, mobileService.getVerifySessionURL(request), verifyid);

			data.put("result", message.equals("101"));

		} catch(Exception e) {
			logger.error("", e);
		}

		return "json";
	}

	private String verifySession() {
		try {
			
			String verifyid = StringUtils.defaultIfEmpty(request.getParameter("verifyid"),"");
			
			if(MobileManager.getInstance().verifySessionKey(verifyid)) {
				data.put("result",true);
			} else {
				data.put("result",false);
			}

		} catch(Exception e) {
			logger.error("", e);
		}

		return "json";
	}

	/**
	 * 取得相关设置
	 * 
	 * 3.0/2.0
	 * 
	 * client.do?method=getconfig&language=zh&clienttype=ipad&clientver=3.0
	 * 
	 * {"config":{"logo":"","welcom":"","bgimg":"","headtext":"移动协同办公系统","footext":"www.weaver.com.cn","version":"2.1"}}
	 * 
	 * 4.0
	 * 
	 * client.do?method=getconfig&clienttype=ipad&clientver=4.0
	 * 
	 * {"config":{"logo":"","welcom":"","bgimg":"","headtext":"移动协同办公系统","footext":"www.weaver.com.cn","name":"E-Mobile","version":"2.1","loginpolicy":"0","pagesize":"10"}}
	 * 
	 */
	private String getConfig() {
		Map<String,String> config = mobileService.getConfig();
		
		data.put("config", config);
		
		return "json";
	}

	/**
	 * 取得模块设置
	 * 
	 * 3.0/2.0
	 * 
	 * client.do?method=getmodules&sessionkey=D6FB74B6525760058D278C3368EE96B9
	 * 
	 * {"modules":[
	 * {"module":"1","scope":"4","count":"?","iconname":"icontab_todolist","unread":"?","label":"待办留言"},
	 * {"module":"2","scope":"5","count":"?","iconname":"icontab_news","unread":"?","label":"新闻中心"},
	 * {"module":"3","scope":"2","count":"?","iconname":"icontab_notice","unread":"?","label":"通知公告"},
	 * {"module":"6","scope":"1","count":"?","iconname":"icontab_addressbook","unread":"?","label":"通讯名单"},
	 * {"module":"7","scope":"11","count":"?","iconname":"icontab_processedworkflow","unread":"?","label":"办结事宜"},
	 * {"module":"8","scope":"6","count":"?","iconname":"icontab_handledworkflow","unread":"?","label":"已办事宜"},
	 * {"module":"9","scope":"7","count":"?","iconname":"icontab_myrequest","unread":"?","label":"我的请求"},
	 * {"module":"10","scope":"3","count":"?","iconname":"icontab_ccworkflow","unread":"?","label":"抄送流程"},
	 * {"module":"11","scope":"12","count":"?","iconname":"icontab_blog","unread":"?","label":"工作微博"}
	 * ]}
	 * 
	 * 4.0
	 * 
	 * {"groups":[
	 * {"id":"1","name":"工作流","description":"工作流相关","showorder":"1","iconname":"icontab_todolist"},
	 * {"id":"2","name":"文档","description":"文档相关","showorder":"2","iconname":"icontab_news"},
	 * {"id":"3","name":"日程","description":"日程","showorder":"3","iconname":"icontab_notice"},
	 * {"id":"4","name":"会议","description":"会议","showorder":"4","iconname":"icontab_notice"},
	 * {"id":"5","name":"通讯录","description":"通讯录相关","showorder":"5","iconname":"icontab_notice"},
	 * {"id":"6","name":"工作微博","description":"工作微博","showorder":"6","iconname":"icontab_notice"},
	 * {"id":"7","name":"其他","description":"?","showorder":"7","iconname":"icontab_notice"}
	 * ]},
	 * {"modules":[
	 * {"id":"4","module":"1","scope":"4","count":"?","iconname":"icontab_todolist","unread":"?","label":"待办留言","group":"1"},
	 * {"id":"5","module":"2","scope":"5","count":"?","iconname":"icontab_news","unread":"?","label":"新闻中心","group":"2"},
	 * {"id":"2","module":"3","scope":"2","count":"?","iconname":"icontab_notice","unread":"?","label":"通知公告","group":"2"},
	 * {"id":"1","module":"6","scope":"1","count":"?","iconname":"icontab_addressbook","unread":"?","label":"通讯名单","group":"5"},
	 * {"id":"11","module":"7","scope":"11","count":"?","iconname":"icontab_processedworkflow","unread":"?","label":"办结事宜","group":"1"},
	 * {"id":"6","module":"8","scope":"6","count":"?","iconname":"icontab_handledworkflow","unread":"?","label":"已办事宜","group":"1"},
	 * {"id":"7","module":"9","scope":"7","count":"?","iconname":"icontab_myrequest","unread":"?","label":"我的请求","group":"1"},
	 * {"id":"3","module":"10","scope":"3","count":"?","iconname":"icontab_ccworkflow","unread":"?","label":"抄送流程","group":"1"},
	 * {"id":"12","module":"11","scope":"12","count":"?","iconname":"icontab_blog","unread":"?","label":"工作微博","group":"6"}
	 * ]}
	 * {"quicknews": [
	 * {"id": "1","module": "1","scope": "10","iconname": "/uploadfile/icons/3.950327128365844E11.jpg","label": "新建流程""},
	 * {"id": "2","module": "11","scope": "6","iconname": "/uploadfile/icons/1363573988440.jpg","label": "新建微博"},
	 * {"id": "3","module": "12","scope": "102","iconname": "/uploadfile/icons/3.823204786217755E11.jpg","label": "新建微信"}
	 * ]}
	 * {"wctmodule":[
	 * {"moduleid":"1","modulename":"流程","checked":"1"}
	 * {"moduleid":"4","modulename":"日程","checked":"1"}
	 * {"moduleid":"5","modulename":"会议","checked":"1"}
	 * {"moduleid":"13","modulename":"邮件","checked":"1"}
	 * ]}
	 */
	private String getModules() {
		ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		MobileUser user = ci.getMobileUser();
		
		List<Map<String,String>> groups = mobileService.getModuleGroups(user);
		if(groups==null) groups = new ArrayList<Map<String,String>>();
		data.put("groups", groups);
		
		List<Map<String,String>> modules = mobileService.getModules(user);
		if(modules==null) modules = new ArrayList<Map<String,String>>();
		data.put("modules", modules);
		
		List<Map<String,String>> quicknews = mobileService.getQuicknews(user);
		if(quicknews==null) quicknews = new ArrayList<Map<String,String>>();
		for(Map<String,String> quicknew : quicknews) {
			String label = quicknew.get("label");
			if(StringUtils.isEmpty(label)) continue;
			quicknew.put("label", getText(label));
		}
		data.put("quicknews", quicknews);
		
		MobilePlugin mainPlugin = MobileManager.getInstance().getMobileMainPlugin();
		List<Map<String, String>> wctmodules = new ArrayList<Map<String, String>>();
		List<Integer> mcids = new ArrayList<Integer>();
		for (MobileModule mm : MobileManager.getInstance().getMobileModule()) {
			if(!mainPlugin.getId().equals(mm.getPluginCode())) continue;
			if(!"1".equals(mm.getVisible())) continue;
			if (!mobileService.getUserHasPermission(user, mm, "read")) continue;
			if(mm.getComponent() == null) continue;
			WorkCenterCategory wcc = mm.getComponent().getWorkCenterCategory();
			if(wcc == null) continue;			
			int wccid = wcc.getId();
			
			if(mcids.contains(wccid)) continue;
			mcids.add(wccid);
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("categoryid", ""+wccid);
			map.put("categoryname", wcc.getName());
			wctmodules.add(map);
		}
		
		data.put("wctmodules", wctmodules);
		
		//放入融云推送参数
		String udidNew = MobileManager.getInstance().getSetting("rongAppUDIDNew");
		data.put("ryudidNew", udidNew);
		String rongAppKey = MobileManager.getInstance().getSetting("rongAppKey");
		data.put("rongAppKey", rongAppKey);
		
		/*
		 * 先取出开启openfire标识符，若为true，则向手机端传送标识符，domain，及访问openfire服务的地址等参数
		 */
		String openfireModule = MobileManager.getInstance().getSetting("openfireModule");
		
		if(openfireModule != null && "true".equals(openfireModule)){
			data.put("openfireModule", openfireModule);
			String openfireDomain = MobileManager.getInstance().getSetting("openfireDomain");
			data.put("openfireDomain", openfireDomain);
			String openfireMobileClientUrl = MobileManager.getInstance().getSetting("openfireMobileClientUrl");
			data.put("openfireHost", openfireMobileClientUrl);
		}
		
		return "json";
	}

	/**
	 * 取得相关模块列表数据
	 * 
	 * 3.0/2.0
	 * 
	 * client.do?method=getwfpages&sessionkey=D6FB74B6525760058D278C3368EE96B9&module=1&scope=4&pageindex=1&keyword=
	 * client.do?method=getwf&sessionkey=D6FB74B6525760058D278C3368EE96B9&module=1&scope=4&detailid=
	 * client.do?method=getadrpages&sessionkey=D6FB74B6525760058D278C3368EE96B9&module=1&scope=4&keyword=
	 * client.do?method=getdocpages&sessionkey=D6FB74B6525760058D278C3368EE96B9&module=1&scope=4&keyword=
	 * client.do?method=getdoc&sessionkey=D6FB74B6525760058D278C3368EE96B9&module=1&scope=4&detailid=
	 * 
	 * {"pagesize":"10","count":"40","ishavepre":"0","pagecount":"4","wfs":[
	 * {"createtime":"2012-02-23 17:11:32","implev":"0","status":"","recivetime":"2012-02-23 17:11:32","wfid":"17928","creatorpic":"/messager/usericon/loginid20100126102914.jpg","wftype":"周工作小结与计划","wftitle":"周工作小结与计划-杨文元-2012-02-23","isnew":"0","creator":"杨文元"},
	 * {"createtime":"2012-02-16 17:58:02","implev":"0","status":"","recivetime":"2012-02-16 17:58:02","wfid":"17497","creatorpic":"/messager/usericon/loginid20100126102914.jpg","wftype":"周工作小结与计划","wftitle":"周工作小结与计划-杨文元-2012-02-16","isnew":"0","creator":"杨文元"},
	 * {"createtime":"2011-12-22 17:20:23","implev":"0","status":"","recivetime":"2011-12-22 17:20:23","wfid":"12733","creatorpic":"/messager/usericon/loginid20100126102914.jpg","wftype":"周工作小结与计划","wftitle":"周工作小结与计划-杨文元-2011-12-22","isnew":"0","creator":"杨文元"}
	 * ],"pageindex":"1","ishavenext":"1"}
	 * 
	 * {"pagesize":"10","count":"425","ishavepre":"0","pagecount":"43","pageindex":"1","userKvList":[
	 * {"sex":"0","manager":"","status":"正式","location":"上海","lastname":"倪云","msgerurl":"","id":"508","jobtitle":"董事会主席","email":"ecologydemo@weaver.com.cn","dept":"董事会","subcom":"集团管理总部","telephone":"02150942228","mobile":"15000209807"},
	 * {"sex":"0","manager":"杨文元","status":"正式","location":"上海","lastname":"周福民","msgerurl":"","id":"514","jobtitle":"行政总监","email":"ecologydemo@weaver.com.cn","dept":"行政管理中心","subcom":"集团管理总部","telephone":"02150942228","mobile":"15000209807"},
	 * {"sex":"0","manager":"黄蓉","status":"正式","location":"上海","lastname":"刘景辉","msgerurl":"","id":"517","jobtitle":"IT总监","email":"ecologydemo@weaver.com.cn","dept":"IT管理中心","subcom":"集团管理总部","telephone":"02150942228","mobile":"15000209807"}
	 * ],"ishavenext":"1"}
	 * 
	 * {"pagesize":"10","count":"8","ishavepre":"0","pagecount":"1","docs":[
	 * {"createtime":"2011-11-15 17:22:07","docimg":"750","docid":"670","owner":"赵静","isnew":"0","docsubject":"维森集团2011年5月份维森之星","modifytime":"2011-11-15 17:22:07"},
	 * {"createtime":"2011-04-01 19:28:24","docimg":"615","docid":"392","owner":"","isnew":"0","docsubject":"企业信息化解决方案研讨会","modifytime":"2011-11-15 17:22:07"},
	 * {"createtime":"2011-03-20 09:11:43","docimg":"516","docid":"372","owner":"","isnew":"0","docsubject":"第一品牌","modifytime":"2011-11-15 17:22:07"}
	 * ],"pageindex":"1","ishavenext":"0"}
	 * 
	 * 4.0
	 * 
	 * client.do?method=getlist&sessionkey=&moduleid=1&pageindex=1&keyword=
	 * 
	 * {"pagesize":"10","ishavepre":"0","count":"445","list":[
	 * {"time":"2012-05-10 16:32:14","image":"","id":"1607","isnew":"0","subject":"7.0TD处理","description":""},
	 * {"time":"2012-05-10 16:27:13","image":"","id":"1606","isnew":"0","subject":"log","description":""},
	 * {"time":"2012-05-10 16:26:34","image":"","id":"1605","isnew":"0","subject":"log","description":""},
	 * {"time":"2012-05-10 10:30:44","image":"","id":"1604","isnew":"0","subject":"公文2月-悟空-2012-05-10","description":""},
	 * {"time":"2012-05-09 17:21:40","image":"","id":"1597","isnew":"1","subject":"4.12 e-cology新功能培训","description":""},
	 * {"time":"2012-05-09 17:21:20","image":"","id":"1596","isnew":"1","subject":"公文2月-悟空-2012-05-09","description":""},
	 * {"time":"2012-05-09 10:36:49","image":"","id":"1595","isnew":"1","subject":"12323","description":""},
	 * {"time":"2012-05-09 09:36:03","image":"","id":"1593","isnew":"1","subject":"人员导入标准模板","description":""},
	 * {"time":"2012-05-09 09:29:43","image":"","id":"1592","isnew":"1","subject":"excel07","description":""},
	 * {"time":"2012-05-09 09:27:02","image":"","id":"1591","isnew":"1","subject":"7.0改造问题汇总表（模板）","description":""}
	 * ],"pagecount":"45","pageindex":"1","ishavenext":"1"}
	 * 
	 */
	private String getList() {
		try {
			
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		
			MobileUser mu = ci.getMobileUser();

			MobileModule mm = MobileManager.getInstance().getMobileModule(moduleid,module);
			
			String isbrow = request.getParameter("isbrow");//获取所有流程
			
			if(mm != null && mobileService.verify(ci,mm.getPlugin())) {
			
				if((mobileService.getUserHasPermission(mu, mm, "read"))||(isbrow!=null&&isbrow.equals("1"))) {
				
					MobilePlugin mp = mm.getPlugin();
					MobilePluginUser mpu = mu.getMobilePluginUser(mp);
					MobileUserConfig muc = mu.getMobileUserConfig("");
	
					if(mpu!=null && StringUtils.isNotEmpty(mpu.getPluginSessionKey())) {
					
						String setting = "";
						if(mm!=null) setting = mm.getSetting();
						String config = "";
						if(muc!=null) config = muc.getSetting();
						
						String sessionKey = mpu.getPluginSessionKey();
						
						int pageIndex = NumberUtils.toInt(request.getParameter("pageindex"), 1);
						pageIndex = pageIndex > 0 ? pageIndex : 1;
						int pageSize = NumberUtils.toInt(StringUtils.defaultIfEmpty(request.getParameter("pagesize"), MobileManager.getInstance().getSetting("mobile.client.pagesize")),10);
						if(pageSize <= 0) {
							pageSize = NumberUtils.toInt(MobileManager.getInstance().getSetting("mobile.client.pagesize"),10);
							if(pageSize <= 0) {
								pageSize = 10;
							}
						}
						
						String keyword = StringUtils.defaultIfEmpty(request.getParameter("keyword"),"");
						keyword = java.net.URLEncoder.encode(keyword,mp.getCharset());
						
						String detailId = StringUtils.defaultIfEmpty(request.getParameter("detailid"),"");

						Map<String,Object> param = new HashMap<String,Object>();
						param.put("module", mm.getComponent().getModel());
						param.put("scope", mm.getId()+"");
						
						if(StringUtils.isNotEmpty(detailId) && !"0".equals(detailId) && !"-1".equals(detailId)) {
							param.put("detailid", detailId);
						}
						param.put("clienttype", ci.getClientType());
						param.put("clientlevel", ci.getClientLevel()+"");
						param.put("clientver", ci.getMobileClient().getClientVer()+"");
						param.put("serverver", MobileManager.getInstance().getVersion()+"");
						param.put("clientos", ci.getMobileClient().getClientOS());
						param.put("clientosver", ci.getMobileClient().getClientOSVer());

						param.put("pageindex", pageIndex+"");
						param.put("pagesize", pageSize+"");
						param.put("sessionkey", sessionKey);
						param.put("setting", StringUtils.defaultIfEmpty(setting,""));
						param.put("config", StringUtils.defaultIfEmpty(config,""));
						param.put("keyword", keyword);
						param.put("isbrow", isbrow);
						param.put("isallwf", request.getParameter("isallwf"));
						//param.put("request", request);
						param.put("response", response);
						
						Enumeration enu=request.getParameterNames();
						while(enu.hasMoreElements()){
							String paraName=(String)enu.nextElement();
							if(!param.containsKey(paraName)){
								param.put(paraName, request.getParameter(paraName));
							}
						}
							
						MobileFunction function = mobileService.getComponentFunction(mm.getComponent(), "list");
						
						if(function!=null) {
						
							data = pluginService.execute(mp, function, param);
							if(data!=null) {
			
								String error = (String) data.get("error");
								if(StringUtils.isEmpty(error)) {
									List<Map<String,Object>> list = (List<Map<String,Object>>) data.get("list");
									response.setContentType("application/json; charset=UTF-8");
									JSONObject obj = JSONObject.fromObject(data);
								    String content = obj.toString();
									response.getWriter().write(content);
									response.getWriter().flush();
									response.getWriter().close();
//									String moduleid = mm.getComponent().getModel();
//								    if(moduleid.equals("1")||moduleid.equals("7")||moduleid.equals("8")||moduleid.equals("9")||moduleid.equals("10")){
//								    	for(Map objMap:list){
//								    		detailId = (String)objMap.get("id");
//								    		request.setAttribute("detailid", detailId);
//											getPage();
//								    		
//								    	}
//								    }
									
									return null;
								} else {
									data.put("errorno", error);
									data.put("error", getText(error));
								}
								
							} else {
								data = new HashMap();
								data.put("errorno", "124");
								data.put("error", getText("124"));
							}
						}
					} else {
						data.put("errorno", "125");
						data.put("error", getText("125"));
					}
				} else {
					data.put("errorno", "125");
					data.put("error", getText("125"));
				}
			} else if(mm == null){
				data.put("errorno", "123");
				data.put("error", getText("123"));
			} else {
				data.put("errorno", "126");
				data.put("error", getText("126"));
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		
		return "json";
	}
	
	/**
	 * 取得相关模块相关数据查看页面URL
	 * 
	 * 3.0/2.0
	 * 
	 * client.do?method=getpage&sessionkey=&module=1&scope=4&detailid=
	 * 
	 * redirect to page
	 * 
	 * 4.0
	 * 
	 * client.do?method=getpage&sessionkey=&module=1&detailid=
	 * 
	 * redirect to page
	 * 
	 */
	private String getPage() {
		try {
			
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		
			MobileUser mu = ci.getMobileUser();
			MobileModule mm = MobileManager.getInstance().getMobileModule(moduleid);
			
			if(mm == null) {
				this.message = "123";
				return "message";
			}
			if(mm.getComponent().getModel().equals("-3")) return redirect();
			if(mm.getComponent().getModel().equals("-5")){
				String url = mm.getSetting();
				if(StringUtils.isNotEmpty(url)) {
					MobilePlugin mp = mm.getPlugin();
					MobilePlugin p = MobileManager.getInstance().getMobileMainPlugin();
					MobilePluginUser mpu = mu.getMobilePluginUser(mp);
					String serverUrl =  StringUtils.defaultIfEmpty(p.getServerURL(), "");
					if(serverUrl.endsWith("/")) serverUrl = serverUrl.substring(0, serverUrl.length()-1);
					if(url.startsWith("/")) url = url.substring(1);
					url = serverUrl +"/"+ url;
					Map<String,Object> param = new HashMap<String,Object>();
					param.put("sessionkey", mpu.getPluginSessionKey());
					param.put("module", "-5");
					param.put("scope", mm.getId()+"");
					param.put("clienttype", ci.getClientType());
					param.put("clientlevel", ci.getClientLevel()+"");
					param.put("clientver", ci.getMobileClient().getClientVer()+"");
					param.put("serverver", MobileManager.getInstance().getVersion()+"");
					param.put("clientos", ci.getMobileClient().getClientOS());
					param.put("clientosver", ci.getMobileClient().getClientOSVer());
					param.put("request", request);
					param.put("response", response);
					param.put("viewmodule", mobileService.getViewModule(mm.getPlugin(), mu));
					Map<String,Object> rd = pluginService.get(url, "get", param, "html","utf-8");
					if(rd!=null) {

						String error = (String) rd.get("error");
						if(StringUtils.isEmpty(error)) {
		
							String content = (String) rd.get("content");
							
							if(StringUtils.isNotEmpty(content)) {
								
								//response.setCharacterEncoding("UTF-8");
								response.setContentType("text/html; charset=UTF-8");
								
								response.getWriter().write(content);
								response.getWriter().flush();
								response.getWriter().close();
							}
						}
					}
				}else{
					message="内部地址为空，请前往配置！";
					return "message";
				}
				return null;
			}
			if(mobileService.verify(ci,mm.getPlugin())) {
//				if(mobileService.getUserHasPermission(mu, mm, "read")) {
					MobilePlugin mp = mm.getPlugin();
					MobilePluginUser mpu = mu.getMobilePluginUser(mp);
					if(mpu!=null && StringUtils.isNotEmpty(mpu.getPluginSessionKey())) {
						boolean beRespone = true; 
						String title = MobileUtil.getLabelName(mm.getLabel(), mu.getLanguageid());
						title = java.net.URLEncoder.encode(title,mp.getCharset());
						String detailId = StringUtils.defaultIfEmpty(request.getParameter("detailid"),"");
						if("".equals(detailId)){
							detailId = StringUtils.defaultIfEmpty((String)request.getAttribute("detailid"),""); //流程列表预加载
							if(!detailId.equals("")){
								beRespone = false; //不需要返回
							}
						}
						int quicknew = NumberUtils.toInt(request.getParameter("quicknew"));
						Map<String,Object> param = new HashMap<String,Object>();
						param.put("module", mm.getComponent().getModel());
						param.put("scope", mm.getId()+"");
						param.put("detailid", detailId);
						param.put("sessionkey", mpu.getPluginSessionKey());
						param.put("clienttype", ci.getClientType());
						param.put("clientlevel", ci.getClientLevel()+"");
						param.put("clientver", ci.getMobileClient().getClientVer()+"");
						param.put("serverver", MobileManager.getInstance().getVersion()+"");
						param.put("clientos", ci.getMobileClient().getClientOS());
						param.put("clientosver", ci.getMobileClient().getClientOSVer());
						param.put("title", title);
						param.put("request", request);
						param.put("response", response);
						param.put("opengps", MobileManager.getInstance().getSetting("mobile.client.opengps"));
						param.put("viewmodule", mobileService.getViewModule(mm.getPlugin(), mu));
						param.put("ispad", ci.getMobileClient().isPad());
						param.put("f_weaver_belongto_userid", request.getParameter("f_weaver_belongto_userid"));
						param.put("f_weaver_belongto_usertype", request.getParameter("f_weaver_belongto_usertype"));
						//param.put("ipaddress", mobileService.getClientIpAddr(request));

						MobileFunction function = null;
						
						if(quicknew > 0) {
							function = mobileService.getQuickNewFunction(mm.getComponent(), ""+quicknew, "view");
						} else {
							function = mobileService.getComponentFunction(mm.getComponent(), "view");
						}
						
						if(function!=null) {
							//logger.debug("request workflow id"+mm.getComponent().getId()+detailId);
//							Object cacheObject = CacheUtil.getUserObject(mpu.getUser().getId(), detailId);
//							if(cacheObject!=null&&!((String)(cacheObject)).equals("")&&beRespone){
//								String cacheContent = (String)cacheObject;
//								response.setCharacterEncoding("UTF-8");
//								response.setContentType("text/html");
//								response.getWriter().write(cacheContent);
//								response.getWriter().flush();
//								response.getWriter().close();
//								return null;
//							}
							Map<String,Object> rd = pluginService.execute(mp, function, param);
							if(rd!=null) {
			
								String error = (String) rd.get("error");
								if(StringUtils.isEmpty(error)) {
				
									String content = (String) rd.get("content");
									
									if(StringUtils.isNotEmpty(content)) {
										logger.debug("store workflow id"+mm.getComponent().getId()+detailId);
//										CacheUtil.putUserObject(mpu.getUser().getId(), mm.getComponent().getId()+ci.getClientType()+detailId, content);
										if(beRespone){
											response.setCharacterEncoding("UTF-8");
											response.setContentType("text/html");
											response.getWriter().write(content);
											response.getWriter().flush();
											response.getWriter().close();
										}
									}
										
									return null;
								} else {
									this.message = error;
									return "message";
								}
							} else {
								this.message = "124";
								return "message";
							}
						} else {
							this.message = "123";
							return "message";
						}
					} else {
						this.message = "125";
						return "message";
					}
//				} else {
//					this.message = "125";
//					return "message";
//				}
			} else {
				this.message = "126";
				return "message";
			}
		
		} catch (Exception e) {
			logger.error("", e);
		}
		return null;
	}
	
	
	private String redirect() {
		try {
			
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		
			MobileUser mu = ci.getMobileUser();
			MobileModule mm = MobileManager.getInstance().getMobileModule(moduleid);
			
//				if(mobileService.getUserHasPermission(mu, mm, "read")) {
	
					MobilePlugin mp = mm.getPlugin();
					
					if(NumberUtils.toInt(mp.getId())<0 && mm.getComponent().getModel().equals("-3")) {
						
						String url = mm.getSetting();
						
						if(StringUtils.isNotEmpty(url)) {
							
							if(url.indexOf("?")>-1) url+="&";
							else url+="?";
							
							url+="loginid=" + URLEncoder.encode(mu.getLoginId(),"UTF-8");
							
							if(url.indexOf("?")>-1) url+="&";
							else url+="?";
							
							long timestamp = new Date().getTime();
							
							url+="stamp=" + timestamp;
							
							if(url.indexOf("?")>-1) url+="&";
							else url+="?";
							
							String secrect = MobileManager.getInstance().getSetting("mobile.url.secrect");
							
							if(secrect==null||"".equals(secrect)){
								secrect = "weaver";
							}
							String token =  CodeUtil.hexSHA1(secrect+mu.getLoginId()+timestamp);
							
							url+="token="+token;
							
							if(!url.startsWith("http://")&&!url.startsWith("https://")) url="http://"+url;
							
							response.sendRedirect(url);
							
						}
						
					}else if(NumberUtils.toInt(mp.getId())<0 && mm.getComponent().getModel().equals("-5")){
						MobilePluginUser mpu = mu.getMobilePluginUser(mp);
						String url = mm.getSetting();
						if(url.indexOf("?")>-1) url+="&";
						else url+="?";
						
						url += "sessionkey="+mpu.getPluginSessionKey();
						response.sendRedirect(url);
					}
					
//				} else {
//					this.message = "125";
//					return "message";
//				}
		
		} catch (Exception e) {
			logger.error("", e);
		}
		return null;
	}
	
	/**
	 * 取得用户数据
	 * 
	 * 4.0
	 * 
	 * client.do?method=getuser&sessionkey=&userid=
	 * client.do?method=getuser&sessionkey=
	 * 
	 * sex=0, manager=xxx, status=试用, location=SH, headerpic=/messager/images/icon_m.jpg, id=1, jobtitle=xxx, email=, name=xxx, dept=技术开发部-上海, subcom=泛微上海, telephone=, mobile=xxx
	 * 
	 * @return
	 */
	private String getUser() {
		
		String id = StringUtils.defaultIfEmpty(request.getParameter("userid"),"");
		
		ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		
		MobileUser mu = ci.getMobileUser();
		
		MobilePlugin mp = MobileManager.getInstance().getMobileMainPlugin();
		
		MobilePluginUser mpu = mu.getMobilePluginUser(mp);
		
		if(mpu!=null && StringUtils.isNotEmpty(mpu.getPluginSessionKey())) {

			String sessionKey = mpu.getPluginSessionKey();
	
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("id", id);
			param.put("sessionkey", sessionKey);
			
			MobileFunction function = mobileService.getMobileFunction(mp, "user");
			
			if(function!=null) {
			
				Map<String,Object> userdata = (Map<String,Object>) pluginService.execute(mp, function, param);
		
				if(userdata!=null) {
					
					String error = (String) userdata.get("error");
					if(StringUtils.isEmpty(error)) {
						
						data = userdata;
	
					} else {
						data.put("errorno", error);
						data.put("error", getText(error));
					}
					
				} else {
					data.put("errorno", "124");
					data.put("error", getText("124"));
				}
			} else {
				data.put("errorno", "123");
				data.put("error", getText("123"));
			}
			
		} else {
			data.put("errorno", "125");
			data.put("error", getText("125"));
		}

		return "json";
	}
	
	/**
	 * 提交页面
	 * 
	 * 4.0
	 * 
	 * client.do?method=postpage&sessionkey=&module=1&scope=&detailid=
	 * 
	 * post to page
	 * 
	 */
	private String postPage() {
		
		try {
		
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		
			MobileUser mu = ci.getMobileUser();
			
			MobileModule mm = MobileManager.getInstance().getMobileModule(moduleid);
			
			if(mobileService.verify(ci,mm.getPlugin())) {
			
//				if(mobileService.getUserHasPermission(mu, mm, "read")) {
		
					MobilePlugin mp = mm.getPlugin();
					MobilePluginUser mpu = mu.getMobilePluginUser(mp);
		
					if(mpu!=null && StringUtils.isNotEmpty(mpu.getPluginSessionKey())) {
					
						String detailId = StringUtils.defaultIfEmpty(request.getParameter("detailid"),"");
						
						String mobileSession = ci.getSessionId();
						
						Map<String,Object> param = new HashMap<String,Object>();
						//param.put("mobilesessionkey", mobileSession);
						param.put("module", mm.getComponent().getModel());
						param.put("scope", mm.getId()+"");
						param.put("detailid", detailId);
						param.put("sessionkey", mpu.getPluginSessionKey());
						param.put("request", request);
						param.put("response", response);
							
						MobileFunction function = mobileService.getComponentFunction(mm.getComponent(), "post");
						
						if(function!=null) {
						
							Map<String,Object> rd = pluginService.execute(mp, function, param);
							if(rd!=null) {
				
								String error = (String) rd.get("error");
								if(StringUtils.isEmpty(error)) {
				
									String content = (String) rd.get("content");
									
									if(StringUtils.isNotEmpty(content)) {
									
										response.setContentType("text/html; charset=UTF-8");
										
										response.getWriter().write(content);
										response.getWriter().flush();
										response.getWriter().close();
									
									}
										
									return null;
								} else {
									this.message = error;
									return "message";
								}
							} else {
								this.message = "124";
								return "message";
							}
						} else {
							this.message = "123";
							return "message";
						}
					} else {
						this.message = "125";
						return "message";
					}
//				} else {
//					this.message = "125";
//					return "message";
//				}
			} else {
				this.message = "126";
				return "message";
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		return null;
	}

	
	/**
	 * 取得相关模块的未读数字
	 * 
	 * 3.0/2.0
	 * 
	 * client.do?method=getcount&sessionkey=D6FB74B6525760058D278C3368EE96B9&module=1&scope=4
	 * 
	 * {"count":"40","unread":"0"}
	 * 
	 * 4.0
	 * 
	 * client.do?method=getcount&sessionkey=D6FB74B6525760058D278C3368EE96B9&module=1&scope=4
	 * 
	 * {"count":"40","unread":"0"}
	 * 
	 */
	private String getCount() {
		try {

			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		
			MobileUser mu = ci.getMobileUser();
			
			MobileModule mm = MobileManager.getInstance().getMobileModule(moduleid);
			
			if(mobileService.verify(ci,mm.getPlugin())) {
			
//				if(mobileService.getUserHasPermission(mu, mm, "read")) {
		
					MobilePlugin mp = mm.getPlugin();
					MobilePluginUser mpu = mu.getMobilePluginUser(mp);
					MobileUserConfig muc = mu.getMobileUserConfig("");
					
					if(mpu!=null && StringUtils.isNotEmpty(mpu.getPluginSessionKey())) {
		
						String setting = "";
						if(mm!=null) setting = mm.getSetting();
						String config = "";
						if(muc!=null) config = muc.getSetting();

						Map<String,Object> param = new HashMap<String,Object>();
						param.put("module", mm.getComponent().getModel());
						param.put("scope", mm.getId()+"");
						param.put("sessionkey", mpu.getPluginSessionKey());

						param.put("setting", StringUtils.defaultIfEmpty(setting,""));
						param.put("config", StringUtils.defaultIfEmpty(config,""));
						
						
						MobileFunction function = mobileService.getComponentFunction(mm.getComponent(), "count");
						
						if(function!=null) {
						
							Map<String,Object> rd = pluginService.execute(mp, function, param);
							if(rd!=null) {
								String error = (String) rd.get("error");
								if(StringUtils.isEmpty(error)) {
			
									String count = (String) rd.get("count");
									String unread = (String) rd.get("unread");
											
									data.put("count", count);
									data.put("unread", unread);
											
								} else {
									data.put("errorno", error);
									data.put("error", getText(error));
								}
							} else {
								data.put("errorno", "124");
								data.put("error", getText("124"));
							}
						} else {
							data.put("count", "0");
							data.put("unread", "0");
						}
					} else {
						data.put("errorno", "125");
						data.put("error", getText("125"));
					}
//				} else {
//					data.put("errorno", "125");
//					data.put("error", getText("125"));
//				}
			} else {
				data.put("errorno", "126");
				data.put("error", getText("126"));
			}
		} catch (Exception e) {
			logger.error("", e);
		}

		return "json";
	}

	/**
	 * 取得可以切换的主从账号列表
	 * 
	 * 3.0/2.0
	 * 
	 * client.do?method=getrelaccount&sessionkey=D6FB74B6525760058D278C3368EE96B9
	 * 
	 * {"users":[
	 * {"jobtitle":"执行总裁","username":"杨文元","userid":"509","subcom":"集团管理总部","dept":"总裁办公室","iscur":"1"},
	 * {"jobtitle":"IT总监","username":"僵尸","userid":"633","subcom":"集团管理总部","dept":"IT管理中心","iscur":"0"},
	 * {"jobtitle":"总经理秘书","username":"秘书","userid":"206","subcom":"维森软件","dept":"总经办","iscur":"0"}
	 * ]}
	 * 
	 * 4.0
	 * 
	 * client.do?method=getrelaccount&sessionkey=D6FB74B6525760058D278C3368EE96B9
	 * 
	 * {"users":[
	 * {"jobtitle":"执行总裁","username":"杨文元","userid":"509","subcom":"集团管理总部","dept":"总裁办公室","iscur":"1"},
	 * {"jobtitle":"IT总监","username":"僵尸","userid":"633","subcom":"集团管理总部","dept":"IT管理中心","iscur":"0"},
	 * {"jobtitle":"总经理秘书","username":"秘书","userid":"206","subcom":"维森软件","dept":"总经办","iscur":"0"}
	 * ]}
	 * 
	 */
	private String getRelaccount() {
		List<Map<String,Object>> accounts = mobileService.getAccounts(request);
		if(accounts==null) accounts = new ArrayList<Map<String,Object>>();
		data.put("users", accounts);	
		
		return "json";
	}
	
	/**
	 * 切换账号
	 * 
	 * 3.0/2.0
	 * 
	 * client.do?method=chgaccount&sessionkey=D6FB74B6525760058D278C3368EE96B9&reluserid=633
	 * 
	 * {"error":""}
	 * 
	 * {"error":"没有权限访问"}
	 * 
	 * 4.0
	 * 
	 * client.do?method=chgaccount&sessionkey=D6FB74B6525760058D278C3368EE96B9&reluserid=633
	 * 
	 * {"error":""}
	 * 
	 * {"error":"没有权限访问"}
	 * 
	 */
	private String chgAccount() {
		
		String newuserid = StringUtils.defaultIfEmpty(request.getParameter("reluserid"),"");
		
		String message = mobileService.chgAccount(newuserid, request);
		
		data.put("errorno", message);
		data.put("error", getText(message));
		
		return "json";
	}
	
	@Action(value="casToThridWeb", interceptorRefs=@InterceptorRef("defaultStack"),results={
		@Result(name="json", type="json", params={"root","data"})
	})
	public String casToThridWeb(){
		data = new HashMap<String, Object>();
		try{
//			String ios = MobileUtil.null2String(request.getParameter("ios"), "");
//			String andr = MobileUtil.null2String(request.getParameter("andr"), "");
//			data.put("ios", ios);
//			data.put("andr", andr);
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
			
			MobileUser mu = ci.getMobileUser();
			
			String loginId = mu.getLoginId();
			
			data.put("loginId", loginId);
			
			long timestamp = new Date().getTime();
			
			data.put("stamp", timestamp);
			
			String secrect = MobileManager.getInstance().getSetting("mobile.url.secrect");
			
			if(secrect==null||"".equals(secrect)){
				secrect = "weaver";
			}
			//data.put("secrect", secrect);
			
			String token =  CodeUtil.hexSHA1(secrect+mu.getLoginId()+timestamp);
			
			data.put("token", token);
		}catch(Exception e){
			e.printStackTrace();
			data.put("error", "请求失败，请联系管理员！");
		}
		return "json";
	}
	/**
	 * 读取图片
	 * 
	 * 3.0/2.0
	 * 
	 * downloadpic.do?url=/messager/images/icon_m.jpg&sessionkey=3D98312B9879749FD9F7617F0E59007C&thumbnail=1
	 * downloadpic.do?url=http://www.sina.com.cn/messager/images/icon_m.jpg&sessionkey=3D98312B9879749FD9F7617F0E59007C&thumbnail=1
	 * downloadpic.do?fileid=3935&sessionkey=61CD24E689C3081453C3D6ECCB5E5DC9&thumbnail=1
	 * downloadpic.do?path=d:/1.png&sessionkey=61CD24E689C3081453C3D6ECCB5E5DC9&thumbnail=1
	 * 
	 * 4.0
	 * 
	 * downloadpic.do?url=/messager/images/icon_m.jpg&sessionkey=3D98312B9879749FD9F7617F0E59007C&thumbnail=1
	 * downloadpic.do?url=http://www.sina.com.cn/messager/images/icon_m.jpg&sessionkey=3D98312B9879749FD9F7617F0E59007C&thumbnail=1
	 * downloadpic.do?fileid=3935&sessionkey=61CD24E689C3081453C3D6ECCB5E5DC9&thumbnail=1
	 * downloadpic.do?path=d:/1.png&sessionkey=61CD24E689C3081453C3D6ECCB5E5DC9&thumbnail=1
	 * 
	 * download.do?url=/css/weaver.css&sessionkey=3D98312B9879749FD9F7617F0E59007C&thumbnail=0&contenttype=
	 * 
	 */
	@Actions({
		@Action(value="downloadpic", interceptorRefs=@InterceptorRef("defaultStack"),results={
			@Result(name="success", type="stream",params={"contentType","${contentType}","contentLength","${contentLength}","contentDisposition","attachment;filename=\"${fileName}\"","inputName","file","bufferSize","4096"})
		}),
		@Action(value="download", interceptorRefs=@InterceptorRef("defaultStack"),results={
			@Result(name="success", type="stream",params={"contentType","${contentType}","contentLength","${contentLength}","contentDisposition","attachment;filename=\"${fileName}\"","inputName","file","bufferSize","4096"})
		})
	})
	public String download() {
		String hurl = StringUtils.defaultIfEmpty(request.getParameter("url"),"");
		String fileid = StringUtils.defaultIfEmpty(request.getParameter("fileid"),"");
		String path = StringUtils.defaultIfEmpty(request.getParameter("path"),"");
		String avatarname = StringUtils.defaultIfEmpty(request.getParameter("path"),"");
		String thumbnail = StringUtils.defaultIfEmpty(request.getParameter("thumbnail"),"1");
		
		Map<String,Object> image = null;
		
		try {
			String fileURL = "";
			
			if(StringUtils.isNotEmpty(fileid)) {
				fileURL = fileid;
			} else if(StringUtils.isNotEmpty(path)) {
				fileURL = path;
			} else if(StringUtils.isNotEmpty(hurl)) {
				fileURL = hurl;
			}
			
			if(fileURL.startsWith("/")) {
				String filePath = ServletActionContext.getServletContext().getRealPath(fileURL);
				boolean allowDownLoad = MobileManager.getInstance().isIncludesDownloadRequest(filePath);
				if(!allowDownLoad){
					return null;
				}
				File f = new File(filePath);
				if(fileURL.startsWith("/avatar/")){
					String folderpath = filePath.substring(0,filePath.lastIndexOf(File.separator));
					String username = filePath.substring(filePath.lastIndexOf(File.separator)+1,filePath.length());
//				    filePath = filePath.substring(0,filePath.indexOf(File.separator+"avatar"+File.separator))+File.separator+"WEB-INF"+filePath.substring(filePath.indexOf(File.separator+"avatar"+File.separator),filePath.length());
//					String filename = new String(Base64.encodeBase64(username.getBytes("UTF-8")));
					//改用MD5加密名称生成文件名
					String filename = MD5v2.MD5Encode(username);
//					filename = filename.replaceAll("/", "");
//					filename = filename.replaceAll("\\\\", "");
				    f = new File(folderpath+File.separator+filename+".png");
					if(!f.exists()){
						File folder = new File(folderpath);
						if(!folder.exists()){
							folder.mkdirs();
						}
						ImageUtil.ganaralPNG(folderpath, filename,username);
					}
					
					byte[] buffer = new byte[4096];
					ByteArrayOutputStream ous = new ByteArrayOutputStream();
					InputStream ios = new FileInputStream(f);
					int read = 0;
					while ((read = ios.read(buffer)) != -1) {
						ous.write(buffer, 0, read);
					}
					file = new ByteArrayInputStream(ous.toByteArray());
					fileName = filename+".png";
					contentType = "image/x-png";
					contentLength = NumberUtils.toInt(f.length()+"");

					ous.close();
					ios.close();
					
					return SUCCESS;
			}
				
				if (f.exists() 
						&& f.getCanonicalPath().startsWith(MobileManager.getInstance().getAppPath()+File.separator) 
						&& !f.getCanonicalPath().startsWith(MobileManager.getInstance().getAppPath()+File.separator+"WEB-INF"+File.separator)) {
					byte[] buffer = new byte[4096];
					ByteArrayOutputStream ous = new ByteArrayOutputStream();
					InputStream ios = new FileInputStream(f);
					int read = 0;
					while ((read = ios.read(buffer)) != -1) {
						ous.write(buffer, 0, read);
					}
					file = new ByteArrayInputStream(ous.toByteArray());
					fileName = f.getName();
					contentType = "";
					contentLength = NumberUtils.toInt(f.length()+"");

					ous.close();
					ios.close();
					
					return SUCCESS;
				}
			}
		
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
			MobileUser mu = ci.getMobileUser();
			
			if(mu == null) {
				this.message = "005";
				return "message";
			}
			
			MobilePlugin mp = null;
			MobilePluginUser mpu = null;
			
			if(moduleid==0)
				moduleid = ci.getLastRequestModuleId();
			
			if(moduleid>0) {
				MobileModule mm = MobileManager.getInstance().getMobileModule(moduleid);
				if(mm.getComponentCode().equals("-5")){
					mp = MobileManager.getInstance().getMobileMainPlugin();
					mpu = mu.getMobilePluginUser(mp);
				}else{
					mp = mm.getPlugin();
					mpu = mu.getMobilePluginUser(mp);
				}
			} else {
				mp = MobileManager.getInstance().getMobileMainPlugin();
				mpu = mu.getMobilePluginUser(mp);
			}
				
			if(mpu!=null && StringUtils.isNotEmpty(mpu.getPluginSessionKey())) {
				
				if(mobileService.verify(ci,mp)) {
				
					if(ci.getMobileUser()!=null) {
					
						Map<String,Object> param = new HashMap<String,Object>();
						param.put("sessionkey", mpu.getPluginSessionKey());
						param.put("url", fileURL);
						param.put("request", request);
						param.put("response", response);
						
						MobileFunction function = mobileService.getMobileFunction(mp, "download");
						
						if(function!=null) {
						
							Map<String,Object> data = pluginService.execute(mp, function, param);
							if(data!=null) {
								
								String error = (String) data.get("error");
								if(StringUtils.isEmpty(error)) {
			
									byte[] c = (byte[]) data.get("content");
									String ct = (String) data.get("content-type");
									String cl = (String) data.get("content-length");
									String fn = (String) data.get("file-name");
									
									image = new HashMap<String,Object>();
									
									image.put("data", c);
									image.put("contenttype", ct);
									image.put("contentlength", cl);
									image.put("filename", fn);
								} else {
									this.message = error;
									return "message";
								}
							} else {
								this.message = "124";
								return "message";
							}
						} else {
							this.message = "123";
							return "message";
						}
					}

				} else {
					this.message = "126";
					return "message";
				}
			} else {
				this.message = "125";
				return "message";
			}

		} catch(Exception e) {
			logger.error("", e);
		}
		
		if(image!=null&&image.size()>0) {
			file = new ByteArrayInputStream((byte[])image.get("data"));
			fileName = (String) image.get("filename");
			
			try {
				fileName = new String(fileName.getBytes("UTF-8"),"iso8859-1");
				//fileName = URLEncoder.encode(fileName,"UTF-8");
			} catch (UnsupportedEncodingException e) {
			}
			contentType = (String) image.get("contenttype");
			contentLength = NumberUtils.toInt((String) image.get("contentlength"));
			
			response.reset();
			
			return SUCCESS;
		}
		
		return null;
	}
	
	private boolean createDownload(String filename,byte[] content) {
		BufferedOutputStream bos = null;
		try {
			String path = ServletActionContext.getServletContext().getRealPath("/") + "download";
			File dir = new File(path);
			if(!dir.exists()) dir.mkdir();
			File file = new File(path + File.separator + new String(filename.getBytes("UTF-8"), System.getProperty("sun.jnu.encoding")));
			FileOutputStream fos = new FileOutputStream(file);
			bos = new BufferedOutputStream(fos);
			bos.write(content);
		} catch(Exception e) {
			return false;
		} finally {
			if(bos!=null) {
				try {
					bos.close();
				} catch (IOException e) {
					logger.error("", e);
				}
			}
		}
		return true;
	}
	
	/**
	 * Android消息推送
	 * @return
	 * {"msg":[{"alert":"测试\nTime:2012-12-28 14:46:18"},{"alert":"123456\nTime:2012-12-28 14:47:10"}]}
	 */
	@SuppressWarnings("unchecked")
	private String pullMessage() {
		String udid = StringUtils.defaultIfEmpty(request.getParameter("udid"), "");
		
		MobilePushDevice mpd = mobileService.getPushDeviceByUDID(udid);
		
		List<String> ofmsgJson = mobileService.getOfflineMsg(mpd.getUserid());
		
		List<Map<String, Object>> ofmsgs = new ArrayList<Map<String, Object>>();
		
		Map<String, Class<?>> classMap = new HashMap<String, Class<?>>();
		classMap.put("para", Map.class);
		
		for(String jsonStr : ofmsgJson) {
			JSONObject jsonObject = JSONObject.fromObject(jsonStr);
			Map<String, Object> msg = (Map<String, Object>)JSONObject.toBean(jsonObject, Map.class, classMap);
			ofmsgs.add(msg);
		}
		
		data.put("msg", ofmsgs);
		
		if(!ofmsgJson.isEmpty()) {
			logger.debug("Pulled "+ofmsgJson+" by user:["+mpd.getUserid()+"] on Android:["+udid+"]");
		}
		
		return "json";
	}
	
	private String getJSON() {
		try {
			
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		
			MobileUser mu = ci.getMobileUser();
			if(moduleid==0){
				moduleid =-1;
			}
			MobileModule mm = MobileManager.getInstance().getMobileModule(moduleid);
			
			if(mobileService.verify(ci,mm.getPlugin())) {
			
//				if(mobileService.getUserHasPermission(mu, mm, "read")) {
	
					MobilePlugin mp = mm.getPlugin();
					MobilePluginUser mpu = mu.getMobilePluginUser(mp);
					
					if(mpu!=null && StringUtils.isNotEmpty(mpu.getPluginSessionKey())) {
	
						String title = MobileUtil.getLabelName(mm.getLabel(), mu.getLanguageid());
						title = java.net.URLEncoder.encode(title,mp.getCharset());
						
						String detailId = StringUtils.defaultIfEmpty(request.getParameter("detailid"),"");
						
						Map<String,Object> param = new HashMap<String,Object>();
						param.put("module", mm.getComponent().getModel());
						param.put("scope", mm.getId()+"");
						param.put("detailid", detailId);
						param.put("sessionkey", mpu.getPluginSessionKey());
						param.put("clienttype", ci.getClientType());
						param.put("clientlevel", ci.getClientLevel()+"");
						param.put("clientver", ci.getMobileClient().getClientVer()+"");
						param.put("serverver", MobileManager.getInstance().getVersion()+"");
						param.put("clientos", ci.getMobileClient().getClientOS());
						param.put("clientosver", ci.getMobileClient().getClientOSVer());
						param.put("title", title);
						param.put("request", request);
						param.put("response", response);
						//param.put("ipaddress", mobileService.getClientIpAddr(request));
							
						MobileFunction function = mobileService.getComponentFunction(mm.getComponent(), "getjson");
						
						if(function!=null) {
							String func = request.getParameter("func");
							String columnid = request.getParameter("columnid");
//							String pageindex = request.getParameter("pageindex");
//							if((columnid==null||columnid.equals("-4"))){
//								param.put("scope", "-1"); //获取全部
//							}
//							if(mm.getComponent().getModel().equals("2")&&func.equals("getcolumn")){  //新闻板块
//								Object cacheObject = CacheUtil.getSystemObject("newsCache","columns"+mm.getComponent().getModel()+mm.getId());
//								if(cacheObject!=null){
//									String content = (String)cacheObject;
//									if(StringUtils.isNotEmpty(content)) {
//										response.setContentType("application/json; charset=UTF-8");
//										response.getWriter().write(content);
//										response.getWriter().flush();
//										response.getWriter().close();
//										return null;
//									}
//								}
//							}
//							if(mm.getComponent().getModel().equals("2")&&func.equals("gethome")){  //新闻
//								Object cacheObject = CacheUtil.getSystemObject("newsCache",mm.getComponent().getModel()+mm.getId()+columnid+pageindex);
//								if(cacheObject!=null){
//									String content = (String)cacheObject;
//									if(StringUtils.isNotEmpty(content)) {
//										response.setContentType("application/json; charset=UTF-8");
//										response.getWriter().write(content);
//										response.getWriter().flush();
//										response.getWriter().close();
//										return null;
//									}
//								}
//							}
//							if(mm.getComponent().getModel().equals("3")&&func.equals("gethome")){  //文档
//								Object cacheObject = CacheUtil.getUserObject(mu.getId(), mm.getComponent().getModel()+mm.getId()+columnid+pageindex);
//								if(cacheObject!=null){
//									String content = (String)cacheObject;
//									if(StringUtils.isNotEmpty(content)) {
//										response.setContentType("application/json; charset=UTF-8");
//										response.getWriter().write(content);
//										response.getWriter().flush();
//										response.getWriter().close();
//										return null;
//									}
//								}
//							}
							Map<String,Object> rd = pluginService.execute(mp, function, param);
							if(rd!=null) {
								String error = (String) rd.get("error");
								if(StringUtils.isEmpty(error)) {
									String content = (String) rd.get("content");
									if(StringUtils.isNotEmpty(content)) {
										org.json.JSONObject obj =  new org.json.JSONObject(content);
										if((mm.getComponent().getModel().equals("2")&&func.equals("gethome"))||(mm.getComponent().getModel().equals("3")&&func.equals("gethome"))){
											obj.put("columnid", columnid);
											content = obj.toString();
										}
										response.setContentType("application/json; charset=UTF-8");
										response.getWriter().write(content);
										response.getWriter().flush();
										response.getWriter().close();
//										final org.json.JSONArray ja = obj.getJSONArray("list");
//											if(ja!=null){
//												String errorno = obj.getString("errorno");
//												if(mm.getComponent().getModel().equals("2")&&func.equals("gethome")){ // 新闻
//													if(ja.length()>0){
//														CacheUtil.putSystemObject("newsCache",mm.getComponent().getModel()+mm.getId()+columnid+pageindex,content);
//													}
//													if(errorno!=null&&errorno.equals("-1")){//columnid失效，重置新闻板块cache
//														CacheUtil.putSystemObject("newsCache","columns"+mm.getComponent().getModel()+mm.getId(),"");
//													}
//												}
//												if(mm.getComponent().getModel().equals("3")&&func.equals("gethome")){  //文档
//													CacheUtil.putUserObject(mu.getId(),mm.getComponent().getModel()+mm.getId()+columnid+pageindex,content);
//												}
//												if(mm.getComponent().getModel().equals("2")&&func.equals("getcolumn")){  //新闻板块
//													CacheUtil.putSystemObject("newsCache","columns"+mm.getComponent().getModel()+mm.getId(),content);
//												}
//											}
									}
									return null;
								} else {
									this.message = error;
									return "message";
								}
							} else {
								this.message = "124";
								return "message";
							}
						} else {
							this.message = "123";
							return "message";
						}
//					} else {
//						this.message = "125";
//						return "message";
//					}
				} else {
					this.message = "125";
					return "message";
				}
			} else {
				this.message = "126";
				return "message";
			}
		
		} catch (Exception e) {
			logger.error("", e);
		}
		return null;
	}
	
	private String postJSON() {
		try {
			
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		
			MobileUser mu = ci.getMobileUser();
			
			MobileModule mm = MobileManager.getInstance().getMobileModule(moduleid);
			
			if(mobileService.verify(ci,mm.getPlugin())) {
			
//				if(mobileService.getUserHasPermission(mu, mm, "read")) {
		
					MobilePlugin mp = mm.getPlugin();
					MobilePluginUser mpu = mu.getMobilePluginUser(mp);
		
					if(mpu!=null && StringUtils.isNotEmpty(mpu.getPluginSessionKey())) {
					
						String detailId = StringUtils.defaultIfEmpty(request.getParameter("detailid"),"");
						String msgType = StringUtils.defaultIfEmpty(request.getParameter("msgType"),"");
						
						String mobileSession = ci.getSessionId();
						
						Map<String,Object> param = new HashMap<String,Object>();
						//param.put("mobilesessionkey", mobileSession);
						param.put("module", mm.getComponent().getModel());
						param.put("scope", mm.getId()+"");
						param.put("detailid", detailId);
						param.put("sessionkey", mpu.getPluginSessionKey());
						param.put("request", request);
						param.put("response", response);
						
						if("image".equals(msgType) || "voice".equals(msgType)) {
							Map<String,Object> data = MobileManager.getInstance().getUpload(uploadID);
							if(data!=null) {
								byte[] d = (byte[]) data.get("file");
								String value = Base64.encodeBase64String(d);
								param.put("fileContent", value);
								param.put("fileName", data.get("fileName"));
							}
						}
							
						MobileFunction function = mobileService.getComponentFunction(mm.getComponent(), "postjson");
						
						if(function!=null) {
						
							Map<String,Object> rd = pluginService.execute(mp, function, param);
							if(rd!=null) {
				
								String error = (String) rd.get("error");
								if(StringUtils.isEmpty(error)) {
				
									String content = (String) rd.get("content");
									
									if(StringUtils.isNotEmpty(content)) {
									
										response.setContentType("application/json; charset=UTF-8");
										
										response.getWriter().write(content);
										response.getWriter().flush();
										response.getWriter().close();
									
									}
										
									return null;
								} else {
									this.message = error;
									return "message";
								}
							} else {
								this.message = "124";
								return "message";
							}
						} else {
							this.message = "123";
							return "message";
						}
					} else {
						this.message = "125";
						return "message";
					}
//				} else {
//					this.message = "125";
//					return "message";
//				}
			} else {
				this.message = "126";
				return "message";
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		return null;
	}
	
	
	
	private String delupload() {
		try {
			boolean result = MobileManager.getInstance().delUpload(uploadID);
			data.put("result", result?"1":"0");
			return "json";
		} catch(Exception e) {
			logger.error("", e);
		}
		return null;
	}

	private String getupload() {
		try {
			Map<String,Object> data = MobileManager.getInstance().getUpload(uploadID);
			if(data!=null) {
				fileName = (String) data.get("fileName");
				contentType = (String) data.get("contentType");
				contentLength = NumberUtils.toInt((String) data.get("contentLength"));
				byte[] d = (byte[]) data.get("file");
				file = new ByteArrayInputStream(d);
				return "data";
			}
		} catch(Exception e) {
			logger.error("", e);
		}
		return null;
	}
	
	private String upload() {
		try {
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
			MobileUser user = ci.getMobileUser();
			List<MobileUserUpload> list = MobileManager.getInstance().addUpload(uploadFile, uploadFileName, uploadContentType, uploadKey, uploadFileDuration, user.getId());
			data.put("upload", list);
			return "json";
		} catch (Exception e) {
			logger.error("", e);
		}
		return null;
	}
	
	/**
	 * 检测当前设备是否是最后登陆的设备
	 * @return
	 */
	private boolean checkDevice() {
		try {
			MobileModule mm = MobileManager.getInstance().getMobileModule(moduleid);
			String singleDevice = (mm != null) ? mm.getComponent().getSingleDevice() : "0";
			
			if("1".equals(singleDevice)) {
				ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
				MobileUser user = ci.getMobileUser();
				
				String curUDID = ci.getMobileClient().getClientUDID();
				String regUDID = mobileService.getPushDeviceByUserid(user.getId()).getClientUDID();
				
				if(StringUtils.isBlank(curUDID) || StringUtils.isBlank(regUDID)) {
					return true;
				}
				
				if(!curUDID.equals(regUDID)) {
					return false;
				}
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		return true;
	}
	
	private String syncData() {
		try {
			
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		
			MobileUser mu = ci.getMobileUser();
			MobilePlugin mainPlugin = MobileManager.getInstance().getMobileMainPlugin();
			
			if(mobileService.verify(ci,mainPlugin)) {
				MobilePluginUser mpu = mu.getMobilePluginUser(mainPlugin);
				
				if(mpu!=null && StringUtils.isNotEmpty(mpu.getPluginSessionKey())) {
					
					Map<String,Object> param = new HashMap<String,Object>();
					param.put("sessionkey", mpu.getPluginSessionKey());
					param.put("clienttype", ci.getClientType());
					param.put("clientlevel", ci.getClientLevel()+"");
					param.put("clientver", ci.getMobileClient().getClientVer()+"");
					param.put("serverver", MobileManager.getInstance().getVersion()+"");
					param.put("request", request);
					param.put("response", response);
						
					MobileFunction function = mobileService.getMobileFunction(mainPlugin, "syncData");
					
					if(function!=null) {
						String type = request.getParameter("type");
//						if(type!=null&&type.equals("HrmResource")){
//							Object cacheObject = CacheUtil.getSystemObject("HrmResource","HrmResource");
//							if(cacheObject!=null){
//								String content = (String)cacheObject;
//								if(StringUtils.isNotEmpty(content)) {
//									response.setContentType("application/json; charset=UTF-8");
//									response.getWriter().write(content);
//									response.getWriter().flush();
//									response.getWriter().close();
//									return null;
//								}
//							}
//						}
						Map<String,Object> rd = pluginService.execute(mainPlugin, function, param);
						if(rd!=null) {
							String error = (String) rd.get("error");
							if(StringUtils.isEmpty(error)) {
								String content = (String) rd.get("content");
								if(StringUtils.isNotEmpty(content)) {
									response.setContentType("application/json; charset=UTF-8");
									response.getWriter().write(content);
									response.getWriter().flush();
									response.getWriter().close();
//									if(type!=null&&type.equals("HrmResource")){
//										CacheUtil.putSystemObject("HrmResource", "HrmResource",content);
//									}
								}
									
								return null;
							} else {
								this.message = error;
								return "message";
							}
						} else {
							this.message = "124";
							return "message";
						}
					} else {
						this.message = "123";
						return "message";
					}
				} else {
					this.message = "125";
					return "message";
				}
			
			} else {
				this.message = "126";
				return "message";
			}
		
		} catch (Exception e) {
			logger.error("", e);
		}
		return null;
	}
	
	private String checkIn() {
		try {
			String type = request.getParameter("type");//"checkin":签到,"checkout":签退
			int checkType = "checkin".equals(type) ? 1 : ("checkout".equals(type) ? 2 : 0);
			
			if(!"1".equals(MobileManager.getInstance().getSetting("mobile.attendance.enable"))&&!type.equals("getStatus")) {
				if(checkType==0) {
					data.put("isEnableCheckin", "0");
					return "json";
				} else {
					return error("134");
				}
			}
			
			MobilePlugin mainPlugin = MobileManager.getInstance().getMobileMainPlugin();
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
			
			if(!mobileService.verify(ci, mainPlugin)) return error("126");
			
			MobileUser mu = ci.getMobileUser();
			MobilePluginUser mpu = mu.getMobilePluginUser(mainPlugin);
			String sessionKey = mpu.getPluginSessionKey();

			if(mpu==null || StringUtils.isBlank(sessionKey)) return error("125");
			
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("sessionkey", sessionKey);
			param.put("ipaddr", mobileService.getClientIpAddr(request));
			param.put("request", request);
			
			if(checkType==1 || checkType==2) {
				String[] latlng = StringUtils.trimToEmpty(request.getParameter("latlng")).split(",");
				if(latlng == null || latlng.length < 2) return error("135");
				
				double lat = NumberUtils.toDouble(latlng[0]);
				double lng = NumberUtils.toDouble(latlng[1]);
				
				boolean inCompany = attendanceService.isInCompany(mu, lng, lat);
				param.put("inCompany", inCompany ? "1" : "0");
			}
				
			MobileFunction function = mobileService.getMobileFunction(mainPlugin, "checkin");
			if(function == null) return error("123");
			
			Map<String,Object> rd = pluginService.execute(mainPlugin, function, param);
			if(rd == null) return error("124");
			
			String error = (String) rd.get("error");
			if(StringUtils.isNotBlank(error)) return error(error);
			
			String content = StringUtils.trim((String)rd.get("content"));
			if(StringUtils.isNotEmpty(content)) {
				response.setContentType("application/json; charset=UTF-8");
				response.getWriter().write(content);
				response.getWriter().flush();
				response.getWriter().close();
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		
		return null;
	}
	
	private String getWorkCenter() {
		try {
			int pageIndex = NumberUtils.toInt(request.getParameter("pageindex"));
			int pageSize = NumberUtils.toInt(request.getParameter("pagesize"));
			String categorystr = request.getParameter("categoryid");
			String[] categoryids = StringUtils.split(categorystr, ',');
			
			List<String> categoryidList = new ArrayList<String>();
			if(categoryids != null) categoryidList = Arrays.asList(categoryids);
			
			MobilePlugin mainPlugin = MobileManager.getInstance().getMobileMainPlugin();
			ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
			
			if(!mobileService.verify(ci, mainPlugin)) return error("126");
			
			MobileUser mu = ci.getMobileUser();
			MobilePluginUser mpu = mu.getMobilePluginUser(mainPlugin);
			String sessionKey = mpu.getPluginSessionKey();

			if(mpu==null || StringUtils.isBlank(sessionKey)) return error("125");
			
			Map<String, List<String>> modulesMap = new HashMap<String, List<String>>();
			for (MobileModule mm : MobileManager.getInstance().getMobileModule()) {
				if(!mainPlugin.getId().equals(mm.getPluginCode())) continue;
				if(!"1".equals(mm.getVisible())) continue;
				if (!mobileService.getUserHasPermission(mu, mm, "read")) continue;
				MobileComponent mc = mm.getComponent();
				if(mc == null) continue;
				WorkCenterCategory wcc = mc.getWorkCenterCategory();
				if(wcc == null) continue;
				if(categoryidList != null && categoryidList.size() != 0 && !categoryidList.contains(""+wcc.getId())) continue;
				
				List<String> scopeList = modulesMap.get(mc.getId());
				if(scopeList == null) scopeList = new ArrayList<String>();
				scopeList.add(""+mm.getId());
				modulesMap.put(mc.getId(), scopeList);
			}
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.putAll(modulesMap);
			
			pageIndex = pageIndex > 0 ? pageIndex : 1;
			int defaultPageSize = NumberUtils.toInt(MobileManager.getInstance().getSetting("mobile.client.pagesize"));
			pageSize = pageSize > 0 ? pageSize : (defaultPageSize > 0 ? defaultPageSize : 10);
			
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("pageindex", pageIndex+"");
			param.put("pagesize", pageSize+"");
			param.put("sessionkey", sessionKey);
			param.put("keyword", keyword);
			param.put("modules", jsonObj.toString());
			param.put("request", request);
				
			MobileFunction function = mobileService.getMobileFunction(mainPlugin, "workcenter");
			if(function == null) return error("123");
			
			Map<String,Object> rd = pluginService.execute(mainPlugin, function, param);
			if(rd==null) return error("124");
			
			String error = (String) rd.get("error");
			if(StringUtils.isNotBlank(error)) return error(error);
			
			String content = StringUtils.trim((String)rd.get("content"));
			if(StringUtils.isNotEmpty(content)) {
				response.setContentType("application/json; charset=UTF-8");
				response.getWriter().write(content);
				response.getWriter().flush();
				response.getWriter().close();
//				JSONObject obj = JSONObject.fromObject(content);
//				final JSONArray ja = (JSONArray)obj.get("list");
//				if(ja!=null){
//					for (int i = 0; i < ja.size(); i++) {
//						JSONObject jo = (JSONObject) ja.get(i);
//						String module = (String)jo.get("module");
//						if("1".equals(module)){
//							String id = (String)jo.get("id");
//							moduleid = Integer.parseInt(module);
//							request.setAttribute("detailid", id);
//							getPage();
//						}
//					}
//				}
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		
		return null;
	}
	
	private String modelPushSetting() {
		int moduleid = NumberUtils.toInt(request.getParameter("moduleid"));
		int ispush = NumberUtils.toInt(request.getParameter("ispush"));
		ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		MobileUser mu = ci.getMobileUser();
		mobileService.setPush(mu, moduleid, ispush);
		data.put("result",true);
		return "json";
	}
	
	private String groupManager() {
		String operation = request.getParameter("operation");
		ClientInfo ci = MobileManager.getInstance().getClientInfo(request);
		String groupid = request.getParameter("groupid");
		MobileUser mu = ci.getMobileUser();
		if(operation.equals("addgroup")){
			
		}else if(operation.equals("delgroup")){
			
		}else if(operation.equals("addgroupbook")){
			if(mobileService.addGroupBook(mu, groupid)){
				data.put("result",true);
			}else{
				data.put("result",false);
			}
		}else  if(operation.equals("delgroupbook")){
			if(mobileService.delGroupBook(mu, groupid)){
				data.put("result",true);
			}else{
				data.put("result",false);
			}
		}else if(operation.equals("getstatus")){
			if(mobileService.getGroupStatus(mu, groupid)){
				data.put("result",true);
			}else{
				data.put("result",false);
			}
		}else if(operation.equals("getgrouplist")){
			List<String>  grouplist = mobileService.getGroupList(mu);
			data.put("list",grouplist);
		}
		
		
		return "json";
	}
	
	private String error(String errcode) {
		data.put("errorno", errcode);
		data.put("error", getText(errcode));
		return "json";
	}
	
	public void setServletResponse(HttpServletResponse res) {
		this.response = res;
	}

	public void setServletRequest(HttpServletRequest req) {
		this.request = req;
	}

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

	public int getModule() {
		return module;
	}

	public void setModule(int module) {
		this.module = module;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	public int getScope() {
		return scope;
	}


	public void setScope(int scope) {
		this.scope = scope;
	}


	public InputStream getFile() {
		return file;
	}


	public void setFile(InputStream file) {
		this.file = file;
	}


	public String getContentType() {
		return contentType;
	}


	public void setContentType(String contentType) {
		this.contentType = contentType;
	}


	public String getFileName() {
		return fileName;
	}


	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public String getKeyword() {
		return keyword;
	}


	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}


	public int getModuleid() {
		return moduleid;
	}


	public void setModuleid(int moduleid) {
		this.moduleid = moduleid;
	}

	public int getContentLength() {
		return contentLength;
	}


	public void setContentLength(int contentLength) {
		this.contentLength = contentLength;
	}


	public File[] getUploadFile() {
		return uploadFile;
	}


	public void setUploadFile(File[] uploadFile) {
		this.uploadFile = uploadFile;
	}


	public String[] getUploadFileName() {
		return uploadFileName;
	}


	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}


	public String[] getUploadContentType() {
		return uploadContentType;
	}


	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}


	public String[] getUploadKey() {
		return uploadKey;
	}


	public void setUploadKey(String[] uploadKey) {
		this.uploadKey = uploadKey;
	}


	public String getUploadID() {
		return uploadID;
	}


	public void setUploadID(String uploadID) {
		this.uploadID = uploadID;
	}


	public String[] getUploadFileDuration() {
		return uploadFileDuration;
	}


	public void setUploadFileDuration(String[] uploadFileDuration) {
		this.uploadFileDuration = uploadFileDuration;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPortraitUri() {
		return portraitUri;
	}

	public void setPortraitUri(String portraitUri) {
		this.portraitUri = portraitUri;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
