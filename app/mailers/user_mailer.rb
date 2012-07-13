class UserMailer < ActionMailer::Base
   def welcome_email(user)
     @user=user
     @url="localhost:3000/login"
     mail(:to=>user.email,
          :subject=>"Welcome to my awesome site",
          :from=>"2pplegend@gmail.com"
    )
   end
   def recover_password(user)
    @user=user
    mail(:to=>user.email,
          :subject=>"find password back",
          :from=>"2pplegend@gmail.com"
    )
   end
end
