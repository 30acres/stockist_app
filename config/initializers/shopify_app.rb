ShopifyApp.configure do |config|
  config.api_key = "<api_key>"
  config.secret = "298cef654795d2722c2a891a0dae3b11"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
end
