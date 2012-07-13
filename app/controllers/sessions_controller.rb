class SessionsController < ApplicationController
   def new
     @title="Sign in"
   end
   def create
    if user = User.authenticate(params[:session][:email],params[:session][:password])
      # Save the user ID in the session so it can be used in
      # subsequent requests
      sign_in user
      redirect_back_or(user)
     else
      flash.now[:error]="Invalid email/password combination"
        @title ="Sign in"
        render 'new'
    end
  end

  def destroy
    # Remove the user id from the session
    sign_out 
    redirect_to root_url
  end
  
  def auth_create
    auth_hash=request.env['omniauth.auth']
    @authorization=Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
   
    if @authorization
          @user=@authorization.user
          sign_in @user
          redirect_back_or(@user)
    else
          user=User.new :name=>auth_hash["info"]["name"], :email=>auth_hash["info"]["email"]
          user.authorizations.build :provider=>auth_hash["provider"], :uid=>auth_hash["uid"]
          user.password="this is fake password"
          user.save!
          sign_in user
          redirect_back_or(user)
    end
        #render :text=>auth_hash["info"]["name"]
  end
end
