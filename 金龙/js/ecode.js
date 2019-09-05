ecodeSDK.overwritePropsFnQueueMapSet('WeaReqTop', {
  fn: (newProps, name) => {
    const { pathname, hash } = window.location;     
    //����Ƭ
     if (pathname === '/spa/prj/index.html' && hash.indexOf('#/main/prj/taskCard') >= 0 ) {
       let nowtab = newProps.selectedKey   
       if(nowtab !='1'){
         return
       }
         if (newProps.buttons.length > 0) {
           let delid='-1'
           let i=0;
          for(let v of newProps.buttons) {
            if(v.props.children =="�༭"){
               delid=delid+','+i
            }else if(v.props.children =="ɾ��"){
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
              if(v.content =="�༭"){
                  delid=delid+','+i
                }else if(v.content =="ɾ��"){
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
    //��Ŀ��Ƭ
    if (pathname === '/spa/prj/index.html' && hash.indexOf('#/main/prj/projectCard') >= 0 ) {
        let nowtab = newProps.selectedKey   
         if (nowtab =='1' && newProps.buttons.length > 0) {
           let delid='-1'
           let i=0;
          for(let v of newProps.buttons) {
            if(v.props.children =="�༭"){
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
              if(v.content =="�༭"){
                  delid=delid+','+i
                }else if(v.content =="����"){
                  delid=delid+','+i
                }else if(v.content =="����"){
                  delid=delid+','+i
                }else if(v.content =="���"){
                  delid=delid+','+i
                }else if(v.content =="����"){
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
            if(v.props.children =="�������"){
               delid=delid+','+i
            }else if(v.props.children =="����ɾ��"){
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
              if(v.content =="�������"){
                  delid=delid+','+i
                }else if(v.content =="����ɾ��"){
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
    //��Ŀ����
     if (pathname === '/wui/index.html' && hash.indexOf('#/main/prj/projectboard') >= 0 ) {
          let nowtab = newProps.selectedKey   
       if(nowtab !='1'){
         return
       }
         if (newProps.buttons.length > 0) {
           let delid='-1'
           let i=0;
          for(let v of newProps.buttons) {
            if(v.props.children =="�༭"){
               delid=delid+','+i
            }else if(v.props.children =="ɾ��"){
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
              if(v.content =="�༭"){
                  delid=delid+','+i
                }else if(v.content =="ɾ��"){
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
    //����Ƭ
    if (pathname === '/spa/prj/index.html' && hash.indexOf('#/main/prj/taskCard') >= 0 ) {
      let nowtab = newProps.children.props.selectedKey;
       if(nowtab !='1'){
         return
       }
       if(newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="�༭"){
                  delid=delid+','+i
                }else if(v.content =="ɾ��"){
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
    //��Ŀ��Ƭ
    if (pathname === '/spa/prj/index.html' && hash.indexOf('#/main/prj/projectCard') >= 0 ) {
      let nowtab = newProps.children.props.selectedKey;
       
       if(nowtab=="1" && newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="�༭"){
                  delid=delid+','+i
                }else if(v.content =="����"){
                  delid=delid+','+i
                }else if(v.content =="����"){
                  delid=delid+','+i
                }else if(v.content =="���"){
                  delid=delid+','+i
                }else if(v.content =="����"){
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
              if(v.content =="�������"){
                  delid=delid+','+i
                }else if(v.content =="����ɾ��"){
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
    //����
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
              if(v.content =="�༭"){
                  delid=delid+','+i
                }else if(v.content =="ɾ��"){
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
              if(v.content =="�༭"){
                  delid=delid+','+i
                }else if(v.content =="����"){
                  delid=delid+','+i
                }else if(v.content =="����"){
                  delid=delid+','+i
                }else if(v.content =="���"){
                  delid=delid+','+i
                }else if(v.content =="����"){
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
              if(v.content =="�������"){
                  delid=delid+','+i
                }else if(v.content =="����ɾ��"){
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
              if(v.content =="�½�����Ŀ"){
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
      
      //��Ŀ���
      if(ecodeSDK.checkLPath('/wui/index.html#/main/prj/monitorResult')) {
         
         if(newProps.datas.length>0){
          let delid='-1'
          let i=0;
          for(let v of newProps.datas){
              if(v.content =="����ɾ��"){
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
//��Ŀ����
ecodeSDK.overwritePropsFnQueueMapSet('WeaTop',{
    fn:(newProps)=>{
        if(ecodeSDK.checkLPath('/wui/index.html#/main/prj/projectboard')) {
           let nowtab 
           try{
               nowtab = newProps.children.props.children[0].props.selectedKey;
          
           }catch(e){
             return;
           }
         
          //��Ŀ��Ϣ
            if (nowtab=="1" && newProps.buttons.length > 0) {
              let delid='-1'
              let i=0;
              for(let v of newProps.buttons) {
                if(v.props.children =="�༭"){
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
        //�����б�
          if (nowtab=="2" && newProps.buttons.length > 0) {
              let delid='-1'
              let i=0;
              for(let v of newProps.buttons) {
                if(v.props.children =="�������"){
                  delid=delid+','+i
                }else if(v.props.children =="����ɾ��"){
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
      //�½�����Ŀ
      if (nowtab=="3" && newProps.buttons.length > 0) {
              let delid='-1'
              let i=0;
              for(let v of newProps.buttons) {
                if(v.props.children =="�½�����Ŀ"){
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
       //��Ŀ���
      if(ecodeSDK.checkLPath('/wui/index.html#/main/prj/monitorResult')) {
         if (newProps.buttons.length > 0) {
              let delid='-1'
              let i=0;
              for(let v of newProps.buttons) {
                if(v.props.children =="����ɾ��"){
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
              if(v.content =="����ɾ��"){
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
