RakutenWebService.configure do |c|
    c.application_id = Rails.application.credentials.rakuten[:api_key]
end
