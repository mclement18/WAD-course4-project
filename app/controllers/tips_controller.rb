class TipsController < ApplicationController
  include RolesHelper
  
  before_action :ensure_authenticated,  only: [:new, :edit, :create, :update, :destroy]
  before_action :set_tip,               only: [:show, :edit, :update, :destroy]
  before_action :authorize_to_edit_tip, only: [:edit, :update, :destroy]

  def index
    @tips = Tip.search(params[:q]).page(params[:page]).per(8)
  end

  def show
  end

  def new
    @tip = Tip.new
  end

  def edit
  end

  def create
    @tip = Tip.new(tip_params)
    @tip.user = current_user
    respond_to do |format|
      if @tip.save
        # In this format call, the flash message is being passed directly to
        # redirect_to().  It's a caonvenient way of setting a flash notice or
        # alert without referencing the flash Hash explicitly.
        format.html { redirect_to @tip, notice: t('notices.tip_created') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tip.update(tip_params)
        # In this format call, the flash message is being passed directly to
        # redirect_to().  It's a caonvenient way of setting a flash notice or
        # alert without referencing the flash Hash explicitly.
        format.html { redirect_to @tip, notice: t('notices.tip_updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tip.destroy
    respond_to do |format|
      # In this format call, the flash message is being passed directly to
      # redirect_to().  It's a caonvenient way of setting a flash notice or
      # alert without referencing the flash Hash explicitly.
      format.html { redirect_to tips_url, notice: t('notices.tip_destroyed') }
      format.js
    end
  end

  private

    def set_tip
      @tip = Tip.find(params[:id])
    end

    def authorize_to_edit_tip
      redirect_to account_tips_path unless can_edit?(@tip)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tip_params
      params.require(:tip).permit(:title, :body)
    end
end
