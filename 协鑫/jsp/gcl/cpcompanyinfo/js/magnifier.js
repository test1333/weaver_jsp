function getElement(id){   
     return document.getElementById(id);   
};
//Amplifier.init('source','dest',jQuery("select#speed").val());//���÷Ŵ�
var Amplifier = {
	source: null,   
	dest: null,     
	scale: 1,    
	init: function(source, dest,scale){   
		this.source = getElement(source);  
		this.dest = getElement(dest);   
		//�Ŵ���
		this.scale = scale||2;  		
		//������ʾ��ͼƬ��λ��
		var borderBox = document.createElement("div");
		//�󶨴�ͼƬ��id
		borderBox.setAttribute("id","chooseArea");   
		//���������Χ���϶���
		borderBox.style.height = parseInt(this.source.style.height)/scale+"px";   
		borderBox.style.width = parseInt(this.source.style.width)/scale+"px";   
		//���������Χ���϶�����ʽ
		borderBox.style.border = "solid red 1px";   
		borderBox.style.position = "relative";   
		borderBox.style.top =(-parseInt(this.source.style.height) - 2)+"px";   
		borderBox.style.left =0+"px"; 
		//׷�������Χ���϶��㵽����
		this.source.appendChild(borderBox);
		//���������ʾimg
		var destImg = document.createElement('img');   
		destImg.style.position = "relative";  
		//��ͼƬ��src
		destImg.src = this.source.getElementsByTagName('img')[0].src;   
		//��ͼƬ����
		this.dest.appendChild(destImg);
	//	console.log("Hello World");
		destImg.height = parseInt(this.source.style.height)*scale;   
		destImg.width = parseInt(this.source.style.width)*scale;
		this.source.onmousemove = function(e){
			
						//	console.log("�������������---------------------------------------------------------");
								if(Amplifier.getEvent(e).offsetX>parseInt(borderBox.style.width)/2 && (parseInt(this.style.width)- Amplifier.getEvent(e).offsetX)>parseInt(borderBox.style.width)/2){   
									borderBox.style.left = Amplifier.getEvent(e).offsetX - parseInt(borderBox.style.width)/2+"px"; 
								}   
								else if(Amplifier.getEvent(e).offsetX<parseInt(borderBox.style.width)/2){   
									borderBox.style.left = 0+"px"; 
								}   
								else{   
									borderBox.style.left = parseInt(this.style.width) - parseInt(borderBox.style.width)+"px"; 
								} 
								
								if(Amplifier.getEvent(e).offsetY>parseInt(borderBox.style.height)/2 - 1 && (parseInt(this.style.height)- Amplifier.getEvent(e).offsetY)>parseInt(borderBox.style.height)/2){   
									borderBox.style.top =( -parseInt(this.style.height) + Amplifier.getEvent(e).offsetY - parseInt(borderBox.style.height)/2 - 2)+"px"; 
								}   
								else if(Amplifier.getEvent(e).offsetY<parseInt(borderBox.style.height)/2){   
									borderBox.style.top = -parseInt(this.style.height) - 2+"px"; 
								}   
								else{   
									borderBox.style.top = -parseInt(borderBox.style.height) - 2+"px"; 
								}   
								
								destImg.style.left = -Math.abs(parseInt(borderBox.style.left)*scale) + 0.5+"px"; 
								destImg.style.top = -( parseInt(this.style.height) - Math.abs(parseInt(borderBox.style.top)) )*scale - 3.5+"px"; 
		};   
	},   
	getEvent: function(e){   
		if (typeof e == 'undefined'){   
			e = window.event||event;   
		}   
		/*alert(ee);
			//alert(e.x?e.x : e.layerX);   
		if(typeof e.x == 'undefined'){   
			ee.offsetX = e.layerX;   
		}   
		if(typeof e.y == 'undefined'){   
 			ee.offsetX = e.layerY;   
		}   */
		return e;   
	}   
};