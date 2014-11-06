class UserSms
  
  def self.captcha_sms(options={}) 
    account_sid = 'aaf98f89486445e6014881872f2309c3'
    auth_token = '0669ff0ab2df44e4aa40182aed1e34b0'
    #小马机经
    app_id = '8a48b5514979e09101497da36fa50217'
    #托福
    #app_id = 'aaf98f89486445e601488189239f09cb'
    message_tmp = '6712'
    #message_tmp = '4534'
    # Set the request parameters
    timestamp = Time.now.strftime "%Y%m%d%H%M%S"
    #host = 'https://sandboxapp.cloopen.com:8883'
    host = 'https://app.cloopen.com:8883'
    auth = Base64.strict_encode64(account_sid + ":" + "#{timestamp}")
    sig = Digest::MD5.hexdigest(account_sid + auth_token + "#{timestamp}")
    
    request_body_map = {to: "#{options[:phone]}", appId: app_id, templateId: message_tmp, datas: ["#{options[:captcha]}", "10"]}
    
    begin
      response = RestClient.post("#{host}/2013-12-26/Accounts/#{account_sid}/SMS/TemplateSMS?sig=#{sig}",
                                 request_body_map.to_json,    # Encode the entire body as JSON
                                 {authorization: auth,
                                  content_type: 'application/json',
                                  accept: 'application/json'}
                                )
      puts "#{response.to_str}"
      puts "Response status: #{response.code}"
      response.headers.each { |k,v|
        puts "Header: #{k}=#{v}"
      }
    
    rescue => e
      puts "ERROR: #{e}"
    end
  end
end
