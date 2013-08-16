class SessionsController < ApplicationController
  def new
  end

  def create
    manager = Manager.find_by_username(params[:username])
    if manager && manager.authenticate(params[:password])
      session[:manager_id] = manager.id
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:manager_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
