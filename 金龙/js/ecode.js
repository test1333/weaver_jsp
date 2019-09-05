ecodeSDK.overwritePropsFnQueueMapSet('WeaReqTop', {
  fn: (newProps, name) => {
    const { pathname, hash } = window.location;     
    //任务卡片
     if (pathname === '/spa/prj/index.html' && hash.indexOf('#/main/prj/taskCard') >= 0 ) {
       let nowtab = newProps.selectedKey   
       if(nowtab !='1'){
         return
       }
         if (newProps.buttons.length > 0) {
           let delid='-1'
           let i=0;
          for(let v of newProps.buttons) {
            if(v.props.children =="编辑"){
               delid=delid+','+i
            }else if(v.props.children =="删除"){
               delid=delid+','+i
            }
            i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){ 
             if(v != -1){ 
                newProps.buttons.splice(v, 1)
             }
           }
         }
         if (newProps.dropMenuDatas.length > 0) {
           let delid='-1'
           let i=0;
           for(let v of newProps.dropMenuDatas){
              if(v.content =="编辑"){
                  delid=delid+','+i
                }else if(v.content =="删除"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.dropMenuDatas.splice(v, 1)
             }
           }
          
         }
    }
    //项目卡片
    if (pathname === '/spa/prj/index.html' && hash.indexOf('#/main/prj/projectCard') >= 0 ) {
        let nowtab = newProps.selectedKey   
         if (nowtab =='1' && newProps.buttons.length > 0) {
           let delid='-1'
           let i=0;
          for(let v of newProps.buttons) {
            if(v.props.children =="编辑"){
               delid=delid+','+i
            }
            i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.buttons.splice(v, 1)
             }
           }
         }
         if (nowtab =='1' && newProps.dropMenuDatas.length > 0) {
           let delid='-1'
           let i=0;
           for(let v of newProps.dropMenuDatas){
              if(v.content =="编辑"){
                  delid=delid+','+i
                }else if(v.content =="正常"){
                  delid=delid+','+i
                }else if(v.content =="延期"){
                  delid=delid+','+i
                }else if(v.content =="完成"){
                  delid=delid+','+i
                }else if(v.content =="冻结"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.dropMenuDatas.splice(v, 1)
             }
           }
          
         }
          if (nowtab =='2' && newProps.buttons.length > 0) {
           let delid='-1'
           let i=0;
          
          for(let v of newProps.buttons) {
            if(v.props.children =="添加任务"){
               delid=delid+','+i
            }else if(v.props.children =="批量删除"){
               delid=delid+','+i
            }
            i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.buttons.splice(v, 1)
             }
           }
         
         }
         if (nowtab =='2' && newProps.dropMenuDatas.length > 0) {
           let delid='-1'
           let i=0;
           for(let v of newProps.dropMenuDatas){
              if(v.content =="添加任务"){
                  delid=delid+','+i
                }else if(v.content =="批量删除"){
               delid=delid+','+i
            }
                i=i+1
          }
          //newProps.dropMenuDatas.splice(4,1)
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
              newProps.dropMenuDatas.splice(v, 1)
             }
           }
         }
    }
    //项目看板
     if (pathname === '/wui/index.html' && hash.indexOf('#/main/prj/projectboard') >= 0 ) {
          let nowtab = newProps.selectedKey   
       if(nowtab !='1'){
         return
       }
         if (newProps.buttons.length > 0) {
           let delid='-1'
           let i=0;
          for(let v of newProps.buttons) {
            if(v.props.children =="编辑"){
               delid=delid+','+i
            }else if(v.props.children =="删除"){
               delid=delid+','+i
            }
            i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){ 
             if(v != -1){ 
                newProps.buttons.splice(v, 1)
             }
           }
         }
         if (newProps.dropMenuDatas.length > 0) {
           let delid='-1'
           let i=0;
           for(let v of newProps.dropMenuDatas){
              if(v.content =="编辑"){
                  delid=delid+','+i
                }else if(v.content =="删除"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.dropMenuDatas.splice(v, 1)
             }
           }
          
         }
     }   
  }
});

