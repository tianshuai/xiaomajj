# encoding: utf-8
namespace :import do
  desc 'import question_bank and answer'
  task :question_bank => :environment do

    sp = '’'
str = 'S_341;;Do you prefer to watch a movie at home or at a movie theater?;;@@
S_342;;What type of books do you enjoy to read? Romance books, biography books or mystery books? Explain why you enjoy reading this type of book? Please include reasons and details in you explanation.;;@@
S_343;;Agree or disagree: Students should be required to wear school uniforms to school.;;@@
S_344;;Some people prefer to make decisions quickly. Others prefer to take their time making them. Which do you prefer and why? Use specific reasons and examples to support your response.;;@@
S_345;;Choose one of the following natural environment and explain why you would like to live there most: mountain，forest，desert，prairie, seashore or somewhere else? Use specific reasons and examples to support your answer.;;@@
S_346;;Some people prefer to read imaginative literature like fictions in their spare time，while others prefer to read real literature or nonfictions，such as historical books and biographies. Which kind of books do you prefer，and why? Use reasons and details in your explanation.;;@@
S_347;;Describe a piece of news that excited you.Why did it excite you?Please include specific reasons and details in your answer.;;@@
S_348;;Some people believe that first-year college students should live in a dorm building that homes only freshmen. Others may prefer the idea that first-year students must live together with students in 2nd, 3rd, or even 4th grade. Which opinion do you agree with? Explain why.;;@@
S_349;;Describe one difference between your current life and your life ten years later. Include reasons and details to support your response.;;@@
S_350;;Would you go to study in a university of a foreign country?;;@@
S_351;;Do you agree or disagree with the following statement? While choosing friends, people should always choose those who have different interests from their own. Include specific reasons and examples in your explanation.;;@@
S_352;;What suggestion would you like to give to a child who is starting school for the first time. Use reasons and specific examples to explain why this suggestion is important.;;@@
S_353;;Some people prefer to live in places where climate doesn’t change very much, while others prefer to live in places where climate changes with seasons. Which one do you prefer? Include reasons and details in your explanation.;;@@
S_354;;Talk about a time when someone (your friends, family or teachers) gave you advice to solve the problem.;;@@
S_355;;Some people think that government should put money on arts and culture like museums and theaters. Others don’t think so. What is your opinion? Use specific reasons and examples to support your choice.;;@@
S_356;;What type of music do you enjoy most? Explain why you enjoy this type of music. Include reasons and details in you explanation.;;@@
S_357;;Do you agree or disagree with the following statement? It’s easier to teach children in primary schools than students in universities. Include reasons and details in your explanation.;;@@
S_358;;While choosing a house or an apartment to live in, what is the most important characteristic you care about? Why?;;@@
S_359;;Some people prefer to watch films or concerts with a group of friends. Others prefer to watch films or concerts alone. Which do you prefer and why? Use specific reasons and examples to support your response.;;@@
S_360;;Describe how your family and friends used to help you.Please give your answer with specific details.;;@@
S_361;;Some people enjoy taking risk and trying new things, others are not adventurous,they are cautious and prefer to avoid danger. Which behavior do you think is better? Explain why.;;'

    arr = str.split('@@')
    arr.each do |n|
      m = n.strip.split(';;')
      return if m.size==0
      if m[1].present?
        content = m[1].strip
      else
        content = ''
      end
      q = QuestionBank.new(number: m[0].strip, content: content, video_url: "V_#{m[0].strip}.mp4")
      #if q.save
      if q.valid?
        puts "question save success!#{m[0].to_s}"
        if m[2].present?
          tip = m[2].strip
        else
          tip = ''
        end
        a = Answer.new(tip: tip, question_bank_id: q.id, audio_url: "A_#{m[0].strip}.mp3")
        #if a.save
        if a.valid?
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
    str = ''
    str.split('@@').each do |m|
      q = m.strip.split(';;')
      return if q.size<2
      question = QuestionBank.find_by(number: q[0])
      if question.present?
        question.update(video_url: q[1])
        puts "success: #{q[0]}"
      end
    end
  end
end

