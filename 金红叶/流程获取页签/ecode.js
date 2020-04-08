let enable = true;

let defaultTab = ''; // 'pic'为流程图key 在跳转地址后接上对应的query参数 获得参数赋值给defaultTab
let isSetDefaultTab = false;

ecodeSDK.overwritePropsFnQueueMapSet('WeaReqTop',{
  fn:(newProps,name)=>{
    if(!enable) return ;
    let path1 = '/spa/workflow/static4form/index.html#/main/workflow/req?aaa=xxx'
    let path2 = '/spa/workflow/static4form/index.html#/main/workflow/req?aaa=yyy'
    let path3 = '/spa/workflow/static4form/index.html#/main/workflow/req?aaa=zzz'

    let pic = ecodeSDK.checkLPath(path1)
    let status = ecodeSDK.checkLPath(path2)
    let resource = ecodeSDK.checkLPath(path3)
    if(!pic && !status && !resource) return ;
    // console.log(newProps.selectedKey)

    if (pic) {
      defaultTab = 'pic'
    } else if (status) {
      defaultTab = 'status'
    } else if (resource) {
      defaultTab = 'resource'
    }

    if(!isSetDefaultTab&&newProps.selectedKey===defaultTab) {
      isSetDefaultTab = true;
    }
    if(newProps.selectedKey!==defaultTab&&!isSetDefaultTab) {
      newProps.selectedKey = defaultTab;
      newProps.onChange(defaultTab);
    }

    setTimeout(()=> {
      if(document.getElementsByClassName('wea-new-top-req')[0]){
        document.getElementsByClassName('wea-new-top-req')[0].style.display = 'none'
      }
      if(document.getElementsByClassName('wea-new-top-req-wapper')[0]){
        document.getElementsByClassName('wea-new-top-req-wapper')[0].style.paddingTop = '0'
      }
    }, 50)

    // console.log('newProps:', newProps)
     
    return newProps;
  },
  order: 1, //排序字段，如果存在同一个页面复写了同一个组件，控制顺序时使用
  desc:'在这里写此复写的作用，在调试的时候方便查找'
});


