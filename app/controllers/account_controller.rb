class AccountController < ApplicationController
  before_action :ensure_authenticated
  
  def edit
    @user = User.first
  end

  def update
    redirect_to account_path
  end
end
