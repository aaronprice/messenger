class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['X-USER-TOKEN'])
  end
end
