if Rails.env.production?
  CarrierWave.configure do |config|
    config.cloud_name = 'djl5j7j35'
    config.api_key = '697139258671171'
    config.api_secret = 'ioidh0dtngngDbqWnICvyh7Fsic'
    config.cdn_subdomain = true
  end
end
