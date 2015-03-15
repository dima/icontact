IContact.configure do |config|
  config.mode = :sandbox
  config.app_id = ENV["i_contact_app_id"]
  config.user_name = ENV["i_contact_user_name"]
  config.password = ENV["i_contact_password"]
end

