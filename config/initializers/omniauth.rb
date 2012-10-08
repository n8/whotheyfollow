Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, "WQgMu8YaifeiK3lYio4lfA", "yV1E4eojtTbSNqbOvcHjlX1ATPXM6mfKvghrZZm2JQ"
end