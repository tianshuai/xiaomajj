/**
 * 
 */
//q_id=题目id,视频链接,用户id,录音状态符,录音计时器,录音时间,录制长度,播放长度,音频播放计时器,音频播放器状态,当前播放的链接
var q_id,q_video_url,userid,rec_state,timer,tsec,record_length,record_play_length,audioPlayTimer,audioPlayState,currentUrl;
var api_url= 'http://xiaomajijing.xiaoma.com';
var api_url= 'http://192.168.1.209:4000';
rec_state=0;
audioPlayState=0;
//写cookies
function setCookie(name,value)
{
var Days = 30;
var exp = new Date(); 
exp.setTime(exp.getTime() + Days*24*60*60*1000);
document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
//读取cookies
function getCookie(name)
{
var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
if(arr=document.cookie.match(reg)) return unescape(arr[2]);
else return null;
}

function saveCookie(id,email,username,token) {
	setCookie("user_id", id);
	setCookie("user_email", email);
	setCookie("user_name", username);
	setCookie("token", token);
}
/**
 * 获取下一个月
 *
 * @date 格式为yyyy.mm的日期，如：2014.01
 */        
function getNextMonth(date) {
    var arr = date.split('.');
    var year = arr[0]; //获取当前日期的年份
    var month = arr[1]; //获取当前日期的月份
    
    
    var year2 = year;
    var month2 = parseInt(month) + 1;
    if (month2 == 13) {
        year2 = parseInt(year2) + 1;
        month2 = 1;
    }
    
    if (month2 < 10) {
        month2 = '0' + month2;
    }

    var t2 = year2 + '.' + month2;
    return t2;
}

//--倒计时START--
//--录音倒计时--
function recordtime(){
	timer=setTimeout('recordtime()', 1000);
	$("#timer").html("0:"+tsec);
	if(tsec<=0){
		clearTimeout(timer);
		FWRecorder.stopRecording('audio');
		rec_state=2;
		record_play_length= record_length-1;
		record_length = record_play_length;
		$("#rerecord").css("display","block");
		$("#start_rec").css('background-image','url(images/xm_video_grayquan.png)');
		$("#start_rec img").attr('src','images/xm_video_but3.png');
	}
	record_length++;
	tsec--;
}
//--录音播放倒计时--
function playtime(){
	timer=setTimeout('playtime()', 1000);
	$("#timer").html("0:"+record_play_length);
	if(record_play_length<=0){
		clearTimeout(timer);
		rec_state=2;
		$("#start_rec").css('background-image','url(images/xm_video_grayquan.png)');
		$("#start_rec img").attr('src','images/xm_video_but3.png');
		FWRecorder.pausePlayBack();
		$("#start_rec").css('cursor','pointer');
		$("#timer").html("0:"+record_length);
	}
	record_play_length--;
}
//---倒计时END---

//声音播放倒计时，结束后切换静态图标
function audioPlayTime(rlength){
	rlength--;
	audioPlayTimer = setTimeout('audioPlayTime('+rlength+')', 1000);
	if(rlength<=0){
		clearTimeout(audioPlayTimer);
		$(".record_pic a img").attr("src","images/recordpic1_jingtai.jpg");
		audioPlayState=0;
	}
	
}


 
function buildAnswers(data){
	var answerArry = data.question_bank.answers;
	var audiodiv;
	for(var i in answerArry){
		audiodiv = $("<div class='record_record'></div>");
		audiodiv.append($("<div class='record_pic'><a audiourl='"+answerArry[i].audio_url.audio_url.url+"' rlength='"+answerArry[i].audio_length+"'><img src='images/recordpic1_jingtai.jpg'></a><span class='answer_hide'></span></div>"));
		audiodiv.append($("<div class='answer_content'><ul><li>"+answerArry[i].tip+"</li></ul></div>"));
		$(".answer").append(audiodiv);
	}
	
}
function getRecordsTimer(){
	setTimeout("getRecordsTimer()", 5000);
	if(typeof(q_id) != "undefined"){
		$.ajax({ 
	          type : "get", 
	          url : api_url+"/api/v1/records?question_bank_id="+q_id, 
	          async : false, 
	          success : function(result){
	        	  getRecordsById(result);
	          } 
	     }); 
	}
}
function getRecordsById(data){
	if(data.records.length>0){
		var recordsArry = data.records;
		$(".record .record_record").remove();
		var recorddiv;
		for(var i in recordsArry){
			recorddiv = $("<div class='record_record'></div>");
			recorddiv.append($("<div class='record_pic'><a audiourl='"+recordsArry[i].audio_url.audio_url.url+"' rlength='"+recordsArry[i].audio_length+"'><img src='images/recordpic1_jingtai.jpg'></a></div>"));
			$(".record").append(recorddiv);
		}
	}
}
function buildRecords(data){
	var recordsArry = data.question_bank.records;
	if(recordsArry.length>0){
		var recorddiv;
		
		for(var i in recordsArry){
			recorddiv = $("<div class='record_record'></div>");
			recorddiv.append($("<div class='record_pic'><a audiourl='"+recordsArry[i].audio_url.audio_url.url+"' rlength='"+recordsArry[i].audio_length+"'><img src='images/recordpic1_jingtai.jpg'></a></div>"));
			$(".record").append(recorddiv);
		}
	}
	
	
	
}
function getDiscussionTimer(){
	setTimeout("getDiscussionTimer()", 5000);
	if(typeof(q_id) != "undefined"){
		$.ajax({ 
	          type : "get", 
	          url : api_url+"/api/v1/Opinions?question_bank_id="+q_id, 
	          async : false, 
	          success : function(result){
	        	  getDiscussionById(result);
	          } 
	     }); 
	}
}
function getDiscussionById(data){
	$(".discussion ul").remove();
	var discussArry = data.Opinions;
	var discussdiv;
	discussdiv = $("<ul></ul>");
	for(var i in discussArry){
		discussdiv.append($("<li><a>"+discussArry[i].content+"</a></li>"));
	}
	$(".discussion h3").after(discussdiv);
}
function buildDiscussion(data){
	var discussArry = data.question_bank.opinions;
	var discussdiv;
	discussdiv = $("<ul></ul>");
	for(var i in discussArry){
		discussdiv.append($("<li><a>"+discussArry[i].content+"</a></li>"));
	}
	$(".discussion h3").after(discussdiv);
	
}

$(function(){
	//--录音状态切换 start----
	$("#start_rec").click(function(){
		
		if (typeof(q_id) != "undefined" && typeof(userid)!="undefined") {
			$("#question_id").val(q_id);
			//state==0 未录音
			if(rec_state==0){
				FWRecorder.record('audio', userid+"-"+q_id+"-"+ new Date().getTime()+'-audio.wav');
			}
			//state==1 当前正在录音
			if(rec_state==1){
				FWRecorder.stopRecording('audio');
				clearTimeout(timer);
				record_play_length= record_length;
				
				$("#audio_length").val(record_length);
				rec_state=2;
				$("#rerecord").css("display","block");
				$("#start_rec").css('background-image','url(images/xm_video_grayquan.png)');
				$("#start_rec img").attr('src','images/xm_video_but3.png');
				$("#recorderApp").attr("style","margin-top:30px;float: left;");
			//state==2 当前已录音完成，可回放
			}else if(rec_state==2){
				FWRecorder.playBack('audio');
				$("#start_rec img").attr('src','images/xm_video_but2.png');
				rec_state=3;
				record_play_length = record_length;
				playtime();
				
				$("#start_rec").css('cursor','default');
			////state==3 正在回放
			}else if(rec_state==3){
				
			}else{
				//开始录音，检测麦克风
				if(FWRecorder.isMicrophoneAccessible()){
					$("#checkflash").hide();
					$("#recorderApp").attr("style","margin-top: -6000px;float: left;");
					$("#start_rec").css('background-image','url(images/xm_video_grayquan.png)');
					$("#start_rec img").attr('src','images/xm_video_but2.png');
					rec_state=1;
					tsec=40;
					record_length=0;
					recordtime();
					
					
				}else{
					$("#recorderApp").attr("style","margin-top:30px;float: left;");
					$("#checkflash").show();
				}
			}
		}else{
			if(typeof(userid)=="undefined"){
				$(".login_us").slideToggle(100);
				$("#msg").html("请先登录");
			}
		}
	});
	//---录音状态切换END---
	
	
	//--重新录音START--
	$("#rerecord").click(function(){
		$("#start_rec").css('background-image','url(images/xm_video_redquan.png)');
		$("#start_rec img").attr('src','images/xm_video_but1.png');
		$("#timer").html("开始练习");
		$("#rerecord").css("display","none");
		FWRecorder.stopRecording('audio');
		clearTimeout(timer);
		$("#recorderApp").attr("style","margin-top: -6000px;float: left;");
		rec_state=0;
	});
	//--重新录音END--
	
	
	//--弹出视频播放---
	$("#playerbtn a").click(function(){
		if (typeof(q_id) == "undefined") { 
			alert('当前题目为空');
			  return ;
		}else{
			
			$("#player").html(q_video_url).addClass("fade in");
			$("#boarddiv").addClass("fade in");
			
		}
	});
	//---弹出视频层END---
	//--关闭视频层START--
	$("#boarddiv").click(function(){
		$("#boarddiv").removeClass("fade in");
		$("#player").removeClass("fade in");
	});
	//--关闭视频层END--
	
	
	swfobject.embedSWF("swf/soundPlay.swf", "audioPlayer", "10", "10", "10.0.0", "swf/expressInstall.swf");
	//判断登录状态
	var token = getCookie("token");
    if(token!=null){
    	$.ajax({ url: api_url+"/api/v1/auth/ping",
			data:{token:token}, 
			type:'get',
			success: function(data){
				username = getCookie("user_name");
				email=getCookie("user_email");
				userid = getCookie("user_id");
				$(".zhuanghao").html(username);
	        	$("#user_id").val(userid);
	      	}
		});
    }
	
	//--录音播放START--
	$('body').on('click','.record_pic a',function(){
		var audio_url = "http://"+$(this).attr("audiourl");
		
		var audio_length=$(this).attr("rlength");
		if(audio_length.split(":").length>2){
			audio_length=audio_length.split(":")[1]*60+audio_length.split(":")[2];
		}else{
			audio_length =audio_length-1;
		}
		
		var swf = swfobject.getObjectById("audioPlayer");
		if(audioPlayState==1){
			
			//停止倒计时
			clearTimeout(audioPlayTimer);
			$(".record_pic a img").attr("src","images/recordpic1_jingtai.jpg");
			//停止当前播放的声音
			swf.stopSound();
			audioPlayState=0;
			if(currentUrl!=audio_url){
				//切换动态图片
				$(this).find("img").attr("src","images/recordpic1_dongtai.gif");
				//播放新的声音
				swf.playSound(audio_url);
				//开始倒计时
				audioPlayTime(audio_length);
				audioPlayState=1;
				currentUrl = audio_url;
			}
		}else if(audioPlayState==0){
			//切换动态图片
			$(this).find("img").attr("src","images/recordpic1_dongtai.gif");
			//播放新的声音
			swf.playSound(audio_url);
			//开始倒计时
			audioPlayTime(audio_length);
			audioPlayState=1;
			currentUrl = audio_url;
		}
	});
	//--录音播放END--
	
	//--展现答案
	$('body').on('click','.answer_hide',function(){
		$(this).parent().parent().find('.answer_content').slideToggle(300);
		$(this).attr('class','answer_show');
	});
	$('body').on('click','.answer_show',function(){
		$(this).parent().parent().find('.answer_content').slideToggle(300);
		$(this).attr('class','answer_hide');
	});
	
	$(".multieditbox").focus(function(){
		$(this).animate({height:"65px",opacity:0.7},300);
	});
	
	//发布评论
	$("#publish").click(function(){
		if(typeof(userid)!="undefined" && typeof(q_id)!="undefined"){
			var contents = $(".multieditbox").val().trim();
			if(contents.length>0){
				$.ajax({ url: api_url+"/api/v1/Opinions",
					data:{content:contents,user_id:userid,question_bank_id:q_id}, 
					type:'post',
					success: function(data){
						$(".multieditbox").val('');
						$.ajax({ 
					          type : "get", 
					          url : api_url+"/api/v1/Opinions?question_bank_id="+q_id, 
					          async : false, 
					          success : function(result){
					        	  getDiscussionById(result);
					          } 
					     }); 
			      	},
			      	error:function(data){
			      		alert("发布失败了~");
			      	}
				});
			}
			
		}else{
			if(typeof(userid)=="undefined"){
				$(".login_us").slideToggle(100);
				$("#msg").html("请先登录");
				$("#useremail").focus();
			}else{
				alert("当前题目为空");
			}
		}
	});
	
	//登录--
	$("#logbtn").click(function(){
		$(".login_us").slideToggle(100);
	})
	$("#dlbtn").click(function(){
		var email =$("#useremail").val().trim();
		var pwd = $("#userpwd").val().trim();
		$("#msg").html("");
		if(email.length==0){
			$("#msg").html("请填写用户名~");
			return ;
		}
		if(pwd.length==0){
			$("#msg").html("请填写密码~");
		}
		$.ajax({ url: api_url+"/api/v1/auth/login",
			data:{login:email,password:pwd}, 
			type:'post',
			success: function(data){
	        	$(".login_us").slideToggle(100);
	        	saveCookie(data.user_id, email, data.login, data.token);
	        	$(".zhuanghao").html(data.login);
	        	userid = data.user_id;
	        	$("#user_id").val(userid);
	        	
	      	},
	      	error:function(data){
	      		$("#msg").html("失败，确认用户名密码是否正确");
	      	}
		});
		
	});
	//注册--
	$("#zcbtn").click(function(){
		window.open("xmjj_register.html");  
	});
	
	
	//直播跳转
	$(".color_blue").click(function () {
		if(typeof(userid)=="undefined"){
			$(".login_us").slideToggle(200);
			$("#msg").html("请先登录");
		}else{
			window.open("xmjj_zbdt.html");
		}
	});
})
