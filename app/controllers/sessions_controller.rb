class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    unless @auth = Account.find_from_hash(auth)
      @auth = Account.create_from_hash(auth, current_user)
    end
    self.current_user = @auth.user
    redirect_to :controller => "websites", :action => "index"
    # render :text => "Welcome, #{current_user.name}."
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to "/", :notice => "Signed out!"
  end

end