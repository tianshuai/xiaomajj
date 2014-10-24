# encoding: utf-8
namespace :import do
  desc 'import question_bank and answer'
  task :question_bank => :environment do

    sp = '’'
str = 'S_401;;What is the most important quality the teacher should have? ;;@@
S_402;; Would you like to make friends with the same interests or the one with different interests? ;;@@
S_403;; Choose ONE of the forms of the technology in the list and tell why it has great impact on people’s lives in your country? Airplane, computer or television. Use specific reasons and examples to support your response.;;@@
S_404;;Do you agree or disagree with the following statement? Yong people today know more about world events than their parents did before.;;@@
S_405;; Your university is planning to allow students to watch TV in theirs dormitories. What is your opinion? What are the advantages and disadvantages of watching TV in dormitories? Include reasons and examples to support your response.;;@@
S_406;; Some people believe that it is better for small children to grow up in a small town. Others, however, believe that it’s better for them to grow up in a big city. Which do you think is better?;;@@
S_407;;Which of the following do you think is the most important for maintaining good health? Doing exercises, eating healthy food, or going to bed early?;;@@
S_408;;Which do you prefer? A job in a distant city with a high salary, or a job in your current city with a low salary.;;@@
S_409;;Nowadays robots are widely used in the society. What are the benefits and risks of this?;;@@
S_410;;Should employees be required to wear suits in the workplace, or should they wear casual clothes?;;@@
S_411;;Your friend often feels nervous when speaking in front of a large group of people. What suggestions would you give to your friend to overcome this fear?;;@@
S_412;;When you take a trip, do you prefer to just look around, or do you prefer to take pictures and keep a journal?;;@@
S_413;; Talk about two singers who are popular in your country. Explain why they are popular and how they are different.;;@@
S_414;;Do you prefer to have fast food in a fast-food restaurant, or do you prefer to have food in other kinds of places?;;@@
S_415;; Describe?how?cellphones?change?people’s?lives.Please?give?your?answer?with?specific?examples?and?details;;@@
S_416;;Some?people?prefer?to?go?to?the?same?place?for?a?vacation.Others?prefer?to?go?to?different?places?and?spend?less?time?at?each?place.Which?do?you?prefer?;;@@
S_417;;What do you think is the most significant benefitthat internet brings to our life? Explain why you think this benefit isimportant. Please include reasons and details to support your response.;;@@
S_418;;Do you agree or disagree with the followingstatement: people live healthier lives now than they did 100 years ago? Pleaseuse specific reasons and examples to support your answer.;;@@
S_419;;Talk about an important decision that you have made.Explain why this decision was important for you in details。;;@@
S_420;; Do you agree or disagree with the statement that it’s important for students to study Art and Music in school.Explain your answer in details.;;@@
S_421;;Describe a person you want to learn more about, explain why you want to know more about this person in details.;;@@
S_422;; Do you agree or disagree with the statement that all children under the age of 16 should attend school. Explain you answer in details.;;@@
S_423;;Describe a person you would like to learn more about and explain why. Please include specific reasons and examples to explain your answer.;;@@
S_424;;Do you agree with the statement that: Artists and musicians are important to the society.;;@@
S_425;;What characteristic is the most important for a student to be succeed, Highly motivated, hard working or intelegent;;@@
S_426;;While traveling, some people prefer to go to new places, others prefer to visit familiar places. Which do you think is better? Explain why. ;;@@
S_427;;Talk about an activity you enjoyed doing with your family when you were a child, explain you answer in details.;;@@
S_428;;Do you agree or disagree it is better to be a member of a team than to be a leader of a team.;;@@
S_429;;Describe a good study habit that is different from other students.;;@@
S_430;;Large grocery department store or small special store, which one do you prefer.;;'

    arr = str.split('@@')
    arr.each do |n|
      m = n.strip.split(';;')
      return if m.size==0
      if m[1].present?
        content = m[1].strip
      else
        content = ''
      end
      q = QuestionBank.new(number: m[0].strip, content: content, video_url: "")
      if q.save
      #if q.valid?
        puts "question save success!#{m[0].to_s}"
        if m[2].present?
          tip = m[2].strip
        else
          tip = ''
        end
        a = Answer.new(tip: tip, question_bank_id: q.id, audio_url: "A_#{m[0].strip}.mp3")
        if a.save
        #if a.valid?
          puts "answer is success!.....#{m[0].strip}"
        end
      else
        puts "error.....#{m[0].strip}"
      end   
    end

  end

  desc 'import question_bank and answer'
  task :upload => :environment do

      begin
        file = File.open('/home/tianshuai/test_for_up.apk')
        AudioUploader.new.store!(file)
        puts 'success'
      rescue=>e
        puts e.message
      end          

  end

  desc 'import video url for question_banks'
  task :question_video => :environment do
    str = 'S_001;;<script src="http://p.bokecc.com/player?vid=3CAEE39E2333D0F19C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_002;;<script src="http://p.bokecc.com/player?vid=5AC7C7A1AEC075559C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_003;;<script src="http://p.bokecc.com/player?vid=D28BBE591290DABC9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_004;;<script src="http://p.bokecc.com/player?vid=4F9663A62C3631D99C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_005;;<script src="http://p.bokecc.com/player?vid=FE3174F23B97D2669C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_006;;<script src="http://p.bokecc.com/player?vid=3E78623CA02936989C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_007;;<script src="http://p.bokecc.com/player?vid=05BBFA59BD56039C9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_008;;<script src="http://p.bokecc.com/player?vid=50B8E2553BA4374C9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_009;;<script src="http://p.bokecc.com/player?vid=B988682510D320C19C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_010;;<script src="http://p.bokecc.com/player?vid=A9A8CD905DB1C7F59C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_011;;<script src="http://p.bokecc.com/player?vid=118E2739B49D3F789C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_012;;<script src="http://p.bokecc.com/player?vid=D237687B73E7843F9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_013;;<script src="http://p.bokecc.com/player?vid=468199D444926E8E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_014;;<script src="http://p.bokecc.com/player?vid=1B27317EC6CF606E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_015;;<script src="http://p.bokecc.com/player?vid=44856E01383B3C749C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_016;;<script src="http://p.bokecc.com/player?vid=879A395DBCD8340B9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_017;;<script src="http://p.bokecc.com/player?vid=9E941454191A369A9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_018;;<script src="http://p.bokecc.com/player?vid=412E08D523901ADF9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_019;;<script src="http://p.bokecc.com/player?vid=7DC98E9AA82776699C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_020;;<script src="http://p.bokecc.com/player?vid=3940B809807CE8F69C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_051;;<script src="http://p.bokecc.com/player?vid=A3C05393F71CD45D9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_052;;<script src="http://p.bokecc.com/player?vid=45D3272DBF80ACAD9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_053;;<script src="http://p.bokecc.com/player?vid=069A7854252EC4249C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_054;;<script src="http://p.bokecc.com/player?vid=C68C6E3BEE5CFC859C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_055;;<script src="http://p.bokecc.com/player?vid=D55D1EF66EA13A7B9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_056;;<script src="http://p.bokecc.com/player?vid=64686AE8F19011EA9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_057;;<script src="http://p.bokecc.com/player?vid=7604383B81E23E9A9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_058;;<script src="http://p.bokecc.com/player?vid=3F57D33C4C4EC1309C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_059;;<script src="http://p.bokecc.com/player?vid=689937D8D11D43789C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_060;;<script src="http://p.bokecc.com/player?vid=66C46401C8B8A99A9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_071;;<script src="http://p.bokecc.com/player?vid=2F6FDBD0C3DA44B99C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_072;;<script src="http://p.bokecc.com/player?vid=5D420042EBD0E3FB9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_073;;<script src="http://p.bokecc.com/player?vid=0825622C05F361759C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_074;;<script src="http://p.bokecc.com/player?vid=C5E2A51BD865C4829C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_075;;<script src="http://p.bokecc.com/player?vid=1D3866A8A1008AA49C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_076;;<script src="http://p.bokecc.com/player?vid=C08CD3ECD9C111019C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_077;;<script src="http://p.bokecc.com/player?vid=768056147CF11B649C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_078;;<script src="http://p.bokecc.com/player?vid=87FB4581777089079C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_079;;<script src="http://p.bokecc.com/player?vid=2E2CE1E8A17BFD379C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_080;;<script src="http://p.bokecc.com/player?vid=E45ED1413EB13A7C9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_081;;<script src="http://p.bokecc.com/player?vid=6744CDC5016ACEB19C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_082;;<script src="http://p.bokecc.com/player?vid=9E295E498CA867C29C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_083;;<script src="http://p.bokecc.com/player?vid=23354336286145D79C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_084;;<script src="http://p.bokecc.com/player?vid=E32135213FDCBE429C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_085;;<script src="http://p.bokecc.com/player?vid=CD11FDB8403091AB9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_086;;<script src="http://p.bokecc.com/player?vid=AF0E5953D39042139C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_087;;<script src="http://p.bokecc.com/player?vid=939F3AE66F7A7B1E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_088;;<script src="http://p.bokecc.com/player?vid=CE9DB8354609A5FB9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_089;;<script src="http://p.bokecc.com/player?vid=8F5E10441B30BC679C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_090;;<script src="http://p.bokecc.com/player?vid=12C14B221F6DE3B59C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_101;;<script src="http://p.bokecc.com/player?vid=08368F974C0551579C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_102;;<script src="http://p.bokecc.com/player?vid=EE65ECE3B4BBA5139C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_103;;<script src="http://p.bokecc.com/player?vid=3F8218B27FA751369C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_104;;<script src="http://p.bokecc.com/player?vid=353CAEF2ECCAB80E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_105;;<script src="http://p.bokecc.com/player?vid=65C67F9815981A749C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_106;;<script src="http://p.bokecc.com/player?vid=5EFC1DE6F8C313429C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_107;;<script src="http://p.bokecc.com/player?vid=BC54CF8FAA797EF89C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_108;;<script src="http://p.bokecc.com/player?vid=58E21D7596BF4DE09C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_109;;<script src="http://p.bokecc.com/player?vid=B51F335EF55833579C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_110;;<script src="http://p.bokecc.com/player?vid=87E3E88635AE69DE9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_111;;<script src="http://p.bokecc.com/player?vid=ED1BA8BFFDC957A69C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_112;;<script src="http://p.bokecc.com/player?vid=6784222F4DC871179C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_113;;<script src="http://p.bokecc.com/player?vid=EE016777895F82FB9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_114;;<script src="http://p.bokecc.com/player?vid=F45AF63AA79FC1F69C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_115;;<script src="http://p.bokecc.com/player?vid=F5B8A7970494175E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_116;;<script src="http://p.bokecc.com/player?vid=CAB98B93CCABB03F9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_117;;<script src="http://p.bokecc.com/player?vid=332D81BCD73F0A589C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_118;;<script src="http://p.bokecc.com/player?vid=E9C05593CE0475F49C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_119;;<script src="http://p.bokecc.com/player?vid=5835DFEB9FBD1E509C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_120;;<script src="http://p.bokecc.com/player?vid=5EA53AE4CB9DA85C9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_121;;<script src="http://p.bokecc.com/player?vid=D027E3EDE15CFB5E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_122;;<script src="http://p.bokecc.com/player?vid=3E34ECBD33E18BAE9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_123;;<script src="http://p.bokecc.com/player?vid=595345A1897AA76D9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_124;;<script src="http://p.bokecc.com/player?vid=45F6D6A4656592159C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_125;;<script src="http://p.bokecc.com/player?vid=D464DCC8299655109C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_126;;<script src="http://p.bokecc.com/player?vid=4F70C0A8D9F4ABC99C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_127;;<script src="http://p.bokecc.com/player?vid=3E6910E053E3147A9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_128;;<script src="http://p.bokecc.com/player?vid=E16DBA78B4B5D71E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_129;;<script src="http://p.bokecc.com/player?vid=69CB23077C60EB0C9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_130;;<script src="http://p.bokecc.com/player?vid=7EAE806F45E2416C9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_131;;<script src="http://p.bokecc.com/player?vid=3FFE40CD42ED22A19C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_132;;<script src="http://p.bokecc.com/player?vid=5CF22B9F43EEB7209C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_133;;<script src="http://p.bokecc.com/player?vid=74A174470330998C9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_134;;<script src="http://p.bokecc.com/player?vid=C7179B1CC6DF25559C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_135;;<script src="http://p.bokecc.com/player?vid=6558A54EFA82DD949C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_136;;<script src="http://p.bokecc.com/player?vid=D09C14A4F84497609C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_137;;<script src="http://p.bokecc.com/player?vid=E34517C07F959B2A9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_138;;<script src="http://p.bokecc.com/player?vid=64BC620040B5E92E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_139;;<script src="http://p.bokecc.com/player?vid=EFA77296999271C99C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_140;;<script src="http://p.bokecc.com/player?vid=6E11A697EC9D59BA9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_141;;<script src="http://p.bokecc.com/player?vid=071EA7C9E73BA7409C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_142;;<script src="http://p.bokecc.com/player?vid=1155C380FF07C17E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_143;;<script src="http://p.bokecc.com/player?vid=27ACD2155E0A21999C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_144;;<script src="http://p.bokecc.com/player?vid=5C7A6237588ACC2E9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_145;;<script src="http://p.bokecc.com/player?vid=285BD257E0AE1ACF9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_146;;<script src="http://p.bokecc.com/player?vid=14C14BA6DEF5CFC39C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_147;;<script src="http://p.bokecc.com/player?vid=F3A82368AC07B39F9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_148;;<script src="http://p.bokecc.com/player?vid=B6961238EED548839C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_149;;<script src="http://p.bokecc.com/player?vid=499B465892F381F89C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_150;;<script src="http://p.bokecc.com/player?vid=C63327DCE33C54209C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_151;;<script src="http://p.bokecc.com/player?vid=EBCA7DCB7F2C6F0C9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_152;;<script src="http://p.bokecc.com/player?vid=88D706FF72A3F1B69C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_153;;<script src="http://p.bokecc.com/player?vid=D063D64BC9B2C8F29C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_154;;<script src="http://p.bokecc.com/player?vid=8F074174497402B09C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_155;;<script src="http://p.bokecc.com/player?vid=A23421C10EBDBB519C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_156;;<script src="http://p.bokecc.com/player?vid=BBCF3DDDACCA97149C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_157;;<script src="http://p.bokecc.com/player?vid=4F34B42D658AE9A39C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_159;;<script src="http://p.bokecc.com/player?vid=C56F12766564F2DE9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_160;;<script src="http://p.bokecc.com/player?vid=8D9E42B709E98BA29C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_161;;<script src="http://p.bokecc.com/player?vid=36CA8F79698BF55F9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_162;;<script src="http://p.bokecc.com/player?vid=1AA6281E58CEC7879C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_163;;<script src="http://p.bokecc.com/player?vid=8F30F431935B2D439C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_164;;<script src="http://p.bokecc.com/player?vid=4FB1CE54315639AB9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_165;;<script src="http://p.bokecc.com/player?vid=2C69AD2FC9539C419C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_166;;<script src="http://p.bokecc.com/player?vid=53DBD5DDF39E5B989C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_167;;<script src="http://p.bokecc.com/player?vid=EEE37E4E6443D14F9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_168;;<script src="http://p.bokecc.com/player?vid=4F57956DBB810BF19C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_169;;<script src="http://p.bokecc.com/player?vid=D105B2BDDCB0D5499C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_170;;<script src="http://p.bokecc.com/player?vid=0DFC4F850A0430D49C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_171;;<script src="http://p.bokecc.com/player?vid=15435A3D11472DD19C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_172;;<script src="http://p.bokecc.com/player?vid=15435A3D11472DD19C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_173;;<script src="http://p.bokecc.com/player?vid=E2DDB80C6CB490F29C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_174;;<script src="http://p.bokecc.com/player?vid=891193D0467D334F9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_175;;<script src="http://p.bokecc.com/player?vid=52EC0F0F6A9472939C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_176;;<script src="http://p.bokecc.com/player?vid=9F85E1168874370B9C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_177;;<script src="http://p.bokecc.com/player?vid=99D74770D26564E89C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_178;;<script src="http://p.bokecc.com/player?vid=6FB73DF056C238A69C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_179;;<script src="http://p.bokecc.com/player?vid=5D5BABA08B01CF999C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>@@
S_180;;<script src="http://p.bokecc.com/player?vid=C3D808AED7B858B99C33DC5901307461&siteid=B86E9AC935D39444&autoStart=false&width=710&height=400&playerid=3B89CC3CB774B9A8&playertype=1" type="text/javascript"></script>'
    str.split('@@').each do |m|
      q = m.strip.split(';;')
      return if q.size<2
      question = QuestionBank.find_by(number: q[0])
      if question.present?
        #question.update(video_url: q[1])
        puts q[0]
        puts q[1]
        puts "success: #{q[0]}"
      end
    end
  end

  desc 'question_banks'
  task :question_url => :environment do
    QuestionBank.all.each do |d|
      d.update(video_url: '') if d.present?
    end
  end

end

