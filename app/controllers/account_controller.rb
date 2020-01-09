class AccountController < ApplicationController
  before_action :ensure_authenticated
  
  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to account_url, notice: 'Profile successfully updated!' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar_url)
  end
end
