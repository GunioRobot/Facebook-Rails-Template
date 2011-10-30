file 'app/controllers/pages_controller.rb', <<-CODE
class PagesController < ApplicationController

  before_filter :fan_gate, :only => :welcome

  def welcome
  end

end
CODE
run 'touch app/views/pages/welcome'
run 'touch app/views/pages/fan_gate'

run 'rm app/controllers/application_controller.rb'
file 'app/controllers/application_controller.rb', <<-CODE
class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller

  helper_method :inside_tab?, :logged_in?, :is_admin?

  def logged_in?
    !!current_facebook_user
  end

  def inside_tab?
    !!facebook_params['page'] || object_to_boolean(params[:inside_tab])
  end

  def is_admin?
    Settings.admin_uids.include?(current_facebook_user.id.to_i)
  end

  def facebook_user_agent?
    logger.debug request.env["HTTP_USER_AGENT"]
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"].starts_with?('facebookexternalhit')
  end

  def fan_gate
    if facebook_params[:page] && facebook_params[:page][:liked] == false
      render('pages/fan_gate', :layout => false) and return false
    end
  end

end
CODE

