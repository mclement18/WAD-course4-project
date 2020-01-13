module Account
  class FavouritesController < ApplicationController
    before_action :ensure_authenticated

    def index
      @tips = current_user.favourites.page(params[:page]).per(6)
    end
  end
end
