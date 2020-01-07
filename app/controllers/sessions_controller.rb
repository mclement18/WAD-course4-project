class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    respond_to do |format|
      if @user.present? && @user.authenticate(params[:password])
        session[:user_id] = @user.id

        format.html { redirect_to root_url, notice: 'Successfully logged in!' }
      else
        format.html { redirect_to new_session_url, alert: 'Invalid email and password combiantion. Please try again.' }
      end
    end
  end

  def destroy
  end
end
