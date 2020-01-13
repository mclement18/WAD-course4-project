class FavouritesController < ApplicationController
  before_action :ensure_authenticated
  
  def create
    @tip = Tip.find(params[:tip_id])
    current_user.favourites << @tip
    flash.now.notice = t('notices.favourite_added')
  end

  def destroy
    @tip = Tip.find(params[:id])
    current_user.favourites.delete(@tip)
    flash.now.notice = t('notices.favourite_removed')
  end
end
