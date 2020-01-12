class UsersController < ApplicationController
  before_action :ensure_admin, only: [:index, :edit, :update, :destroy]
  before_action :set_user,     only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page]).per(6)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # In this format call, the flash message is being passed directly to
        # redirect_to().  It's a caonvenient way of setting a flash notice or
        # alert without referencing the flash Hash explicitly.
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: t('notices.user_created') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_update_params)
        # In this format call, the flash message is being passed directly to
        # redirect_to().  It's a caonvenient way of setting a flash notice or
        # alert without referencing the flash Hash explicitly.
        format.html { redirect_to @user, notice: t('notices.user_updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: t('notices.user_destroyed') }
      format.js
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def ensure_admin
      redirect_to root_path unless current_user.role == 'admin'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :avatar, :password)
    end

    def user_update_params
      params.require(:user).permit(:email, :name, :avatar, :role)
    end
end
