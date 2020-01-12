class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    respond_to do |format|
      if @user.present? && @user.authenticate(params[:password])
        session[:user_id] = @user.id

        format.html { redirect_to root_url, notice: t('notices.login_success') }
      else
        format.html { redirect_to new_session_url, alert: t('alerts.login_fail') }
      end
    end
  end

  def destroy
    session.delete(:user_id)
    respond_to do |format|
      format.html { redirect_to root_url, notice: t('notices.logout_success') }
    end
  end
end
