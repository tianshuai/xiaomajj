class UserSms
  
  def self.captcha_sms(options={}) 
    # Set the request parameters
    timestamp = Time.now.strftime "%Y%m%d%H%M%S"
    host = 'https://sandboxapp.cloopen.com:8883'
    auth = Base64.strict_encode64("aaf98f89486445e6014881872f2309c3" + ":" + "#{timestamp}")
    sig = Digest::MD5.hexdigest("aaf98f89486445e6014881872f2309c3" + "0669ff0ab2df44e4aa40182aed1e34b0" + "#{timestamp}")
    
    request_body_map = {to: "#{options[:phone]}", appId: "aaf98f89486445e601488189239f09cb", templateId: "1", datas: ["#{options[:captcha]}", "1"]}
    
    begin
      response = RestClient.post("#{host}/2013-12-26/Accounts/aaf98f89486445e6014881872f2309c3/SMS/TemplateSMS?sig=#{sig}",
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
