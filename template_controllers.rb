run 'rm app/controllers/application_controller.rb'
file 'app/controllers/application_controller.rb', <<-CODE
class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller
  
  helper_method :current_facebook_user, :inside_tab?, :logged_in?, :is_admin?
  
  def logged_in?
    !!current_facebook_user
  end
  
  def inside_tab?
    !!facebook_params[:profile_id]
  end
  
  def is_admin?
    Settings.admin_uids.include?(current_facebook_user.id.to_i)
  end
  
  def ensure_application_is_installed
    if logged_in?
      true
    else
      top_redirect_to authentication_url
      false
    end
  end
  
  def authentication_url
    return_url = Settings.facebook_apps_url + '/' + Settings.canvas_name + request.fullpath
    Mogli::Authenticator.new(Facebooker2.app_id, Facebooker2.secret, return_url).authorize_url
  end
  
  def top_redirect_to(path)
    path = top_url(path) unless path.start_with?('http')
    render :text => "<script>top.location.href = '#{path}';</script>"
  end
  
  def top_url(path)
    Settings.facebook_apps_url + '/' + Settings.canvas_name + path
  end
  
  def inside_tab?
    facebook_params && facebook_params[:profile_id]
  end
  
  def facebook_user_agent?
    logger.debug request.env["HTTP_USER_AGENT"]
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"].starts_with?('facebookexternalhit')
  end
  
end
CODE

file 'app/controllers/pages_controller.rb', <<-CODE
class PagesController < ApplicationController
  
  def tab
    render :tab, :layout => 'tab'
  end
  
end
CODE


file 'app/views/pages/index.html.haml', <<-CODE
%h1 This is the tab
CODE