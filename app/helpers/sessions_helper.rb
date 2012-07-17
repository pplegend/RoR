module SessionsHelper
  def authenticate
     deny_access unless signed_in?
  end
  def deny_access
      store_location
      redirect_to signin_path, :notice =>"Please sign in to access this page"
  end

  def sign_in(user)
    cookies.permanent.signed[:remember_token]=[user.id,user.salt]
    current_user=user
  end
  def sign_out
     cookies.delete(:remember_token)
     session[:cart_id]=nil
     current_user=nil
  end
  def current_user
    @current_user ||=user_from_remember_token
  end
  def signed_in?
     !current_user.nil?
  end
  def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      clear_return_to
  end
  def deny_access
      respond_to do |accepts|
        accepts.html do
        store_location
        redirect_to signin_url, :notice =>"Please sign in to access this page"
        end
        accepts.js do
              render(:update) { |page| page.redirect_to(:controller => '/sessions', :action => 'new') }
              flash[:notice]="Please sign in to access this page"
        end 
      end
  end
  private
  def user_from_remember_token
     User.authenticate_with_salt(*remember_token)
     end
  def remember_token
        cookies.signed[:remember_token] || [nil,nil]
  end
  def store_location
        session[:return_to]=request.fullpath
  end
  def clear_return_to
        session[:return_to]=nil
  end

end
