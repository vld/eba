class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_manager
    @current_manager ||= Manager.find(session[:manager_id]) if session[:manager_id]
  end

  def autheticate!
    redirect_to :root, error: 'You should be logged in' unless @current_manager
  end
  helper_method :current_manager
end
