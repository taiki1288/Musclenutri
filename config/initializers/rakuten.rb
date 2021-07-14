RakutenWebService.configure do |c|
    c.application_id = Rails.application.credentials.rakuten[:api_key]
    # c.affiliate_id = ENV['RWS_AFFILIATION_ID']
end
