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
end
