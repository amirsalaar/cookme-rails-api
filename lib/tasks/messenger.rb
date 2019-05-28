module Messenger

  def send_sms(number, message)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    from = ENV['TWILIO_NUMBER']
    
    @client.api.account.messages.create(
      from: from,
      to: number,
      body: message
    )
  end

end
