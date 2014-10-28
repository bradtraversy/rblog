class Admin::ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
 	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception

  	layout 'admin/application'

  	helper_method :current_user

  	private
		def current_user
  			@current_user ||= User.find(session[:user_id]) if session[:user_id]
		end
	private
		def verify_logged_in
    		unless current_user
      		redirect_to admin_login_path
    		end
  		end
end