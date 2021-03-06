class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      else
        redirect_to :back, notice: "Incorrect username or password"
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, notice:"You have logged out."
  end
end