ecodeSDK.overwritePropsFnQueueMapSet('WeaRightMenu', {
  fn: (newProps, name) => {
    const { pathname, hash } = window.location;       
    //任务卡片
    if (pathname === '/spa/prj/index.html' && hash.indexOf('#/main/prj/taskCard') >= 0 ) {
      let nowtab = newProps.children.props.selectedKey;
       if(nowtab !='1'){
         return
       }
       if(newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="编辑"){
                  delid=delid+','+i
                }else if(v.content =="删除"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.datas.splice(v, 1)
             }
           }
      }
    }
    //项目卡片
    if (pathname === '/spa/prj/index.html' && hash.indexOf('#/main/prj/projectCard') >= 0 ) {
      let nowtab = newProps.children.props.selectedKey;
       
       if(nowtab=="1" && newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="编辑"){
                  delid=delid+','+i
                }else if(v.content =="正常"){
                  delid=delid+','+i
                }else if(v.content =="延期"){
                  delid=delid+','+i
                }else if(v.content =="完成"){
                  delid=delid+','+i
                }else if(v.content =="冻结"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.datas.splice(v, 1)
             }
           }
      }
      if(nowtab=="2" && newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="添加任务"){
                  delid=delid+','+i
                }else if(v.content =="批量删除"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.datas.splice(v, 1)
             }
           }
      }
    }
    //看板
     if(ecodeSDK.checkLPath('/wui/index.html#/main/prj/projectboard')) {
         let nowtab 
       try{
          nowtab = newProps.children.props.selectedKey
        }catch(e){
              return;
        }
        if(nowtab !='1'){
         return
       }
       if(newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="编辑"){
                  delid=delid+','+i
                }else if(v.content =="删除"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.datas.splice(v, 1)
             }
           }
      }
     }
     if(ecodeSDK.checkLPath('/wui/index.html#/main/prj/projectboard')) {
        
       let nowtab 
       try{
          nowtab = newProps.children[0].props.children.props.children[0].props.selectedKey;
      }catch(e){
             return;
      }
      if(nowtab=="1" && newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="编辑"){
                  delid=delid+','+i
                }else if(v.content =="正常"){
                  delid=delid+','+i
                }else if(v.content =="延期"){
                  delid=delid+','+i
                }else if(v.content =="完成"){
                  delid=delid+','+i
                }else if(v.content =="冻结"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.datas.splice(v, 1)
             }
           }
      }
      if(nowtab=="2" && newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="添加任务"){
                  delid=delid+','+i
                }else if(v.content =="批量删除"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.datas.splice(v, 1)
             }
           }
      }
      if(nowtab=="3" && newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="新建子项目"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.datas.splice(v, 1)
             }
           }
      }
     }
      
      //项目监控
      if(ecodeSDK.checkLPath('/wui/index.html#/main/prj/monitorResult')) {
         
         if(newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="批量删除"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.datas.splice(v, 1)
             }
           }
      }
      }
  }
});
//项目看板
ecodeSDK.overwritePropsFnQueueMapSet('WeaTop',{
    fn:(newProps)=>{
        if(ecodeSDK.checkLPath('/wui/index.html#/main/prj/projectboard')) {
           let nowtab 
           try{
               nowtab = newProps.children.props.children[0].props.selectedKey;
          
           }catch(e){
             return;
           }
         
          //项目信息
            if (nowtab=="1" && newProps.buttons.length > 0) {
              let delid='-1'
              let i=0;
              for(let v of newProps.buttons) {
                if(v.props.children =="编辑"){
                  delid=delid+','+i
                }
                i=i+1
              }
              let arrids = delid.split(",").reverse();
              for(let v of arrids){
                if(v != -1){
                    newProps.buttons.splice(v, 1)
                }
              }
         }
        //任务列表
          if (nowtab=="2" && newProps.buttons.length > 0) {
              let delid='-1'
              let i=0;
              for(let v of newProps.buttons) {
                if(v.props.children =="添加任务"){
                  delid=delid+','+i
                }else if(v.props.children =="批量删除"){
                  delid=delid+','+i
                }
                i=i+1
              }
              let arrids = delid.split(",").reverse();
              for(let v of arrids){
                if(v != -1){
                    newProps.buttons.splice(v, 1)
                }
              }
         }
      //新建子项目
      if (nowtab=="3" && newProps.buttons.length > 0) {
              let delid='-1'
              let i=0;
              for(let v of newProps.buttons) {
                if(v.props.children =="新建子项目"){
                  delid=delid+','+i
                }
                i=i+1
              }
              let arrids = delid.split(",").reverse();
              for(let v of arrids){
                if(v != -1){
                    newProps.buttons.splice(v, 1)
                }
              }
         }
      }
       //项目监控
      if(ecodeSDK.checkLPath('/wui/index.html#/main/prj/monitorResult')) {
         if (newProps.buttons.length > 0) {
              let delid='-1'
              let i=0;
              for(let v of newProps.buttons) {
                if(v.props.children =="批量删除"){
                  delid=delid+','+i
                }
                i=i+1
              }
              let arrids = delid.split(",").reverse();
              for(let v of arrids){
                if(v != -1){
                    newProps.buttons.splice(v, 1)
                }
              }
         }
        if (newProps.dropMenuDatas.length > 0) {
           let delid='-1'
           let i=0;
           for(let v of newProps.dropMenuDatas){
              if(v.content =="批量删除"){
                  delid=delid+','+i
                }
                i=i+1
          }
          let arrids = delid.split(",").reverse();
           for(let v of arrids){
             if(v != -1){
                newProps.dropMenuDatas.splice(v, 1)
             }
           }
          
         }
      }
            
    }
});
