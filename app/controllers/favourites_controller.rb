class FavouritesController < ApplicationController
  before_action :ensure_authenticated
  
  def create
    @tip = Tip.find(params[:tip_id])
    current_user.favourites << @tip
  end

  def destroy
    @tip = Tip.find(params[:id])
    current_user.favourites.delete(@tip)
  end
end
