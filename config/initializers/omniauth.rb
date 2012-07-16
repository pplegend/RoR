OmniAuth.config.full_host = "http://localhost:3000"
Rails.application.config.middleware.use OmniAuth::Builder do
   provider :facebook, 250497581700071, '5bb6d670123e58663960ce6bad7372c0'
  provider :google_oauth2, '726237978378.apps.googleusercontent.com', 'L7YY1qYcMFsn8yu_QETZoCWk', {:access_type => 'online', :approval_prompt => ''}
end
