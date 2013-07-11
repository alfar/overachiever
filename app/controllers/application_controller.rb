class ApplicationController < ActionController::Base
  protected
  helper_method :current_user, :signed_in?, :empty_accounts
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
  
  def empty_accounts
    accounts = []
    if !signed_in? || !current_user.user_has_account("facebook")
      accounts.push({"name" => "Facebook", "id" => "facebook", "icon" => "facebook" })
    end
    if !signed_in? || !current_user.user_has_account("github")
      accounts.push({"name" => "GitHub", "id" => "github", "icon" => "github" })
    end
    if !signed_in? || !current_user.user_has_account("google_oauth2")
      accounts.push({"name" => "Google", "id" => "google_oauth2", "icon" => "google-plus" })
    end
    if !signed_in? || !current_user.user_has_account("twitter")
      accounts.push({"name" => "Twitter", "id" => "twitter", "icon" => "twitter" })
    end
    return accounts
  end
  
end
