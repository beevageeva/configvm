class ApplicationController < ActionController::Base
  protect_from_forgery



  protected

	def checkLogin
	if session[:username].nil?
		redirect_to login_path
	end

	end

  def authenticate_http
      authenticate_or_request_with_http_basic do |user_name, password|
	      user_name == HTTP_USER && password == HTTP_PASS
      end
  end

end
